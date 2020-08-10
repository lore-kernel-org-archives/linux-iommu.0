Return-Path: <SRS0=AIGO=BU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC2C433E0
	for <iommu@archiver.kernel.org>; Mon, 10 Aug 2020 07:54:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287422065C
	for <iommu@archiver.kernel.org>; Mon, 10 Aug 2020 07:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287422065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F26DB87E7A;
	Mon, 10 Aug 2020 07:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nR5OOH21xta; Mon, 10 Aug 2020 07:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8193F87D0E;
	Mon, 10 Aug 2020 07:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69813C0864;
	Mon, 10 Aug 2020 07:54:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1772C004D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 07:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9DC1787E5F
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 07:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fbp+mqCOvM6R for <iommu@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 07:54:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76F0F87D0E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 07:54:41 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id v13so8092259oiv.13
 for <iommu@lists.linux-foundation.org>; Mon, 10 Aug 2020 00:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BVxB3479AF19vVgQTNpUIFHlH9OwsA2eid0MPwV0Nhs=;
 b=kixgjfUC28MHDAJsRPGIWP9QmO+OmC9vWt8XnQZ1NadgNsTEXk3yfdzWXC4hgHmEBv
 7DvdNVIZgAuHRSaRqlzj+9oaCTskuHU1OjJrg6l2gOLnDUf8ENfPbe+p++nZCD7zKVda
 i62PSkt6BDfuvQV+hL+FPCT8p2bCqSFrMQP0PSv79mgAbco9STQ4VCsEzX7ZZqM1oLjF
 kdHJNb4uGs7C2kJfTSPbcVR7wHZV39v5t6Ba7BgopJO0LM2sNoABECadheiP/LJG52ri
 NR2+EUKM5dgu6n7TYFdSO/pFEUoBYYU+s9G1/DLie5umZX9QWE+F9kslV3BWVbl21G7d
 VKCQ==
X-Gm-Message-State: AOAM5309MFZ0ooy4F1qltyAM3WAKNAaG+z/snCsLOo6IXd21VJjZuVSn
 RXoLh7982EwjbTmOL/D5cVZKj0861pD1RmsmANI=
X-Google-Smtp-Source: ABdhPJxgFdidTVAFODckZ2RCZ+KmWC/yJB0+ysb0XhnacXp3SOkRfMahcG9B60dWR73a+LDZb0z3h1zBZ56b1i1le38=
X-Received: by 2002:aca:adc4:: with SMTP id
 w187mr20036329oie.153.1597046080801; 
 Mon, 10 Aug 2020 00:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200809193527.19659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200809193527.19659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2020 09:54:29 +0200
Message-ID: <CAMuHMdXSdtm02jroh0EV210jnVCnVc6RO+bk8x7z_mBWa741yQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Sort compatible
 string in increasing number of the SoC
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>
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

On Sun, Aug 9, 2020 at 9:35 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Sort the items in the compatible string list in increasing number of SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

As my previous tag was conditional on fixing the sort order:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
