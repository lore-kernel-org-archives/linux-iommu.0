Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963B5C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 05:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 219F7611D3;
	Fri, 24 Jun 2022 05:39:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 219F7611D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aPXoTZFoDIJ8; Fri, 24 Jun 2022 05:39:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B94ED60B9A;
	Fri, 24 Jun 2022 05:39:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B94ED60B9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70FC1C0039;
	Fri, 24 Jun 2022 05:39:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8167BC002D;
 Fri, 24 Jun 2022 05:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4612C84848;
 Fri, 24 Jun 2022 05:39:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4612C84848
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPz_BvAbCV52; Fri, 24 Jun 2022 05:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 254A4847AA
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 254A4847AA;
 Fri, 24 Jun 2022 05:39:06 +0000 (UTC)
X-UUID: 8974fcc91cf4473f861aa31b1ed3be7e-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:696aae49-583a-4e22-9975-bd4e6d524399, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:b14ad71, CLOUDID:17d673d8-850a-491d-a127-60d9309b2b3e,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 8974fcc91cf4473f861aa31b1ed3be7e-20220624
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2041637942; Fri, 24 Jun 2022 13:39:01 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Jun 2022 13:39:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jun 2022 13:39:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 13:38:58 +0800
Message-ID: <8a5e9c81ab1487154828af3ca21e62e39bcce18c.camel@mediatek.com>
Subject: Re: [PATCH v3 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
To: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Date: Fri, 24 Jun 2022 13:38:58 +0800
In-Reply-To: <YrUk8IINqDEZLfIa@Asurada-Nvidia>
References: <20220623200029.26007-1-nicolinc@nvidia.com>
 <20220623200029.26007-2-nicolinc@nvidia.com>
 <270eec00-8aee-2288-4069-d604e6da2925@linux.intel.com>
 <YrUk8IINqDEZLfIa@Asurada-Nvidia>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, jordan@cosmicpenguin.net,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org, kvm@vger.kernel.org,
 zhang.lyra@gmail.com, iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 jgg@nvidia.com, yangyingliang@huawei.com, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, kevin.tian@intel.com,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 christophe.jaillet@wanadoo.fr, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, marcan@marcan.st,
 linux-kernel@vger.kernel.org, baolin.wang7@gmail.com,
 linux-mediatek@lists.infradead.org, robin.murphy@arm.com
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2022-06-23 at 19:44 -0700, Nicolin Chen wrote:
> On Fri, Jun 24, 2022 at 09:35:49AM +0800, Baolu Lu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 2022/6/24 04:00, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/mtk_iommu_v1.c
> > > b/drivers/iommu/mtk_iommu_v1.c
> > > index e1cb51b9866c..5386d889429d 100644
> > > --- a/drivers/iommu/mtk_iommu_v1.c
> > > +++ b/drivers/iommu/mtk_iommu_v1.c
> > > @@ -304,7 +304,7 @@ static int mtk_iommu_v1_attach_device(struct
> > > iommu_domain *domain, struct device
> > >       /* Only allow the domain created internally. */
> > >       mtk_mapping = data->mapping;
> > >       if (mtk_mapping->domain != domain)
> > > -             return 0;
> > > +             return -EMEDIUMTYPE;
> > > 
> > >       if (!data->m4u_dom) {
> > >               data->m4u_dom = dom;
> > 
> > This change looks odd. It turns the return value from success to
> > failure. Is it a bug? If so, it should go through a separated fix
> > patch.

Thanks for the review:)

> 
> Makes sense.
> 
> I read the commit log of the original change:
> 
https://lore.kernel.org/r/1589530123-30240-1-git-send-email-yong.wu@mediatek.com
> 
> It doesn't seem to allow devices to get attached to different
> domains other than the shared mapping->domain, created in the
> in the mtk_iommu_probe_device(). So it looks like returning 0
> is intentional. Though I am still very confused by this return
> value here, I doubt it has ever been used in a VFIO context.

It's not used in VFIO context. "return 0" just satisfy the iommu
framework to go ahead. and yes, here we only allow the shared "mapping-
>domain" (All the devices share a domain created internally).

thus I think we should still keep "return 0" here.

Thanks:)

> 
> Young, would you please give us some input?
> 
> Overall, I feel it's better to play it safe here by dropping
> this part. If we later confirm there is a need to fix it, we
> will do that in a separate patch anyway.
> 
> Thanks
> Nic

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
