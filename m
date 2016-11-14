From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: Add support for page access protection bits
Date: Mon, 14 Nov 2016 16:00:15 +0100
Message-ID: <20161114150015.GA13998@8bytes.org>
References: <CGME20161103080459eucas1p254076fdf45c72dbc09aee42fe6234c0d@eucas1p2.samsung.com>
 <1478160285-14214-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478160285-14214-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 03, 2016 at 09:04:45AM +0100, Marek Szyprowski wrote:
> This patch add support for page access protection bits. Till now this
> feature was disabled and Exynos SYSMMU always mapped pages as read/write.
> Now page access bits are set according to the protection bits provided
> in iommu_map(), so Exynos SYSMMU is able to detect incorrect access to
> mapped pages. Exynos SYSMMU earlier than v5 doesn't support write-only
> mappings, so pages with such protection bits are mapped as read/write.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 63 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 12 deletions(-)

Applied, thanks Marek.
