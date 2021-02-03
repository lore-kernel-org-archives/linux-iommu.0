Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D76C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:34:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5154264F49
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 00:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5154264F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D835985EC1;
	Wed,  3 Feb 2021 00:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tlrV9QKEslA; Wed,  3 Feb 2021 00:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 773E8857F8;
	Wed,  3 Feb 2021 00:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52433C0FA7;
	Wed,  3 Feb 2021 00:34:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B95C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8C86585C90
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NbGAmqS6QmN4 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 00:33:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7898F85044
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 00:33:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCC464F6A;
 Wed,  3 Feb 2021 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612312438;
 bh=5Y/XoJCOn6/NGYorjRJVq5H7yCRRQePzX7xnCGRIvHs=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=a9F6yI27yX8GlW6r4oc9PzqBi9W6twsMIpsVmH7gyHNmNmblVEs1RuumPNiH0iee5
 gX3sA/jLYfrc7bRJ/GSATNIoeZPuYZe5zIf7i1OlC+uNKyCBznfuPV2gdltKWQ8gnl
 pxMIE4NK5VPTUO+AhkRVCSjleAaZEbX4YDkId77EpYoxGzIAxH2uCXAmNZs8YviG3a
 XMbnUPPakq9HH6f4R18u8zdtoeOBQ+0w/zkWhj05fStbZnEMWoX/R3dc/cvfC6udvm
 owGQ487O3z76Wejmq10QSPtB7dN9/iWjOSR3eHvfXzwkk8aDtl+mndRudxOP0cPU1m
 RyxJ/PGfPzc7w==
MIME-Version: 1.0
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date: Tue, 02 Feb 2021 16:33:56 -0800
Message-ID: <161231243653.76967.3231080427102153199@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: Tomer Maimon <tmaimon77@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-gpio@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Jeffery <andrew@aj.id.au>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Quoting Rob Herring (2021-02-02 12:55:42)
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> index fa0ee03a527f..53cc6df0df96 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> @@ -18,7 +18,7 @@ properties:
>      const: 1
>  
>    compatible:
> -    const: allwinner,sun9i-a80-usb-clocks
> +    const: allwinner,sun9i-a80-usb-clks

Should the file name change too?

>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
> index eb241587efd1..118c5543e037 100644
> --- a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
> +++ b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
> @@ -66,8 +66,8 @@ properties:
>        - arm,syscon-icst525-integratorcp-cm-mem
>        - arm,integrator-cm-auxosc
>        - arm,versatile-cm-auxosc
> -      - arm,impd-vco1
> -      - arm,impd-vco2
> +      - arm,impd1-vco1
> +      - arm,impd1-vco2
>  
>    clocks:
>      description: Parent clock for the ICST VCO
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
