From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/5] iommu/rockchip: add ARM64 cache flush operation for
 iommu
Date: Tue, 24 May 2016 10:59:27 +0100
Message-ID: <20160524095927.GS4892@e104818-lin.cambridge.arm.com>
References: <1463967439-13354-1-git-send-email-zhengsq@rock-chips.com>
 <1463967439-13354-5-git-send-email-zhengsq@rock-chips.com>
 <5742DEFE.1040902@arm.com>
 <20160523133500.GF4892@e104818-lin.cambridge.arm.com>
 <5743BCF5.8030607@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5743BCF5.8030607@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, heiko@sntech.de, Mark Rutland <mark.rutland@arm.com>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 24, 2016 at 10:31:17AM +0800, Shunqian Zheng wrote:
> On 2016=E5=B9=B405=E6=9C=8823=E6=97=A5 21:35, Catalin Marinas wrote:
> >On Mon, May 23, 2016 at 11:44:14AM +0100, Robin Murphy wrote:
> >>On 23/05/16 02:37, Shunqian Zheng wrote:
> >>>From: Simon <xxm@rock-chips.com>
> >>>
> >>>Signed-off-by: Simon <xxm@rock-chips.com>
> >>>---
> >>>  drivers/iommu/rockchip-iommu.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>>diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockch=
ip-iommu.c
> >>>index 043d18c..1741b65 100644
> >>>--- a/drivers/iommu/rockchip-iommu.c
> >>>+++ b/drivers/iommu/rockchip-iommu.c
> >>>@@ -95,12 +95,16 @@ struct rk_iommu {
> >>>
> >>>  static inline void rk_table_flush(u32 *va, unsigned int count)
> >>>  {
> >>>+#if defined(CONFIG_ARM)
> >>>  	phys_addr_t pa_start =3D virt_to_phys(va);
> >>>  	phys_addr_t pa_end =3D virt_to_phys(va + count);
> >>>  	size_t size =3D pa_end - pa_start;
> >>>
> >>>  	__cpuc_flush_dcache_area(va, size);
> >>>  	outer_flush_range(pa_start, pa_end);
> >>>+#elif defined(CONFIG_ARM64)
> >>>+	__dma_flush_range(va, va + count);
> >>>+#endif
> >>Ugh, please don't use arch-private cache maintenance functions dire=
ctly from
> >>a driver. Allocating/mapping page tables to be read by the IOMMU is=
 still
> >>DMA, so using the DMA APIs is the correct way to manage them, *espe=
cially*
> >>if it needs to work across multiple architectures.
>=20
> It's easier for us if changing  the __dma_flush_range() to
> __flush_dcache_area() is acceptable here?

It's not really acceptable for arm64, nor for arm32. Please fix this
driver in a similar way to commit e3c971960fd4 ("iommu/tegra-smmu:
Convert to use DMA API").

The only place where we allowed __flush_dcache_area() is in the GICv3
driver and that's because it hasn't been wired as a platform device
(yet).

--=20
Catalin
