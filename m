Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5071773D
	for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729345698; cv=none; b=rmknZNF6Mmaku2Hu3tS+xwZ6yqSmgFKtcyPmEcAxtw2MDCLB9O+PZsrBs1Yg+KHOHFXA0RWjWMRXWzPJJSmoPcWKfCejagkH68mam5sr6OL0V0d1BnJpa64qCY5dkaig0HDEhj6dLdwt5XZ9LO9tVM9K0VSTBsKh3kF/uQqNePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729345698; c=relaxed/simple;
	bh=4n4MDIGsB9Spnw3RFqAqbHVaogMhzkqd10PZBPMdCrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Xg9/1oolW+iwGjOcudrz6Os1B7udvCcy2ZU4qj7A2IKp4CdTBluNLBjj9cmzM5bJtPzATBm38gK2iq5vbTVB4qtiWqQ/NG5mGvs5FdEVTXhK9SLm2IcIswoMDwDkMAlGL+5ec0+oSIzUnVhGtHYTE9fSYdG0hjOeoimxgR/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouGf1koQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouGf1koQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539ee1acb86so1027530e87.0
        for <iommu@lists.linux.dev>; Sat, 19 Oct 2024 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729345694; x=1729950494; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZF+3PSfcTB2UDavtYip93HP4kFxDmgaXd2qMwKIPLX0=;
        b=ouGf1koQPXc3YH/ZD7K+faMbHJFYDp+7aEJAWKVlUIX/lOyKnolRf2i2qPIcQrWfh5
         INe0Bqb3q+5dR700gU9QtYa+gDP41Iwbid+QSG1iqEiNy+RzrO53l8+uz2A9B3cWMeZp
         hA4ArJPthkKNeryp8J34CGAAtHadbXIC11FsS8W66SxbC4Nwwl6MplaaUxE012bVUBl4
         JE+O9qfRUHFzBXzxM0Ldq0vTIR3oBnQnPQV05UGDxCF4prWQNXOJaN4jO4TxL3/SAQRQ
         3JGtznfHpu2Uy2IdM/O46kcKnXdMBtPaO374ciG4U+2GKWBi2Cjzw2ldcrA1hdoIQmKA
         OaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729345694; x=1729950494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF+3PSfcTB2UDavtYip93HP4kFxDmgaXd2qMwKIPLX0=;
        b=LOllV7NvK/8tUMtgakfeWO4NK5kd5XPY7QO2iFCtuyuiQKIvuhVPWOa/7xbwfShxqy
         eH3fcKIptvYrtxODqUFSb1KIjMfUNXAE0us22ebkjh4/FLEJcicGDnfb+9fBCbg6Q+at
         jSFRcPVHiKhKB3uad8MDOdf2h+a0/MDAOvlpqsGi7ypexIVI4M6x7cIJzUu2jESznPyh
         SdXV3ZyUR1PmRD5o6qjEr+VcyOpn6zpv5yx6/HKJ93ZgqX2TDIIOtfAO5X1es7geyH+3
         9XOX0DGT356iE2rfcftak3VMPBpmrggiQqCO+J4RRyQ/knEFyPn2j4BvRzrXsSniHNuP
         4YtA==
X-Forwarded-Encrypted: i=1; AJvYcCWF76sxbeEzxWvh4iT+fgwdHDtlPhfnZE6VyNoiafFJZ+/SDga5C2lxI98bMMFADalYuuAMCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc8J0qWnViOkdzQO5vQbXDBaFKicUYxhihXqYqewB70KymY3YN
	a4WujHVOqNEivtjx1ADUUY9hYZmSnq5c+2u0Z7a1XnSMMrZphn4ag0cn3dRq/no=
X-Google-Smtp-Source: AGHT+IHZH0/QDC6nai6IqvI7l/SISX6Cr3HJY8vpF2UAC+FhTHL0xpnRDeU//bb+OlwsbM1uk2Yb9w==
X-Received: by 2002:a05:6512:6d1:b0:539:a2f5:2f1d with SMTP id 2adb3069b0e04-53a154afc13mr3133309e87.61.1729345693715;
        Sat, 19 Oct 2024 06:48:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b01a8sm534826e87.50.2024.10.19.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:48:12 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:48:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH RFC 14/14] arm64: dts: qcom: Add Xiaomi Redmi 5A
