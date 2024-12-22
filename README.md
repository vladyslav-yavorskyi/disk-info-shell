# Disk and Partition Selection Script

This shell script provides a user-friendly interface for selecting a disk and its partitions using `dialog`. The script generates a report containing disk and partition information, including their usage, and saves it as a timestamped file.

## Features
- Displays available disks on the system for selection using a radio list.
- Lists partitions of the selected disk using a checklist for multiple selection.
- Generates a detailed report of the selected disk and partitions.
- Saves the report with a timestamped filename in the current working directory.

## Prerequisites
- **Bash Shell**: Ensure the script is executed in a Bash environment.
- **dialog**: Install the `dialog` package for interactive terminal-based GUIs.

### Installation of `dialog`
On Debian-based systems:
sudo apt install dialog

On Fedora-based systems:
sudo dnf install dialog

## Usage
1. Save the script as `disk_partition_report.sh`.
2. Make the script executable:
   chmod +x disk_partition_report.sh
3. Run the script:
   ./disk_partition_report.sh

## How It Works
1. **Disk Selection**:
   - The script lists all available disks using `lsblk` and allows the user to select one disk through a radio list.

2. **Partition Selection**:
   - After selecting a disk, the script lists all its partitions and allows the user to select multiple partitions using a checklist.

3. **Report Generation**:
   - A report is generated with details of the selected disk and partitions, including disk space usage (`df -h` output).
   - The report is saved with a filename format: `Raport_YYYYMMDD-HHMMSS.txt`.

## Output
- **Example Report**:
  Raport z dnia 20241222-153045 ze stanu dysków
  
  Dostępne dyski:
  sda       500G disk
  sdb       1TB  disk
  
  Stan użycia dla /dev/sda1:
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda1       50G   10G   40G  20% /
  --------------------------
  
  Plik o nazwie Raport_20241222-153045.txt został zapisany w /path/to/current/directory.

## Exit Codes
- **0**: Successful execution.
- **1**: User exited without selecting a disk or partitions.

## Error Handling
- If no disk is selected, the script exits with a message:
  Nie wybrałeś żadnego dysku :(

- If no partition is selected or the selected disk has no partitions, the script exits with a message:
  Nie wybrałeś partycji albo dysk ich nie ma :(


## Author
- **Vladyslav Yavorskyi**

## Notes
- The script assumes the user has appropriate permissions to access disk and partition information.
- Run the script with caution on production systems as it interacts with disk partitions.
