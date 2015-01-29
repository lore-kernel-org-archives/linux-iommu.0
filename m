From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 04/26] iommu, x86: Implement irq_set_vcpu_affinity for
	intel_ir_chip
Date: Thu, 29 Jan 2015 07:55:24 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002389312@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-5-git-send-email-feng.wu@intel.com>
	<1422458811.5293.56.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422458811.5293.56.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
> Sent: Wednesday, January 28, 2015 11:27 PM
> To: Wu, Feng
> Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 04/26] iommu, x86: Implement irq_set_vcpu_affinity for
> intel_ir_chip
> 
> On Fri, 2014-12-12 at 23:14 +0800, Feng Wu wrote:
> > Implement irq_set_vcpu_affinity for intel_ir_chip.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Acked-by: David.Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> assuming a
> suitable answer to...
> 
> > +		vcpu_pi_info = (struct vcpu_data *)vcpu_info;
> > +		memcpy(irte_pi, &ir_data->irte_entry, sizeof(struct irte));
> > +
> > +		irte_pi->urg = 0;
> > +		irte_pi->vector = vcpu_pi_info->vector;
> > +		irte_pi->pda_l = (vcpu_pi_info->pi_desc_addr >>
> > +				 (32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
> > +		irte_pi->pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
> > +				 ~(-1UL << PDA_HIGH_BIT);
> > +
> > +		irte_pi->__reserved_1 = 0;
> > +		irte_pi->__reserved_2 = 0;
> > +		irte_pi->__reserved_3 = 0;
> > +		irte_pi->__reserved_4 = 0;
> 
> .... do we need a barrier here before we set this bit?

Thanks a lot for your Ack, David!

I cannot find a reason why we need a barrier here, since 'irte_pi' is only a local
variant here, the real operation to program hardware occurs in modify_irte(), in
which spin lock is acquired, this means the there is an implicit barrier there.

Thanks,
Feng

> 
> > +		irte_pi->pst = 1;
> > +
> > +		modify_irte(&ir_data->irq_2_iommu, (struct irte *)irte_pi);
> 
> 
> --
> dwmw2
