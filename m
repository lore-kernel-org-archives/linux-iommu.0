From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v13 00/19] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Tue, 13 May 2014 19:20:38 +0200
Message-ID: <20140513172038.GC23770@8bytes.org>
References: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399875304-19948-1-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shaik Ameer Basha <shaik.ameer@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, arnd@arndb.de, t.figa@samsung.com, kgene.kim@samsung.com, pullip.cho@samsung.com, a.motakis@virtualopensystems.com, grundler@chromium.org, s.nawrocki@samsung.com, prathyush.k@samsung.com, rahul.sharma@samsung.com, sachin.kamat@linaro.org, supash.ramaswamy@linaro.org, varun.sethi@freescale.com, joshi@samsung.com, tomasz.figa@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Mon, May 12, 2014 at 11:44:45AM +0530, Shaik Ameer Basha wrote:
> Cho KyongHo (18):
>   iommu/exynos: fix build errors
>   iommu/exynos: change error handling when page table update is failed
>   iommu/exynos: allocate lv2 page table from own slab
>   iommu/exynos: fix L2TLB invalidation
>   iommu/exynos: remove prefetch buffer setting
>   iommu/exynos: add missing cache flush for removed page table entries
>   iommu/exynos: always enable runtime PM
>   iommu/exynos: remove dbgname from drvdata of a System MMU
>   iommu/exynos: use managed device helper functions
>   iommu/exynos: gating clocks of master H/W
>   iommu/exynos: remove custom fault handler
>   iommu/exynos: change rwlock to spinlock
>   iommu/exynos: use exynos-iommu specific typedef
>   iommu/exynos: enhanced error messages
>   documentation: iommu: add binding document of Exynos System MMU
>   iommu/exynos: support for device tree
>   iommu/exynos: turn on useful configuration options
>   iommu/exynos: apply workaround of caching fault page table entries
> 
>  .../devicetree/bindings/iommu/samsung,sysmmu.txt   |   65 ++
>  drivers/iommu/exynos-iommu.c                       | 1035 ++++++++++++--------
>  2 files changed, 677 insertions(+), 423 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt

Applied, thanks. Please send another patch to update the documentation
as requested by Arnd.


	Joerg
