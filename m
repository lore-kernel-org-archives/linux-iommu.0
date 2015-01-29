From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 08/26] iommu, x86: Add intel_irq_remapping_capability() for
	Intel
Date: Thu, 29 Jan 2015 08:57:54 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0023896B8@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-9-git-send-email-feng.wu@intel.com>
	<1422459450.5293.62.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422459450.5293.62.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: David Woodhouse [mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org]
> Sent: Wednesday, January 28, 2015 11:38 PM
> To: Wu, Feng
> Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 08/26] iommu, x86: Add intel_irq_remapping_capability() for
> Intel
> 
> On Fri, 2014-12-12 at 23:14 +0800, Feng Wu wrote:
> > Add the Intel side implementation for capability in
> > struct irq_remap_ops.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> > +static bool intel_irq_remapping_capability(enum irq_remap_cap cap)
> > +{
> > +	struct dmar_drhd_unit *drhd;
> > +	struct intel_iommu *iommu;
> > +
> > +	switch (cap) {
> > +	case IRQ_POSTING_CAP:
> > +		/*
> > +		 * If 1) posted-interrupts is disabled by user
> > +		 * or 2) irq remapping is disabled, posted-interrupts
> > +		 * is not supported.
> > +		 */
> > +		if (disable_irq_post || !irq_remapping_enabled)
> > +			return 0;
> > +
> > +		for_each_iommu(iommu, drhd)
> > +			if (!cap_pi_support(iommu->cap))
> > +				return 0;
> > +
> 
> If a new IOMMU is hotplugged now which doesn't support posted
> interrupts, what happens?

Good question, Just had a offline discussion with Jiang Liu, actually, there
is the same question for IR. In the current implementation, If IR is in use
and a new IOMMU without IR capability is hotplugged, it will reject this
hotplugging. I think I can simple follow the same policy for PI.

Thanks,
Feng

> 
> --
> David Woodhouse                            Open Source Technology
> Centre
> David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel
> Corporation
