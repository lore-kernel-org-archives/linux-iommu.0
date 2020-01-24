Return-Path: <SRS0=cWJn=3O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7BFC2D0DB
	for <iommu@archiver.kernel.org>; Sat, 25 Jan 2020 16:07:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43C02071A
	for <iommu@archiver.kernel.org>; Sat, 25 Jan 2020 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzPWHzc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43C02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6CA9586124;
	Sat, 25 Jan 2020 16:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sbgIuiUhxAjV; Sat, 25 Jan 2020 16:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B04AA84DDD;
	Sat, 25 Jan 2020 16:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EED8C1D80;
	Sat, 25 Jan 2020 16:07:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAC3EC0174
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 20:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A3CE6878BC
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 20:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v-i9lf8pMbOA for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jan 2020 20:54:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 94841878BB
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 20:54:27 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p17so789135wmb.0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jan 2020 12:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opkZhz5duR9Fq5DdteTxdcCMw2LLGvVz5ld2quduWCU=;
 b=VzPWHzc+9AwICXQCpK8UFlEJx29WP+RQDUYAl4ZuwJ4ZT2A1UF6z8gLniJgwqwpbOw
 mjdDBi8NAMffhnJUnyYsUVgUwChGfGltqilmpPejqCf+h83mrdgSWvL7Se4glrFWRFR/
 doPYqnQeAZnV9WfOru4+U9kJXiy2clVjczUdvZn30tbpMvRsiPTolySL1t5YBrctpOnG
 zKn31xaqN0vUCHaKvLzbJRm2KWdYiscbmpwAowj21krQ8duow1MsxMLaUIYPuSSekHx/
 ucmcbeLyHgqan4yp1/soISTooRIzL6shEsDtfCxNNRVgjESDIlMYp3kdHvYKHWXqQy0x
 BPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=opkZhz5duR9Fq5DdteTxdcCMw2LLGvVz5ld2quduWCU=;
 b=mVOwCKsZCpXFTW31uQUIDrcRiovWhKRnz824tpsIw0Bz6plKDsww1OltzmRI9S3gwo
 C2eX3Nfrti/1NYc/iRQvlPrz2EZ1EK9UL6S5WLOknQQ7jngVBwnziI5QkL1U5eUzgp/8
 hJfvaGOtekRTeLFqbBdXQqsMAr599aEJcP4SdYjaCHDvjanCR7yWEkW9eltu7C6wDXES
 Ha7lA6tk4v97zbETfnwpfBmKrI0pXX35/2w5Vho2m2Rjk8ZNu+0xCnKJQJoXLfvEQqpm
 WzASvujvHXDRuDnZOTfOqHHmaIiTehjB3miUVEF1B6r0pgaQJNagYKapcxtYtxWaLY2j
 mBUQ==
X-Gm-Message-State: APjAAAW2QH0gSp/2kgh+vzmqHlcNIMx0eAB8xHcqskwkGm3Sb1vUkohx
 B4Owt1AwZi41lrSVNLaVvrs=
X-Google-Smtp-Source: APXvYqxM4IdIrgE2Yh8Co6XoPZAg6AxqlyYVfJQBW2cGptnFKjuymJgPm0Zl+D27Czd2RqPrFOMCVA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr957857wmd.102.1579899266075; 
 Fri, 24 Jan 2020 12:54:26 -0800 (PST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net.
 [194.152.20.232])
 by smtp.gmail.com with ESMTPSA id h8sm9812977wrx.63.2020.01.24.12.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:54:25 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add IOMMU
Date: Fri, 24 Jan 2020 21:54:23 +0100
Message-ID: <5320339.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <54e22e25c2c13cb1b73cc7ecb645b5d62f325b63.1579696927.git-series.maxime@cerno.tech>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <54e22e25c2c13cb1b73cc7ecb645b5d62f325b63.1579696927.git-series.maxime@cerno.tech>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 25 Jan 2020 16:07:23 +0000
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

Hi!

Dne sreda, 22. januar 2020 ob 13:44:09 CET je Maxime Ripard napisal(a):
> Now that we have a driver for the IOMMU, let's start using it.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> 29824081b43b..8608bcf1c52c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -53,6 +53,7 @@
>  	de: display-engine {
>  		compatible = "allwinner,sun50i-h6-display-engine";
>  		allwinner,pipelines = <&mixer0>;
> +		iommus = <&iommu 0>;
>  		status = "disabled";
>  	};

Isn't iommu property of the mixer node? After all, mixer is the one which 
reads one or more framebuffers. Once second mixer is defined, would you put 
another iommu phandle here?

Best regards,
Jernej

> 
> @@ -122,6 +123,7 @@
>  				clock-names = "bus",
>  					      "mod";
>  				resets = <&display_clocks 
RST_MIXER0>;
> +				iommus = <&iommu 0>;
> 
>  				ports {
>  					#address-cells = <1>;
> @@ -345,6 +347,15 @@
>  			#interrupt-cells = <3>;
>  		};
> 
> +		iommu: iommu@30f0000 {
> +			compatible = "allwinner,sun50i-h6-iommu";
> +			reg = <0x030f0000 0x10000>;
> +			interrupts = <GIC_SPI 57 
IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_IOMMU>;
> +			resets = <&ccu RST_BUS_IOMMU>;
> +			#iommu-cells = <1>;
> +		};
> +
>  		mmc0: mmc@4020000 {
>  			compatible = "allwinner,sun50i-h6-mmc",
>  				     "allwinner,sun50i-a64-mmc";




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
