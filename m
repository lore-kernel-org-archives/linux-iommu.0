Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3903CC43334
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 20:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C63BE40977;
	Wed,  1 Jun 2022 20:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7dI6CFfAuON; Wed,  1 Jun 2022 20:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CBD0410C5;
	Wed,  1 Jun 2022 20:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F579C0039;
	Wed,  1 Jun 2022 20:01:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45346C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 20:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3379840650
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 20:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5SBbIQkCHkk for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 20:01:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8AA6A404EC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 20:01:45 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id u140so4056574oie.3
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 13:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hM5KF5wCwVdKsYo5M+AgMiM3NVZvgB0creSQpi4bIVM=;
 b=EY6qJ/1azh1Bo2naoiVQCuKEsfZ2RVZNBWV6QgCf3CD5sBreYDml+5Ae0VWyoIheKq
 XYROVQieD3K3FM6Ms1jSNj/NyARBPNxffwEKHvCx400bO48I5pwzhjsXYJc8LGRWno89
 mpOhEghlbExl9tRpGy7JlRP2oOROA5cz5b/ok4VjJ5//issW+oDo/8RzZMMDbSOv2EfJ
 3b9LTFiXfXRx6rJWvvGySMTTL2KWwmkjUIOU+/IPPO16nQwTIU+XGaM2DB4kv4maP2pP
 rtw+OT7GEe0/My0Wm1dGCfK86C/V5+LGhYqm5QzUIFrnP4yqkC5LBAUNy1q2HPY95LUf
 ISoQ==
X-Gm-Message-State: AOAM530D7YjHj1qdplTuXJdCxElTxUrMunA7ONF2v6mcSyF6yLXBCzJU
 J8xqH4h6gDzmJKHmc0SZBg==
X-Google-Smtp-Source: ABdhPJz/ahrvEIyLaTJn2tdg3qpfcBBKaT+gGiEjPOUSa+SOVMJSI109IsfvmyTNBHZT51qJxtq0fQ==
X-Received: by 2002:a05:6808:15a3:b0:32b:9c85:3434 with SMTP id
 t35-20020a05680815a300b0032b9c853434mr16880204oiw.118.1654113704350; 
 Wed, 01 Jun 2022 13:01:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 r21-20020a056830081500b0060603221245sm1270062ots.21.2022.06.01.13.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jun 2022 13:01:44 -0700 (PDT)
Received: (nullmailer pid 338460 invoked by uid 1000);
 Wed, 01 Jun 2022 20:01:43 -0000
Date: Wed, 1 Jun 2022 15:01:43 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Message-ID: <20220601200143.GA334351-robh@kernel.org>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
 <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
 <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
 will@kernel.org
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

On Wed, May 18, 2022 at 01:42:20PM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/05/22 13:29, Matthias Brugger ha scritto:
> > =

> > =

> > On 18/05/2022 12:04, AngeloGioacchino Del Regno wrote:
> > > Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
> > > mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon=
(s)
> > > instead of performing a per-soc compatible lookup.
> > > =

> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > > =A0 .../devicetree/bindings/iommu/mediatek,iommu.yaml=A0=A0=A0=A0=A0=
=A0=A0=A0 | 8 ++++++++
> > > =A0 1 file changed, 8 insertions(+)
> > > =

> > > diff --git
> > > a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > index 2ae3bbad7f1a..c4af41947593 100644
> > > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > @@ -101,6 +101,10 @@ properties:
> > > =A0=A0=A0=A0=A0 items:
> > > =A0=A0=A0=A0=A0=A0=A0 - const: bclk
> > > +=A0 mediatek,infracfg:
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/phandle
> > > +=A0=A0=A0 description: The phandle to the mediatek infracfg syscon
> > > +
> > > =A0=A0=A0 mediatek,larbs:
> > > =A0=A0=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/phandle-array
> > > =A0=A0=A0=A0=A0 minItems: 1
> > > @@ -112,6 +116,10 @@ properties:
> > > =A0=A0=A0=A0=A0=A0=A0 Refer to bindings/memory-controllers/mediatek,s=
mi-larb.yaml. It must sort
> > > =A0=A0=A0=A0=A0=A0=A0 according to the local arbiter index, like larb=
0, larb1, larb2...
> > > +=A0 mediatek,pericfg:
> > > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/phandle
> > > +=A0=A0=A0 description: The phandle to the mediatek pericfg syscon
> > > +
> > =

> > I didn't explain myself. What I was suguesting was to squash the patch
> > that add requiered mediatek,infracfg with the patch that adds
> > mediatk,infracfg to the binding description. And then squash the both
> > patches adding pericfg as well.
> =

> Sorry Matthias, I'm not sure ... I think I'm misunderstanding you again...
> ...but if I'm not, I don't think that squashing actual code and bindings =
together
> is something acceptable?
> =

> I've made that kind of mistake in the past and I was told multiple times =
that
> dt-bindings changes shall be sent separately from the actual driver chang=
es.

Combine patches 1 and 6 is the suggestion, not driver changes.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
