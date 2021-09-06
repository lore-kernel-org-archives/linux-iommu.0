Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D8C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 15:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C3B606A5
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48C3B606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16DFD403FB;
	Mon,  6 Sep 2021 15:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDMZoP4ZDcjr; Mon,  6 Sep 2021 15:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1086040402;
	Mon,  6 Sep 2021 15:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D771EC001C;
	Mon,  6 Sep 2021 15:31:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9356DC001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AFA140402
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjQwW2vfR52k for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:31:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52B1E403FB
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 15:31:49 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id bf15so5930068vsb.0
 for <iommu@lists.linux-foundation.org>; Mon, 06 Sep 2021 08:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JjpgCCKn8pZaZ4VTjt0b7oN/N//2baxfz4BZA8973Js=;
 b=XbH6OzhkaAdhLHW4uYHv7+GhHTxN1HBsgazs9vjVi1h2SlBJwOawu+0pQWSTm3eqtL
 8gcX6KdTVtc2jzabloUz+vzF+98biL6gJSZhJ+wxi+lZ4iu3lDNVqSPkD0G4I4F/CGrI
 jUGylzk/pDcmOF4kPqTAG6JjR+Wa1kLFxKio4oAfpHPGa3IBCiSbzvUKHyl15Etz4cLn
 DHfFIwypwFYlD05do3Ls9/Eu7VMdZrcWM4e/FiS478NU6ZDUlps0IxC8q1BoNBPtxcL8
 d5LzBMsTYN/ZKGDHXAd1zNvZ+FAkEp3GCgYv2Udtg7X0n2cHd8+mYURvJ96xyo5h2n6w
 xgwg==
X-Gm-Message-State: AOAM533MNE5KkT0PTErFZVaNZtcuB5tXgl/BcftS7NM5UfqIHPBKyArn
 IXPG7DbJvpvVipNcrlmcED175UUcdSBksLzGWLY=
X-Google-Smtp-Source: ABdhPJxP0x+z+6DEKedIcEuAJAEjlfVgR/QCxZvmYioIDSdNu1ioPb0GPdZGzzgvuef6ZdSb0wKOzbQEVVW56N9cHQA=
X-Received: by 2002:a05:6102:b10:: with SMTP id
 b16mr2720341vst.41.1630942308124; 
 Mon, 06 Sep 2021 08:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
 <20210901102705.556093-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20210901102705.556093-2-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Sep 2021 17:31:36 +0200
Message-ID: <CAMuHMdUOQQbrxcvFDPQYokAj9pewrML30jq1g_OGs12OY_36Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: add r8a779a0 support
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

On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for r8a779a0 (R-Car V3U).
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
