Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF394C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:57:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440BE2080C
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UJ1XsXF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440BE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9ABB87091;
	Tue, 15 Sep 2020 05:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmkBXx5Q6MJO; Tue, 15 Sep 2020 05:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4745787006;
	Tue, 15 Sep 2020 05:57:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E03C0859;
	Tue, 15 Sep 2020 05:57:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E95FDC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDFD98708C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Myg6ljLxAmLM for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 05:57:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3FB8687006
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:57:14 +0000 (UTC)
X-UUID: f93b882ba17d4d34b5c81542cc40b4fb-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=7TyzYnNnuHx6SNq8ViyS5YlncO0DkL6/ccYuDYtvhdI=; 
 b=UJ1XsXF8Ynu+qsosV0rMO09oCcSY3xfeeO2NBBj4NecLn6viicLZLP9KTZl5L6FvI4/9AwDmGV7bYbJq5qvNOi46FeuCahvqz3pzdcJRUvQGA51xNKE9zyCfsHI2q7lBrMgUf5CjpgEim4ZUCHXYsidXkQqqQ7adBQnmIAaua38=;
X-UUID: f93b882ba17d4d34b5c81542cc40b4fb-20200915
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 829302080; Tue, 15 Sep 2020 13:57:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 15 Sep 2020 13:57:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 13:57:06 +0800
Message-ID: <1600149301.25043.17.camel@mhfsdcap03>
Subject: Re: [PATCH v2 02/23] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Tue, 15 Sep 2020 13:55:01 +0800
In-Reply-To: <20200914232345.GA465583@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-3-yong.wu@mediatek.com>
 <20200914232345.GA465583@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F0B44B45969F81D8D7A3A71A4A0A1C136FDDE0730FA3C551C17876F4581648A22000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
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

On Mon, 2020-09-14 at 17:23 -0600, Rob Herring wrote:
> On Sat, Sep 05, 2020 at 04:08:59PM +0800, Yong Wu wrote:
> > Convert MediaTek SMI to DT schema.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../mediatek,smi-common.txt                   | 49 ----------
> >  .../mediatek,smi-common.yaml                  | 96 +++++++++++++++++++
> >  .../memory-controllers/mediatek,smi-larb.txt  | 49 ----------
> >  .../memory-controllers/mediatek,smi-larb.yaml | 85 ++++++++++++++++

[...]

> > +  mediatek,smi:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: a phandle to the smi_common node.
> > +
> > +  mediatek,larb-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: the hardware id of this larb.
> > +      Required property for mt2701, mt2712, mt6779 and mt7623.
> 
> Is there a set of valid values?

In the patch[4/23], I change the larb_nr to 32. normally this id is from
0 to 31. I will add this in next version:

    minimum: 0
    maximum: 31

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8173-clk.h>
> > +    #include <dt-bindings/power/mt8173-power.h>
> > +
> > +    larb1: larb@16010000 {
> > +      compatible = "mediatek,mt8173-smi-larb";
> > +      reg = <0x16010000 0x1000>;
> > +      mediatek,smi = <&smi_common>;
> > +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> > +      clocks = <&vdecsys CLK_VDEC_CKEN>,
> > +               <&vdecsys CLK_VDEC_LARB_CKEN>;
> > +      clock-names = "apb", "smi";
> > +    };
> > +
> > -- 
> > 2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
