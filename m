Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1559C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 07:39:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E67206D7
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 07:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E67206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 315B588583;
	Thu, 18 Jun 2020 07:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AkWpcnqBWsa; Thu, 18 Jun 2020 07:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83B7B8857C;
	Thu, 18 Jun 2020 07:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61E02C07FF;
	Thu, 18 Jun 2020 07:39:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 865BFC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D2C520113
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-F5GleFwDRS for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 07:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 42D4F20011
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 07:39:24 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id i74so4259660oib.0
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 00:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JPQ/PH3aH+rlKhf78bS3JYd7KhJYAAclpBwrav1LP0c=;
 b=Nw34fW/Btxb6WFWBAQv5axzFGXqodFoAybJqrs4Do+POCRY20Hjmp03+Hd64tFTnVs
 YRUDZFit6Cg4PqLXLDnVsMM03lbGYkgb2rj/pi1RFNLqkLqBBmFe6kdXj/ZmrUPpd/TJ
 Oy54l5cEEXs9uW86dc9wHRhXaZ9IlXx+7zKCEl3VdeJxH1sYx7owjyrSU2XA64RP8rNf
 03/77RcJ/cH7lMN2K6ZQr3imgi0Js9w66XDhQIGMOgGIAraFjqt4i2h9rJQOIlCguxvo
 jidT4FdAC/YgZ0FLysvaxrA24qWdG5eyFDHYcGSgngjRYnKK/zUT5Ckni6a39l74x3A6
 g25Q==
X-Gm-Message-State: AOAM533uweBP8fr1oRvgYZDfX6lTyywRPo7sayILwZxz49jQ3izwEgcP
 EXZiuvoFvlljGOUVwjsJIakDo1rrEAAYyGTnfSs=
X-Google-Smtp-Source: ABdhPJy4yUnPGoDLOCCQPH7S491o6IyHC9WENjbj4u6y5OalCmoE+8y/bCOTmagHYhARE+BM4ZATmE0eAZ6ulNI3An4=
X-Received: by 2002:aca:849:: with SMTP id 70mr1816387oii.153.1592465963424;
 Thu, 18 Jun 2020 00:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <1591873830-10128-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1591873830-10128-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1591873830-10128-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jun 2020 09:39:12 +0200
Message-ID: <CAMuHMdUnwgYhVo0jjRcHrmnOFi3Dokdu6cL26=mQ7DudS5+QZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: add r8a77961 support
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

On Thu, Jun 11, 2020 at 1:11 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for r8a77961 (R-Car M3-W+).
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

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
