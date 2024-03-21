Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162658AD6
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008945; cv=none; b=psJssxmMAkQRldk72vtiNkqn5YarDAKHXjx70t+Bb5MOG+FzvLsQShRrTGc9Fa1EbiOGVYYs1f8fGJBc0zCryW5SK67WwTAD1Bvr+jBrL90qsth8omHE7ZV4owxss/3njtnqku/dI1KEjl7ZnFFshSIhZ7ckyZNpG4fvJa1nL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008945; c=relaxed/simple;
	bh=1oZTswTLCK7Z+3DMifQ0y7SMF5QBjEZ6wL1QP9Si9+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTpr7pktcARHiC7Pb8ztAXzLDa+E0wLmJs8kCv+foBsx/4IXE1d7+ARjHP3e5EYUzqAuNrYNExygFyxazeIaXLIpozx2dLdrnh09fypb+4UfL2APDHCg5MvPDaK1YJry1hcuH2op9ZB3YjLiHsklbk/zs5tXjsva5+uZVdhHSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEnKwjFc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEnKwjFc"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4707502aafso120298766b.0
        for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711008941; x=1711613741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x816MoU6PHSK5OV4r96bOarzyV/+1Q+CoptfU+1txQM=;
        b=sEnKwjFckhvf9j6PdIRzlgVjxs7K6XryQ+knGnXD5i669OUxNaiNhlc39gB55ngYy/
         YAdz9mHRajlJe+WOx6+3HCLU533/bZ3p5zuMuosEPHJQqOleZ6TvKvG73jYGQ+3tr+vc
         2eFIJrqmCpN4ypM8qJsev2oR07b2SrhtDCS4PZBnsEgLts9NPOeF78CYy5zPhVCg270v
         TrQ4TNhzs1MfdZZCwolPsbrbkgBo3p8KsrVyFG3I/nC8DWkRheOsOHiQMxEIA2/1EIAz
         EN4eZZCxtP34wkrF9wwaByq58sBuFotzcMO24gLwO1xl1lqyBiSiNB4A6a+vIfSAToaz
         g5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711008941; x=1711613741;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x816MoU6PHSK5OV4r96bOarzyV/+1Q+CoptfU+1txQM=;
        b=BjphHU3K5TGb5l/GIbY/jpoQZZEUBZe+1ao6PUy9DCWnFINWLB2SRAcBxPcVccWl6D
         TDhJMwh1EpG5RJmETjAlVHvBCLGn/eFC2YsPPWl7gHVmBe/9AfGXalBrMDcOUm4H/j4+
         BBh3Kcm2YfE92BNe9Lx8YBGYIf+MoRyUTXF/sV4R3PKPwVcEwcmcdmi+NO/u4ap3vQ9P
         s3Ir/2/aflEFOHwhjGLIouPiTO+/+vaB2hI7msm5wuZv5QYu/bXAotjdDHQQxZ2I43Er
         1qoFfvJt0B8kgXvMNK7T4uZjQqhl49woDgJrXwwAq1BubmLTst2tIWa3IzXHMKvDTpJ4
         skEA==
X-Forwarded-Encrypted: i=1; AJvYcCVbXga6+0nJ/3DfOB5M9eU/BlKaoOPGQz5dvupRYVVvZdjr6KSCHH5h9n6loPbBMMssUjtlW99NKqXQX9em39uOV2Q5TMw=
X-Gm-Message-State: AOJu0YxyhKiB4xaWjmexUXsZGzUq/bCBpJqyrNJQB6YfBGqQvjWC4w+u
	fgoSp1/9VhHVYn/5ho/fpy3tPZ18WbIFh4tyrEZSC4/NWYmGzJMPqfQ+Df6MMcw=
X-Google-Smtp-Source: AGHT+IEYkiatPL37N//Ix/BRdeKpjBwTSEgxXwfCLeLYT0Kun6SLo6VDUqL7zQG4KSTdCVIAtECJiQ==
X-Received: by 2002:a17:907:b9cf:b0:a46:f563:a642 with SMTP id xa15-20020a170907b9cf00b00a46f563a642mr1790488ejc.7.1711008941627;
        Thu, 21 Mar 2024 01:15:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906368400b00a44936527b5sm8253978ejc.99.2024.03.21.01.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:15:41 -0700 (PDT)
Message-ID: <a60f6017-bd19-431e-8cff-7d73f6f114fe@linaro.org>
Date: Thu, 21 Mar 2024 09:15:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add VEPU121 to rk3588
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-4-linkmauve@linkmauve.fr>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320173736.2720778-4-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> The TRM (version 1.0 page 385) lists five VEPU121 cores, but only four
> interrupts are listed (on page 24), so I’ve only enabled four of them
> for now.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 80 +++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 2a23b4dc36e4..fe77b56ac9a0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -2488,6 +2488,86 @@ gpio4: gpio@fec50000 {
>  		};
>  	};
>  
> +	jpeg_enc0: video-codec@fdba0000 {
> +		compatible = "rockchip,rk3588-vepu121";
> +		reg = <0x0 0xfdba0000 0x0 0x800>;
> +		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
> +		clock-names = "aclk", "hclk";
> +		iommus = <&jpeg_enc0_mmu>;
> +		power-domains = <&power RK3588_PD_VDPU>;
> +	};
> +
> +	jpeg_enc0_mmu: iommu@fdba0800 {
> +		compatible = "rockchip,rk3588-iommu";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

