def find_fixed_point(arr, left, right):
    length = right - left


    if length == 1:
        if arr[left] == left:
            return left
        else:
            return -1

    mid = left + length // 2
    print(left, right, mid)

    if arr[mid] < mid:
        return find_fixed_point(arr, mid + 1, right)
    elif arr[mid] > mid:
        return find_fixed_point(arr, left, mid)
    else:
        return mid


fin = open('C:/Users/Mihai/Desktop/tap probleme multe/di/fix.txt')

n = int(next(fin))
nums = [int(x) for x in next(fin).split()]

fixed = find_fixed_point(nums, 0, n)

print(fixed)
