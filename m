From: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v3 0/5] MT2701 iommu support
Date: Mon, 6 Jun 2016 09:30:10 +0800
Message-ID: <1465176610.14476.2.camel@mtksdaap41>
References: <1464339400-22559-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464339400-22559-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pebolle@tiscali.nl, kendrick.hsu@mediatek.com, arnd@arndb.de, srv_heupstream@mediatek.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, djkurtz@google.com, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, youlin.pei@mediatek.com, erin.lo@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 2016-05-27 at 16:56 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 

Is there will be some comments for this version patchset?
Any comments is welcome.
Thanks.

>   Mediatek's m4u(Multimedia Memory Management Unit) and SMI(Smart
> Multimedia Interface)have two generations HW. They basically sharing the
> same hardware block diagram, but have some difference as below:
> 
>   Generation one m4u only supports one layer, flat pagetable addressing,
> and only supports 4K size page mapping. While generation two m4u supports 2
> levels of pagetable which uses the ARM short-descriptor translation table
> format for address translation.
> They have slight different register base and register offset.
> They have very different HW ports defines.
> 
>   Generaion one SMI has additional "async" clock which transform the smi
> clock into emi clock domain, this clock should be prepared and enabled for
> SMI generation one HW.
> The register which control the iommu need to translation the address or not
> for a particular port is located at smi ao base(smi always on register
> base) for generation one SMI HW, but located at each larb's register base
> for generation two HW.
> 
> This patch set add mt2701 iommu support, it's based on 4.6-rc1 and James
> Liao's "Add clock support for Mediatek MT2701 v8[1]" and "Mediatek MT2701
> SCPSYS power domain support v7[2]" patch.
> 
> v3:
> -Rebase on "of: Implement iterator for phandles[3]" and take use of
>  of_for_each_phandle.
> -Forward-declare mtk_iommu_domain and implement the struct separately.
> -Free the pagetable memory in mtk_iommu_domain_free
> -Roll back the mapping in error case.
> -Minor cleanups.
> 
> v2: https://lists.linuxfoundation.org/pipermail/iommu/2016-May/017068.html
> -Fix syntax errors in dt-bindings.
> -Use dma_alloc/free_coherent to allocate pagetable memory and reduce the
>  streaming DMA stuff.
> -Make the mtk_iommu_ops.pgsize_bitmap as ~0UL << MT2701_IOMMU_PAGE_SHIFT.
> -Use macro instead of variable to indicate the pagetable size.
> -Change some macro name from MTK_XXX to MT2701_XXX.
> 
> v1: http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005301.html
> -initial version
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005439.html
> [2] http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html
> [3] https://lists.linuxfoundation.org/pipermail/iommu/2016-April/016300.html
> 
> Honghui Zhang (5):
>   dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and
>     smi
>   iommu/mediatek: move the common struct into header file
>   memory/mediatek: add support for mt2701
>   iommu/mediatek: add support for mtk iommu generation one HW
>   ARM: dts: mt2701: add iommu/smi dtsi node for mt2701
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  13 +-
>  .../memory-controllers/mediatek,smi-common.txt     |  21 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   4 +-
>  arch/arm/boot/dts/mt2701.dtsi                      |  51 ++
>  drivers/iommu/Kconfig                              |  18 +
>  drivers/iommu/Makefile                             |   1 +
>  drivers/iommu/mtk_iommu.c                          |  48 +-
>  drivers/iommu/mtk_iommu.h                          |  77 +++
>  drivers/iommu/mtk_iommu_v1.c                       | 728 +++++++++++++++++++++
>  drivers/memory/mtk-smi.c                           | 168 ++++-
>  include/dt-bindings/memory/mt2701-larb-port.h      |  85 +++
>  11 files changed, 1140 insertions(+), 74 deletions(-)
>  create mode 100644 drivers/iommu/mtk_iommu.h
>  create mode 100644 drivers/iommu/mtk_iommu_v1.c
>  create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h
> 
