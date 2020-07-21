Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C852EC433E5
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 02:01:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBD0206E9
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 02:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBD0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6562186470;
	Tue, 21 Jul 2020 02:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91vK1KRsFHQF; Tue, 21 Jul 2020 02:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC3EB8638F;
	Tue, 21 Jul 2020 02:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC766C089F;
	Tue, 21 Jul 2020 02:01:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19104C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1498E87A73
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EgJ44KbjYJhC for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 02:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8D8C8878A5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:01:09 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id t18so15059277ilh.2
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 19:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4coWlWluVBZIU2YwRK6iRmx4Qe40biSfC4r+y33fdQQ=;
 b=NJob5yUmGiPYqdczSI89Ym80QyG3zWp1GkiaW1KSdCi57OQLCbtW8FfWbyGRA6M7Aa
 AM0dMBFIlEY/RpCpdYDlTuZ9HHjUrYLKaJwt42ntEFIu1Y4vpi4Tsb9+zR48sJFYPqwz
 gKntUxdeDDP+clF3Zk/A4sTZgZL4mwdqLx45I0LqhU/eCOraZc9WC8RCzG/KtI0ly1FZ
 iK/EMD7Cwb/c4BCePDEbtQQjQHmGlipcthZfvbSq2DI2o/sITphlLRl2Z1i8ymSBEP5n
 KpwZZjDtNsAHVsDSlriayfXIuXuYAmCoP7IgY5hhmcQfcfJR/8iAMXGf2ewnYK5/GDgt
 NXlg==
X-Gm-Message-State: AOAM5321uCpQiiVotddkWLnnR9pw2lmifS5H2cHzbQGlgKjnQryOsm4e
 BfcPUNf5laLMIQkP9+5Kaw==
X-Google-Smtp-Source: ABdhPJw6yirC6GJsGZXSwAWpBSfNz67bs5OsZemqLf1ded7njYlxVrGNsox3/tosI8RW8daPCRfMEg==
X-Received: by 2002:a92:db44:: with SMTP id w4mr24935691ilq.306.1595296868945; 
 Mon, 20 Jul 2020 19:01:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id y2sm10001176iox.22.2020.07.20.19.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 19:01:07 -0700 (PDT)
Received: (nullmailer pid 3373185 invoked by uid 1000);
 Tue, 21 Jul 2020 02:01:06 -0000
Date: Mon, 20 Jul 2020 20:01:06 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/9] arm64: dts: renesas: r8a774e1: Add IPMMU device nodes
Message-ID: <20200721020106.GA3372559@bogus>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 iommu@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Prabhakar <prabhakar.csengg@gmail.com>, dmaengine@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
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

On Mon, Jul 13, 2020 at 10:35:14PM +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Add RZ/G2H (R8A774E1) IPMMU nodes.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 121 ++++++++++++++++++++++
>  1 file changed, 121 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
