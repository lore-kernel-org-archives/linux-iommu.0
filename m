Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE87C433E1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 02:37:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E0320A8B
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 02:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WrBBTQc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0320A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6589A8985A;
	Fri,  3 Jul 2020 02:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVMEUgindde7; Fri,  3 Jul 2020 02:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9BB1B89854;
	Fri,  3 Jul 2020 02:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E837C0890;
	Fri,  3 Jul 2020 02:37:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75BAAC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D85288C78
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17edfVLztOrt for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 02:37:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2D67888C71
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:37:37 +0000 (UTC)
X-UUID: e3168b26750c43e7820306a4ad4e8fe6-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=nfiF1q92PaTMd0SuXB3WAwRouzIiMHg7VW7edlego8Y=; 
 b=WrBBTQc56UrWQBbztWpifOQKmZLirDulavXIkZ0MP52Pm+X+Z30t9UK0PlHzdMOXQcqY3ySwD2XZXSwkgivvoJDH1swgcChoz7CP7wkM+WVRtsNj4aJm2TVBLq4lSi44L1PQe5l4B3WzQqFRQ+cbOWobnZDqKvF8sQvx59KZTQs=;
X-UUID: e3168b26750c43e7820306a4ad4e8fe6-20200703
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 916058513; Fri, 03 Jul 2020 10:37:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 10:37:32 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 10:37:32 +0800
Message-ID: <1593743784.22738.0.camel@mbjsdccf07>
Subject: Re: [PATCH v5 02/10] iommu/mediatek: Rename the register
 STANDARD_AXI_MODE(0x48) to MISC_CTRL
From: chao hao <Chao.Hao@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Fri, 3 Jul 2020 10:36:24 +0800
In-Reply-To: <1593569872.32037.6.camel@mhfsdcap03>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-3-chao.hao@mediatek.com>
 <1593569872.32037.6.camel@mhfsdcap03>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: FY Yang <fy.yang@mediatek.com>, wsd_upstream@mediatek.com,
 Chao Hao <"chao hao"@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
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

On Wed, 2020-07-01 at 10:17 +0800, Yong Wu wrote:
> On Mon, 2020-06-29 at 15:13 +0800, Chao Hao wrote:
> > For iommu offset=0x48 register, only the previous mt8173/mt8183 use the
> > name STANDARD_AXI_MODE, all the latest SoC extend the register more
> > feature by different bits, for example: axi_mode, in_order_en, coherent_en
> > and so on. So rename REG_MMU_MISC_CTRL may be more proper.
> > 
> > This patch only rename the register name, no functional change.
> > 
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 14 +++++++-------
> >  drivers/iommu/mtk_iommu.h |  2 +-
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> ...
> 
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index ea949a324e33..1b6ea839b92c 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -18,7 +18,7 @@
> >  #include <soc/mediatek/smi.h>
> >  
> >  struct mtk_iommu_suspend_reg {
> > -	u32				standard_axi_mode;
> > +	u32				misc_ctrl;
> 
> Here will cause build fail for v1:
> 
> drivers/iommu/mtk_iommu_v1.c:675:20: error: 'struct
> mtk_iommu_suspend_reg' has no member named 'standard_axi_mode'
>   writel_relaxed(reg->standard_axi_mode,
>                     ^
> 
> We could change something like:
> 
> union {
> 	u32	standard_axi_mode; /* only for v1 */
> 	u32	misc_ctrl;         /* only for v2 */
> };
> 
> >  	u32				dcm_dis;
> >  	u32				ctrl_reg;
> >  	u32				int_control0;

ok, I will fix it in next version, thanks

> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
