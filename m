From: jacob pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Tue, 21 Mar 2017 13:56:25 -0700
Message-ID: <20170321135625.0000229b@intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
        <20170227195441.5170-30-jean-philippe.brucker@arm.com>
        <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
        <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Harv Abdulhamid <harba@qti.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nate Watterson <nwatters@qti.qualcomm.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson <alex.williamson>
List-Id: iommu@lists.linux-foundation.org

On Tue, 21 Mar 2017 19:37:56 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> > For invalidation, I've following info in in pseudo code.
> > struct iommu_svm_tlb_invalidate_info
> > {
> >        __u32 inv_type;
> > #define IOTLB_INV			(1 << 0)
> > #define EXTENDED_IOTLB_INV		(1 << 1)
> > #define DEVICE_IOTLB_INV		(1 << 2)
> > #define EXTENDED_DEVICE_IOTLB_INV	(1 << 3)
> > #define PASID_CACHE_INV		(1 << 4)
> >        __u32 pasid;
> >        __u64 addr;
> >        __u64 size;
> >        __u8 granularity;
> > #define DEFAULT_INV_GRN        0
> > #define PAGE_SELECTIVE_INV     (1 << 0)
> > #define PASID_SELECVIVE_INV    (1 << 1)
> >        __u64 flags;
> > #define INVALIDATE_HINT_BIT    (1 << 0)
> > #define GLOBAL_HINT_BIT        (1 << 1)
> > #define DRAIN_READ_BIT         (1 << 2)
> > #define DRAIN_WRITE_BIT        (1 << 3)
> > #define DEVICE_TLB_GLOBAL_BIT  (1 << 4)
> >        __u8 mip;
> >        __u16 pfsid;
> > };  
> 
> This would also benefit from being split into generic and
> architectural parts. Former would be defined in VFIO, latter would be
> in the IOMMU driver.
> 
> struct tlb_invalidate_info
> {
> 	__u8 granularity
> #define DEFAULT_INV_GRN		0	/* What is default? */
> #define PAGE_SELECTIVE_INV	(1 << 0)
> #define PASID_SELECTIVE_INV	(1 << 1)
> 	__u32 pasid;
> 	__u64 addr;
> 	__u64 size;
> 
> 	/* Since IOMMU format has already been validated for this
> table, the IOMMU driver knows that the following structure is in a
> 	   format it knows */
> 	__u8 opaque[];
> };
> 
> struct tlb_invalidate_info_intel
> {
> 	__u32 inv_type;
> 	...
> 	__u64 flags;
> 	...
> 	__u8 mip;
> 	__u16 pfsid;
> };

I presume for Intel/arch specific part, the opaque data can simply be
the descriptor itself. i.e. struct qi_desc. There is no need to
generalize since it has already been validated to be architecture
specific data.

Arch specific IOMMU driver can take further action on the opaque data,
e.g. replace guest DID with host DID based on other info passed down
from the caller.