Message-ID: <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org>

On Sat, Oct 19, 2024 at 01:50:51PM +0200, Barnabás Czémán wrote:
> Add initial support for Xiaomi Redmi 5A (riva).
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                |   1 +
>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 295 +++++++++++++++++++++++
>  2 files changed, 296 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 065bb19481c16db2affd291826d420c83a89c52a..79add0e07d8a5f3362d70b0aaaaa9b8c48e31239 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86518.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..7553f73603fc87797b0d424a2af6f2da65c90f5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Barnabas Czeman
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/leds/common.h>
> +#include "msm8917.dtsi"
> +#include "pm8937.dtsi"
> +
> +/ {
> +	model = "Xiaomi Redmi 5A (riva)";
> +	compatible = "xiaomi,riva", "qcom,msm8917";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <QCOM_ID_MSM8917 0>;
> +	qcom,board-id = <0x1000b 2>, <0x2000b 2>;

Is this required to boot?

> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		charge-full-design-microamp-hours = <3000000>;
> +		energy-full-design-microwatt-hours = <11500000>;
> +		constant-charge-current-max-microamp = <1000000>;
> +		constant-charge-voltage-max-microvolt = <4400000>;
> +		precharge-current-microamp = <256000>;
> +		charge-term-current-microamp = <60000>;
> +		voltage-min-design-microvolt = <3400000>;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "framebuffer0";
> +
> +		framebuffer0: framebuffer@90001000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
> +			width = <720>;
> +			height = <1280>;
> +			stride = <(720 * 3)>;
> +			format = "r8g8b8";
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>,
> +				 <&gcc GCC_MDSS_MDP_CLK>,
> +				 <&gcc GCC_MDSS_BYTE0_CLK>,
> +				 <&gcc GCC_MDSS_PCLK0_CLK>,
> +				 <&gcc GCC_MDSS_ESC0_CLK>;
> +			power-domains = <&gcc MDSS_GDSC>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-volup {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		/delete-node/ reserved@85b00000;
> +		qseecom_mem: reserved@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		framebuffer_mem: memory@90001000 {
> +			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
> +			no-map;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {

regulator-vph-pwr, please

> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5306";
> +		reg = <0x38>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 0x2008>;
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +		vcc-supply = <&pm8937_l10>;
> +		iovcc-supply = <&pm8937_l5>;
> +
> +		touchscreen-size-x = <720>;
> +		touchscreen-size-y = <1280>;
> +	};
> +};
> +
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	bq27426@55 {
> +		compatible = "ti,bq27426";
> +		reg = <0x55>;
> +		monitored-battery = <&battery>;
> +	};
> +
> +	bq25601@6b{
> +		compatible = "ti,bq25601";
> +		reg = <0x6b>;
> +		monitored-battery = <&battery>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <61 IRQ_TYPE_EDGE_FALLING>;
> +
> +		input-voltage-limit-microvolt = <4400000>;
> +		input-current-limit-microamp = <1000000>;
> +	};
> +};
> +
> +&pm8937_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pm8937_spmi_regulators {
> +	pm8937_s5: s5 {

Which regulator is this?

> +		regulator-min-microvolt = <1050000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +

[..]

> +
> +&wcnss {
> +	vddpx-supply = <&pm8937_l5>;
> +	status = "okay";
> +

rogue empty line

> +};
> +
> +&wcnss_iris {
> +	compatible = "qcom,wcn3620";
> +	vddxo-supply = <&pm8937_l7>;
> +	vddrfa-supply = <&pm8937_l19>;
> +	vddpa-supply = <&pm8937_l9>;
> +	vdddig-supply = <&pm8937_l5>;
> +};
> +
> +&wcnss_mem {
> +	status = "okay";
> +};
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry
