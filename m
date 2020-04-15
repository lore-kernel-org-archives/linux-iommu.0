Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D0C2BA19
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 14:21:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3BB20857
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3BB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1987E85F2D;
	Wed, 15 Apr 2020 14:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02uoetpS3qAn; Wed, 15 Apr 2020 14:21:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AB51859BA;
	Wed, 15 Apr 2020 14:21:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E841C1AE2;
	Wed, 15 Apr 2020 14:21:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49F92C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 14:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3475685EEF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 14:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ElNOM_avj81o for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 14:21:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 249F1859BA
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 14:21:23 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id f52so16443otf.8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dnvZD4Dm4e5FRgntE759Yt2PxA+q1fuND8zsrub9kLs=;
 b=IOOPNxkTzm9KBNHFbXNlrfGV5x9R+jSZFRUwBoZiDYvGvA/Ho74btMjUfaFByeLT9P
 rA5D+yW1kSD5E6ORcREa49JU6YbbxpYTxYQA/OYfn1A+qZZs9AGNUKEXbHRX1VdVTUe8
 MJlF4JMx/YS0b6b5ka5e99aopgvJbv8Y0SUXXnoI6/pCjyAm0qMh2lXXGtj66AHY1mmh
 Ya1Pt+CNHIgORFwff7sTgnXB5EoYhUlkKogmBJkAyTt/2W8cNifP8PVPArX18ieP5v8i
 f3AdlF12tDaYkYppypRo8bvGTOukrDwAdaOdlAhyB1Tq2nhZxvSeaKpTa84oMG43Hs2r
 c4XQ==
X-Gm-Message-State: AGi0PubTrispxSzOZ9gNPP8mEs8MuciiHk9y5puGdTg+NUqvLOOCgYBC
 sKqDqv3EtNjumUBgrD/17OoQl5j4fyD3pKdN48s=
X-Google-Smtp-Source: APiQypIG2ckswGmQ7Vt/axIUAX+BtAwJOJQokWKIZnojuoFp2TeGwYdTsUd02L9Tf1SQqNYp+XNW0q+iQh9SWBYejGA=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr21994872otl.145.1586960482326; 
 Wed, 15 Apr 2020 07:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Apr 2020 16:21:10 +0200
Message-ID: <CAMuHMdXvZp5GFY5-SjXP0PLE8MiwYencVMti93wU4E3N2c0QVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bndings: iommu: renesas,
 ipmmu-vmsa: convert to json-schema
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Shimoda-san,

On Tue, Apr 14, 2020 at 2:26 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas VMSA-Compatible IOMMU bindings documentation
> to json-schema.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/renesas,ipmmu-vmsa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas VMSA-Compatible IOMMU
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +description:
> +  The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
> +  It provides address translation for bus masters outside of the CPU, each
> +  connected to the IPMMU through a port called micro-TLB.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,ipmmu-r8a7743  # RZ/G1M
> +              - renesas,ipmmu-r8a7744  # RZ/G1N
> +              - renesas,ipmmu-r8a7745  # RZ/G1E
> +              - renesas,ipmmu-r8a7790  # R-Car H2
> +              - renesas,ipmmu-r8a7791  # R-Car M2-W
> +              - renesas,ipmmu-r8a7793  # R-Car M2-N
> +              - renesas,ipmmu-r8a7794  # R-Car E2
> +              - renesas,ipmmu-r8a7795  # R-Car H3
> +          - const: renesas,ipmmu-vmsa  # R-Car Gen2 or RZ/G1
> +      - items:
> +          - enum:
> +              - renesas,ipmmu-r8a73a4  # R-Mobile APE6

I believe the R-Mobile APE6 IPMMU is similar to the R-Car Gen2 IPMMU,
and thus belongs in the section above instead.

> +              - renesas,ipmmu-r8a774a1 # RZ/G2M
> +              - renesas,ipmmu-r8a774b1 # RZ/G2N
> +              - renesas,ipmmu-r8a774c0 # RZ/G2E
> +              - renesas,ipmmu-r8a7796  # R-Car M3-W
> +              - renesas,ipmmu-r8a77965 # R-Car M3-N
> +              - renesas,ipmmu-r8a77970 # R-Car V3M
> +              - renesas,ipmmu-r8a77980 # R-Car V3H
> +              - renesas,ipmmu-r8a77990 # R-Car E3
> +              - renesas,ipmmu-r8a77995 # R-Car D3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Specifiers for the MMU fault interrupts. For instances that support
> +      secure mode two interrupts must be specified, for non-secure and secure
> +      mode, in that order. For instances that don't support secure mode a
> +      single interrupt must be specified. Not required for cache IPMMUs.

    items:
      - description: <non-secure ...>
      - description: <secure ...>

> +
> +  '#iommu-cells':
> +    const: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  renesas,ipmmu-main:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Reference to the main IPMMU instance in two cells. The first cell is
> +      a phandle to the main IPMMU and the second cell is the interrupt bit
> +      number associated with the particular cache IPMMU device. The interrupt
> +      bit number needs to match the main IPMMU IMSSTR register. Only used by
> +      cache IPMMU instances.

This property is not valid only on R-Car Gen2 and R-Mobile APE6.

(untested)

oneOf:
  - properties:
      contains:
        const: renesas,ipmmu-vmsa
  - properties:
      renesas,ipmmu-main:
        $ref: /schemas/types.yaml#/definitions/phandle-array
        description:
          [...]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
