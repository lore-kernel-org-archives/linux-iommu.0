Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB24C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:52:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D979F206C9
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 05:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RL4wcFJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D979F206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 91AAF20477;
	Tue, 15 Sep 2020 05:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z3MLvDwYOVVQ; Tue, 15 Sep 2020 05:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8F8C820472;
	Tue, 15 Sep 2020 05:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73883C0859;
	Tue, 15 Sep 2020 05:52:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2041C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8B8D986FA1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CA0On+VxII9i for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 05:52:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3A8A086F9F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 05:52:04 +0000 (UTC)
X-UUID: 75f0df4815ca46939aaf5de83bc32b9c-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=nJ8djf+4aZ5rpE1RVUZAt4X6QQ07QZXLCPjNDV2nP0c=; 
 b=RL4wcFJAGI/WWOo/h8kNFBRG4OXSQtq6TSLfmEjJhIIgtJWFU74DjUxhdwd7CZ6Bk4G5EvSNItOTJeEsX2/yr0p0BWnKLUFh0fBobRm6vrjZe8ii/03TiHC7bKEWvYvxSP+m4RZ/T1qhC2LoY56T5RafSglFN3hp3UgyZPQZCQs=;
X-UUID: 75f0df4815ca46939aaf5de83bc32b9c-20200915
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1538148269; Tue, 15 Sep 2020 13:51:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 15 Sep 2020 13:51:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 13:51:45 +0800
Message-ID: <1600148980.25043.11.camel@mhfsdcap03>
Subject: Re: [PATCH v2 01/23] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Tue, 15 Sep 2020 13:49:40 +0800
In-Reply-To: <20200914232204.GA457962@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-2-yong.wu@mediatek.com>
 <20200914232204.GA457962@bogus>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 111B958147B5710F8EC8EE31D6C3E1F8F83B044953526CC951ED6485D3399B752000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-09-14 at 17:22 -0600, Rob Herring wrote:
> On Sat, Sep 05, 2020 at 04:08:58PM +0800, Yong Wu wrote:
> > Convert MediaTek IOMMU to DT schema.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---

[...]

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt2701-m4u #mt2701 generation one HW
> > +      - mediatek,mt2712-m4u #mt2712 generation two HW
> > +      - mediatek,mt6779-m4u #mt6779 generation two HW
> > +      - mediatek,mt7623-m4u, mediatek,mt2701-m4u #mt7623 generation one HW
> 
> This is not right.
> 
> items:
>   - const: mediatek,mt7623-m4u
>   - const: mediatek,mt2701-m4u
> 
> And that has to be under a 'oneOf' with the rest of this.

Thanks for the review. Is this OK?

  compatible:
    oneOf:
      - const: mediatek,mt2701-m4u # mt2701 generation one HW
      - const: mediatek,mt2712-m4u # mt2712 generation two HW
      - const: mediatek,mt6779-m4u # mt6779 generation two HW
      - const: mediatek,mt8173-m4u # mt8173 generation two HW
      - const: mediatek,mt8183-m4u # mt8183 generation two HW
      - const: mediatek,mt8192-m4u # mt8192 generation two HW
            
      - description: mt7623 generation one HW
        items:
          - const: mediatek,mt7623-m4u
          - const: mediatek,mt2701-m4u

> 
> > +      - mediatek,mt8173-m4u #mt8173 generation two HW
> > +      - mediatek,mt8183-m4u #mt8183 generation two HW
> > +
> > +  reg:
> > +    maxItems: 1

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
