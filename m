Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CCC4332F
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B70860D6D;
	Tue,  4 Jan 2022 15:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Slo0UQwGAT7X; Tue,  4 Jan 2022 15:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84AD960BC1;
	Tue,  4 Jan 2022 15:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A824C0031;
	Tue,  4 Jan 2022 15:55:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B0AC006E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6309C60C01
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sld5inyJZR_c for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8454A60BFF
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id F26C61F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311701;
 bh=fPBIfJjVcoXofCD1fNUii7LIvv42S5BZmY9Gwg/vvxs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GuT8uwRR0r1DXel74kTa76Ic4uUp1nwzwOBXQqig/2HM6O2Azi93HPr6wVR2VLSM+
 2j91N+G5h5h7Tm/IBemQKdb30xRh1YbQEZsNj6S0VObC2t1X629kYS1bi363Cuz6dw
 eUigh5eCsjcQXVDAl18GGmtTa3LwmvfivTIQDMf02R5VUuuoZiTGYKtpwxfud/uBpM
 oIermrwBW+PMu8PYScVRRuv16vjYdcwrx2I+BW+JjLFsLUWmMwwCNTfC77BffrXyXG
 F3885a8L67q05vcM0qFKUXYbxaPixhLaPT/HtRIk1vh9az2AADZfsNOYkPQVh9ctsL
 TqlfPq61mLleg==
Subject: Re: [PATCH v3 22/33] iommu/mediatek: Add PCIe support
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-23-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <3b5e7072-0935-4383-27a1-dd8d623cc608@collabora.com>
Date: Tue, 4 Jan 2022 16:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-23-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 23/09/21 13:58, Yong Wu ha scritto:
> Currently the code for of_iommu_configure_dev_id is like this:
> 
> static int of_iommu_configure_dev_id(struct device_node *master_np,
>                                       struct device *dev,
>                                       const u32 *id)
> {
>         struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
>         err = of_map_id(master_np, *id, "iommu-map",
>                         "iommu-map-mask", &iommu_spec.np,
>                         iommu_spec.args);
> ...
> }
> 
> It supports only one id output. BUT our PCIe HW has two ID(one is for
> writing, the other is for reading). I'm not sure if we should change
> of_map_id to support output MAX_PHANDLE_ARGS.
> 
> Here add the solution in ourselve drivers. If it's pcie case, enable one
> more bit.
> 
> Not all infra iommu support PCIe, thus add a PCIe support flag here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 37d6dfb4feab..3f1fd8036345 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_platform.h>
> +#include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
> @@ -132,6 +133,7 @@
>   #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
>   #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
>   #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
> +#define IFA_IOMMU_PCIe_SUPPORT		BIT(15)

This definition looks like "breaking" the naming convention that's used in this
driver... what about MTK_INFRA_IOMMU_PCIE_SUPPORT?

>   
>   #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
>   
> @@ -401,8 +403,11 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
>   				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
>   		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
>   			peri_mmuen_msk = BIT(portid);
> -			peri_mmuen = enable ? peri_mmuen_msk : 0;
> +			/* PCIdev has only one output id, enable the next writing bit for PCIe */
> +			if (dev_is_pci(dev))
> +				peri_mmuen_msk |= BIT(portid + 1);
>   
> +			peri_mmuen = enable ? peri_mmuen_msk : 0;
>   			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
>   						 peri_mmuen_msk, peri_mmuen);
>   			if (ret)
> @@ -977,6 +982,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>   		if (ret)
>   			goto out_bus_set_null;
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
> +		#ifdef CONFIG_PCI

Please fix the indentation of this ifdef (do not indent).

> +		if (!iommu_present(&pci_bus_type)) {
> +			ret = bus_set_iommu(&pci_bus_type, &mtk_iommu_ops);
> +			if (ret) /* PCIe fail don't affect platform_bus. */
> +				goto out_list_del;
> +		}
> +		#endif
>   	}
>   	return ret;
>   
> @@ -1007,6 +1021,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>   		device_link_remove(data->smicomm_dev, &pdev->dev);
>   		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
> +		#ifdef CONFIG_PCI

ditto.

> +		bus_set_iommu(&pci_bus_type, NULL);
> +		#endif
>   	}
>   	pm_runtime_disable(&pdev->dev);
>   	devm_free_irq(&pdev->dev, data->irq, data);
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
