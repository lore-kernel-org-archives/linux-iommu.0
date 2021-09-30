Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C352C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 08:52:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE8C613A9
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 08:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFE8C613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0DAA8402E;
	Thu, 30 Sep 2021 08:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7v8AuKY3gJ8; Thu, 30 Sep 2021 08:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF60284048;
	Thu, 30 Sep 2021 08:52:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C67C0011;
	Thu, 30 Sep 2021 08:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6DDC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 08:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7D3B60778
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 08:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qq7rdBChSImt for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:51:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2860D605DC
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 08:51:59 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id y74so2462879vky.12
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 01:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m5P6ZyShaVeYhWVRJKP1PIOkI+YrZXWqg8sKMg41Lio=;
 b=3iVULFfGgRezJWFBhm/dX0fsfGQtGB3TlGHPXrJo95G9wmv72jUwpr7mi2ui7AQ0nH
 i6xn0iXSSkCSOsVXwuk9giOE07jZWId3r03Uq65rdwBBEuaNSoMviSFu1eoEsCalyD7Y
 gV5TYvUtshkjT0J3C0iruomY9FWXmysPEk8I2c+SxGGcxy1l9/ywfKR2zp4F8BNmwW5J
 eKfjngXR65FxKEEL4HATiLYRvJE0iIj/MeEAXV8VUc2DBq43BBJtsSQpRDkDo4wzUVJR
 7Y1olfXfpyum+fU2GFYH+0Xp7TDoC3ElzeJt5C0s0p9XCwRNAohl2lhU7ijnSK8I5b4e
 bDjA==
X-Gm-Message-State: AOAM533tuRGbuJ8LpTdUEjfWwhBIcQ/ws4X6s5Z9Y2SO5fBwsrPQqTXh
 xoCO3x4M2GSvBCbkBRLYG6okiW464OEjOBOkrcg=
X-Google-Smtp-Source: ABdhPJz1vo+I+Wcsh48CwzD5470mzlIbp79s3RZD7B9rSW4uXBWkd8droNHqKLCdiQeyDI9NcnmkgI7w0r3FQDlmhBM=
X-Received: by 2002:a05:6122:e71:: with SMTP id
 bj49mr489886vkb.7.1632991918045; 
 Thu, 30 Sep 2021 01:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Sep 2021 10:51:46 +0200
Message-ID: <CAMuHMdXkFWHrh1cs4YW_bpP0samT+gSkm99_AboZ=coO3iRj+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/ipmmu-vmsa: Add support for r8a779a0
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
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

Hi Shimoda-san,

On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch series adds support for r8a779a0 (R-Car V3U).
>
> Yoshihiro Shimoda (2):
>   dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779a0 support
>   iommu/ipmmu-vmsa: Add support for r8a779a0

Thanks to rcar-4.1.0.rc16 of the R-Car BSP, I was pointed to the fact
that the IPMMU modules on R-Car V3U have module clocks and resets,
unlike on other R-Car SoCs.
Probably they should be handled, too?

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
