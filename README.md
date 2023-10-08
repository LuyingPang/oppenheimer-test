# oppenheimer-test
This is test scripts written in robot framework for Oppenheimer project. 

## How to run
* Install python https://www.python.org/downloads/
* Download or clone this repository to your desktop.
* Install all the packages in requirements by running
  ```
  pip install requirements.txt
  ```
* To run all tests, open terminal and navigate to folder oppenheimer-test. Run the below command in the terminal
  ```
  robot -d Output Tests
  ```
  OR
  ```
  python3 -m robot -d Output Tests
  ```
  Please note that you have to run this app https://bit.ly/3RGTBrV before running the tests.

  ## Some notes 
  * Test cases cover the happy flow of user stories only.
  * Do expect failure when running userstory4. The rest of the cases should be PASS. 

  
