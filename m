From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
Date: Tue, 13 Mar 2018 13:54:00 -0500
Message-ID: <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
	<CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On 03/13/2018 12:16 PM, Andy Shevchenko wrote:
> On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
> 
>> +       default n
> 
> Redundant

Roger that.

>> +#include <linux/pci.h>
>> +#include <linux/iommu.h>
>> +#include <linux/debugfs.h>
> 
> Keep in order?

What order would that be? These few needed files are listed in the same
order as which they appear in amd_iommu.c. I'm gonna need a preference
spelled out, please (and a rationale, so I may better understand).

>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
> 
>> +/* DebugFS helpers */
>> +#define        OBUFP           (obuf + oboff)
>> +#define        OBUFLEN         obuflen
>> +#define        OBUFSPC         (OBUFLEN - oboff)
>> +#define        OSCNPRINTF(fmt, ...) \
>> +               scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
> 
> I don't see any advantages of this. Other way around, they will simple
> makes things hard to read an understand in place.

I used this technique in the CCP driver code (where it was accepted), in 
an effort to do the opposite of what you claim: make the code more 
readable. Given the 80 column limit, a large number of arguments, and 
very long statements, IMO something needs to give. I don't find the use 
of #defines to be obfuscating.

I'm not trying to argue, but rather simply state the perspective / 
reasoning I used to create a source file I feel is manageable. I have 17 
more iommu patches built upon this strategy, and this seems to be 
advantageous for all of them.

> 
> 
>> +       for (i = start ; i <= end ; i++)
> 
> Missed {}

Wasn't sure about the M.O. given that the body of this loop is a single 
if statement. And I don't see anywhere in
https://www.kernel.org/doc/html/latest/process/coding-style.html
in section 3.1 where curly braces are called for in this situation. May 
I ask for clarification on the style rule, please?

> 
>> +               if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
>> +                   || amd_iommu_dev_table[i].data[1])
>> +                       n++;
>> +       return n;
>> +}
> 
>> +
>> +static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
>> +                                         char __user *ubuf,
>> +                                         size_t count, loff_t *offp)
>> +{
>> +       struct amd_iommu *iommu = filp->private_data;
> 
>> +       unsigned int obuflen = 512;
> 
> Sounds like way too much.

I can tune these up.

> 
>> +       if (!iommu)
>> +               return 0;
> 
> When this possible?

It was intended as a sanity check, but if this happens, much worse has 
already gone wrong. I'll remove.

> 
>> +       obuf = kmalloc(OBUFLEN, GFP_KERNEL);
>> +       if (!obuf)
>> +               return -ENOMEM;
>> +
>> +       n = amd_iommu_count_valid_dtes(0, 0xFFFF);
>> +       oboff += OSCNPRINTF("%d\n", n);
> 
>> +       return ret;
>> +}
> 
> 
>> @@ -89,6 +89,7 @@
>>   #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>
>>   #define LOOP_TIMEOUT   100000
>> +
>>   /*
>>    * ACPI table definitions
>>    *
> 
> Doesn't belong to the patch.

I'm sorry, I don't understand. The added blank line doesn't belong to 
the patch?

> 
>> +#endif
>> +
>> +
> 
> Extra unneeded line.
> 
Thanks,
