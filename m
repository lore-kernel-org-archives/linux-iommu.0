Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D75C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 22:46:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D040164D9E
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 22:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040164D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9A2E6870D2;
	Tue,  2 Feb 2021 22:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nrD0vDw8a0kO; Tue,  2 Feb 2021 22:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 997F0870C8;
	Tue,  2 Feb 2021 22:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E527C0FA7;
	Tue,  2 Feb 2021 22:46:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2B08C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 22:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CF60884483
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 22:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wtA0i5XJO_P for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 22:35:58 +0000 (UTC)
X-Greylist: delayed 00:09:19 by SQLgrey-1.7.6
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 968D4842FF
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 22:35:58 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 218CF580165;
 Tue,  2 Feb 2021 17:26:38 -0500 (EST)
Received: from imap2 ([10.202.2.52])
 by compute3.internal (MEProxy); Tue, 02 Feb 2021 17:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=4wZcFLCCzwfMPCcZuJzeRdQ3jjb2nMr
 fui5IjhGx5nQ=; b=OwJiVPzNdUHbCvmTv1YDtu7Eha3+dg1ZQ+xQHRxqCxmhxSH
 Ubg2iKCAvUjWkPe8SRRTP9psI9GR1dbb5vMvypjs1zcCg3y1bFRkGTUa9zEpw4aa
 yE+mf0n/SpCaBdOr/6XjmaL9MFzaqA6nvncTmVJBKv5Ml59+9S+2cQ00mhj2hRk3
 +Z4hkkdQ/fykebYBcIy5Y2jDLW4goMpdjYKfFo3DhneIlvB2LucSXZkg7x/UlKcN
 rr0MeMwd8fJ9uK/nO8favtmGMmNG35U1Ooe3v6dlPasc3g2Idg3zUfM7o5czbIpL
 iybO0UvsGqnSS/bbLWIZx2VglGnnDTXQ7d62kGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4wZcFL
 CCzwfMPCcZuJzeRdQ3jjb2nMrfui5IjhGx5nQ=; b=JwijdwW+mP7x2V86r3m/MF
 1Tejumh1AzaW0Uwd8NU5h/feTgPeWoWrB5WJJS+8P5IAqPm0HjZSXsDUcxEr/Ctl
 WevWGKgf05/LfHJ7CDxi3PK321oblHLbgLTusnWVLhra0PfEvK3U5PAMQSg0947M
 SiTd+aixvUW6F08i79Zr8PraWd+HB+gnLOQ416FPLVYCMCvjtDwpNp2y2GGkfwam
 EtASuYvOrNpAans7OIdlLqezQc5IRzc2+hZ06hC+r6zhYCIeUk5o0h9K+k+KxuR6
 XQYB760brbb5cpoe8nP8BeMxgtNhbv1vdBKxLQqF4ta2X8vQP3tszajU031fnq5g
 ==
X-ME-Sender: <xms:m9EZYAng1_zGpX9IcBpC2WWy-2UXzLrEOteuW3ZSm92sJbDCLbNy8g>
 <xme:m9EZYP2VdDkY4dQ0VB1uxub5bi6l5IbYwWjTR-vHaCbMXrJ1r5BmDDafzUzl1bIqR
 HWtl8FqSw1FpyAa-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedtgdduiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
 grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
 vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:m9EZYOqCAdg_UUD7Y7wHWtrM1fwC-_wRp4sZ3ZYRTcBPBlnwlpxIQg>
 <xmx:m9EZYMll3jRO1cCzNDE0onJkoNnZ0cKaIzIZbq4RfCAt9mgCx9oldw>
 <xmx:m9EZYO2ws7Ga9ze1wzjCq94e48PIPirAcF_G28FdbPTj-oklucE4og>
 <xmx:ntEZYBEihhU3PlYgBskF03BF1wLUTrkjnYuBaWlo-n5pR6rV45r7hw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 154AEA0005D; Tue,  2 Feb 2021 17:26:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <d3257529-b3cf-4a02-a526-70390f77306e@www.fastmail.com>
In-Reply-To: <20210202205544.24812-1-robh@kernel.org>
References: <20210202205544.24812-1-robh@kernel.org>
Date: Wed, 03 Feb 2021 08:56:08 +1030
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Rob Herring" <robh@kernel.org>, devicetree@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/3]_dt-bindings:_Fix_undocumented_compatible_strin?=
 =?UTF-8?Q?gs_in_examples?=
