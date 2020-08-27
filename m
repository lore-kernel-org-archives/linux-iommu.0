Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B264C433E5
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 10:29:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF73D22BF3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfWl0T/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF73D22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8644886888;
	Thu, 27 Aug 2020 10:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zheFIEo5e9Sj; Thu, 27 Aug 2020 10:29:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 267D5867F6;
	Thu, 27 Aug 2020 10:29:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4628C07FF;
	Thu, 27 Aug 2020 10:29:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D17A6C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B9FD486888
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:29:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29HO44V_O0oo for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 10:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com
 [209.85.219.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 200A1867F6
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 10:29:05 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id p191so2686502ybg.0
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 03:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9p4OFhVWpfoFModMO68JgN4kLUfWn4ZrdXLtONTzats=;
 b=cfWl0T/uduUii6AXuAat69qCUSaqTEdxBOxERMz8xs9hUTeNu4BCzoJcLPwR00qgaV
 e3eVum1dak1LKAu6424cfl806r5wrJQjNM2K8QVrKluzB3jgu6C3boB0V2FEr9rrfxL7
 lIXQPqg7SeiBTIppjggaUv9YEH/mBrPYIKUDHoeO8TO3qeIdPjYyO2uLYq/c0tLtyZgK
 yTMSksf7A3iJiUAafJDVQbjzP3gldibdgWZtol3EGo79vI2HpSRKC9BWaG4o7nGdFQOD
 HB/hCPrmJJLgxvzee4ibdYUvgpLcL+vEmQ0FoV3MwVvx1Psro+P6iikMcwUAL/H1Qp5J
 Xz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9p4OFhVWpfoFModMO68JgN4kLUfWn4ZrdXLtONTzats=;
 b=syoiAkPkILJ4hx79NLrRXi6CCSf6zQIFznInmU+XqUGRe4XiEzwSRZxz+h3HjlXnpF
 wXZyOEFCeglZ0LNP4NKJM1fU0A2J7j6mhuaALYiE5UdOBdYwL3rSur+SEPh2g5tCFGka
 XfaKkCHqr6awgGozznwHJsGhsem0LmANXKF0MQpB3n1XIjApIGHz/52+ZTmQi1IRfeCH
 36eA/aIodhwA/PlK8BNS1yrkPAQvTj13OxQgPeEo1Ta62cgz1aWdTpYZ1EGpzsMiEOj5
 oIsIaftiqvD0NplJ92A932oyUVe3Uceomwtvzk8ChRuFcQ7cqfkvmNZPDmoRDOseoF3l
 sA+w==
X-Gm-Message-State: AOAM533Vj/okLUAY+k6o8v0EJSu8flt9h5E3YeFx6b8H7RMYCNSxKOho
 WCD6KcdL21Rv/cxwNDPz2lZy7m6IQXtg6h9REFM=
X-Google-Smtp-Source: ABdhPJx324llbhik3pGqUwsEqNwv5W5jnr6M095ctSXSrBgZc/2KENC6v9kVZnh8wCEtOOI2vH7CQaoNO4SKSVMh3Go=
X-Received: by 2002:a25:8149:: with SMTP id j9mr28778381ybm.214.1598524144200; 
 Thu, 27 Aug 2020 03:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 27 Aug 2020 11:28:37 +0100
Message-ID: <CA+V-a8voHnHdmSBmewE3BStksxE4dEM1CtE7KwPZ5dn6PmV_0A@mail.gmail.com>
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

On Mon, Jul 13, 2020 at 10:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Document RZ/G2H (R8A774E1) SoC bindings.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
>  1 file changed, 1 insertion(+)
>
Gentle ping, this patch is not queued up yet at [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/

Cheers,
Prabhakar
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
