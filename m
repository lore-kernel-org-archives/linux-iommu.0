Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A83C33C9E
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DCB2081E
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YwjgCSzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DCB2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97385872E8;
	Tue,  7 Jan 2020 11:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMFSzxSm4jWp; Tue,  7 Jan 2020 11:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7441485E5E;
	Tue,  7 Jan 2020 11:12:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AFB9C1D82;
	Tue,  7 Jan 2020 11:12:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE74EC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 11:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B1E6685456
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 11:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2COUXmZ9uX2 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 11:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 401D185455
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 11:12:05 +0000 (UTC)
X-UUID: e9480024c608450193c56231e429a662-20200107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=WMr3UPnGITP5bTTnYXem67Bw3Z1PvUOBw2GrJkfKFx8=; 
 b=YwjgCSzJXVfLC99n7e4cqNA2MAxsJEgaIqsnetT4ZmqDb/cjlZSbLtLJhs43Ra2dI+kqo0a3iE1DAxWBN3QgL1hhf/oeZ0NEGC5lH2pcQcqrs1otIyQLNnEd6FM1Q3PnvH+pYPGDgANzAKiEfQhOTtMkenTM8Rvgj8r5FqSqwro=;
X-UUID: e9480024c608450193c56231e429a662-20200107
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 735702914; Tue, 07 Jan 2020 19:12:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 Jan 2020 19:11:33 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 Jan 2020 19:10:53 +0800
Message-ID: <1578395459.19217.5.camel@mbjsdccf07>
Subject: Re: [PATCH v2 01/19] dt-bindings: mediatek: Add bindings for MT6779
From: chao hao <Chao.Hao@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Tue, 7 Jan 2020 19:10:59 +0800
In-Reply-To: <20200106215716.GA31059@bogus>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
 <20200105104523.31006-2-chao.hao@mediatek.com>
 <20200106215716.GA31059@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Cui Zhang <cui.zhang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, 2020-01-06 at 15:57 -0600, Rob Herring wrote:
> On Sun, 5 Jan 2020 18:45:05 +0800, Chao Hao wrote:
> > This patch adds description for MT6779 IOMMU.
> > 
> > MT6779 has two iommus, they are MM_IOMMU and APU_IOMMU which
> > use ARM Short-Descriptor translation format.
> > 
> > The MT6779 IOMMU hardware diagram is as below, it is only a brief
> > diagram about iommu, it don't focus on the part of smi_larb, so
> > I don't describe the smi_larb detailedly.
> > 
> > 			     EMI
> > 			      |
> > 	   --------------------------------------
> > 	   |					|
> >         MM_IOMMU                            APU_IOMMU
> > 	   |					|
> >        SMI_COMMOM-----------		     APU_BUS
> >           |		   |			|
> >     SMI_LARB(0~11)  SMI_LARB12(FAKE)	    SMI_LARB13(FAKE)
> > 	  |		   |			|
> > 	  |		   |		   --------------
> > 	  |		   |		   |	 |	|
> >    Multimedia engine	  CCU		  VPU   MDLA   EMDA
> > 
> > All the connections are hardware fixed, software can not adjust it.
> > 
> > >From the diagram above, MM_IOMMU provides mapping for multimedia engine,
> > but CCU is connected with smi_common directly, we can take them as larb12.
> > APU_IOMMU provides mapping for APU engine, we can take them larb13.
> > Larb12 and Larb13 are fake larbs.
> > 
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  .../bindings/iommu/mediatek,iommu.txt         |   2 +
> >  include/dt-bindings/memory/mt6779-larb-port.h | 215 ++++++++++++++++++
> >  2 files changed, 217 insertions(+)
> >  create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Hi Rob,

I am Sorry, this is my first time upstream and not clear for some
details, please forgive me for this mistake.
I put the changed explanation into cover letter([PATCH v2 00/19] MT6779
IOMMU SUPPORT) about this patch. I will pay attention to this problem in
next version.

Change since v1 for this patch
1.Delete M4U_PORT_UNKNOWN define because of not use it.
2.Correct coding format: ex: /*larb3-VENC*/  -->  /* larb3-VENC */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
