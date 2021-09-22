__kernel void iterativeQuicksort(__global int *array, __global int *stack)

{
    const int chunk_size = get_global_id(0);

    //Get the starting and ending index of the given array
    int left = 0;
    int right = chunk_size - 1;

    //Top of stack
    int top = -1;

    //Temp value for swapping
    int temp;

    //Create the left:right pair and push into stack
    stack[++top] = left;
    stack[++top] = right;

    //Loop until the stack is empty
    while (top >= 0)
    {
        //Get subarray using the first left:right pair from the stack
        right = stack[top--];
        left = stack[top--];

        //Take the right element as the pivot
        int pivot = array[right];

        //Elements less than the pivot go left of idx, those greater go to the right
        int idx = left;

        /*
        Increment idx each time an element is found to be less than or equal to the pivot
        Place element before the idx
        */
        for (int i = left; i < right; i++)
        {
            if (array[i] <= pivot)
            {
                temp = array[i];
                array[i] = array[idx];
                array[idx] = temp;
                idx++;
            }
        }
      
        //Swap the idx with the pivot
        temp = array[idx];
        array[idx] = array[right];
        array[right] = temp;

        //Indices of elements less than current pivot are pushed to the stack
        if (idx - 1 > left)
        {
            stack[++top] = left;
            stack[++top] = idx - 1;
        }

        //Indices of elements greater than current pivot are pushed to the stack
        if (idx + 1 < right)
        {
            stack[++top] = idx + 1;
            stack[++top] = right;
        }
    }
}
