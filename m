Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936467E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 03:37:22 +0000 (UTC)
X-UUID: 8844abe01d92461a8f8114348dc39259-20220907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W5moPVBHRStMlIt5ZHAvR6r7Sr7pcBbJlmSifcWDKzk=;
	b=cfb8GX0Y0hDKSaE580gSZvPxPES4Nk7OB6ve1oORedIwzUrHv1XAQMfbsyW7vbqIvE7wEYqAc1DobDOggKjokXpFtdX6BIKPpVXLcYW8GbRCkq+la8rkV3fbQhXX6y8bZf9NYfy8zF4uCK2dVEJOUnp2OzEGPO4upAbmtT3ShrU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:49067b20-1bce-4b29-ac77-02a81e430a88,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
	Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:692be756-e800-47dc-8adf-0c936acf4f1b,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8844abe01d92461a8f8114348dc39259-20220907
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1433134188; Wed, 07 Sep 2022 11:37:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Sep 2022 11:37:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 7 Sep 2022 11:37:13 +0800
Message-ID: <9ceced14196f19c38867cc3a2ded979ac25079c8.camel@mediatek.com>
Subject: Re: [PATCH v2 2/3] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA master
From: Yong Wu <yong.wu@mediatek.com>
To: Chengci.Xu <chengci.xu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
Date: Wed, 7 Sep 2022 11:37:12 +0800
In-Reply-To: <20220831125502.7818-3-chengci.xu@mediatek.com>
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
	 <20220831125502.7818-3-chengci.xu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N

On Wed, 2022-08-31 at 20:55 +0800, Chengci.Xu wrote:
> The register which can enable IOMMU for INFRA master should be setted
> in secure world for security concerns. Therefore, we add a SMC
> command
> for INFRA master to enable/disable INFRA IOMMU in ATF. This function
> is
> prepared for MT8188.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c  | 34 ++++++++++++++++++++++++++--------
>  include/soc/mediatek/smi.h |  1 +
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7e363b1f24df..6fe780783ec8 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2015-2016 MediaTek Inc.
>   * Author: Yong Wu <yong.wu@mediatek.com>
>   */
> +#include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/clk.h>
> @@ -28,6 +29,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
>  #include <asm/barrier.h>
>  #include <soc/mediatek/smi.h>
>  
> @@ -138,6 +140,7 @@
>  #define PM_CLK_AO			BIT(15)
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>  #define PGTABLE_PA_35_EN		BIT(17)
> +#define CFG_IFA_MASTER_IN_ATF		BIT(18)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -554,14 +557,29 @@ static int mtk_iommu_config(struct
> mtk_iommu_data *data, struct device *dev,
>  			else
>  				larb_mmu->mmu &=
> ~MTK_SMI_MMU_EN(portid);
>  		} else if (MTK_IOMMU_IS_TYPE(data->plat_data,
> MTK_IOMMU_TYPE_INFRA)) {
> -			peri_mmuen_msk = BIT(portid);
> -			/* PCI dev has only one output id, enable the
> next writing bit for PCIe */
> -			if (dev_is_pci(dev))
> -				peri_mmuen_msk |= BIT(portid + 1);
> -
> -			peri_mmuen = enable ? peri_mmuen_msk : 0;
> -			ret = regmap_update_bits(data->pericfg,
> PERICFG_IOMMU_1,
> -						 peri_mmuen_msk,
> peri_mmuen);
> +			if (MTK_IOMMU_HAS_FLAG(data->plat_data,
> CFG_IFA_MASTER_IN_ATF)) {
> +				struct arm_smccc_res res;
> +
> +				portid = MTK_M4U_TO_PORT(fwspec-
> >ids[i]);
> +				arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONT
> ROL,
> +					      IOMMU_ATF_CMD_CONFIG_INFR
> A_IOMMU,
> +					      portid, enable, 0, 0, 0,
> 0, &res);
> +				ret = (int)res.a0;

Too many indentations. Please create a new interface or even just use
"if", like:

if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 xx
} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA &&
           MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF))
{ /* Configure the mmu_en in the ATF for infra IOMMU */
  xx
} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) {
}

> +
> +			} else {
> +				peri_mmuen_msk = BIT(portid);
> +				/* PCI dev has only one output id,
> +				 * enable the next writing bit for PCIe
> +				 */
> +				if (dev_is_pci(dev))
> +					peri_mmuen_msk |= BIT(portid +
> 1);
> +
> +				peri_mmuen = enable ? peri_mmuen_msk :
> 0;
> +				ret = regmap_update_bits(data->pericfg,
> +							 PERICFG_IOMMU_
> 1,
> +							 peri_mmuen_msk
> ,
> +							 peri_mmuen);
> +			}
>  			if (ret)
>  				dev_err(dev, "%s iommu(%s) inframaster
> 0x%x fail(%d).\n",
>  					enable ? "enable" : "disable",
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index dfd8efca5e60..99f13b0e416d 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -13,6 +13,7 @@
>  
>  enum iommu_atf_cmd {
>  	IOMMU_ATF_CMD_CONFIG_SMI_LARB,		/* For mm master to
> en/disable iommu */
> +	IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,	/* For infra master
> en/disable iommu */
>  	IOMMU_ATF_CMD_MAX,
>  };
>  

