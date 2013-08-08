From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v9 02/16] iommu/exynos: add missing cache flush for removed
 page table entries
Date: Thu, 08 Aug 2013 15:44:09 +0200
Message-ID: <1726114.ptuhYydfjT@amdc1227>
References: <002601ce941a$e987ba50$bc972ef0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <002601ce941a$e987ba50$bc972ef0$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 08 of August 2013 18:37:34 Cho KyongHo wrote:
> This commit adds cache flush for removed small and large page entries
> in exynos_iommu_unmap(). Missing cache flush of removed page table
> entries can cause missing page fault interrupt when a master IP
> accesses an unmapped area.
> 
> Tested-by: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 233f382..d545a25 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1002,6 +1002,7 @@ static size_t exynos_iommu_unmap(struct
> iommu_domain *domain, if (lv2ent_small(ent)) {
>  		*ent = 0;
>  		size = SPAGE_SIZE;
> +		pgtable_flush(ent, ent + 1);
>  		priv->lv2entcnt[lv1ent_offset(iova)] += 1;
>  		goto done;
>  	}
> @@ -1010,6 +1011,7 @@ static size_t exynos_iommu_unmap(struct
> iommu_domain *domain, BUG_ON(size < LPAGE_SIZE);
> 
>  	memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
> +	pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
> 
>  	size = LPAGE_SIZE;
>  	priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;

Looks reasonable.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
