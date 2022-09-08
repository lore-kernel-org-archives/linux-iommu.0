Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A27C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 09:57:32 +0000 (UTC)
X-UUID: dfecda3f6a4f4f64a2c3ad5e0d3a3d58-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8OtqXaIWZ6RVGIDA1jcSd7SZp685DXwkQtdgGcw5XKI=;
	b=O1j+ChS6yh5Kuw+KbfWfNEtLF5sm7ahHdZA7wtTD79zcCH51TCexLP9EI0d0tRUK4eDptJd2fVfx4zOsHX+oKcKHIKCQkjcJ/jGlqaHYWCog6CghTYeSGw5As3H1Qy5GAHt81cXrCAsBWQWImoLlvhIDcCZm1OCnoMLBWzJSsLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:725512fc-0a6b-4524-8a93-396addfe392d,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
	_Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:725512fc-0a6b-4524-8a93-396addfe392d,OB:0,LOB
	:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
	am,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:6990d0eb-2856-4fce-b125-09d4c7ebe045,C
	OID:139ee92951a2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dfecda3f6a4f4f64a2c3ad5e0d3a3d58-20220908
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1198248949; Thu, 08 Sep 2022 17:57:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 17:57:20 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 8 Sep 2022 17:57:19 +0800
Message-ID: <d3ed0ed813270285cfd1319368d8943668ba3c4b.camel@mediatek.com>
Subject: Re: [PATCH v2 3/3] iommu/mediatek: Add MT8188 IOMMU Support
From: Chengci.Xu <chengci.xu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Yong Wu" <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Date: Thu, 8 Sep 2022 17:57:19 +0800
In-Reply-To: <c6853021-e7ef-3078-9c9e-f0c6b56e566d@collabora.com>
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
	 <20220831125502.7818-4-chengci.xu@mediatek.com>
	 <c6853021-e7ef-3078-9c9e-f0c6b56e566d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2022-09-02 at 11:04 +0200, AngeloGioacchino Del Regno wrote:
> Il 31/08/22 14:55, Chengci.Xu ha scritto:
> > MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the
> > other
> > is for vpp. and 1 INFRA IOMMU.
> > 
> > Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 48
> > +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 48 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6fe780783ec8..98c2eae5229e 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -164,6 +164,7 @@ enum mtk_iommu_plat {
> >   	M4U_MT8173,
> >   	M4U_MT8183,
> >   	M4U_MT8186,
> > +	M4U_MT8188,
> >   	M4U_MT8192,
> >   	M4U_MT8195,
> >   };
> > @@ -1479,6 +1480,50 @@ static const struct mtk_iommu_plat_data
> > mt8186_data_mm = {
> >   	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
> >   };
> >   
> > +static const struct mtk_iommu_plat_data mt8188_data_infra = {
> > +	.m4u_plat	  = M4U_MT8188,
> > +	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE |
> > PM_CLK_AO |
> > +			    MTK_IOMMU_TYPE_INFRA |
> > IFA_IOMMU_PCIE_SUPPORT |
> > +			    CFG_IFA_MASTER_IN_ATF,
> > +	.pericfg_comp_str = "mediatek,mt8188-pericfg_ao",
> 
> pericfg_comp_str is used only for IOMMU enable from Linux, but MT8188
> enables it
> with a SMC command, so this is unused.
> 
> Please drop it.

Thanks for your review.

Yes. For MT8188, pericfg_comp_str is unused and should be dropped.
But deleting it simply will lead to INFRA IOMMU probe fail because
following code flow.

	line 1236:
		p = data->plat_data->pericfg_comp_str;
		data->pericfg = syscon_regmap_lookup_by_compatible(p);
		if (IS_ERR(data->pericfg)) {
			ret = PTR_ERR(data->pericfg);
			goto out_runtime_disable;
		}

So we will update probe flow(patch 2/3) and then drop it(patch 3/3) in
the next version. 

> 
> > +	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
> > +	.banks_num	  = 1,
> > +	.banks_enable     = {true},
> > +	.iova_region      = single_domain,
> > +	.iova_region_nr   = ARRAY_SIZE(single_domain),
> > +};
> > +
> 
> Regards,
> Angelo
> 
> 

