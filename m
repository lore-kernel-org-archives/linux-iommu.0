Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0DC2D0A3
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 07:45:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C07223AB
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 07:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GwALrNlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C07223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E5E187160;
	Mon, 26 Oct 2020 07:45:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fY-j2ENqyBuU; Mon, 26 Oct 2020 07:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2494687143;
	Mon, 26 Oct 2020 07:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00416C088B;
	Mon, 26 Oct 2020 07:45:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 080D3C0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E9A9787143
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elp9oBeBr+Ub for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 07:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E5E387129
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 07:45:52 +0000 (UTC)
X-UUID: 5141fc99c02e4a1f8b70cbc146099df1-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=lojLUg9fFbo8jOsfPb9idJA9/aY654a36SbR0fCGZpQ=; 
 b=GwALrNlGsToOK6VLEuay3oe/1JeCGR0cAj8odDzxZ6h8HxTls2Aq3qhYo9I7gW6WAdnPDfVQ6bXV/aANgUFhI6FT7GuZc6ya6nVMsUpjQDOXwn26pkmF34CMZDCr1pt8liSPjfBT8Y1JvxC5a6OCvAPO+TEzfE9Tb1XbZ/sDBbQ=;
X-UUID: 5141fc99c02e4a1f8b70cbc146099df1-20201026
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 375836218; Mon, 26 Oct 2020 15:45:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 26 Oct 2020 15:45:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 15:45:34 +0800
Message-ID: <1603698334.26323.88.camel@mhfsdcap03>
Subject: Re: [PATCH v3 11/24] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable
 for MediaTek
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Mon, 26 Oct 2020 15:45:34 +0800
In-Reply-To: <20201023112148.GB20933@willie-the-truck>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-12-yong.wu@mediatek.com>
 <20201023112148.GB20933@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7D5007B554F3125CBCD9B8D492C92003C020E35494172D92BAFD6D3255A98BE82000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, 2020-10-23 at 12:21 +0100, Will Deacon wrote:
> On Wed, Sep 30, 2020 at 03:06:34PM +0800, Yong Wu wrote:
> > The standard input iova bits is 32. MediaTek quad the lvl1 pagetable
> > (4 * lvl1). No change for lvl2 pagetable. Then the iova bits can reach
> > 34bit.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 13 ++++++++++---
> >  drivers/iommu/mtk_iommu.c          |  2 +-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 8362fdf76657..306bae2755ed 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -50,10 +50,17 @@
> >   */
> >  #define ARM_V7S_ADDR_BITS		32
> 
> If we rename this to _ARM_V7S_ADDR_BITS can we then have ARM_V7S_ADDR_BITS
> take a cfg parameter and move the arm_v7s_is_mtk_enabled() check in there?
> Same for _ARM_V7S_LVL_BITS.
> 
> That would avoid scattering arm_v7s_is_mtk_enabled() into all the users.

I added "cfg" for _ARM_V7S_LVL_BITS in Robin's mail. is that ok?

Regarding ARM_V7S_ADDR_BITS, I'd like to keep it as is(Don't add cfg),
this macro only is used in ARM_V7S_LVL_SHIFT and checking the value of
ias/oas.

a) ARM_V7S_LVL_SHIFT always expect ARM_V7S_ADDR_BITS is 32.

b) our ias/oas is different(ias is 34 while oas is 35). If we define a
new macro, we need two about this, like:
#define ARM_V7S_IADDR_BITS(cfg)	(!arm_v7s_is_mtk_enabled(cfg) ? 32 : 34)
#define ARM_V7S_OADDR_BITS(cfg)	(!arm_v7s_is_mtk_enabled(cfg) ? 32 : 35)
and the two will only are used in the checking of ias/oas.

thus it looks unnecessary?

> 
> Will

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
