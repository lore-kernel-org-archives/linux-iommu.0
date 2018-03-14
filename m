From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
Date: Wed, 14 Mar 2018 10:24:56 -0500
Message-ID: <08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
	<CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
	<30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
	<CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/13/2018 03:23 PM, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
>> On 03/13/2018 12:16 PM, Andy Shevchenko wrote:
>>> On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
> 
>>>> +#include <linux/pci.h>
>>>> +#include <linux/iommu.h>
>>>> +#include <linux/debugfs.h>
>>>
>>>
>>> Keep in order?
> 
>> What order would that be? These few needed files are listed in the same
>> order as which they appear in amd_iommu.c. I'm gonna need a preference
>> spelled out, please (and a rationale, so I may better understand).
> 
> To increase readability and avoid potential header duplication (here
> is can bus protocol implementation where the problem exists for real,
> even in new code!)

With all due respect, I don't find that you clearly answered my 
question. I will hazard a guess that you mean to -alphabetize- them? 
Which I am happy to do, and will do so in the next version.

If that is not your meaning, I'll have to ask you to use small words, 
and not presume any understanding on my (or anyone's) part about 
preferences that are not documented in the style guide. I don't mean to 
be thick, but I have to ask for clarity.

Given that this is a preference, and that there are reasons for -not- 
doing so, I would also like to hear other comments on this suggestionn.


>>>> +       for (i = start ; i <= end ; i++)
> 
>>> Missed {}
> 
>> Wasn't sure about the M.O. given that the body of this loop is a single if
>> statement. And I don't see anywhere in
>> https://www.kernel.org/doc/html/latest/process/coding-style.html
>> in section 3.1 where curly braces are called for in this situation. May I
>> ask for clarification on the style rule, please?
> 
> You can do nothing, though I'm guided by the end of section 3.0
> (though it tells only about 'if' case).

Fixed this.

> 
>>>> @@ -89,6 +89,7 @@
>>>>    #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>>>
>>>>    #define LOOP_TIMEOUT   100000
>>>> +
>>>>    /*
>>>>     * ACPI table definitions
>>>>     *
> 
>>> Doesn't belong to the patch.
> 
>> I'm sorry, I don't understand. The added blank line doesn't belong to the
>> patch?
> 
> Correct.
> 
Fixed this.

Thanks,
Gary
