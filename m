From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] Exynos IOMMU: improve clock management
Date: Wed, 15 Jun 2016 14:00:36 +0200
Message-ID: <20160615120035.GH26566@8bytes.org>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 23, 2016 at 11:30:06AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> This patch series improves clock management in Exynos IOMMU driver, so
> the driver will be ready for potential deferred probe caused by
> not-yet-available clocks. Such case doesn't happen with current kernel,
> but it may happen with the planned rework on clocks and power domain
> code.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Marek Szyprowski (3):
>   iommu/exynos: Return proper errors from getting clocks
>   iommu/exynos: Fix master clock management for inactive SYSMMU
>   iommu/exynos: Prepare clocks when needed, not in driver probe
> 
>  drivers/iommu/exynos-iommu.c | 95 ++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 53 deletions(-)

Applied all, thanks.
