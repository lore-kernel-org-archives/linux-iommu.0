Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92419C433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 09:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31F1140012;
	Wed,  2 Feb 2022 09:23:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKZ8Zf_ThvMq; Wed,  2 Feb 2022 09:23:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B65034033F;
	Wed,  2 Feb 2022 09:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB63C0011;
	Wed,  2 Feb 2022 09:23:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04107C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E18F7813D5
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MsnhyfE2-0sG for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 09:23:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31A4581392
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 09:23:51 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id a24so4227423uat.10
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 01:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hCUm6YJgeaBSW2LffvWnBA0o47V64tlsOuuAWMjoV6M=;
 b=0P6FsgdlYpqVsGpSmFqEVZkqFW47rYIqyrdNEjItBNW2ivQ4lHMOvkr1TxkQE4fLjZ
 x28hPFFcuSlqQAl5ZTFGtRsRrbzSBxWdUFr9s7ghAXSDr7MyXgiTUcPUqXp6sePEuDJK
 ovLX7+umejBy4bniwdPj0zMl6HO4g9NCxBEpL4PEdZdLKeFftN8pZGjrTH7UOj9/WgHD
 jIhEZX0l8QQQSbGCJeOR4PUl8WHGcdsexv0wAAIxHmQbFHfDcoq2kVJylB8YkQSVp0C3
 BYyp7SCuzn9O7utSSlnmgM00v45woLt93N3UzZSdqvVDNpz48v9uqtIiNRfiC7no9jFU
 WNTg==
X-Gm-Message-State: AOAM532hIzzamg3/AA0zgf8PcoHQhoPSrj+W8OXtvAbIOzmcl4S83K0u
 dIVI0NdsgErIpfAdHYUijaz6652d9fgEBQ==
X-Google-Smtp-Source: ABdhPJyfZcuJuRLrhLWidKXgLuy4jac3aR5xGk5wVmJuJpf6+kJaE0YaqsLQkZqTBQ2hE5UC+EoG3w==
X-Received: by 2002:ab0:59f0:: with SMTP id k45mr11190746uad.135.1643793829810; 
 Wed, 02 Feb 2022 01:23:49 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com.
 [209.85.222.43])
 by smtp.gmail.com with ESMTPSA id n10sm4793078vso.34.2022.02.02.01.23.49
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 01:23:49 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id m90so18000976uam.2
 for <iommu@lists.linux-foundation.org>; Wed, 02 Feb 2022 01:23:49 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr10939867vsb.68.1643793828948; 
 Wed, 02 Feb 2022 01:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220125125602.4144793-3-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Feb 2022 10:23:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmievc1U0PXfv01wsibUs+B+5U6kPbcE8=v2GKTvFbTA@mail.gmail.com>
Message-ID: <CAMuHMdXmievc1U0PXfv01wsibUs+B+5U6kPbcE8=v2GKTvFbTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
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

On Tue, Jan 25, 2022 at 6:36 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for R-Car Gen4 like r8a779f0 (R-Car S4-8). The IPMMU
> hardware design of r8a779f0 is the same as r8a779a0. So, rename
> "r8a779a0" to "rcar_gen4".
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c

> @@ -743,7 +744,7 @@ static bool ipmmu_device_is_allowed(struct device *dev)
>         unsigned int i;
>
>         /*
> -        * R-Car Gen3 and RZ/G2 use the allow list to opt-in devices.
> +        * R-Car Gen3, Gen4 and RZ/G2 use the allow list to opt-in devices.
>          * For Other SoCs, this returns true anyway.
>          */
>         if (!soc_device_match(soc_needs_opt_in))

There are a few more references to "Gen3" that can be extended.

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
