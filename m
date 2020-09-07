Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4DEC43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E18207C3
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1NqE+sdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E18207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 09B6285E7D;
	Mon,  7 Sep 2020 10:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TvC4_jv7zrnC; Mon,  7 Sep 2020 10:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C01385DF6;
	Mon,  7 Sep 2020 10:06:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B46C0052;
	Mon,  7 Sep 2020 10:06:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 297F6C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B8CAF85E5C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ewOkUc4c72x for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:06:16 +0000 (UTC)
X-Greylist: delayed 18:43:47 by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E68EC85DF6
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:06:14 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id h4so13439991ioe.5
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v0OvTuxE+/iMswMQTjQb/bjlIs084TlMlRT8WNmVF+Y=;
 b=1NqE+sdR4ONCLnZ5XhFqnlHSfQVFov4iy/cT+yyxmAzy5+YCr/Ul9KigmS858zeHof
 veerpBJ8XhqPoT84DSedPKvLdYY3GqAGqRsEkjV+NU9bChBpBNA1NZNkxENzA7KPM1cJ
 YbNZSDGYeZOwNGjxpWRPNef161HXLK7nWTU8e4wLNPz62F/si1Y2ll6mGdGWppAmk1hR
 XDf6BujzOkpGItyYi/ysU1ESNG0WrA8+8+xAtGfGZlmB8cW9STc/iJZZuljVuRxIfSg+
 PhJx7H8iMDclSVWwaOTyu7KmLReNaaaD0MY9P/+s2Gt3YrLzIKH9AUN2tCQZJViElB9G
 Vc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v0OvTuxE+/iMswMQTjQb/bjlIs084TlMlRT8WNmVF+Y=;
 b=PNkidZ52yt1EsSUWK2Qy9/Fm4b2EdB5HDmfgnXWhbUR6VP57AiAi9oFZn6cidIPNGj
 Hud2f+b1Id6zh84OsgMc2t1QLCyI5NjrJtExs43ojmDe1SmVitVkuU6z+ovdPCQiJjlw
 o0zq3tiyL1vLs7zInMobz1PYVKPaf3OMjU4qN3Hyj+gm4f/+wCaB5d6QID0LMg6FoLIz
 +GgR7zn81kzSkdbHjSXSur+77RBj0FDkQfAOrpMNgjYo+KdtyL1vBLU24LznvZxbcrSd
 9lPsv5Jx9tRR+UWvkMAs4hcXRQ9zozcLMSvX111HmmU+3yjktHCMl1gU9uwXTuxlXl65
 1CuQ==
X-Gm-Message-State: AOAM531EY9yoIqclTyXkHnbBC4a0dT7dtEbklQ8l0+IZBEO4BmnZRfcj
 yPhVSFssN7LgfyLR3OPCSg3l98Asp92I2GIE+ubFGw==
X-Google-Smtp-Source: ABdhPJw52QuX8XyBkW5w5YSCJbnGbo22v3h5joTjE50AnRXJMICHttb6i5OzXghJCZwUuJmPrBvIE2wQCbUxcbTWSzI=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr2869058ior.154.1599473174144; 
 Mon, 07 Sep 2020 03:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200906151928.881209-1-fparent@baylibre.com>
 <20200906151928.881209-3-fparent@baylibre.com>
 <1599450232.27773.13.camel@mhfsdcap03>
In-Reply-To: <1599450232.27773.13.camel@mhfsdcap03>
From: Fabien Parent <fparent@baylibre.com>
Date: Mon, 7 Sep 2020 12:06:03 +0200
Message-ID: <CAOwMV_wXM9Tt-NhKQ05juvj06reD70AXUNzqWTEMeAgqcmnO0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
To: Yong Wu <yong.wu@mediatek.com>
Cc: DTML <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, miles.chen@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

> > +static const struct mtk_iommu_plat_data mt8167_data = {
> > +     .m4u_plat     = M4U_MT8167,
> > +     .flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
>
> The 4GB mode flow was improved at[1] which has just been applied.
>
> If you add 4gb_mode flag but don't have "mt8167-infracfg", the probe may
> be failed.

Looking back at the datasheet I don't think HAS_4GB_MODE should have
been enabled for MT8167 anyway. I just removed it and retested the
patch. I will fix it in v4. Thanks

> [1]
> https://lore.kernel.org/linux-iommu/20200904112117.GC16609@8bytes.org/T/#m613e9926735d07ad004fddbbcedaa50b5afacca1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