X-Mailman-Approved-At: Tue, 02 Feb 2021 22:46:26 +0000
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
 Stephen Boyd <sboyd@kernel.org>, iommu@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 David Miller <davem@davemloft.net>
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



On Wed, 3 Feb 2021, at 07:25, Rob Herring wrote:
> Running 'dt-validate -m' will flag any compatible strings missing a schema.
> Fix all the errors found in DT binding examples. Most of these are just
> typos.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Vincent Cheng <vincent.cheng.xh@renesas.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml        | 2 +-
>  Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml  | 4 ++--
>  Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml        | 2 +-
>  Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml | 2 +-
>  .../devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml          | 2 +-
>  .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml         | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 2 +-
>  Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml          | 4 +---
>  Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml    | 4 ++--
>  11 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git 
> a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> index fa0ee03a527f..53cc6df0df96 100644
> --- 
> a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> +++ 
> b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
> @@ -18,7 +18,7 @@ properties:
>      const: 1
>  
>    compatible:
> -    const: allwinner,sun9i-a80-usb-clocks
> +    const: allwinner,sun9i-a80-usb-clks
>  
>    reg:
>      maxItems: 1
> diff --git 
> a/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml 
> b/Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
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
> diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml 
> b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> index 1465c9ebaf93..1d48ac712b23 100644
> --- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> +++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
> @@ -66,7 +66,7 @@ examples:
>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>  
>      main_crypto: crypto@4e00000 {
> -        compatible = "ti,j721-sa2ul";
> +        compatible = "ti,j721e-sa2ul";
>          reg = <0x4e00000 0x1200>;
>          power-domains = <&k3_pds 264 TI_SCI_PD_EXCLUSIVE>;
>          dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
> diff --git 
> a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml 
> b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
> index 1f2ef408bb43..fe1e1c63ffe3 100644
> --- a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
> @@ -46,7 +46,7 @@ examples:
>      #include <dt-bindings/gpio/msc313-gpio.h>
>  
>      gpio: gpio@207800 {
> -      compatible = "mstar,msc313e-gpio";
> +      compatible = "mstar,msc313-gpio";
>        #gpio-cells = <2>;
>        reg = <0x207800 0x200>;
>        gpio-controller;
> diff --git 
> a/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml 
> b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
> index e3ef2d36f372..128444942aec 100644
> --- a/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/nuvoton,npcm7xx-i2c.yaml
> @@ -17,7 +17,7 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: nuvoton,npcm7xx-i2c
> +    const: nuvoton,npcm750-i2c
>  
>    reg:
>      maxItems: 1
> diff --git 
> a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml 
> b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> index cde1afa8dfd6..349633108bbd 100644
> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> @@ -93,7 +93,7 @@ examples:
>      #include <dt-bindings/power/r8a7791-sysc.h>
>  
>      ipmmu_mx: iommu@fe951000 {
> -        compatible = "renasas,ipmmu-r8a7791", "renasas,ipmmu-vmsa";
> +        compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
>          reg = <0xfe951000 0x1000>;
>          interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> diff --git 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> index 54631dc1adb0..5dbb84049ff6 100644
> --- 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> +++ 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> @@ -63,7 +63,7 @@ examples:
>          reg = <0x1e6e2000 0x1a8>;
>  
>          pinctrl: pinctrl {
> -            compatible = "aspeed,g4-pinctrl";
> +            compatible = "aspeed,ast2400-pinctrl";
>  
>              pinctrl_i2c3_default: i2c3_default {
>                  function = "I2C3";
> diff --git 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> index a90c0fe0495f..ad1c33364b38 100644
> --- 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> +++ 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> @@ -81,7 +81,7 @@ examples:
>              reg = <0x1e6e2000 0x1a8>;
>  
>              pinctrl: pinctrl {
> -                compatible = "aspeed,g5-pinctrl";
> +                compatible = "aspeed,ast2500-pinctrl";
>                  aspeed,external-nodes = <&gfx>, <&lhc>;
>  
>                  pinctrl_i2c3_default: i2c3_default {
> diff --git 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> index c78ab7e2eee7..ad91c0bc54da 100644
> --- 
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> +++ 
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
> @@ -95,7 +95,7 @@ examples:
>          reg = <0x1e6e2000 0xf6c>;
>  
>          pinctrl: pinctrl {
> -            compatible = "aspeed,g6-pinctrl";
> +            compatible = "aspeed,ast2600-pinctrl";

Ah, thanks. For the Aspeed changes:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
