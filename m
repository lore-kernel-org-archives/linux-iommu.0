Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F6CC433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 11:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68C57610A4;
	Thu, 27 Jan 2022 11:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dB8QjPEPLcMu; Thu, 27 Jan 2022 11:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 463346103F;
	Thu, 27 Jan 2022 11:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09ABFC0011;
	Thu, 27 Jan 2022 11:02:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4CCC000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E61A984F52
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hW0tY6UD8xjb for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3107584F4C
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:02:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 484FA1F45063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643281332;
 bh=y7Q22FYn8FoxG+Q7a9gHib0Iq0zzREi7aiuVl2foqxg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=LBoJzGDUMVKX/gSf3SIgVY/ZJKUJvgV0EfVS5PiKs6FAyMFU88KJCNZHbtzmGFgVW
 gicw+2P8E7/gwjAFTRxW9k8eECDChSpaPtbtyLsQFK+vNVAjBEJD40pf8lpgklenY2
 WqVtlopRIn4O42kbfyCUMs9fC4qtEniYdaupWno8nKxKK+/RqaBWpcgmwXpEuZ1W0K
 tcqxnUZVd5tHcpGhdL1BXymy7MvRGt3ff77giKXyibWzeDi+GxCbtPOrfDrjSFIiVt
 gcoKhn/NlXMKLMEuy2tRvJw8IHcce6jMZUuB+NR/9kRI5CHgUKQuRtK/UmmTclCVuG
 BOeN7Nwg0V+QQ==
Subject: Re: [PATCH v4 06/35] iommu/mediatek: Add mutex for m4u_group and
 m4u_dom in data
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-7-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <62d2a231-3d05-5008-fae2-335c4ad853bd@collabora.com>
Date: Thu, 27 Jan 2022 12:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-7-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

Il 25/01/22 09:56, Yong Wu ha scritto:
> Add a mutex to protect the data in the structure mtk_iommu_data,
> like ->"m4u_group" ->"m4u_dom". For the internal data, we should
> protect it in ourselves driver. Add a mutex for this.
> This could be a fix for the multi-groups support.
> 
> Fixes: c3045f39244e ("iommu/mediatek: Support for multi domains")
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 13 +++++++++++--
>   drivers/iommu/mtk_iommu.h |  2 ++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index ec2c387abf60..095736bfb7b4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -464,15 +464,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   		dom->data = data;
>   	}
>   
> +	mutex_lock(&data->mutex);
>   	if (!data->m4u_dom) { /* Initialize the M4U HW */
>   		ret = pm_runtime_resume_and_get(m4udev);
>   		if (ret < 0)
> -			return ret;
> +			goto data_unlock;

In order to enhance human readability, I would rather propose:

			goto err_unlock;

Apart from this,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   
>   		ret = mtk_iommu_hw_init(data);
>   		if (ret) {
>   			pm_runtime_put(m4udev);
> -			return ret;
> +			goto data_unlock;
>   		}
>   		data->m4u_dom = dom;
>   		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> @@ -480,9 +481,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   
>   		pm_runtime_put(m4udev);
>   	}
> +	mutex_unlock(&data->mutex);
>   
>   	mtk_iommu_config(data, dev, true, domid);
>   	return 0;
> +
> +data_unlock:
> +	mutex_unlock(&data->mutex);
> +	return ret;
>   }
>   
>   static void mtk_iommu_detach_device(struct iommu_domain *domain,
> @@ -592,6 +598,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	if (domid < 0)
>   		return ERR_PTR(domid);
>   
> +	mutex_lock(&data->mutex);
>   	group = data->m4u_group[domid];
>   	if (!group) {
>   		group = iommu_group_alloc();
> @@ -600,6 +607,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	} else {
>   		iommu_group_ref_get(group);
>   	}
> +	mutex_unlock(&data->mutex);
>   	return group;
>   }
>   
> @@ -874,6 +882,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> +	mutex_init(&data->mutex);
>   
>   	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>   				     "mtk-iommu.%pa", &ioaddr);
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index f81fa8862ed0..f413546ac6e5 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -80,6 +80,8 @@ struct mtk_iommu_data {
>   
>   	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
>   
> +	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
> +
>   	struct list_head		list;
>   	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
>   };
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
