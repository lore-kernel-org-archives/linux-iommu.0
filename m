From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on
 iommu driver initialization
Date: Wed, 19 Jul 2017 15:12:54 +1000
Message-ID: <1500441174.3350.19.camel@au1.ibm.com>
References: <20170630052436.15212-1-aik@ozlabs.ru>
         <20170630052436.15212-5-aik@ozlabs.ru>
         <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
         <2391df16-2095-315b-e091-3e3eb69bb668@arm.com>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2391df16-2095-315b-e091-3e3eb69bb668@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Yongji Xie <elohimes@gmail.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2017-07-11 at 11:39 +0100, Robin Murphy wrote:
> I have no idea what the context is here, but this flag looks wrong
> generally. IRQ remapping is a property of the irqchip and has nothing to
> do with PCI, so pretending it's a property of PCI buses looks like a
> massive hack around... something.
> 
> Also, iommu_capable() is a fundamentally broken and unworkable interface
> anyway. The existing IRQ remapping code really wants updating to
> advertise IRQ_DOMAIN_FLAG_MSI_REMAP on the relevant MSI domains so that
> IOMMU_CAP_INTR_REMAP can go away for good. That way, all consumers who
> actually care about whether IRQ remapping is implemented (see e.g. VFIO)
> can use irq_domain_check_msi_remap() or check specific devices in a sane
> and scalable manner.

As you rightfully said, you have no idea what the context is :-)

This is not an interrupt domain.

On powerpc we have a single global unified domains that contains all
our MSIs, IPIs, internally interrupts and what not, because of the way
our interrupts infrastructure works.

So there is no such thing as "a property of the MSI domain".

The way the HW works is that the PCI Host Bridge has the ability
to filter which device can access which MSIs. This is done by the IOMMU
portion of the bridge.

Thus it's a filtering capability, not a remapping capability per-se,
and it's a property of the IOMMU domain.

Sicne this is also a paravitualized interface, the "remapping" part
is handled by the HV calls done by the guest to configure the MSIs.

The HW filtering ensures that an evil guest cannot do bad things if
it goes manually whack the MSI table.

Now this issue have been discussed and patches floated around for
*YEARS* now and there is still no upstream solution for what is a
completely trivial problem: Don't bloody bloock MSI BAR table access on
pseries platforms. It kills performance on a number of device due to
our 64K pages.

A 1-liner fix in qemu would have done it YEARS ago. But instead we have
now painted about 1000 bike sheds and going without anything that
actually works. Yay.

Ben.
