Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033CC433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 08:16:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C2C61950
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 08:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C2C61950
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B086606BE;
	Sun, 28 Mar 2021 08:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KBED9t91GSPm; Sun, 28 Mar 2021 08:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 286766074E;
	Sun, 28 Mar 2021 08:16:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0CFCC000B;
	Sun, 28 Mar 2021 08:16:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91F9CC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 08:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BBF340178
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 08:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bCOwkJ7KTTMI for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 08:16:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D716F4016F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 08:16:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D6A76198F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616919396;
 bh=4CuJQ8EA3X0dLjfVJb0qayzZWmk2CnAh0upi7tGjfZQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dvEgRHFDzql1yoMRxwyQIBY7hwZKlwCvrvRWMifQZAJzxFP51wUYl1wwRFkChRwqa
 nAJWpvHyohovK2yCZT7Zd9Vb2FJ3eCkxz7WjngQYLKXvFUPrwgZtRgNLKmTeyoj5bZ
 eYuu9y1xyfCLLLQpexty6dsCVr5PZDV3i54hiQHflRXdTcUCkM01vU/xyHUXHhjeC0
 /0qC1Kkzid4pX2wjKHX3Wk1ryxdrN/rKfCzQe2MsH35T13YTEq/zzES4bknuGeaIP5
 S2XvGX3h76e+dZWUJjjp5GTGcSSO5LDH+QriY1qp16oWptychlYdEO+XsTDOTqg37K
 6yJo+zUEY18WQ==
Received: by mail-oi1-f182.google.com with SMTP id i81so10219632oif.6
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 01:16:36 -0700 (PDT)
X-Gm-Message-State: AOAM533womkFjYn3IxlJfjjULNOsHS9CvrtYWfrfNZwr2AocaHQSXJzW
 3wSL7vQuUpV7+tflZD2jjtQJCeszmNcOwhv3QfM=
X-Google-Smtp-Source: ABdhPJxYtGzJlX1YL6gQiKAp0fD5CeNsvzjXj5b3i+Gzrj0uoEQbigl2nkQkiN29+h9mnMgNHLPZDMPKdVXYW7Gmydc=
X-Received: by 2002:aca:5945:: with SMTP id n66mr14779649oib.11.1616919395634; 
 Sun, 28 Mar 2021 01:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-3-sven@svenpeter.dev>
In-Reply-To: <20210328074009.95932-3-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@kernel.org>
Date: Sun, 28 Mar 2021 10:16:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Message-ID: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
To: Sven Peter <sven@svenpeter.dev>
Cc: DTML <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stan Skowronek <stan@corellium.com>
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

On Sun, Mar 28, 2021 at 9:40 AM Sven Peter <sven@svenpeter.dev> wrote:

I noticed only one detail here:

> +  - |+
> +    dart2a: dart2a@82f00000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f00000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };

The name of the iommu should be iommu@82f00000, not dart2a@82f00000.

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
