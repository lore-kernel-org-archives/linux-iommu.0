From: Tianyu Lan <lantianyu1986@gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 1 Feb 2019 13:45:08 +0800
Message-ID: <CAOLK0pwZMT-KQrjZBNO4kpxiuT_J_6UjdW9FcQNyvahNOMqe3Q@mail.gmail.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <87k1ikylcn.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1ikylcn.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org, davem@davemloft.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, kys@microsoft.com, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Hi Vitaly:
            Thanks for your review.

On Thu, Jan 31, 2019 at 10:04 PM Vitaly Kuznetsov <vkuznets@redhat.com> wro=
te:
>
> lantianyu1986@gmail.com writes:
>
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > On the bare metal, enabling X2APIC mode requires interrupt remapping
> > function which helps to deliver irq to cpu with 32-bit APIC ID.
> > Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> > MSI protocol already supports to deliver interrupt to the CPU whose
> > virtual processor index is more than 255. IO-APIC interrupt still has
> > 8-bit APIC ID limitation.
> >
> > This patch is to add Hyper-V stub IOMMU driver in order to enable
> > X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2A=
PIC
> > interrupt remapping capability when X2APIC mode is available. Otherwise=
,
> > it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> > and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  drivers/iommu/Kconfig         |   7 ++
> >  drivers/iommu/Makefile        |   1 +
> >  drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/iommu/irq_remapping.c |   3 +
> >  drivers/iommu/irq_remapping.h |   1 +
> >  5 files changed, 201 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv-iommu.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 45d7021..5c397c0 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -437,4 +437,11 @@ config QCOM_IOMMU
> >       help
> >         Support for IOMMU on certain Qualcomm SoCs.
> >
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V stub IOMMU support"
> > +     depends on HYPERV
> > +     help
> > +         Hyper-V stub IOMMU driver provides capability to run
> > +         Linux guest with X2APIC mode enabled.
> > +
> >  endif # IOMMU_SUPPORT
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index a158a68..8c71a15 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
> >  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
> >  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
> >  obj-$(CONFIG_QCOM_IOMMU) +=3D qcom_iommu.o
> > +obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.=
c
> > new file mode 100644
> > index 0000000..a64b747
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
> > +
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/iommu.h>
> > +#include <linux/module.h>
> > +
> > +#include <asm/hw_irq.h>
> > +#include <asm/io_apic.h>
> > +#include <asm/irq_remapping.h>
> > +#include <asm/hypervisor.h>
> > +
> > +#include "irq_remapping.h"
> > +
> > +/*
> > + * According IO-APIC spec, IO APIC has a 24-entry Interrupt
> > + * Redirection Table.
> > + */
> > +#define IOAPIC_REMAPPING_ENTRY 24
>
> KVM already defines KVM_IOAPIC_NUM_PINS - is this the same thing?

It's the same purpose  IOMMU driver is out of KVM scope and so define a new=
 one.
Otherwise, this maybe changed in the future when add interrupt
remapping function.

>
> > +
> > +static cpumask_t ioapic_max_cpumask =3D { CPU_BITS_NONE };
> > +struct irq_domain *ioapic_ir_domain;
> > +
> > +static int hyperv_ir_set_affinity(struct irq_data *data,
> > +             const struct cpumask *mask, bool force)
> > +{
> > +     struct irq_data *parent =3D data->parent_data;
> > +     struct irq_cfg *cfg =3D irqd_cfg(data);
> > +     struct IO_APIC_route_entry *entry;
> > +     cpumask_t cpumask;
> > +     int ret;
> > +
> > +     cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
> > +
> > +     /* Return error If new irq affinity is out of ioapic_max_cpumask.=
 */
> > +     if (!cpumask_empty(&cpumask))
> > +             return -EINVAL;
> > +
> > +     ret =3D parent->chip->irq_set_affinity(parent, mask, force);
> > +     if (ret < 0 || ret =3D=3D IRQ_SET_MASK_OK_DONE)
> > +             return ret;
> > +
> > +     entry =3D data->chip_data;
> > +     entry->dest =3D cfg->dest_apicid;
> > +     entry->vector =3D cfg->vector;
> > +     send_cleanup_vector(cfg);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct irq_chip hyperv_ir_chip =3D {
> > +     .name                   =3D "HYPERV-IR",
> > +     .irq_ack                =3D apic_ack_irq,
> > +     .irq_set_affinity       =3D hyperv_ir_set_affinity,
> > +};
> > +
> > +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> > +                                  unsigned int virq, unsigned int nr_i=
rqs,
> > +                                  void *arg)
> > +{
> > +     struct irq_alloc_info *info =3D arg;
> > +     struct IO_APIC_route_entry *entry;
> > +     struct irq_data *irq_data;
> > +     struct irq_desc *desc;
> > +     struct irq_cfg *cfg;
> > +     int ret =3D 0;
> > +
> > +     if (!info || info->type !=3D X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs=
 > 1)
> > +             return -EINVAL;
> > +
> > +     ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> > +     if (ret < 0)
> > +             goto fail;
> > +
> > +     irq_data =3D irq_domain_get_irq_data(domain, virq);
> > +     cfg =3D irqd_cfg(irq_data);
> > +     if (!irq_data || !cfg) {
> > +             ret =3D -EINVAL;
> > +             goto fail;
> > +     }
>
> fail: label doesn't do anything, you can just return (and you actually
> do on the first failure path).

Yes=EF=BC=8Cwill update.

