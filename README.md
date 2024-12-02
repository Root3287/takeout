# Takeout

A simple program to determine if you can takeout or cook in. 
Based on https://www.youtube.com/shorts/httSoD5uiww.

This is just a way that I can run performance testing/test with batch jobs processing.

# Requirements

## Premake5
> Repo: [https://github.com/premake/premake-core](https://github.com/premake/premake-core)

## Building
----
1. Clone this repo with submodules
2. ```premake5 gmake2```
3. ```make -C workspace/ config=release```
4. Done!

## Running
All executable will be in the ```./bin``` directory after a build.

Best to run with GNU parallels

```
parallel \\
	--joblog ./takeout.joblog \\
	--resume \\
	--results ./takeout.csv \\
	./path/to/takeout -w {1} -t {2} -g {3} -c {4} -o {5} ::: $(seq 10 5 60) ::: $(seq 5 5 200) ::: $(seq 0 5 500) ::: $(seq 0 0.08334 4) ::: $(seq 0 0.08334 1)
```

This runs `./path/to/takeout` in parallel with wages ranging 10-60 increment by 5, takeout price 5-200 incrementing by 5, groceries price ranging 0-500 incrementing by 5, cooking time 0-4 hours incrementing by approx 5 minutes, ordering time ranging from 0-1 hours incrementing approximatly by 5 minutes.
The results are saved to `takeout.csv` 
This also saves a joblog and resumes if a job log is present.

## License
View the License.md
