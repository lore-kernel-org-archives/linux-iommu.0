Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D42C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:29:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E0620C56
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E0620C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5B0DF20487;
	Wed, 23 Dec 2020 08:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ivLBakwsrsUJ; Wed, 23 Dec 2020 08:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 77FF820349;
	Wed, 23 Dec 2020 08:29:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBC1C1787;
	Wed, 23 Dec 2020 08:29:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC152C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D9F0085540
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rs54vFWdRUlQ for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:29:11 +0000 (UTC)
X-Greylist: delayed 00:10:26 by SQLgrey-1.7.6
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28AB0854DB
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:29:11 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id j13so2811192pjz.3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MtRevYqK8sqR14rLsfzjE387SZOyOC0INohDVQpnu/o=;
 b=eniRj4JCG7HSOxKs+Xv2XOqjiq/o9XyHjwzWVHjAT3jWwP+ldVc0+eWag0AsvRdgC0
 gKt/Phk8yoX6YxQFXZMQfH1IOhgrBGo6PcH7enCXeYyfCdjyr6uDtBLoNshhAEf5stpk
 DtCpy9+9pzrpuXJidDrgorvS03FVLv3M7FSto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MtRevYqK8sqR14rLsfzjE387SZOyOC0INohDVQpnu/o=;
 b=ZZ5OKNvxujO8g/MKuq/bBTUyLHULYkrnHXwtEjAHNpu9/ZTGJu2zFZK4MMyYiBbz1H
 sJMm7bv78Arz3lYCvl/1qRp22lI65A6DKpvjYjOWKOImaQvHclEP4pSgrI58fztNYnJ+
 nxQNB+cSaxYyQtkOMmywWIvkpZVyKLa6c6pFdHVCXS4e2VYRUKroEYJOUVCM0Wu3ZZBd
 /E6dY/NxjkrpvHWgS9V/m88z3p2dfJub9NpfLEffEPzJoPIt25zR/xozCX2+QW2hINo+
 2RZW2xShjGHZWiCJe976wJwM7nAVY3y3kOlLpOxYaiLcaLkTSP+xK0zESClP0to31zq9
 GQxQ==
X-Gm-Message-State: AOAM533hAL3aDTVxpcGzKBxVYZFPVmH348jPNsyxvc3RM7/ejfScbkHl
 Up0KI7i5dyOJPW/JTL/hwWlgEA==
X-Google-Smtp-Source: ABdhPJxwhDWa65ztRldJLKunkdsaTgTcsOr8hUNnOAXF3Z/ppin9ltztXhGaIKLe03R/ZD2nPu+1vw==
X-Received: by 2002:a17:90b:90f:: with SMTP id
 bo15mr25095694pjb.148.1608712150675; 
 Wed, 23 Dec 2020 00:29:10 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id p17sm11910519pfn.52.2020.12.23.00.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:29:09 -0800 (PST)
Date: Wed, 23 Dec 2020 17:29:04 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 16/27] iommu/mediatek: Add device link for smi-common
 and m4u
Message-ID: <X+L/0E6p9t+a/l5w@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-17-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-17-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Dec 09, 2020 at 04:00:51PM +0800, Yong Wu wrote:
> In the lastest SoC, M4U has its special power domain. thus, If the engine
> begin to work, it should help enable the power for M4U firstly.
> Currently if the engine work, it always enable the power/clocks for
> smi-larbs/smi-common. This patch adds device_link for smi-common and M4U.
> then, if smi-common power is enabled, the M4U power also is powered on
> automatically.
> 
> Normally M4U connect with several smi-larbs and their smi-common always
> are the same, In this patch it get smi-common dev from the first smi-larb
> device(i==0), then add the device_link only while m4u has power-domain.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 30 ++++++++++++++++++++++++++++--
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 09c8c58feb78..5614015e5b96 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -706,7 +707,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  		return larb_nr;
>  
>  	for (i = 0; i < larb_nr; i++) {
> -		struct device_node *larbnode;
> +		struct device_node *larbnode, *smicomm_node;
>  		struct platform_device *plarbdev;
>  		u32 id;
>  
> @@ -732,6 +733,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  
>  		component_match_add_release(dev, &match, release_of,
>  					    compare_of, larbnode);
> +		if (i != 0)
> +			continue;

How about using the last larb instead and moving the code below outside
of the loop?

> +		smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> +		if (!smicomm_node)
> +			return -EINVAL;
> +
> +		plarbdev = of_find_device_by_node(smicomm_node);
> +		of_node_put(smicomm_node);
> +		data->smicomm_dev = &plarbdev->dev;
> +	}
> +
> +	if (dev->pm_domain) {
> +		struct device_link *link;
> +
> +		link = device_link_add(data->smicomm_dev, dev,
> +				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +		if (!link) {
> +			dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +			return -EINVAL;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -739,7 +760,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>  				     "mtk-iommu.%pa", &ioaddr);
>  	if (ret)
> -		return ret;
> +		goto out_link_remove;
>  
>  	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
>  	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
> @@ -763,6 +784,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	iommu_device_unregister(&data->iommu);
>  out_sysfs_remove:
>  	iommu_device_sysfs_remove(&data->iommu);
> +out_link_remove:
> +	if (dev->pm_domain)
> +		device_link_remove(data->smicomm_dev, dev);
>  	return ret;
>  }
>  
> @@ -777,6 +801,8 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  		bus_set_iommu(&platform_bus_type, NULL);
>  
>  	clk_disable_unprepare(data->bclk);
> +	if (pdev->dev.pm_domain)
> +		device_link_remove(data->smicomm_dev, &pdev->dev);
>  	devm_free_irq(&pdev->dev, data->irq, data);
>  	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
>  	return 0;
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index d0c93652bdbe..5e03a029c4dc 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -68,6 +68,7 @@ struct mtk_iommu_data {
>  
>  	struct iommu_device		iommu;
>  	const struct mtk_iommu_plat_data *plat_data;
> +	struct device			*smicomm_dev;
>  
>  	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
