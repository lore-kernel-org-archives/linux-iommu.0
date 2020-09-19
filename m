Return-Path: <SRS0=bQzQ=C4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000FC43464
	for <iommu@archiver.kernel.org>; Sat, 19 Sep 2020 11:10:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDA621481
	for <iommu@archiver.kernel.org>; Sat, 19 Sep 2020 11:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh/TvrqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDA621481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 17B348685E;
	Sat, 19 Sep 2020 11:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QD0hrjtTzqqr; Sat, 19 Sep 2020 11:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 785BE852D5;
	Sat, 19 Sep 2020 11:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 511F8C1AD4;
	Sat, 19 Sep 2020 11:10:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF0F4C0859
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 11:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB07387482
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 11:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mz0uJJtgGl8p for <iommu@lists.linux-foundation.org>;
 Sat, 19 Sep 2020 11:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
 [209.85.219.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 138758746E
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 11:10:37 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id c17so6397499ybe.0
 for <iommu@lists.linux-foundation.org>; Sat, 19 Sep 2020 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oSKiRKyUWoQSftUDXcJrCu9pwlvBOoEx/VC+0sM+BVw=;
 b=dh/TvrqS/DyPGQWixmwNWhpF06+/Mj/iCI1ohjpH294TpemWM6vl2H0h088WGz8NPW
 R2PBl53rQuQwBONzrTUj984gz2mNRqSzh8XjzeRjGO9c0ubQXa/uUcLPD2MM+dplnOpE
 UMjEThv8d3hQFfInp1gxOPUO8cEkcm5SjvjyY34w2D+neVa8pgsk6WConEHd2mTfdy9U
 luJ7nYSbbQKhEZqODAhPfrsjvV8HDenEtq8k2l9Kd0gs4ir8WrFghO6Gp6x9M5gnoB1s
 zPKhzeaoL8ShrSFe5AwP2VjZueZYt+rwuRhBWQ5267fKyCMQ6FlcCP5I/4hbLzhtz55v
 ot5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oSKiRKyUWoQSftUDXcJrCu9pwlvBOoEx/VC+0sM+BVw=;
 b=AIiz8CrNj3YTcHn/anuUITrwZZLHamyQpU0tMGt/p9w2iVRDfTdzwhxj/tI7XUHjhq
 6qJTHpMOalcJtqcdx+dt/fgzecCfX0O+ay0GlUMezhH8jAokeqLEA4pkfRErjZAI9ZJu
 rUy4tLcqa+BCFREkFXtO1r7UYhfBAkRTWOot4mj5mxMITSfCSPniRNSVQFE423n4BOh2
 34oaDvK9uNmEfWGe3F0Y3fZrDkxb5yMOQ7GaUvCiXfjb7EbCEWE0N8LZiaSTf4kvkWHl
 iGAK4yw+qMsIXddkn1u+DG6xnAP5H06fuEZnmCuVrn1+Tw43B3d7KpSL7SL90RCYnWbY
 YqoQ==
X-Gm-Message-State: AOAM530d9xMASpJVayf6jTOquvxvEPFb128VYfjrx8kv0qnKVa5aaHdq
 1Gn2dVHdYZhnYsQcybrlkRO3ApFoxDPnCQ0cyjM=
X-Google-Smtp-Source: ABdhPJy4rSARUd8GZNwmfFZdBgZDMQF9IpVcsP5v3P2pt2pZf6Jwz8qtdWIXPaKAgsN223Tv2yVLuiUQ2NZjvmW+5FM=
X-Received: by 2002:a25:6849:: with SMTP id d70mr27870018ybc.395.1600513836167; 
 Sat, 19 Sep 2020 04:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8voHnHdmSBmewE3BStksxE4dEM1CtE7KwPZ5dn6PmV_0A@mail.gmail.com>
In-Reply-To: <CA+V-a8voHnHdmSBmewE3BStksxE4dEM1CtE7KwPZ5dn6PmV_0A@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sat, 19 Sep 2020 12:10:10 +0100
Message-ID: <CA+V-a8tYYvmwE156i_0DnToT+Ep_0SbZWnN4gXpvc_md50Knvw@mail.gmail.com>
Subject: Re: [PATCH 8/9] dt-bindings: net: renesas,ravb: Add support for
 r8a774e1 SoC
To: "David S. Miller" <davem@davemloft.net>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi David,

On Thu, Aug 27, 2020 at 11:28 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi David,
>
> On Mon, Jul 13, 2020 at 10:36 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> >
> > Document RZ/G2H (R8A774E1) SoC bindings.
> >
> > Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> Gentle ping, this patch is not queued up yet at [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/
>
Could you please pick this patch.

Cheers,
Prabhakar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
