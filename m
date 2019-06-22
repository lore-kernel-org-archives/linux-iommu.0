Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70638C48BE0
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD7E20821
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD7E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E9E51429;
	Sat, 22 Jun 2019 02:42:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C918E13F6
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 02:42:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0CE5D27B
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 02:42:54 +0000 (UTC)
X-UUID: 3a5c12a496284309aaa64221c992f670-20190622
X-UUID: 3a5c12a496284309aaa64221c992f670-20190622
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1618682078; Sat, 22 Jun 2019 10:42:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Sat, 22 Jun 2019 10:42:48 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 22 Jun 2019 10:42:47 +0800
Message-ID: <1561171367.4850.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2 02/12] iommu/mediatek: Add probe_defer for smi-larb
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Sat, 22 Jun 2019 10:42:47 +0800
In-Reply-To: <a11fa818-cf62-cc24-2c41-4688fda5a88f@gmail.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
	<1560171313-28299-3-git-send-email-yong.wu@mediatek.com>
	<a11fa818-cf62-cc24-2c41-4688fda5a88f@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 62D4D809DF879D30713C1D085668025D905896208B75832BE651A5243713B1D32000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Tomasz
	Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


On Wed, 2019-06-19 at 15:52 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:55, Yong Wu wrote:
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready, then all the iommu consumer always is after the smi driver.
> > 
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> > 
> > This is a preparing patch for adding device_link.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 2 +-
> >  drivers/iommu/mtk_iommu_v1.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6fe3369..f7599d8 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -664,7 +664,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  			id = i;
> >  
> >  		plarbdev = of_find_device_by_node(larbnode);
> > -		if (!plarbdev) {
> > +		if (!plarbdev || !plarbdev->dev.driver) {
> 
> can't we use:
> device_lock()
> device_is_bound(struct device *dev)
> device_unlock()

A new API for me. Thanks the hint. I have tried. it is ok.


> 
> >  			of_node_put(larbnode);
> >  			return -EPROBE_DEFER;
> >  		}
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 0b0908c..c43c4a0 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -604,7 +604,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  			plarbdev = of_platform_device_create(
> >  						larb_spec.np, NULL,
> >  						platform_bus_type.dev_root);
> > -			if (!plarbdev) {
> > +			if (!plarbdev || !plarbdev->dev.driver) {
> >  				of_node_put(larb_spec.np);
> >  				return -EPROBE_DEFER;
> >  			}
> > 



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
