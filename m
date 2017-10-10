From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: Remove initconst attribute to avoid
 potential kernel oops
Date: Tue, 10 Oct 2017 14:13:59 +0200
Message-ID: <20171010121359.kb7b22regypsg2vd@8bytes.org>
References: <CGME20171009114035eucas1p102089b889ad374b33c3302f1ad84e783@eucas1p1.samsung.com>
 <20171009114023.3427-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171009114023.3427-1-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 09, 2017 at 01:40:23PM +0200, Marek Szyprowski wrote:
> Exynos SYSMMU registers standard platform device with sysmmu_of_match
> table, what means that this table is accessed every time a new platform
> device is registered in a system. This might happen also after the boot,
> so the table must not be attributed as initconst to avoid potential kernel
> oops caused by access to freed memory.
> 
> Fixes: 6b21a5db3642 ("iommu/exynos: Support for device tree")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied, thanks.
