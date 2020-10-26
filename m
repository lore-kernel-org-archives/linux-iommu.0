Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F0CC2D0A3
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 07:42:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FC222370
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 07:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JrwCHtZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FC222370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60C1187160;
	Mon, 26 Oct 2020 07:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXhfd9u0npYS; Mon, 26 Oct 2020 07:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7FC7B87129;
	Mon, 26 Oct 2020 07:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D676C088B;
	Mon, 26 Oct 2020 07:42:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55D2CC0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 373C2866FE
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzAjUzE9F8yL for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 07:42:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 18C1786669
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:42:12 +0000 (UTC)
X-UUID: b451202fb9eb4ca7b6d1941c66e6ee5b-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=KDA+LpW6FDBz49qbTaYvO3XwD3JWyDQOAMzmFaf86MU=; 
 b=JrwCHtZFB/nCXCepC9MG9nKlZ7OeettQ0mHd0/YgOk0O572rD+nH+Se1SZ1G/4XcO0bvGGqndoBO4Rqpz75j4g13cWW3bjBtkeeIWngGaRcU8aWFocPcp8Af67Bc2gPfhP6+Mrw/UKtLGYT7Axex7f0/rjJ8lgzUs1iuKnMyxqs=;
X-UUID: b451202fb9eb4ca7b6d1941c66e6ee5b-20201026
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 166890295; Mon, 26 Oct 2020 15:42:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 26 Oct 2020 15:41:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 15:41:22 +0800
Message-ID: <1603698083.26323.87.camel@mhfsdcap03>
Subject: Re: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable
 for MediaTek
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 26 Oct 2020 15:41:23 +0800
In-Reply-To: <a5713949-1d95-40f1-d35d-d99735b48294@arm.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-12-yong.wu@mediatek.com>
 <a5713949-1d95-40f1-d35d-d99735b48294@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 020A65BDCF4EA27467567D031B54810B516A69E7C2B6BB71FC4C0F5EDD0582DF2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 2020-10-23 at 15:10 +0100, Robin Murphy wrote:
> On 2020-09-30 08:06, Yong Wu wrote:
> > The standard input iova bits is 32. MediaTek quad the lvl1 pagetable
> > (4 * lvl1). No change for lvl2 pagetable. Then the iova bits can reach
> > 34bit.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/io-pgtable-arm-v7s.c | 13 ++++++++++---
> >   drivers/iommu/mtk_iommu.c          |  2 +-
> >   2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 8362fdf76657..306bae2755ed 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -50,10 +50,17 @@
> >    */
> >   #define ARM_V7S_ADDR_BITS		32
> >   #define _ARM_V7S_LVL_BITS(lvl)		(16 - (lvl) * 4)
> > +/* MediaTek: totally 34bits, 14bits at lvl1 and 8bits at lvl2. */
> > +#define _ARM_V7S_LVL_BITS_MTK(lvl)	(20 - (lvl) * 6)
> 
> This should defined in terms of both lvl and cfg->ias. The formula here 
> is nothing more than a disgusting trick I made up since a linear 
> interpolation happened to fit the required numbers. That said, all of 
> these bits pretending that short-descriptor is a well-defined recursive 
> format only served to allow the rest of the code to look more like the 
> LPAE code - IIRC they've already diverged a fair bit since then, so 
> frankly a lot of this could stand to be unpicked and made considerably 
> clearer by simply accepting that level 1 and level 2 are different from 
> each other.

If the formula is not good and make it clearer, How about this?


/*
 * We have 32 bits total; 12 bits resolved at level 1, 8 bits at level
2,
-* and 12 bits in a page. With some carefully-chosen coefficients we can
-* hide the ugly inconsistencies behind these macros and at least let
the
-* rest of the code pretend to be somewhat sane.
+* and 12 bits in a page.
+*
+* MediaTek extend 2 bits to reach 34 bits, 14 bits at lvl1 and 8 bits
at lvl2.
 */

-#define _ARM_V7S_LVL_BITS(lvl)		(16 - (lvl) * 4)
+#define _ARM_V7S_LVL1_BITS_NR(cfg)     (((cfg)->ias == 32) ? 12 : 14)
+#define _ARM_V7S_LVL2_BITS_NR		8
+
+#define _ARM_V7S_LVL_BITS(lvl, cfg)    \
+      (((lvl) == 1) ? _ARM_V7S_LVL1_BITS_NR(cfg):_ARM_V7S_LVL2_BITS_NR)

> Robin.
> 
> >   #define ARM_V7S_LVL_SHIFT(lvl)		(ARM_V7S_ADDR_BITS - (4 + 8 * (lvl)))
> >   #define ARM_V7S_TABLE_SHIFT		10
> >   
> > -#define ARM_V7S_PTES_PER_LVL(lvl, cfg)	(1 << _ARM_V7S_LVL_BITS(lvl))
> > +#define ARM_V7S_PTES_PER_LVL(lvl, cfg)	({				\
> > +	int _lvl = lvl;							\
> > +	!arm_v7s_is_mtk_enabled(cfg) ?					\
> > +	 (1 << _ARM_V7S_LVL_BITS(_lvl)) : (1 << _ARM_V7S_LVL_BITS_MTK(_lvl));\
> > +})
> > +
> >   #define ARM_V7S_TABLE_SIZE(lvl, cfg)					\
> >   	(ARM_V7S_PTES_PER_LVL(lvl, cfg) * sizeof(arm_v7s_iopte))
> >   
> > @@ -63,7 +70,7 @@
> >   #define _ARM_V7S_IDX_MASK(lvl, cfg)	(ARM_V7S_PTES_PER_LVL(lvl, cfg) - 1)
> >   #define ARM_V7S_LVL_IDX(addr, lvl, cfg)	({			\
> >   	int _l = lvl;							\
> > -	((u32)(addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l, cfg); \
> > +	((addr) >> ARM_V7S_LVL_SHIFT(_l)) & _ARM_V7S_IDX_MASK(_l, cfg); \
> >   })
> >   
> >   /*
> > @@ -755,7 +762,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >   {
> >   	struct arm_v7s_io_pgtable *data;
> >   
> > -	if (cfg->ias > ARM_V7S_ADDR_BITS)
> > +	if (cfg->ias > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> >   		return NULL;
> >   
> >   	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index f6a2e3eb59d2..6e85c9976a33 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -316,7 +316,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
> >   			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
> >   			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
> >   		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
> > -		.ias = 32,
> > +		.ias = 34,
> >   		.oas = 35,
> >   		.tlb = &mtk_iommu_flush_ops,
> >   		.iommu_dev = data->dev,
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
