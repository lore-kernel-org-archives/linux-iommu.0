Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F1C388F9
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:42:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0B1207F7
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 02:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B7i1qKrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0B1207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 717D486D22;
	Thu, 12 Nov 2020 02:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6OP9yZPlcvKb; Thu, 12 Nov 2020 02:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C09C86CEF;
	Thu, 12 Nov 2020 02:42:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49001C0889;
	Thu, 12 Nov 2020 02:42:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1A01C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AC8D087541
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FPTlk739yds for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 02:42:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 17E108753C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 02:42:27 +0000 (UTC)
X-UUID: 9be016932b0b47b695a8a04d0e8f8134-20201112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=2akmVV9MmjilHzebTF46wwbdEe3nnOXuaGxT3mDFxZs=; 
 b=B7i1qKrUtHcI/SrwT5pZORy4ir14B95DBrTr40zBuN/emudAM9UljPzdzwIxIU/KipAoPdnBqq69O4YtWo0SayqRd9mCp/cVg8pqHfY55ZKSB3xDznpBQJzrWb2xopkGnj2phZeALos97dcKsTy7u7el/w3Lg5rwWjTpp2N/hDw=;
X-UUID: 9be016932b0b47b695a8a04d0e8f8134-20201112
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1625091449; Thu, 12 Nov 2020 10:42:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 12 Nov 2020 10:42:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 10:42:19 +0800
Message-ID: <1605148938.26323.127.camel@mhfsdcap03>
Subject: Re: [PATCH v4 13/24] iommu/mediatek: Add device link for smi-common
 and m4u
From: Yong Wu <yong.wu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 12 Nov 2020 10:42:18 +0800
In-Reply-To: <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-14-yong.wu@mediatek.com>
 <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9DD61C76332B6A687D16ACA0116BA587755327AA8BAE00AF0ECEE2DBB83A02B42000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Tomasz Figa <tfiga@google.com>,
 kernel-team@android.com, lkml <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Evan Green <evgreen@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
 Will Deacon <will@kernel.org>, linux-arm
 Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 2020-11-12 at 09:10 +0800, Nicolas Boichat wrote:
> On Wed, Nov 11, 2020 at 8:40 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the lastest SoC, M4U has its special power domain. thus, If the engine
> > begin to work, it should help enable the power for M4U firstly.
> > Currently if the engine work, it always enable the power/clocks for
> > smi-larbs/smi-common. This patch adds device_link for smi-common and M4U.
> > then, if smi-common power is enabled, the M4U power also is powered on
> > automatically.
> >
> > Normally M4U connect with several smi-larbs and their smi-common always
> > are the same, In this patch it get smi-common dev from the first smi-larb
> > device(i==0), then add the device_link only while m4u has power-domain.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 36 +++++++++++++++++++++++++++++++++---
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 34 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index cfdf5ce696fd..4ce7e0883e4d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > @@ -705,7 +706,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >                 return larb_nr;
> >
> >         for (i = 0; i < larb_nr; i++) {
> > -               struct device_node *larbnode;
> > +               struct device_node *larbnode, *smicomm_node;
> >                 struct platform_device *plarbdev;
> >                 u32 id;
> >
> > @@ -731,6 +732,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >
> >                 component_match_add_release(dev, &match, release_of,
> >                                             compare_of, larbnode);
> > +               if (!i) {
> 
> Maybe more of a style preference, but since you are actually comparing
> an integer, I prefer seeing i == 0.
> 
> Also, might be nicer to do
> 
> if (i != 0)
>    continue;
> 
> And de-indent the rest.

Thanks. will fix.

> 
> > +                       smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> > +                       if (!smicomm_node)
> > +                               return -EINVAL;
> > +
> > +                       plarbdev = of_find_device_by_node(smicomm_node);
> > +                       of_node_put(smicomm_node);
> > +                       data->smicomm_dev = &plarbdev->dev;
> > +               }
> > +       }
> > +
> > +       if (dev->pm_domain) {
> > +               struct device_link *link;
> > +
> > +               link = device_link_add(data->smicomm_dev, dev,
> > +                                      DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> > +               if (!link) {
> > +                       dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> > +                       return -EINVAL;
> > +               }
> >         }
> >
> >         platform_set_drvdata(pdev, data);
> > @@ -738,14 +759,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >         ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
> >                                      "mtk-iommu.%pa", &ioaddr);
> >         if (ret)
> > -               return ret;
> > +               goto out_link_remove;
> >
> >         iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
> >         iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
> >
> >         ret = iommu_device_register(&data->iommu);
> >         if (ret)
> > -               return ret;
> > +               goto out_sysfs_remove;
> 
> Technically, this change is unrelated.

Sharp eye. Right. I thought it was small enough to squash here.

I will use a new patch to fix this(add fixes tag, and no need add
cc-stable I think.).

> 
> >
> >         spin_lock_init(&data->tlb_lock);
> >         list_add_tail(&data->list, &m4ulist);
> > @@ -754,6 +775,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >                 bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
> >
> >         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> > +
> > +out_sysfs_remove:
> > +       iommu_device_sysfs_remove(&data->iommu);
> > +out_link_remove:
> > +       if (dev->pm_domain)
> > +               device_link_remove(data->smicomm_dev, dev);
> > +       return ret;
> >  }
> >
> >  static int mtk_iommu_remove(struct platform_device *pdev)
> > @@ -767,6 +795,8 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> >                 bus_set_iommu(&platform_bus_type, NULL);
> >
> >         clk_disable_unprepare(data->bclk);
> > +       if (pdev->dev.pm_domain)
> > +               device_link_remove(data->smicomm_dev, &pdev->dev);
> >         devm_free_irq(&pdev->dev, data->irq, data);
> >         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> >         return 0;
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index d0c93652bdbe..5e03a029c4dc 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -68,6 +68,7 @@ struct mtk_iommu_data {
> >
> >         struct iommu_device             iommu;
> >         const struct mtk_iommu_plat_data *plat_data;
> > +       struct device                   *smicomm_dev;
> >
> >         struct dma_iommu_mapping        *mapping; /* For mtk_iommu_v1.c */
> >
> > --
> > 2.18.0
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
