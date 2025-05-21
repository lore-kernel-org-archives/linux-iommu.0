Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430A383A5;
	Wed, 21 May 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785734; cv=none; b=Dea/Eqv+xZDmJb+hNaNedN11++5ci8Hlq0FG4TihDRj/UYcBlDaLO76a1yiDmT5BwcYeOa6AOR9ev/WOFLmP2PL9XoO9zzp4Zd55KSjsuZ4gUGJY8UJErcW5iDDjH3kn+CoShGH2OYbicWb62CHwF03JtYcOHJTe9dXzZN92bpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785734; c=relaxed/simple;
	bh=jXl0OotgD+85DVFJREE1im9n5MMc1eZmHD6Z/7IoqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLISRe1S5CXabkLaM1O01uJYfu2yXz3l+V6YDfKFbSpssS6gw5iNmV+kLPFrNN03OMklkJsPNiodLE8p1RdYZYNiiqFQ0OLoUl2o0YDOQdheOKjCNX0ITfNphL6XjxCi3pJd5jCvOZRj1K7lq0dUYVXyfceX9nZPfN6BklRSCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzpch6Ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzpch6Ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6979FC4CEE9;
	Wed, 21 May 2025 00:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747785733;
	bh=jXl0OotgD+85DVFJREE1im9n5MMc1eZmHD6Z/7IoqVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xzpch6AxmJmqIKU1MNMhV6r+ZUcFyE6XLvHM/8foZm27SJCHk0oiZzxKvS94j6i/K
	 1gqDikjs90pIPcOhm2XSK5TxKNJvUREDIvThJh44OOl673K2lmROFMKRbpa3bnbh/1
	 bCCpoRvoukdb62EywWi100owxVeiKeKDkLxzO/beKegHX5lry/VkVsio4rmowXKUno
	 MsrSxLt3UGrVCEsi2aKgSw+gl/TARELO0fKD9zI/uxbra9Oc5ez+jXSNNIDAf80xkd
	 miNqtFsNT3w1dvKqVhTQq0t64LoiJsFxdXzPpQFSl+TKU0Q9eILO9w4f8DipERx8vZ
	 xDw+67LsUtugw==
Date: Tue, 20 May 2025 19:02:11 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 2/2] iommu/mediatek: Add support for Dimensity 1200
 MT6893 MM IOMMU
Message-ID: <20250521000211.GA1717916-robh@kernel.org>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
 <20250410144008.475888-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410144008.475888-3-angelogioacchino.delregno@collabora.com>

On Thu, Apr 10, 2025 at 04:40:08PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for the two MM IOMMUs found in the MediaTek Dimensity
> 1200 (MT6893) SoC, used for display, camera, imgsys and vpu.
> 
> Since the MT6893 SoC is almost fully compatible with MT8192, also
> move the mt8192_larb_region_msk before the newly introduced mt6893
> platform data, as the larb regions from mt8192 are fully reused.
> 
> Note that the only difference with MT8192 is that MT6893 needs the
> SHARE_PGTABLE flag.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index df98d0c65f54..0a54c6521bf5 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1550,6 +1550,31 @@ static const struct mtk_iommu_plat_data mt6795_data = {
>  	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping. */
>  };
>  
> +static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
> +	[0] = {~0, ~0},				/* Region0: larb0/1 */
> +	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
> +	[2] = {0, 0, ~0, 0, 0, 0, 0, 0,		/* Region2: larb2/9/11/13/14/16/17/18/19/20 */
> +	       0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), ~(u32)(BIT(4) | BIT(5)), 0,
> +	       ~0, ~0, ~0, ~0, ~0},
> +	[3] = {0},
> +	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
> +	[5] = {[14] = BIT(4) | BIT(5)},		/* larb14 port4/5 */
> +};
> +
> +static const struct mtk_iommu_plat_data mt6893_data = {
> +	.m4u_plat     = M4U_MT8192,
> +	.flags        = HAS_BCLK | OUT_ORDER_WR_EN | HAS_SUB_COMM_2BITS |
> +			WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
> +	.inv_sel_reg  = REG_MMU_INV_SEL_GEN2,
> +	.banks_num    = 1,
> +	.banks_enable = {true},
> +	.iova_region  = mt8192_multi_dom,
> +	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
> +	.iova_region_larb_msk = mt8192_larb_region_msk,
> +	.larbid_remap    = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
> +			    {0, 14, 16}, {0, 13, 18, 17}},
> +};
> +
>  static const struct mtk_iommu_plat_data mt8167_data = {
>  	.m4u_plat     = M4U_MT8167,
>  	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
> @@ -1673,17 +1698,6 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
>  			   27, 28 /* ccu0 */, MTK_INVALID_LARBID}, {4, 6}},
>  };
>  
> -static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
> -	[0] = {~0, ~0},				/* Region0: larb0/1 */
> -	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
> -	[2] = {0, 0, ~0, 0, 0, 0, 0, 0,		/* Region2: larb2/9/11/13/14/16/17/18/19/20 */
> -	       0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), ~(u32)(BIT(4) | BIT(5)), 0,
> -	       ~0, ~0, ~0, ~0, ~0},
> -	[3] = {0},
> -	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
> -	[5] = {[14] = BIT(4) | BIT(5)},		/* larb14 port4/5 */
> -};
> -
>  static const struct mtk_iommu_plat_data mt8192_data = {
>  	.m4u_plat       = M4U_MT8192,
>  	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> @@ -1777,6 +1791,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
>  	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
> +	{ .compatible = "mediatek.mt6893-iommu-mm", .data = &mt6893_data},

Are you going to fix the typo>   ^

It is still warning with 'make dt_compatible_check' that it is 
undocumented.

Rob
