Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A5C11F68
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 07:31:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6080B61D03
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 07:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6080B61D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 196EB40178;
	Wed, 30 Jun 2021 07:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3LzvU-zCNzou; Wed, 30 Jun 2021 07:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4ED8F40184;
	Wed, 30 Jun 2021 07:31:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2614EC0010;
	Wed, 30 Jun 2021 07:31:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9CDC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 07:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5478B40639
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 07:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdGfQYliWhRA for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 07:31:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp4.osuosl.org (Postfix) with ESMTP id 720DD405FB
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 07:31:30 +0000 (UTC)
X-UUID: d8c28328ba0341c8a7351691847667c5-20210630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=62IYE54IdDULAKwoKbHVM6/DHaOQllqFJgwJn2lFs3o=; 
 b=Js6kweoZOvtGLYzNFo9t8a6+U0vW5lmffG+YczPcM8ZIJNp9LAJ2Ldjy9xqh81eVmBJJgc1hfG1FBIJtP0VJKWyMSewHqH4K4tuJEWDOGUgjyn6wIks8PM/I3ocSQxFLg/JMQFk+ft45X+EgAYPvsMJpjQugEuHmV8xvZqKMIHY=;
X-UUID: d8c28328ba0341c8a7351691847667c5-20210630
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1737304554; Wed, 30 Jun 2021 15:31:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 30 Jun 2021 15:30:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 15:30:57 +0800
Message-ID: <1625038257.25647.5.camel@mhfsdcap03>
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 30 Jun 2021 15:30:57 +0800
In-Reply-To: <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-2-yong.wu@mediatek.com>
 <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1963F5674633076AEF957F6E442E2D1D0BE305E0B7F438FD146FEE00D7D59E362000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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

On Wed, 2021-06-30 at 08:26 +0200, Krzysztof Kozlowski wrote:
> On 30/06/2021 04:34, Yong Wu wrote:
> > This patch adds descriptions for mt8195 IOMMU which also use ARM
> > Short-Descriptor translation table format.
> > 
> > In mt8195, there are two smi-common HW and IOMMU, one is for vdo(video
> > output), the other is for vpp(video processing pipe). They connects
> > with different smi-larbs, then some setting(larbid_remap) is different.
> > Differentiate them with the compatible string.
> > 
> > Something like this:
> > 
> >     IOMMU(VDO)          IOMMU(VPP)
> >        |                   |
> >   SMI_COMMON_VDO      SMI_COMMON_VPP
> >   ---------------     ----------------
> >   |      |   ...      |      |     ...
> > larb0 larb2  ...    larb1 larb3    ...
> > 
> > Another change is that we have a new IOMMU that is for infra master like
> > PCIe and USB. The infra master don't have the larb and ports, thus we
> > rename the port header file to mt8195-memory-port.h rather than
> > mt8195-larb-port.h.
> > 
> > Also, the IOMMU is not only for MM, thus, we don't call it "m4u" which
> > means "MultiMedia Memory Management UNIT". thus, use the "iommu" as the
> > compatiable string.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
> >  .../dt-bindings/memory/mt8195-memory-port.h   | 390 ++++++++++++++++++
> >  2 files changed, 397 insertions(+)
> >  create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> > 
> 
> I understand this will go through IOMMU tree. Do you know about any
> further patches for memory controllers which will need the header?

This header file will only be used in dtsi file. the iommu masters will
use these port definitions in the dtsi.

The SMI driver no need include this header file.

By the way, the mt8195 SMI patches is at:

https://lore.kernel.org/linux-mediatek/20210616114346.18812-1-yong.wu@mediatek.com/ 

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks very much for your quick review.

> 
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
