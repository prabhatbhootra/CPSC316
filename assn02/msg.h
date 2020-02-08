/*
 * msg.h -- List of messages for P- compiler
 *
 * Prabhat Bhootra
 *
 * Date:
 * Modification History:
 *
 */

/* Some error definitions for the scanner */
#define mnKeywordFound                     0
#define mnUnknownChar                      1
#define mnIllegalString                    2
#define mnLegalInteger  		   3
#define mnLegalIdentifier		   4
#define mnLegalFloat                       5
#define mnLegalString		           6
#define mnSimpleOperator		   7
#define mnCompoundOperator		   8

/* Actual messages */
static char *message[] = {
    "%s: %d: keyword '%s' found\n",
    "%s: %d: unknown character %#x\n",
    "%s: %d: illegal string\n",
    "%s: %d: integer '%s'\n",
    "%s: %d: identifier '%s'\n",
    "%s: %d: float '%s'\n",
    "%s: %d: string '%s'\n",
    "%s: %d: simple operator '%s'\n",
    "%s: %d: compound operator '%s'\n"
};
