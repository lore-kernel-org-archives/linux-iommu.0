From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 2/5] iommu/vt-d: Add debugfs support to show context
	internals
Date: Thu, 28 Dec 2017 10:51:58 +0200
Message-ID: <1514451118.7000.308.camel@linux.intel.com>
References: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
	<1513902760-45605-3-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513902760-45605-3-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2017-12-21 at 16:32 -0800, Sohil Mehta wrote:
> From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> IOMMU internals states such as root and context can be exported to the
> userspace.
> 
> Example of such dump in Kabylake:

> v5: Change to a SPDX license tag
>     Fix seq_printf formatting
> 
> 

> +#define pr_fmt(fmt)     "INTEL_IOMMU: " fmt
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/debugfs.h>
> +#include <linux/pci.h>
> +#include <linux/iommu.h>
> +#include <linux/intel-iommu.h>
> +#include <linux/intel-svm.h>
> +#include <linux/dmar.h>
> +#include <linux/spinlock.h>

It might make sense to keep above ordered alphabetically.

> +static void root_tbl_entry_show(struct seq_file *m, struct
> intel_iommu *iommu,
> +				u64 rtaddr_reg, bool ext, bool
> new_ext)
> +{
> +	int bus;
> +
> +	seq_printf(m, "\nIOMMU %s: %2s Root Table Addr:%llx\n",
> iommu->name,
> +		   ext ? "Extended" : "", rtaddr_reg);

Still leading '\n'...

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
