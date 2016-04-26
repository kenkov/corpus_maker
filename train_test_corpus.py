#! /usr/bin/env python
# coding: utf-8


if __name__ == "__main__":
    import argparse
    import random

    parser = argparse.ArgumentParser()
    parser.add_argument(
        'corpus', metavar='corpus', type=str,
        help='corpus file'
    )
    parser.add_argument(
        'train_corpus', metavar='train_corpus', type=str,
        help='train corpus file'
    )
    parser.add_argument(
        'test_corpus', metavar='test_corpus', type=str,
        help='test corpus file'
    )
    parser.add_argument(
        '--percent', '-p', default=10, type=int,
        help='percentage of test set'
    )
    args = parser.parse_args()


    with open(args.corpus) as f:
        lines = f.readlines()
        num_lines = len(lines)
        random.shuffle(lines)

        test_num = int(num_lines * args.percent / 100)
        num_testset_lines = 0
        num_trainset_lines = 0
        with open(args.test_corpus, "w") as test_f:
            for line in (_.strip() for _ in lines[:test_num]):
                num_testset_lines += 1
                print(line, file=test_f)
        with open(args.train_corpus, "w") as train_f:
            for line in (_.strip() for _ in lines[test_num:]):
                num_trainset_lines += 1
                print(line, file=train_f)

        print(
            "total lines: {}\ntrain set lines: {}\ntest set lines: {}".format(
                num_lines,
                num_trainset_lines,
                num_testset_lines
            )
        )
