Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9B2C43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 07:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B9441848;
	Fri, 17 Jun 2022 07:03:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2B9441848
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQoft7dq44jV; Fri, 17 Jun 2022 07:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A311B41505;
	Fri, 17 Jun 2022 07:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A311B41505
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E979C0039;
	Fri, 17 Jun 2022 07:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30BECC002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6B1A417A5
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:03:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6B1A417A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UM7-WhKkdrrY for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:03:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEF1841505
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEF1841505
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 07:03:04 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id o16so4195696qvr.10
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 00:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=782clpgKbkbkIFunSIHJAHC4GaZ8B8BhsKlBvD6iDNE=;
 b=aiUmSIYt6PDCd5txLSU1BCX55C3hZEdd9+doT5dV1MIS4bfrvNSnQAu0CrXrgRSWyV
 nV78pZYFnfr00PBfLe+80xAxx/nZ8rVyxdnjj++WdWCqh/aCT5/uOqlD3C7fFL4LeLMG
 0wxnEBId2XmfQUEhXpz6PUM4WVO2fGf+geUaDKpj/2hFPcBRB7ZcLzynjvHAvGA1ZOGy
 IKvQcRWGjxr7/fAubtGhknvthMOpi/hz7ahWFar1Xqkp0b+zbID0vXC39lIw6MBz3QfW
 75Vg+mCWT24fdMC/5IPaWAN/0XQxadNe+5FKsdVGq9WGi+s/EOocbBLf6+ZVlM8JVsKp
 qyIQ==
X-Gm-Message-State: AJIora8sUB5u57xuPu8bh4/3LvaKj/xYQ/CLD/3GQEzKHoWDsuOWQdJw
 RN8ouSx0V3LqjL/K7hdbY/4UnUlF+vp9Kw==
X-Google-Smtp-Source: AGRyM1vmyDcnylj0lLILP8wrMnMhgXgxM/dnfva4+Pr2CdkICkvQbaccMrq5DEtUTveuaAYzg6YNcw==
X-Received: by 2002:ac8:4e51:0:b0:305:754:9f99 with SMTP id
 e17-20020ac84e51000000b0030507549f99mr7230919qtw.684.1655449383353; 
 Fri, 17 Jun 2022 00:03:03 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com.
 [209.85.128.176]) by smtp.gmail.com with ESMTPSA id
 x23-20020ae9e917000000b0069fc13ce1f2sm3548055qkf.35.2022.06.17.00.03.01
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 00:03:01 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-2ef5380669cso34088337b3.9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 00:03:01 -0700 (PDT)
X-Received: by 2002:a81:6157:0:b0:30c:7e4d:b28e with SMTP id
 v84-20020a816157000000b0030c7e4db28emr9810613ywb.502.1655449380718; Fri, 17
 Jun 2022 00:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220617010107.3229784-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220617010107.3229784-1-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Jun 2022 09:02:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrPYyM6SHFoo0HrnQNvsCswBVFfeavf0LyES4-_ESa1g@mail.gmail.com>
Message-ID: <CAMuHMdVrPYyM6SHFoo0HrnQNvsCswBVFfeavf0LyES4-_ESa1g@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix compatible for rcar-gen4
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>
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

On Fri, Jun 17, 2022 at 3:16 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Fix compatible string for R-Car Gen4.
>
> Fixes: ae684caf465b ("iommu/ipmmu-vmsa: Add support for R-Car Gen4")
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
