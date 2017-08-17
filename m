From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Thu, 17 Aug 2017 17:34:25 +0100
Message-ID: <20170817163424.GC30719@arm.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
 <1502459130-6234-3-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502459130-6234-3-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com, christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, mst@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
> When running a virtual SMMU on a guest we sometimes need to trap
> all changes to the translation structures. This is especially useful
> to integrate with VFIO. This patch adds a new option that forces
> the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
> 
> TLBI commands then can be trapped.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v1 -> v2:
> - rebase on v4.13-rc2
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
>  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index c9abbf3..ebb85e9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -52,6 +52,10 @@ the PCIe specification.
>                          devicetree/bindings/interrupt-controller/msi.txt
>                        for a description of the msi-parent property.
>  
> +- tlbi-on-map       : invalidate caches whenever there is an update of
> +                      any remapping structure (updates to not-present or
> +                      present entries).
> +

My position on this hasn't changed, so NAK for this patch. If you want to
emulate something outside of the SMMUv3 architecture, please do so, but
don't pretend that it's an SMMUv3.

Will
