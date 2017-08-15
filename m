From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 0/4] Patches to support ring0 SVM and devtlb
Date: Tue, 15 Aug 2017 07:59:29 -0700
Message-ID: <20170815145928.GA56170@otc-nc-03>
References: <1502224170-5344-1-git-send-email-ashok.raj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502224170-5344-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Jacob Pan <jacob.jun.pan@intel.com>, CQ Tang <cq.tang@intel.com>, Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>, ashok.raj@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg

I haven't received any update to this patchset.. 

Could you help get this merged through your tree? we have tested this
series internally.

Cheers,
Ashok

On Tue, Aug 08, 2017 at 01:29:26PM -0700, Ashok Raj wrote:
> Hi
> 
> Sorry for resending.. iommu list email was mistyped :-(
> 
> The first 2 patches in the series fix some simple bugs in Intel vt-d driver.
> The 3rd patch Adds support for kmem notify required to support ring0 SVM.
> 4th patch uses the hooks to perform device tlb invalidations.
> 
> Ashok Raj (3):
>   iommu/vt-d: IOMMU Page Request needs to check if address is canonical.
>   iommu/vt-d: Avoid calling virt_to_phys() on null pointer
>   iommu/vt-d: Hooks to invalidate iotlb/devtlb when using supervisor
>     PASID's.
> 
> Huang Ying (1):
>   mm: Add kernel MMU notifier to manage remote TLB
> 
>  arch/x86/include/asm/tlbflush.h |  1 +
>  arch/x86/mm/tlb.c               |  1 +
>  drivers/iommu/intel-iommu.c     |  3 ++-
>  drivers/iommu/intel-svm.c       | 43 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h     |  5 ++++-
>  include/linux/mmu_notifier.h    | 33 +++++++++++++++++++++++++++++++
>  mm/mmu_notifier.c               | 25 ++++++++++++++++++++++++
>  7 files changed, 107 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
