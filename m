Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4489BC433E6
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A4C20737
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h8WRNFGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A4C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CC07F20400;
	Fri, 17 Jul 2020 08:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Woef2j110bBE; Fri, 17 Jul 2020 08:18:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0DC972000D;
	Fri, 17 Jul 2020 08:18:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B8AC07FF;
	Fri, 17 Jul 2020 08:18:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F91DC0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 08:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 58EEC880FB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 08:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kc87MBXzpViK for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 08:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id CBD83880C2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 08:18:34 +0000 (UTC)
X-UUID: 1f5ee34c1b514bc68d959a307bc0f959-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=jFgiHvr1fVVgOZ8IpoZq8KSqHUKORJrsDZDgN40XiAY=; 
 b=h8WRNFGZ7w4shM3mbMkE2zKSbK1FnBwTqhMP4RtCVTBwu0UAbxwEL4/4SXr27m5Aq9Jo+yPsG0iSov9pqX5V+Rx4rWKLOAF0aftWk2hmfA5kNk+55XbYjbUl3ueCcMZ/xuJeHxiG+9qM0+1GAbIxL0ey+TiVl6K/ycl06VgQJdQ=;
X-UUID: 1f5ee34c1b514bc68d959a307bc0f959-20200717
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1625753150; Fri, 17 Jul 2020 16:18:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 16:18:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 16:18:24 +0800
Message-ID: <1594973906.12796.20.camel@mtkswgap22>
Subject: Re: [PATCH 1/4] dt-bindings: mediatek: add mediatek,infracfg phandle
From: Miles Chen <miles.chen@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Fri, 17 Jul 2020 16:18:26 +0800
In-Reply-To: <20200715205120.GA778876@bogus>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
 <20200715205120.GA778876@bogus>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5CB742BDEFA856503BBD69CE4475BAA8884078200B5E49D595D6209E416DC56D2000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 2020-07-15 at 14:51 -0600, Rob Herring wrote:
> On Thu, Jul 02, 2020 at 05:37:17PM +0800, Miles Chen wrote:
> > Add a description for mediatek,infracfg. We can check if 4GB mode
> > is enable by reading it instead of checking the unexported
> > symbol "max_pfn".
> > 
> > This is a step towards building mtk_iommu as a kernel module.
> 
> You determined this before without DT, so it is an OS problem and 
> shouldn't need a DT update.

Thanks for your comment.

The old way (using max_pfn) do determine this is risky because the
max_pfn may lower than (GB if reserved memory regions occupy memory
higher than 4GB.

So, the better way to do this is by reading register from H/W.
> 
> I'd assume there's only one instance of the node mediatek,infracfg 
> points to, so just search for it if you want to get the info from DT.
> 
I can do syscon_regmap_lookup_by_compatible() to search for it. However,
the compatibles are different in mt2712e.dtsi and mt8173.dtsi. so I have
to search "mediatek,mt2712-infracfg" and "mediatek,mt8173-infracfg"
respectively.

Using mediatek,infracfg phandle can make the code easier to read.
Is it possible to reconsider the phandle approach, please?


arch/arm64/boot/dts/mediatek/mt2712e.dtsi:253:
infracfg: syscon@10001000 {
compatible = "mediatek,mt2712-infracfg", "syscon";
arch/arm64/boot/dts/mediatek/mt8173.dtsi:363:                   
infracfg: power-controller@10001000 {
compatible = "mediatek,mt8173-infracfg", "syscon";



> 
> > 
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > index ce59a505f5a4..a7881deabcca 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > @@ -74,6 +74,8 @@ Required properties:
> >  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
> >  	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
> >  	according to the local arbiter index, like larb0, larb1, larb2...
> > +- mediatek,infracfg: a phandle to infracfg. It is used to confirm if 4GB mode is set.
> > +	It is an optional property, add it when the SoC have 4g mode.
> >  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
> >  	Specifies the mtk_m4u_id as defined in
> >  	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> > -- 
> > 2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
