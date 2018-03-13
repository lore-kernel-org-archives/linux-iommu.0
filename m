From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
Date: Tue, 13 Mar 2018 19:16:44 +0200
Message-ID: <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
	<152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152055664720.63229.16209149030018336339.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:

> +       default n

Redundant


> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/debugfs.h>

Keep in order?

> +#include "amd_iommu_proto.h"
> +#include "amd_iommu_types.h"

> +/* DebugFS helpers */
> +#define        OBUFP           (obuf + oboff)
> +#define        OBUFLEN         obuflen
> +#define        OBUFSPC         (OBUFLEN - oboff)
> +#define        OSCNPRINTF(fmt, ...) \
> +               scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)

I don't see any advantages of this. Other way around, they will simple
makes things hard to read an understand in place.


> +       for (i = start ; i <= end ; i++)

Missed {}

> +               if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
> +                   || amd_iommu_dev_table[i].data[1])
> +                       n++;
> +       return n;
> +}

> +
> +static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
> +                                         char __user *ubuf,
> +                                         size_t count, loff_t *offp)
> +{
> +       struct amd_iommu *iommu = filp->private_data;

> +       unsigned int obuflen = 512;

Sounds like way too much.

> +       if (!iommu)
> +               return 0;

When this possible?

> +       obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +       if (!obuf)
> +               return -ENOMEM;
> +
> +       n = amd_iommu_count_valid_dtes(0, 0xFFFF);
> +       oboff += OSCNPRINTF("%d\n", n);

> +       return ret;
> +}


> @@ -89,6 +89,7 @@
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>
>  #define LOOP_TIMEOUT   100000
> +
>  /*
>   * ACPI table definitions
>   *

Doesn't belong to the patch.

> +#endif
> +
> +

Extra unneeded line.

-- 
With Best Regards,
Andy Shevchenko
