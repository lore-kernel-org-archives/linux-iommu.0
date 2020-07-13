Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5AC433E4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAB6208D5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAB6208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 111E48A05D;
	Mon, 13 Jul 2020 21:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mox7sz-YP7WW; Mon, 13 Jul 2020 21:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D60189919;
	Mon, 13 Jul 2020 21:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44837C0888;
	Mon, 13 Jul 2020 21:36:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99315C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 88D7F8A055
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGvsxxq6vqWX for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 21:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1357889919
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:36:08 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id p205so6592142iod.8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 14:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ds31A3g/zm7RWz12Mdt2xEVw3TUuXdV7t8TgREVUS5k=;
 b=H7rZQHUXfrv7yV3sSvMrx/uEAG2fKgcDe7dIp+ICwq2cyvTBjiZyk6cas2lo+CHD7P
 umGZaKzOfZAnheNb3dNriXZ/CNeuFoEVCV+YB8nERVmUH6UWZrJ8zfLjj7kXshwsIUR/
 V0q4VGaEl2XQcmopx6G2w9e/qZeKO4p3fvl0VBjEwoQxP0fqvrsimQRaxDlVlMSqerIf
 e4Bk3nGl3+Oo1ZgumOH8IKU2NcaPpZx+zw2Ki1ngw41m9SqdJxK2EoKBd03u4SkbvRWr
 MxmSWZiNFc1+zwIQGTEb69k29PNmw9vMflV4sTwsBshRK4hwnmEN2KuCUbQdxnorkiw8
 ykgA==
X-Gm-Message-State: AOAM531e2JgGcjyB8tcoWvsZe6zNo6R8dzaBMmXRpdN0qUmcbn6LBDux
 LRmIw0Te0mZu7vBl3WV05Q==
X-Google-Smtp-Source: ABdhPJzIjXhyFFB2gzub0W2jM/rvGAFEwl9LO8mdLyLFlXaE/U0x+bzAY8WF8WzxMPhaHpWDEwsegA==
X-Received: by 2002:a02:10c1:: with SMTP id 184mr2288036jay.135.1594676167287; 
 Mon, 13 Jul 2020 14:36:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id x19sm1372922ioh.38.2020.07.13.14.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 14:36:06 -0700 (PDT)
Received: (nullmailer pid 769509 invoked by uid 1000);
 Mon, 13 Jul 2020 21:36:05 -0000
Date: Mon, 13 Jul 2020 15:36:05 -0600
From: Rob Herring <robh@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
Message-ID: <20200713213605.GA766184@bogus>
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-4-tn@semihalf.com>
 <3172ec21-d773-7fcb-f1ee-f557f72f20c5@arm.com>
 <972f5cbd-705b-e18a-7477-5f6922804361@semihalf.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <972f5cbd-705b-e18a-7477-5f6922804361@semihalf.com>
Cc: devicetree@vger.kernel.org, gregory.clement@bootlin.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 nadavh@marvell.com, iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 mw@semihalf.com, will@kernel.org, hannah@marvell.com,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jul 03, 2020 at 11:26:32AM +0200, Tomasz Nowicki wrote:
> On 03.07.2020 11:05, Robin Murphy wrote:
> > On 2020-07-02 21:16, Tomasz Nowicki wrote:
> > > Add specific compatible string for Marvell usage due to errata of
> > > accessing 64bits registers of ARM SMMU, in AP806.
> > > =

> > > AP806 SoC uses the generic ARM-MMU500, and there's no specific
> > > implementation of Marvell, this compatible is used for errata only.
> > > =

> > > Signed-off-by: Hanna Hawa <hannah@marvell.com>
> > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > ---
> > > =A0 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
> > > =A0 1 file changed, 5 insertions(+)
> > > =

> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index d7ceb4c34423..7beca9c00b12 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -38,6 +38,11 @@ properties:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - qcom,sc7180-smmu-500
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - qcom,sdm845-smmu-500
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: arm,mmu-500
> > > +=A0=A0=A0=A0=A0 - description: Marvell SoCs implementing "arm,mmu-50=
0"
> > > +=A0=A0=A0=A0=A0=A0=A0 items:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - enum:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - marvell,ap806-smmu-500
> > =

> > Isn't a single-valued enum just a constant? :P
> =

> That's how copy-paste engineering ends up :)

It's fine like this if you expect more SoCs to be added.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
