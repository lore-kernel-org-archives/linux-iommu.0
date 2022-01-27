Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39F3C433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 13:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40D2440169;
	Thu, 27 Jan 2022 13:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMQsaSwGpxSg; Thu, 27 Jan 2022 13:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD8E14014E;
	Thu, 27 Jan 2022 13:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 914A6C001A;
	Thu, 27 Jan 2022 13:50:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A32AEC000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 13:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 833F860EF1
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 13:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ideasonboard.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkRgXT0dv5SK for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 13:50:22 +0000 (UTC)
X-Greylist: delayed 00:06:22 by SQLgrey-1.8.0
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 786EE60C20
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 13:50:22 +0000 (UTC)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC91949C;
 Thu, 27 Jan 2022 14:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1643291036;
 bh=LNTPgJr89tkA0iGFDgELfs9wQTVYZHc1hJjqa5lPsD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dv2jddbgboBqlIOfP5gnMCQSYBEG7/FPgNk4F3gnzusaItfMnu7XgW4jB2dDWqroA
 8UPvUK1ea8XCFTZqfjxienzgQUdOmxPUm57NQW2LoWCE0p4xJorzMtdaVvJyBmoV4I
 cllPiUrNNxOnHw/hMVEVPXttUZaPsLPafbnOJCG0=
Date: Thu, 27 Jan 2022 15:43:35 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: renesas, ipmmu-vmsa: add r8a779f0
 support
Message-ID: <YfKhh8FQdfY7eTiT@pendragon.ideasonboard.com>
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-2-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXgg8XApJETkN1oDDSy=N01kJaTz4DADyD9ZOM0ZXXttA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXgg8XApJETkN1oDDSy=N01kJaTz4DADyD9ZOM0ZXXttA@mail.gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Hi Geert,

On Thu, Jan 27, 2022 at 12:05:31PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 25, 2022 at 6:33 PM Yoshihiro Shimoda wrote:
> > Document the compatible values for the IPMMU-VMSA blocks in
> > the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > @@ -44,6 +44,10 @@ properties:
> >                - renesas,ipmmu-r8a77990 # R-Car E3
> >                - renesas,ipmmu-r8a77995 # R-Car D3
> >                - renesas,ipmmu-r8a779a0 # R-Car V3U
> > +      - items:
> > +          - enum:
> > +              - renesas,ipmmu-r8a779f0 # R-Car S4-8
> > +          - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
> 
> I'm wondering if we need the family-specific fallback.
> For R-Car Gen3, we don't have it, and match on (all) the SoC-specific
> compatible values instead.
> Do you remember why we decided to do it that way?

I'm afraid I don't. You know my usual opinion of SoC-specific compatible
strings :-)

> At least R-Car V3M/V3H/D3 have slight differences in the register bits,
> but I don't think that was the reason.

-- 
Regards,

Laurent Pinchart
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
