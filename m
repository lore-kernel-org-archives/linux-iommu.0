Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E41C388F9
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 01:11:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD3420678
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 01:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDnlXe7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD3420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 481C287534;
	Thu, 12 Nov 2020 01:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sSCe7NOUUYC; Thu, 12 Nov 2020 01:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97F2187526;
	Thu, 12 Nov 2020 01:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ABDFC0889;
	Thu, 12 Nov 2020 01:11:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B11FC016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 01:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E26287534
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 01:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPmrMIZ+hQh2 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 01:11:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
 [209.85.221.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A733A87526
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 01:11:00 +0000 (UTC)
Received: by mail-vk1-f196.google.com with SMTP id o73so950686vka.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jz5kAZbrArqI0Wtmw+vtyP3p8jdhel21wmv2CFUUROo=;
 b=kDnlXe7tyEixWf+480/PTLTVkBUYGbtBisgVqL6qcQgy4sPKvzTV6/tSw83j47RD7q
 Rf9VAXW9kIm4P+pX/HXhGKwX9LVFIVmcuHv/6Jag9gPlQcBFdbxZcRC33/54CUyQozsU
 NIphtyIs1Otvd9bO8oM70co0kkF3ZZXDKONwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jz5kAZbrArqI0Wtmw+vtyP3p8jdhel21wmv2CFUUROo=;
 b=DBXh1jrhHpkrjHjMzNN5b2a75y5uCqss9uKRBmEX30DOnhb6yqZwIL9jAuBCTmxq9g
 KIBQPBvaDNQIWP9hCqiaWF8AhlJc6mJa+F4/K29/ZPbtpFLOkPsf6NhiN25TGSi4Uify
 RN7763H8RIQgPwsEdWK2yw5Kd75+UdhzA6Ph8ygZYVhe30k8Omse7qTcWM77HLqmY25S
 hql34bQcV19saiVNcvK4Sxnlq+R/NznGpHqfXQM+Vn2I65d9tXkHguX9B8zVNCIFqxCh
 3uTtX/a2sbIkZTikCbt0wSz7QZI6RHUiSPc8TCvfbtslbTWIq2rD+UDQgFYcwF2Riin0
 Te5w==
X-Gm-Message-State: AOAM531+cPQ41Zpw1qYZCTUEx5ld04ZfRkHNE712wEPJVXoOuAuw+udM
 4OZrYtqecHbOOyAEuFcl9aDANllRa3OhoUegI+02qA==
X-Google-Smtp-Source: ABdhPJw+9rZ4nbhsdwX6zx9uimjIrtTve1brVMfTJF95tCZp/3u+DvsL8qx0usBjUpgCHUXOc17+xjTd7E+Sg/oGTEc=
X-Received: by 2002:a1f:cd07:: with SMTP id d7mr16387452vkg.10.1605143459607; 
 Wed, 11 Nov 2020 17:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-14-yong.wu@mediatek.com>
In-Reply-To: <20201111123838.15682-14-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 12 Nov 2020 09:10:49 +0800
Message-ID: <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/24] iommu/mediatek: Add device link for smi-common
 and m4u
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@google.com>,
 srv_heupstream <srv_heupstream@mediatek.com>, chao.hao@mediatek.com,
 Will Deacon <will@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Evan Green <evgreen@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Wed, Nov 11, 2020 at 8:40 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
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
>  drivers/iommu/mtk_iommu.c | 36 +++++++++++++++++++++++++++++++++---
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index cfdf5ce696fd..4ce7e0883e4d 100644
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
> @@ -705,7 +706,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>                 return larb_nr;
>
>         for (i = 0; i < larb_nr; i++) {
> -               struct device_node *larbnode;
> +               struct device_node *larbnode, *smicomm_node;
>                 struct platform_device *plarbdev;
>                 u32 id;
>
> @@ -731,6 +732,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>
>                 component_match_add_release(dev, &match, release_of,
>                                             compare_of, larbnode);
> +               if (!i) {

Maybe more of a style preference, but since you are actually comparing
an integer, I prefer seeing i == 0.

Also, might be nicer to do

if (i != 0)
   continue;

And de-indent the rest.

> +                       smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> +                       if (!smicomm_node)
> +                               return -EINVAL;
> +
> +                       plarbdev = of_find_device_by_node(smicomm_node);
> +                       of_node_put(smicomm_node);
> +                       data->smicomm_dev = &plarbdev->dev;
> +               }
> +       }
> +
> +       if (dev->pm_domain) {
> +               struct device_link *link;
> +
> +               link = device_link_add(data->smicomm_dev, dev,
> +                                      DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> +               if (!link) {
> +                       dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +                       return -EINVAL;
> +               }
>         }
>
>         platform_set_drvdata(pdev, data);
> @@ -738,14 +759,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>                                      "mtk-iommu.%pa", &ioaddr);
>         if (ret)
> -               return ret;
> +               goto out_link_remove;
>
>         iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
>         iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
>
>         ret = iommu_device_register(&data->iommu);
>         if (ret)
> -               return ret;
> +               goto out_sysfs_remove;

Technically, this change is unrelated.

>
>         spin_lock_init(&data->tlb_lock);
>         list_add_tail(&data->list, &m4ulist);
> @@ -754,6 +775,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>                 bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
>
>         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +
> +out_sysfs_remove:
> +       iommu_device_sysfs_remove(&data->iommu);
> +out_link_remove:
> +       if (dev->pm_domain)
> +               device_link_remove(data->smicomm_dev, dev);
> +       return ret;
>  }
>
>  static int mtk_iommu_remove(struct platform_device *pdev)
> @@ -767,6 +795,8 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>                 bus_set_iommu(&platform_bus_type, NULL);
>
>         clk_disable_unprepare(data->bclk);
> +       if (pdev->dev.pm_domain)
> +               device_link_remove(data->smicomm_dev, &pdev->dev);
>         devm_free_irq(&pdev->dev, data->irq, data);
>         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
>         return 0;
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index d0c93652bdbe..5e03a029c4dc 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -68,6 +68,7 @@ struct mtk_iommu_data {
>
>         struct iommu_device             iommu;
>         const struct mtk_iommu_plat_data *plat_data;
> +       struct device                   *smicomm_dev;
>
>         struct dma_iommu_mapping        *mapping; /* For mtk_iommu_v1.c */
>
> --
> 2.18.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
