From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V2 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Sun, 3 Feb 2019 22:24:17 +0000
Message-ID: <DM5PR2101MB09188597928747A79A8B47A1D76C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549113287-5606-3-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
List-Id: iommu@lists.linux-foundation.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Saturday, Feb=
ruary 2, 2019 5:15 AM

I have a couple more comments ....

>=20
> +config HYPERV_IOMMU
> +	bool "Hyper-V IRQ Remapping Support"
> +	depends on HYPERV
> +	select IOMMU_API
> +	help
> +	    Hyper-V stub IOMMU driver provides IRQ Remapping capability
> +	    to run Linux guest with X2APIC mode on Hyper-V.
> +
> +

I'm a little concerned about the terminology here.  The comments and
commit messages for these patches all say that Hyper-V guests don't
have interrupt remapping support.  And we don't really *need* interrupt
remapping support because all the interrupts that should be nicely spread
out across all vCPUs (i.e., the MSI interrupts for PCI pass-thru devices) a=
re
handled via a hypercall in pci-hyperv.c, and not via the virtual IOAPIC.  S=
o
we have this stub IOMMU driver that doesn't actually do interrupt remapping=
.
It just prevents assigning the very small number of non-performance sensiti=
ve
IOAPIC interrupts to a CPU with an APIC ID above 255.

With that background, describing this feature as "Hyper-V IRQ Remapping
Support" seems incorrect, and similarly in the "help" description.  Finding
good terminology for this situation is hard.  But how about narrowing the
focus to x2APIC handling:

	bool "Hyper-V x2APIC IRQ Handling"
	...
	help
	   Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
	   guests to run with x2APIC mode enabled


> +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	struct irq_alloc_info *info =3D arg;
> +	struct irq_data *irq_data;
> +	struct irq_desc *desc;
> +	int ret =3D 0;
> +
> +	if (!info || info->type !=3D X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> +		return -EINVAL;
> +
> +	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		return ret;
> +
> +	irq_data =3D irq_domain_get_irq_data(domain, virq);
> +	if (!irq_data) {
> +		irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +		return -EINVAL;
> +	}
> +
> +	irq_data->chip =3D &hyperv_ir_chip;
> +
> +	/*
> +	 * IOAPIC entry pointer is saved in chip_data to allow
> +	 * hyperv_irq_remappng_activate()/hyperv_ir_set_affinity() to set
> +	 * vector and dest_apicid. cfg->vector and cfg->dest_apicid are
> +	 * ignorred when IRQ remapping is enabled. See ioapic_configure_entry()=
.
> +	 */
> +	irq_data->chip_data =3D info->ioapic_entry;
> +
> +	/*
> +	 * Hypver-V IO APIC irq affinity should be in the scope of
> +	 * ioapic_max_cpumask because no irq remapping support.
> +	 */
> +	desc =3D irq_data_to_desc(irq_data);
> +	cpumask_and(desc->irq_common_data.affinity,
> +			desc->irq_common_data.affinity,
> +			&ioapic_max_cpumask);

The intent of this cpumask_and() call is to ensure that IOAPIC interrupts
are initially assigned to a CPU with APIC ID < 256.   But do we know that
the initial value of desc->irq_common_data.affinity is such that the result
of the cpumask_and() will not be the empty set?  My impression is that
these local IOAPIC interrupts are assigned an initial affinity mask with al=
l
CPUs set, in which case this will work just fine.  But I'm not sure if that
is guaranteed.

An alternative would be to set the affinity to ioapic_max_cpumask and
overwrite whatever might have been previously specified.  But I don't know
if that's really better.

> +
> +	return 0;
> +}
