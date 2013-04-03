From: Stuart Yoder <b08248@gmail.com>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 14:09:45 -0500
Message-ID: <CALRxmdDHYp1+svjwDrhMc9w2p7H8t87PphEZ1t+97C-EHDR+3g@mail.gmail.com>
References: <1364943035.24520.28@snotra>
	<1364960240.2882.230.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364960240.2882.230.camel@bling.home>
Sender: kvm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Wood <scottwood@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yoder Stuart-B08248 <B08248@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: iommu@lists.linux-foundation.org

> Would is be possible for userspace to simply leave room for MSI bank
> mapping (how much room could be determined by something like
> VFIO_IOMMU_GET_MSI_BANK_COUNT) then document the API that userspace can
> DMA_MAP starting at the 0x0 address of the aperture, growing up, and
> VFIO will map banks on demand at the top of the aperture, growing down?
> Wouldn't that avoid a lot of issues with userspace needing to know
> anything about MSI banks (other than count) and coordinating irq numbers
> and enabling handlers?

This is basically option #A in the original proposals sent.   I like
this approach, in that it
is simpler and keeps user space mostly out of this...which is
consistent with how things are done
on x86.  User space just needs to know how many windows to leave at
the top of the aperture.
The kernel then has the flexibility to use those windows how it wants.

But one question, is when should the kernel actually map (and unmap)
the MSI banks.   One thing we need to do is enable the aperture...and current
thinking is that is done on the first DMA_MAP.   Similarly when the last mapping
is unmapped we could also umap the MSI banks.

Sequence would be something like:

        VFIO_GROUP_SET_CONTAINER     // add groups to the container

        VFIO_SET_IOMMU(VFIO_FSL_PAMU)    // set iommu model

        cnt = VFIO_IOMMU_GET_MSI_BANK_COUNT    // returns max # of MSI banks

        VFIO_IOMMU_SET_ATTR(ATTR_GEOMETRY) // set overall aperture

        VFIO_IOMMU_SET_ATTR(ATTR_WINDOWS) // set # of windows,
including MSI banks

        VFIO_IOMMU_MAP_DMA    // map the guest's memory
               ---> kernel enables aperture and maps needed MSI banks here

        VFIO_DEVICE_SET_IRQS
               ---> kernel sets actual MSI addr/data in physical
device here (I think)


Stuart
