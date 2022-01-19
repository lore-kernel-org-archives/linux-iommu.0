Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C544DC433EF
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 16:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62595825FE;
	Wed, 19 Jan 2022 16:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTGutqvIU81V; Wed, 19 Jan 2022 16:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2AAF18261C;
	Wed, 19 Jan 2022 16:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44958C007F;
	Wed, 19 Jan 2022 16:12:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2907FC002F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 10:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16EBF60A89
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 10:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8G2EdCcxKxNh for <iommu@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 10:35:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73D7260011
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 10:35:48 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id cx27so9202903edb.1
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 02:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OSDFZdcVmsxc9n5bq5153WrX2NPdR5H36ptL4DF/Ld8=;
 b=YzN3hIDiV3bsIYsBRldtIUseIA+Xg7yiUwxhkQBN4CpuDkGRGuFL7tAwCFTPYxhsRL
 HPHBSnHmlPJjpHnwXFn3XLaO3n9wa1rhK6vn59VsHIzMFUB6Jaq/3jsmguiQSKRchg1F
 Rt8vJSiYrulpQPWwPqPi3M8d7DsPrMLpe1PuuNpPMpczmmAtVSklZu+pQaTuoZw/CFJz
 zmTnBvK6MUoD+sXbx5PZpdbapVrA4zutuPKb+I0hcI1WoSE1tZMwas+pgK6nHJrD6hKt
 eeU6QEdcKx7a9glyGv2v53ut+S9OpX/JqVokRLDZ4YgZwe4DtxLJ2DYjxyR/R4KjvJPB
 tM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OSDFZdcVmsxc9n5bq5153WrX2NPdR5H36ptL4DF/Ld8=;
 b=pXjoni2W/LsveP56VYGAwmRnyWt+vV0JGV64KNaJPNFh7VqStX3nn70BeDNf8j1EI0
 Re7KH964cxm3IlaX+lGgJO+rt14W6Pu/Drrijmo88m422ytogeU4KtDVH7DMRL3wEORl
 AWdjpgtzT7TYBLwlfr0sbm+jftqtuoDf5bY6d/NA0Jyk3ochlq/xTxTz/l132gdsl0sP
 1FJTt+waSHeaRq1K/N6eXgznk8fglIQTmOWRCCmz0synUPWO2pPmJ9/WdibGedRZvaJV
 Dyp0YMSNQNJSsvOFZ+pE4tyrD4HA1chR63lXLRzrP09GufgqRWrsnPbuoU4Dgyhv3qHL
 Q39w==
X-Gm-Message-State: AOAM532wIJcnmuXaWsrGUM24B9yjpcmNPKYYPhq3IZV73EUwcE3H6ofM
 l3LJYH4TAfLYKX6VfCbdsy0=
X-Google-Smtp-Source: ABdhPJxftTapCLkxAI0MUlBNg1QEZq+09+lN2uAiNmyiN4LnLKb1WAquBvnPN+ndGN2eyHqbgIspAw==
X-Received: by 2002:a05:6402:4310:: with SMTP id
 m16mr13576339edc.344.1642588546591; 
 Wed, 19 Jan 2022 02:35:46 -0800 (PST)
Received: from skbuf ([188.25.255.2])
 by smtp.gmail.com with ESMTPSA id go41sm6349344ejc.200.2022.01.19.02.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 02:35:46 -0800 (PST)
Date: Wed, 19 Jan 2022 12:35:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Improve phandle-array schemas
Message-ID: <20220119103542.el3yuqds6ihpkthn@skbuf>
References: <20220119015038.2433585-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119015038.2433585-1-robh@kernel.org>
X-Mailman-Approved-At: Wed, 19 Jan 2022 16:12:49 +0000
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 Sebastian Reichel <sre@kernel.org>, linux-ide@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Pavel Machek <pavel@ucw.cz>, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Lee Jones <lee.jones@linaro.org>, linux-riscv@lists.infradead.org,
 linux-leds@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Marc Zyngier <maz@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, iommu@lists.linux-foundation.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, linux-usb@vger.kernel.org,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 linux-crypto@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
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

On Tue, Jan 18, 2022 at 07:50:38PM -0600, Rob Herring wrote:
> The 'phandle-array' type is a bit ambiguous. It can be either just an
> array of phandles or an array of phandles plus args. Many schemas for
> phandle-array properties aren't clear in the schema which case applies
> though the description usually describes it.
> 
> The array of phandles case boils down to needing:
> 
> items:
>   maxItems: 1
> 
> The phandle plus args cases should typically take this form:
> 
> items:
>   - items:
>       - description: A phandle
>       - description: 1st arg cell
>       - description: 2nd arg cell
> 
> With this change, some examples need updating so that the bracketing of
> property values matches the schema.
> ---
(...)
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> index 702df848a71d..c504feeec6db 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> @@ -34,6 +34,8 @@ properties:
>        full routing information must be given, not just the one hop
>        routes to neighbouring switches
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
>  
>    ethernet:
>      description:

For better or worse, the mainline cases of this property all take the
form of:

arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
				link = <&switch1port9 &switch2port9>;
				link = <&switch1port10 &switch0port10>;
arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
						link = <&switch1port6
							&switch2port9>;
						link = <&switch1port5
							&switch0port5>;
arch/arm/boot/dts/vf610-zii-scu4-aib.dts
						link = <&switch1port10
							&switch3port10
							&switch2port10>;
						link = <&switch3port10
							&switch2port10>;
						link = <&switch1port9
							&switch0port10>;

So not really an array of phandles.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
