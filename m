From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v6 6/8] iommu, x86: Setup Posted-Interrupts capability for
	Intel iommu
Date: Fri, 22 May 2015 01:03:17 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002546B1B@SHSMSX104.ccr.corp.intel.com>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
	<1432191555-3516-7-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1505211249280.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1505211249280.4225@nanos>
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
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org]
> Sent: Thursday, May 21, 2015 6:51 PM
> To: Wu, Feng
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v6 6/8] iommu, x86: Setup Posted-Interrupts capability for Intel
> iommu
> 
> On Thu, 21 May 2015, Feng Wu wrote:
> > @@ -647,6 +647,20 @@ static int __init intel_enable_irq_remapping(void)
> > +	/*
> > +	 * Set Posted-Interrupts capability.
> > +	 */
> > +	if (!disable_irq_post) {
> > +		intel_irq_remap_ops.capability |= 1 << IRQ_POSTING_CAP;
> > +
> > +		for_each_iommu(iommu, drhd)
> > +			if (!cap_pi_support(iommu->cap)) {
> > +				intel_irq_remap_ops.capability &=
> > +						~(1 << IRQ_POSTING_CAP);
> > +				break;
> > +			}
> > +	}
> > +
> 
> > @@ -874,6 +894,20 @@ static int reenable_irq_remapping(int eim)
> > +	/*
> > +	 * Set Posted-Interrupts capability.
> > +	 */
> > +	if (!disable_irq_post) {
> > +		intel_irq_remap_ops.capability |= 1 << IRQ_POSTING_CAP;
> > +
> > +		for_each_iommu(iommu, drhd)
> > +			if (!cap_pi_support(iommu->cap)) {
> > +				intel_irq_remap_ops.capability &=
> > +						~(1 << IRQ_POSTING_CAP);
> > +				break;
> > +			}
> > +	}
> > +
> 
> Verbatim copy and paste. Ever heard about the concept of helper functions?

Good idea!

Thanks,
Feng

> 
> Thanks,
> 
> 	tglx
