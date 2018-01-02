From: "Kammela, Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v5 2/5] iommu/vt-d: Add debugfs support to show context
	internals
Date: Tue, 2 Jan 2018 21:01:23 +0000
Message-ID: <2824B99DC70CE746926327C52CA42F7648404FBF@ORSMSX111.amr.corp.intel.com>
References: <1513902760-45605-1-git-send-email-sohil.mehta@intel.com>
	<1513902760-45605-3-git-send-email-sohil.mehta@intel.com>
	<1514451118.7000.308.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1514451118.7000.308.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Shankar, Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu,
	Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Andy Shevchenko [mailto:andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Thursday, December 28, 2017 12:52 AM
> To: Mehta, Sohil <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>;
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Raj, Ashok
> <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Kammela,
> Gayatri <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Shankar, Ravi V
> <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Yu, Fenghua
> <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: Re: [PATCH v5 2/5] iommu/vt-d: Add debugfs support to show context
> internals
> 
> On Thu, 2017-12-21 at 16:32 -0800, Sohil Mehta wrote:
> > From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > IOMMU internals states such as root and context can be exported to the
> > userspace.
> >
> > Example of such dump in Kabylake:
> 
> > v5: Change to a SPDX license tag
> >     Fix seq_printf formatting
> >
> >
> 
> > +#define pr_fmt(fmt)     "INTEL_IOMMU: " fmt
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/pci.h>
> > +#include <linux/iommu.h>
> > +#include <linux/intel-iommu.h>
> > +#include <linux/intel-svm.h>
> > +#include <linux/dmar.h>
> > +#include <linux/spinlock.h>
> 
> It might make sense to keep above ordered alphabetically.
Sure Andy!
> 
> > +static void root_tbl_entry_show(struct seq_file *m, struct
> > intel_iommu *iommu,
> > +				u64 rtaddr_reg, bool ext, bool
> > new_ext)
> > +{
> > +	int bus;
> > +
> > +	seq_printf(m, "\nIOMMU %s: %2s Root Table Addr:%llx\n",
> > iommu->name,
> > +		   ext ? "Extended" : "", rtaddr_reg);
> 
> Still leading '\n'...
My bad, will correct it
> 
> --
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Intel Finland Oy
