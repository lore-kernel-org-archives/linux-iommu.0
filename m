Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD67C3A5A5
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 05:56:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE73E20870
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 05:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE73E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F1AB5C6E;
	Thu,  5 Sep 2019 05:56:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4638EC37
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 05:56:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 74763A9
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 05:56:53 +0000 (UTC)
X-UUID: b315badb3ec945b792741a96f66d657f-20190905
X-UUID: b315badb3ec945b792741a96f66d657f-20190905
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 273631663; Thu, 05 Sep 2019 13:56:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 5 Sep 2019 13:56:38 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 5 Sep 2019 13:56:37 +0800
Message-ID: <1567662999.18702.28.camel@mhfsdcap03>
Subject: Re: [PATCH v3 06/14] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: houlong wei <houlong.wei@mediatek.com>
Date: Thu, 5 Sep 2019 13:56:39 +0800
In-Reply-To: <1567570074.31301.19.camel@mhfsdcap03>
References: <mailman.21807.1567503573.19300.linux-mediatek@lists.infradead.org>
	<1567570074.31301.19.camel@mhfsdcap03>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B5594BCA8B000D0387E321BE740558961162944E3E3D0781D08371B12D3EAA0E2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	minghsiu.tsai@mediatek.com, ming-fan.chen@mediatek.com,
	anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
	Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
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

On Wed, 2019-09-04 at 12:07 +0800, houlong wei wrote:
> Hi, Yong,
> 
> I have inline comment below.

Thanks for your review.

> 
> > MediaTek IOMMU has already added the device_link between the consumer
> > and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> > 
> > CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 38 ---------------------------
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 --
> >  drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
> >  3 files changed, 41 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> > index 9afe816..5985a9b 100644
> > --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> > +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> > @@ -9,7 +9,6 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> > -#include <soc/mediatek/smi.h>
> >  
> >  #include "mtk_mdp_comp.h"
> >  
> > @@ -58,14 +57,6 @@ void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
> >  {
> >  	int i, err;
> >  
> > -	if (comp->larb_dev) {
> > -		err = mtk_smi_larb_get(comp->larb_dev);
> > -		if (err)
> > -			dev_err(dev,
> > -				"failed to get larb, err %d. type:%d id:%d\n",
> > -				err, comp->type, comp->id);
> > -	}
> 
> In previous design,mtk_mdp_comp_clock_on() is called by each MDP
> hardware component, and mtk_smi_larb_get() is also called for each MDP
> hardware component which accesses DRAM via SMI larb.
> 
> Since mdp device only contains mdp_rdma component, so
> pm_runtime_get_sync() will ignore other smi-larb clock. We need consider
> how to enable clocks of other smi-larb associated with other mdp
> component, e.g. mdp_wdma, mdp_wrot.
> 

Sorry, I'm not so familiar with mdp, thus, for MDP part, the test and
reviewing from Minghsiu or you is expected.

This patch only delete the smi interface literally. In my understanding,
mdp should call pm_runtime_get with the corresponding device, no matter
mdp_wdma or mdp_wrot device.

Of course I am not sure the mdp flow, If this patch affect its function,
please tell me. Also, If mdp driver need change correspondingly, I will
put it into this series like [12/14] of this patchset which is from
display.

[snip]


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
