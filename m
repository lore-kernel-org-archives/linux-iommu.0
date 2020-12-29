Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDAEC433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:25:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF1F207B8
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF1F207B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCEB08712C;
	Tue, 29 Dec 2020 11:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipWgY6kW8hFB; Tue, 29 Dec 2020 11:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2D2CB87120;
	Tue, 29 Dec 2020 11:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 107D2C088B;
	Tue, 29 Dec 2020 11:25:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0281BC0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC21386866
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iWHbG3v0kJQN for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 11:25:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5570848A3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:25:17 +0000 (UTC)
X-UUID: baca8fc22ce7428f86fe29ae54de9112-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=ldY0xu4Bpq6j4mWxH+e0rb8pjBx8nAg1BnDNDsLOWX4=; 
 b=T6h8g+KmaOyIVuuy7UkFGdmixI7BSKDTYjn5Dz157ZZ1x16C5Bwa2LvvZRawo7v+98JYzKV3C4cvBmEFIRuVR89cxe12oOTz9E8qtYuJ8ulMuCsh9Daag/xzd0x8RGcIyjqureR0QDpJydEzzTDccTuEMQAxK4k9PcrKcvRyZpw=;
X-UUID: baca8fc22ce7428f86fe29ae54de9112-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 959207855; Tue, 29 Dec 2020 19:25:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 29 Dec 2020 19:25:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:25:12 +0800
Message-ID: <1609241112.26323.299.camel@mhfsdcap03>
Subject: Re: [PATCH v5 16/27] iommu/mediatek: Add device link for smi-common
 and m4u
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Dec 2020 19:25:12 +0800
In-Reply-To: <X+L/0E6p9t+a/l5w@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-17-yong.wu@mediatek.com>
 <X+L/0E6p9t+a/l5w@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B7DF2E6AB0CEF4F62DCE00F5D850EE1FFCC5768A5FB62BA86F6C9FE06CF202472000:8
X-MTK: N
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

On Wed, 2020-12-23 at 17:29 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:51PM +0800, Yong Wu wrote:
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
> >  drivers/iommu/mtk_iommu.c | 30 ++++++++++++++++++++++++++++--
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 09c8c58feb78..5614015e5b96 100644
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
> > @@ -706,7 +707,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  		return larb_nr;
> >  
> >  	for (i = 0; i < larb_nr; i++) {
> > -		struct device_node *larbnode;
> > +		struct device_node *larbnode, *smicomm_node;
> >  		struct platform_device *plarbdev;
> >  		u32 id;
> >  
> > @@ -732,6 +733,26 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  
> >  		component_match_add_release(dev, &match, release_of,
> >  					    compare_of, larbnode);
> > +		if (i != 0)
> > +			continue;
> 
> How about using the last larb instead and moving the code below outside
> of the loop?

Of course OK. Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
