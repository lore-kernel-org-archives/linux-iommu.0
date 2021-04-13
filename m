Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE5C433B4
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6AB613B6
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6AB613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B621405D0;
	Tue, 13 Apr 2021 14:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5bi0kA91dXZ8; Tue, 13 Apr 2021 14:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F7B9405E2;
	Tue, 13 Apr 2021 14:58:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC13C000C;
	Tue, 13 Apr 2021 14:58:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24844C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13463405E2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PQk4WyGj6FE for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:58:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0C56405DE
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:42 +0000 (UTC)
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lWKUz-0005Ga-5s
 for iommu@lists.linux-foundation.org; Tue, 13 Apr 2021 14:58:41 +0000
Received: by mail-ej1-f71.google.com with SMTP id t23so3407665ejx.11
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 07:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ph9+/mYhqHgYa9Fj9YRroZ2f7XAlKgwCaPOsxelpWRE=;
 b=aNKYmLD+qqqpoYAzSNoUaEeS1fit97SbktlIuVRrKoz93uJLINxQpPfAxrBuW73NiP
 +gmhpJdHmwHUps14nv0y441uwR7O2WLKQ34uqSM25OiDd9kJSOMBclVhtw7URWVKkQ0C
 GWFBHM1WcTTANZmUjJK/PUCvzAU/6fdTkbaYceywCyk6G1GyXbKqdxzWVOFhcEmKNYy4
 dinPq0twJwejSRUf1tVr8hefBXGHDvTELvVVQHv75o0k62MR8MHL8pTCEOnya91gEpWq
 zV/SVq8IfnvhocH+bkjn2r5F3AajpE6dhrZFDXxuiTIi5tlqvlK6Lfgis3kA1yUltliw
 Kq6A==
X-Gm-Message-State: AOAM530I5uqSyP7AqqlHbO5GCx1IZ7izt8GzF6yWGuu9STPMTWeMlv13
 PZ9+eP1FR6YTxG1QRC40n28tXxuLbbzwSm+Ef+aICQ2d4ZZJbL9GYl1YllyyWD15KUXUWp1AQsJ
 ULORPCToz+faR6c0kbWGkGbb6KJwIgc8FttJvSqwPr17XYnQ=
X-Received: by 2002:a17:906:c7ca:: with SMTP id
 dc10mr13614394ejb.294.1618325910748; 
 Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgRCGqwTKY1uXNFzYOC/YmWaq5iHZG/z/5N5f+QW5qWm9hQs1h7yWI+1JNCO0I2BVghLszFQ==
X-Received: by 2002:a17:906:c7ca:: with SMTP id
 dc10mr13614363ejb.294.1618325910652; 
 Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch.
 [188.155.192.147])
 by smtp.gmail.com with ESMTPSA id p3sm4395217ejd.65.2021.04.13.07.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: (subset) [PATCH v5 00/16] Clean up "mediatek,larb"
Date: Tue, 13 Apr 2021 16:58:24 +0200
Message-Id: <161832589345.71964.1780926932144222450.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 acourbot@chromium.org, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, iommu@lists.linux-foundation.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-mediatek@lists.infradead.org,
 chao.hao@mediatek.com, ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 10 Apr 2021 17:11:12 +0800, Yong Wu wrote:
> MediaTek IOMMU block diagram always like below:
> 
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |  ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
> 
> [...]

Applied, thanks!

[04/16] memory: mtk-smi: Add device-link between smi-larb and smi-common
        commit: 6ce2c05b21189eb17b3aa26720cc5841acf9dce8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
