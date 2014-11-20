From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 02/13] KVM: Initialize VT-d Posted-Interrtups Descriptor
Date: Thu, 20 Nov 2014 04:53:00 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0022A04CD@SHSMSX104.ccr.corp.intel.com>
References: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
	<1415600812-27773-3-git-send-email-feng.wu@intel.com>
	<546210B1.7060007@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <546210B1.7060007-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Jiang Liu [mailto:jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, November 11, 2014 9:36 PM
> To: Wu, Feng; gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org;
> mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 02/13] KVM: Initialize VT-d Posted-Interrtups Descriptor
> 
> On 2014/11/10 14:26, Feng Wu wrote:
> > This patch initialize the VT-d Posted-interrupt Descritpor.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  arch/x86/include/asm/irq_remapping.h |    1 +
> >  arch/x86/kernel/apic/apic.c          |    1 +
> >  arch/x86/kvm/vmx.c                   |   56
> ++++++++++++++++++++++++++++++++-
> >  3 files changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/irq_remapping.h
> b/arch/x86/include/asm/irq_remapping.h
> > index b7747c4..a3cc437 100644
> > --- a/arch/x86/include/asm/irq_remapping.h
> > +++ b/arch/x86/include/asm/irq_remapping.h
> > @@ -57,6 +57,7 @@ extern bool setup_remapped_irq(int irq,
> >  			       struct irq_chip *chip);
> >
> >  void irq_remap_modify_chip_defaults(struct irq_chip *chip);
> > +extern int irq_post_enabled;
> >
> >  #else  /* CONFIG_IRQ_REMAP */
> >
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index ba6cc04..987408d 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -162,6 +162,7 @@ __setup("apicpmtimer", setup_apicpmtimer);
> >  #endif
> >
> >  int x2apic_mode;
> > +EXPORT_SYMBOL_GPL(x2apic_mode);
> >  #ifdef CONFIG_X86_X2APIC
> >  /* x2apic enabled before OS handover */
> >  int x2apic_preenabled;
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 3e556c6..a4670d3 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -45,6 +45,7 @@
> >  #include <asm/perf_event.h>
> >  #include <asm/debugreg.h>
> >  #include <asm/kexec.h>
> > +#include <asm/irq_remapping.h>
> >
> >  #include "trace.h"
> >
> > @@ -408,13 +409,32 @@ struct nested_vmx {
> >  };
> >
> >  #define POSTED_INTR_ON  0
> > +#define POSTED_INTR_SN  1
> > +
> >  /* Posted-Interrupt Descriptor */
> >  struct pi_desc {
> >  	u32 pir[8];     /* Posted interrupt requested */
> > -	u32 control;	/* bit 0 of control is outstanding notification bit */
> > -	u32 rsvd[7];
> > +	union {
> > +		struct {
> > +			u64	on	: 1,
> > +				sn	: 1,
> > +				rsvd_1	: 13,
> > +				ndm	: 1,
> > +				nv	: 8,
> > +				rsvd_2	: 8,
> > +				ndst	: 32;
> > +		};
> > +		u64 control;
> > +	};
> > +	u32 rsvd[6];
> >  } __aligned(64);
> >
> > +static void pi_clear_sn(struct pi_desc *pi_desc)
> > +{
> > +	return clear_bit(POSTED_INTR_SN,
> > +			(unsigned long *)&pi_desc->control);
> > +}
> > +
> >  static bool pi_test_and_set_on(struct pi_desc *pi_desc)
> >  {
> >  	return test_and_set_bit(POSTED_INTR_ON,
> > @@ -4396,6 +4416,33 @@ static void ept_set_mmio_spte_mask(void)
> >  	kvm_mmu_set_mmio_spte_mask((0x3ull << 62) | 0x6ull);
> >  }
> >
> > +static bool pi_desc_init(struct vcpu_vmx *vmx)
> > +{
> > +	unsigned int dest;
> > +
> > +	if (irq_post_enabled == 0)
> > +		return true;
> > +
> > +	/*
> > +	 * Initialize Posted-Interrupt Descriptor
> > +	 */
> > +
> > +	pi_clear_sn(&vmx->pi_desc);
> > +	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
> > +
> > +	/* Physical mode for Notificaiton Event */
> > +	vmx->pi_desc.ndm = 0;
> > +	dest = cpu_physical_id(vmx->vcpu.cpu);
> > +
> > +	if (x2apic_mode)
> Hi Feng,
> 	Could you try to use x2apic_enabled() here so you don't
> need to export x2apic_mode?
> Regards!
> Gerry

In that case, we should also export x2apic_enabled(), right?

Thanks,
Feng

> > +		vmx->pi_desc.ndst = dest;
> > +	else
> > +		vmx->pi_desc.ndst = (dest << 8) & 0xFF00;
> > +
> > +	return true;
> > +}
> > +
> > +
> >  /*
> >   * Sets up the vmcs for emulated real mode.
> >   */
> > @@ -4439,6 +4486,11 @@ static int vmx_vcpu_setup(struct vcpu_vmx
> *vmx)
> >
> >  		vmcs_write64(POSTED_INTR_NV, POSTED_INTR_VECTOR);
> >  		vmcs_write64(POSTED_INTR_DESC_ADDR, __pa((&vmx->pi_desc)));
> > +
> > +		if (!pi_desc_init(vmx)) {
> > +			printk(KERN_ERR "Initialize PI descriptor error!\n");
> > +			return 1;
> > +		}
> >  	}
> >
> >  	if (ple_gap) {
> >
