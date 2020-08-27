Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13BC433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 16:40:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CBF2087C
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="un7kjnEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CBF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3025868DC;
	Thu, 27 Aug 2020 16:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuIGjo0GpDyU; Thu, 27 Aug 2020 16:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DC52865C1;
	Thu, 27 Aug 2020 16:40:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDEDC07FF;
	Thu, 27 Aug 2020 16:40:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3900DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 16:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2128C876C3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 16:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2k2e+HRS1Sxl for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 16:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com
 [209.85.219.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6CD778762A
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 16:40:13 +0000 (UTC)
Received: by mail-yb1-f194.google.com with SMTP id a34so3287595ybj.9
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WYSs0Dku1zdRA2KBaI0ZluOi6UmY5Y9GrXFeF+fDRFw=;
 b=un7kjnEQ+aqsO+z8jtw8rj5enqEblNxAaBGnKPz5YF1M/H5UYX4IB2itVqzx4F9M+A
 4Iw61Lgg+T2/csniC5jvZ46vzCXwe+6ucpfL//IIr2N4fzxId6yxup8IcTBmIH9J1wxH
 xmgaggsssg9MRIaVUt4/uLPzY6xuiGzR9l3f6wTubw05+rhnAtN3ucwXRVkyO/E+iL2c
 Jv+81bmqvmke2b2srFFNR6de7skjpZkTrzLADYU47UvUFd5kFw73lM1gHC3O60ILOWxW
 I4ZCr2cSWmKOElAxgXNe3UVqleDnJSO5F8AP+wHoBbyarZgklem/skA1eZo7nJRMkMI8
 wO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WYSs0Dku1zdRA2KBaI0ZluOi6UmY5Y9GrXFeF+fDRFw=;
 b=NOnOTJK4gzh7DXDVYTSlt7nGeSgTX1541bEgr7GKnjlm7oakn9ohTaSaqOu1aT6AIU
 8eXwwdrwC3KdyGJ4mORFxO8f+eufMl/Aiw0vKSCN1D5LJ92GmdP6as4TJwEAR3DJ2kIr
 9YuYUAX8SZ6hhBAWADCpYMpacFs1m0Y3a8KiEFeTpt5HeNqt6SUqWtVHjnzd/7TyiVAy
 591EGNfsVtAnKywSnsyTb6v3tVqw3VLsM0Eqc+eq7svXTKgdomgEQ1B4USEQ4NdcCxhG
 28QnFLVS7pjGqpBehveityzhi/PyhHsYrLmpCInzxpvALM6BXvfk6UQXM4BWDA2kTRh9
 jumA==
X-Gm-Message-State: AOAM5303gj8iPZ4RDRWMxWnKg83LWUDi1fl57eKqrmkFXRV3kHU47enF
 8MDZgiAOmZoIJpPU8zbZ/KnE7Rf41utvRddJdK0=
X-Google-Smtp-Source: ABdhPJxrvVPIJbZVxMNdYQbfcSKbpYNpnY4WH7M5vvvn2G4XY4Uv7BI34VoTls0DSRQbKIiloMf4ZMzXPy4YgYSJnGI=
X-Received: by 2002:a25:2f4d:: with SMTP id v74mr28209467ybv.401.1598546412501; 
 Thu, 27 Aug 2020 09:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594676120-5862-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 27 Aug 2020 17:39:46 +0100
Message-ID: <CA+V-a8tZAp_oTpG2MsdC47TtGP7=oM6CubCnjBoR6UhV4=opNg@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: gpio: renesas,
 rcar-gpio: Add r8a774e1 support
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 netdev <netdev@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 dmaengine <dmaengine@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Linus and Bartosz,

On Mon, Jul 13, 2020 at 10:35 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document Renesas RZ/G2H (R8A774E1) GPIO blocks compatibility within the
> relevant dt-bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
Gentle ping.

Cheers,
Prabhakar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
