From: "Mehta, Sohil" <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu/vt-d: Add Intel IOMMU debugfs to show
	extended context internals
Date: Thu, 7 Dec 2017 20:30:28 +0000
Message-ID: <1512678653.120652.23.camel@intel.com>
References: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
	<1512531807-24268-4-git-send-email-sohil.mehta@intel.com>
	<5A27A787.2060307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A27A787.2060307-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Content-ID: <F396509BD8113841A12BCAE741B3C527-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Yu, Fenghua" <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shevchenko,
	Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shankar,
	Ravi V" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Kammela,
	Gayatri" <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2017-12-06 at 16:17 +0800, Lu Baolu wrote:
> Hi,
> 
> On 12/06/2017 11:43 AM, Sohil Mehta wrote:
> > 
> > From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > +
> > +	if (new_ext) {
> > +		seq_printf(m, "Higher Context tbl entries for Bus:
> > %d\n", bus);
> > +		ctx_lo = context[0].lo;
> > +
> > +		if (!(ctx_lo & CONTEXT_PASIDE)) {
> > +			context[1].hi = (u64)virt_to_phys(
> > +					iommu->pasid_state_table);
> > +			context[1].lo = (u64)virt_to_phys(iommu-
> > >pasid_table) |
> > +					intel_iommu_get_pts(iommu)
> > ;
> Why do you change the context entries here?
> 

Thanks for catching this. The context entires were mistakenly getting
changed. We'll remove it.
