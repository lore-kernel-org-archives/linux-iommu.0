Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C19C433E4
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 02:02:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C11E2077D
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 02:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C11E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED14887A9D;
	Tue, 21 Jul 2020 02:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VN3HGh9OVgEk; Tue, 21 Jul 2020 02:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C60C878A5;
	Tue, 21 Jul 2020 02:02:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C8ACC089F;
	Tue, 21 Jul 2020 02:02:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62FB6C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5B5DF878A5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lidL36yc0JHB for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 02:02:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E3DED87A73
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 02:02:38 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id q3so15046945ilt.8
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 19:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C6sxjz8cQBHBfpqcqYjPc2k4llIyWqyfVKlT/NeeUxk=;
 b=WznETi8i4yz9/rluZRnWrj4KjHV/1a3zuWbyL2dbruDh5boeBYz+JGW2543lJfiw+C
 vSjeOISDsmrj5h6Q1WOgLb3L2rqrIrzDHNr9KUylPQQH4U6RB2sxQYLnrUZl0XeaXtSP
 unQHAfRFYysBR96zBfVYpcmjA4PvaeGrkiE+q5man2Y/C4BDJZvaOh498UaQKiQmO24O
 FHs2le76lmv0IxI1Kk/l0LKzgD3xMLyq4qEiTJ7qybthwcLDSYY8p0McylS4Q2IbgD9L
 AcV7BCaFXxPeqD/THBpozGeYC7p6xQmB2svtibin3CvlSGWxS2ktSodjrZYfSSTqwfW0
 1few==
X-Gm-Message-State: AOAM532t/+H1iAD8vu4fSjwPUSqXNqSvUxovNvV6iVLZay2GAVFYPTY5
 nNFIYVjz02Acofwl1obeCw==
X-Google-Smtp-Source: ABdhPJxX74z9HXclwgDeBM2Q5ozxho0K5hV9uTK/097gQNaE+eInRy3aYrFpJlSzAA0aKm6RFiiX3A==
X-Received: by 2002:a92:8947:: with SMTP id n68mr26670327ild.235.1595296958270; 
 Mon, 20 Jul 2020 19:02:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id f2sm9869392ioc.52.2020.07.20.19.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 19:02:37 -0700 (PDT)
Received: (nullmailer pid 3375235 invoked by uid 1000);
 Tue, 21 Jul 2020 02:02:36 -0000
Date: Mon, 20 Jul 2020 20:02:36 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/9] dt-bindings: iommu: renesas, ipmmu-vmsa: Add r8a774e1
 support
Message-ID: <20200721020236.GA3374330@bogus>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1594676120-5862-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Mon, Jul 13, 2020 at 10:35:12PM +0100, Lad Prabhakar wrote:
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