>
> > +
> > +     irq_data->chip =3D &hyperv_ir_chip;
> > +
> > +     /*
> > +      * Save IOAPIC entry pointer here in order to set vector and
> > +      * and dest_apicid in the hyperv_irq_remappng_activate()
>
> and and

Nice catch.

>
> > +      * and hyperv_ir_set_affinity(). IOAPIC driver ignores
> > +      * cfg->dest_apicid and cfg->vector when irq remapping
> > +      * mode is enabled. Detail see ioapic_configure_entry().
>
> I would re-phrase this a bit:
>
> /*
>  * IOAPIC entry pointer is saved in chip_data to allow
>  * hyperv_irq_remappng_activate()/hyperv_ir_set_affinity() to set
>  * vector and dest_apicid. cfg->vector and cfg->dest_apicid are
>  * ignorred when IRQ remapping is enabled. See ioapic_configure_entry().
>  */
>
> But I'm still a bit confused. Hope others are not.

This is better. Thanks.

>
> > +      */
> > +     irq_data->chip_data =3D entry =3D info->ioapic_entry;
> > +
>
> I personally dislike double assignments, hard to remember which one
> happens first :-)

OK. will update.

>
> > +     /*
> > +      * Hypver-V IO APIC irq affinity should be in the scope of
> > +      * ioapic_max_cpumask because no irq remapping support.
> > +      */
> > +     desc =3D irq_data_to_desc(irq_data);
> > +     cpumask_and(desc->irq_common_data.affinity,
> > +                     desc->irq_common_data.affinity,
> > +                     &ioapic_max_cpumask);
> > +
> > + fail:
> > +     return ret;
> > +}
> > +
> > +static void hyperv_irq_remapping_free(struct irq_domain *domain,
> > +                              unsigned int virq, unsigned int nr_irqs)
> > +{
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static int hyperv_irq_remappng_activate(struct irq_domain *domain,
> > +                       struct irq_data *irq_data, bool reserve)
> > +{
> > +     struct irq_cfg *cfg =3D irqd_cfg(irq_data);
> > +     struct IO_APIC_route_entry *entry =3D irq_data->chip_data;
> > +
> > +     entry->dest =3D cfg->dest_apicid;
> > +     entry->vector =3D cfg->vector;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct irq_domain_ops hyperv_ir_domain_ops =3D {
> > +     .alloc =3D hyperv_irq_remapping_alloc,
> > +     .free =3D hyperv_irq_remapping_free,
> > +     .activate =3D hyperv_irq_remappng_activate,
> > +};
> > +
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     u32 apic_id;
> > +     int i;
> > +
> > +     if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV ||
> > +         !x2apic_supported())
> > +             return -ENODEV;
> > +
> > +     fn =3D irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +     if (!fn)
> > +             return -EFAULT;
> > +
> > +     ioapic_ir_domain =3D
> > +             irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> > +                             0, IOAPIC_REMAPPING_ENTRY, fn,
> > +                             &hyperv_ir_domain_ops, NULL);
> > +
> > +     irq_domain_free_fwnode(fn);
> > +
> > +     /*
> > +      * Hyper-V doesn't provide irq remapping function for
> > +      * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> > +      * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
> > +      * and set cpu into ioapic_max_cpumask if its APIC ID is less
> > +      * than 255.
> > +      */
> > +     for (i =3D 0; i < 256; i++) {
> > +             apic_id =3D cpu_physical_id(i);
> > +             if (apic_id > 255)
> > +                     continue;
> > +
> > +             cpumask_set_cpu(i, &ioapic_max_cpumask);
> > +     }
>
> This is probably not an issue right now, but what if we have > 256 CPUs?
> Assuming there are no CPUs with the same APIC is, would it be better to
> go through all of them seeting bits in ioapic_max_cpumask accordingly?
> (Imagine a situation when CPU257 has APIC id =3D 1).

The APiC ID assignment with "CPUx"accords the order of local APIC
entry in the ACPI MADT table.
We got that the order will be monotonic increasing from Hyper-V team
.I will add this in the comment
to avoid confusion. APIC IDs reflects cpu topology and so there maybe
some APIC ID gaps(e.g, cpu
number in one socket is a number of  power of 2).

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init hyperv_enable_irq_remapping(void)
> > +{
> > +     return IRQ_REMAP_X2APIC_MODE;
> > +}
> > +
> > +static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_in=
fo *info)
> > +{
> > +     if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_IOAPIC)
> > +             return ioapic_ir_domain;
> > +     else
> > +             return NULL;
> > +}
> > +
> > +struct irq_remap_ops hyperv_irq_remap_ops =3D {
> > +     .prepare                =3D hyperv_prepare_irq_remapping,
> > +     .enable                 =3D hyperv_enable_irq_remapping,
> > +     .get_ir_irq_domain      =3D hyperv_get_ir_irq_domain,
> > +};
> > diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remappin=
g.c
> > index b94ebd4..81cf290 100644
> > --- a/drivers/iommu/irq_remapping.c
> > +++ b/drivers/iommu/irq_remapping.c
> > @@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
> >       else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
> >                amd_iommu_irq_ops.prepare() =3D=3D 0)
> >               remap_ops =3D &amd_iommu_irq_ops;
> > +     else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> > +              hyperv_irq_remap_ops.prepare() =3D=3D 0)
> > +             remap_ops =3D &hyperv_irq_remap_ops;
> >       else
> >               return -ENOSYS;
>
> Here we act under assumption that Intel/AMD IOMMUs will never be exposed
> under Hyper-V. It may make sense to actually reverse the order of the
> check: check PV IOMMUs _before_ we actually check for hardware ones.

Yes, this will be better for Hyper-V case but KVM guest and bare metal
use Intel/AMD
IOMMU driver. The function is just called once during boot up and so check =
order
will not affect boot time too much.

@Joerg Roedel Could you have a look this? Thanks.
