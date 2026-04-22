Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08D24887E
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822752; cv=none; b=al7N6mfRIW6wSNkrmx5eh1ZQzevd3GQdG+NH/95IAl9LhKx5x8l0+NDkApV8Iy3z0AgOMIO6UbcKSWFlwTVkv/capsq67kDVrDsBcmDqh4vgaZcdwRmP0H9w5ICdneDUKyyEzVQTP37jM9i9qW+KrUi5nZaEVLqRSaIs4IM4YM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822752; c=relaxed/simple;
	bh=i2BoUeBiaBN5BhTYVusWVsTRIANEkj7qt4bG5qmvTfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETfzHFKUON8SW5twXYIhbcqtfFdHtcNZByqP8lCcaXatQXnCREY1IqeqYtAwQyTtP+qgCTV5RuoINj704DT4pUVmMuUEfDo7pK/f/vBegoouBn143kv+0Yenf2KLBXxsGTylJgQtn+1G/AvgTvqDwbe6psmitoe7V41vuEZRHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBpf+8bf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfCFsxyE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBpf+8bf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfCFsxyE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZrHa727931
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C8AfVkpjz5uA/yuNgUlEQ8Vv
	m91nbKA2JeN2OZf9jbg=; b=dBpf+8bfQYwThnxsaLcGS9nW4PuPLP683Aj4Hbas
	D7BxH58zRTFaJ1ctDXswlDwgYKjhpYTV4jEQ410Vq7HV1kMVmTPCbUBTo4Menmih
	N30NGC/VMT2of57nM27ERCyW9WHXW5XscDdWtn3WcMyvBJTTfU5+dffrl4ZNO327
	1X+m9yU7Nc+eTmFUNxyU/9akomfYHKE1oyfR3fBTggB4X87CAhkwPSAXah0cfMjn
	SZQ8M9k23DNaCOX9WZF3/7hvQlz24lgJmLZe+52UY/TDQPdYi60K2ka/G1IVTXdp
	zNRyeWWdUw+aLWum+n35mo4+GPRLR+Q0hZEkebS1KZTmYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenh95cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:52:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso599393985a.3
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776822749; x=1777427549; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8AfVkpjz5uA/yuNgUlEQ8Vvm91nbKA2JeN2OZf9jbg=;
        b=MfCFsxyE9D2QOW82sOYpB5eE9+iLgnG02clyDc5smCkr4i+TqqX+3+y3uWcbqqTDSR
         hxoMzHjCbaChLk9decm9bukbcQfSWCq6QUVX789M7bOR51Kojj10mXg/nNOoRNlOSiNd
         ekTgNlEbF7GtN8649wJoaw76GfNLUvLy7zM+1TBB6xJvweHZHyTopbjs/f1D43TaCAW6
         AlNDWsF18OcURyA/LfJka+1IFhftsX9OKZkIRoZUdxifRsrBAM/jh8qwQLR1nM7PrkQu
         E5Am80F7XQnaWUVhUEeeDj+6i1YvoU//mStQxC+27F1enL5n41Y6M4pfa7iGHFoIIaHw
         sr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822749; x=1777427549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8AfVkpjz5uA/yuNgUlEQ8Vvm91nbKA2JeN2OZf9jbg=;
        b=JfGWE/xZNFjfyTndXUpiGf9/OD+zQ6lkfieKE7g2SmrD4Ogf2k8CSY1OSgY5TDiE+I
         NvspFQ2mmsFuHvOAEl2AHOs7LqdcvZ77NuNaM0Pv3vaq50PH0U+/hoq7ZwDnIG6nAoou
         tRns5OUCUlSPrVRs1ZP6CYQLhvdyVqwXqyTsO03Pe7CQ01tD2hXHCSfACDVwYe9OlSNl
         O77ByAzMA6BskyJB5Fi8edVEtxWrtjghzs/LzbdpEHocvmpleC6dEZbkrl9KEK3yuCjq
         +ba4aEsoFUhg6dVNKSD+Ar1cMc1lULqWQblIprRgXUlLvogwGzu/xfesRGzF1/N1OOgd
         UgTg==
X-Forwarded-Encrypted: i=1; AFNElJ+M7wxJjXMUZH/VHFcYsxPWYnEBfo5mt3Xakcotm0pTNd7FmcYWvhwD6vmRL1/KwlkpXOxqKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2PEosvQQXDvZC//PpRHP+SNAbcOp0zN9yflgCNcwHCu9DOAYu
	XSFcpAbnLZIh/SE2dHSYVRUyHqRKatdcAn2Jb3N6zKOs/hN5rUExczd4gQW0rDz0NYoRA9gGfz4
	DpTaEoWCEbR0EyZ8QLTHFCtk0RjrTb+wOOxrGlM1qLNE0dD2q1OWFeTuZcA==
X-Gm-Gg: AeBDieuA6vPFYlNpL02b/DfNNUN8Am21k7lT6IteYg0+UWrMWdOdRTg6rxSS6sL4qyG
	mrqPbSWmOw9wz0Hj2llW1UItfCmfzE2+nc0PVKQx/Q0XYrBluFCIgBtElcez9bXrYsMQOC3GIrw
	NvaqqtU8vjLe8VivrhuDHEiwDw0FCXoDmkDBbl+cTZH6g3Oe0DQL5juYqM2eGfpkp3sBV+ofngU
	D1YQBt8+QdvMrz1TW+RD+01hWLCM2AsvodsCIAcy06PHMjnHYYhmzDN1xJx6DUU9vw98oCGCGdN
	6lTk4FtFQRrGHIx6YODbCSO8wcjiLLMLl58kg7iJGZL0sB50LiLdD17XdTTIumXGfbxio27n5ql
	MKYCpWSujam8qr7dgv7JFemOsqQMfIMIUBoIj3/Hkmw1L8EnQnWHhci6tx5rKLZYRc86Bul6GM+
	Vc+ZSROc1XCB6Gf+Ufcewsth8eWy1B23R4FyfhUJf+OJXF2w==
X-Received: by 2002:a05:622a:1b24:b0:50f:c26d:f31f with SMTP id d75a77b69052e-50fc26e284fmr4057941cf.19.1776822749545;
        Tue, 21 Apr 2026 18:52:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1b24:b0:50f:c26d:f31f with SMTP id d75a77b69052e-50fc26e284fmr4057751cf.19.1776822749072;
        Tue, 21 Apr 2026 18:52:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185c8a33sm4116785e87.36.2026.04.21.18.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:52:26 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:52:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
Message-ID: <7vknnza4kjylf7djlykq5ytzyjvk3nsrhpn52bvnb33edzg6hb@ufrlygkis6o6>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-8-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-8-bcb0857724de@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e829de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NUSM9a-ApLgp72EsCKoA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNiBTYWx0ZWRfX911izEqZyQ+b
 anpZyCGdLGNlHMqVoxkXIBtsr/XTEiPr7aBqtfqz1CxK4LL33oYoTA3DAKrrE/YYxKQfVqqif/S
 W4xEz/tqsWISwHhDXQK/pPL/HrOkdWyzIXFUQB8i3OD61YfBY8dTLuTNPLe+/Jm5H9S7PrnX1L8
 65WhouFTox0a9jFLd0v8iv4F8IJqTMZ/12OR+2PJD4/wbUSVRZjGwFWu4p0x9imgvAUTIIWYeIY
 P/gsMtZf2j+9pob7Jfzc8FzlroS4NxTXTqn4wxTEijIN26Bcd3VKBsoLB4eMhiz8d+G2/gwvI0/
 ED3evq+9yICSEerUkQG8znhPNJOrH2hjhvUlzfx1JW+McCIMk++cMrZ/I0f5Pqjfp6PcXPa9qLe
 Nxuuz2ftQh4mDs1IVmZpTJz6vkT/tfxKImMe5BB27AnBrWApCohnd3vN3bKaAtn0qA79Z6aJfdh
 fmpehtaS2bBOisxIIAw==
X-Proofpoint-ORIG-GUID: 3PD7EC35ao2B-CPAxdVGxWNZOs1_Ec38
X-Proofpoint-GUID: 3PD7EC35ao2B-CPAxdVGxWNZOs1_Ec38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220016

On Tue, Apr 21, 2026 at 11:45:14AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> Add a device tree for the Samsung Galaxy S4, codenamed jflte.
> 
> This has been tested on a Samsung Galaxy S4 GT-I9505. The initial support
> covers UART, USB peripheral mode with USB networking, the front LED and
> the physical buttons.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-apq8064-samsung-jflte.dts   | 484 +++++++++++++++++++++
>  2 files changed, 485 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 32a44b02d2fa..c23c961f79e3 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8064-ifc6410.dtb \
>  	qcom-apq8064-sony-xperia-lagan-yuga.dtb \
>  	qcom-apq8064-asus-nexus7-flo.dtb \
> +	qcom-apq8064-samsung-jflte.dtb \
>  	qcom-apq8064-lg-nexus4-mako.dtb \
>  	qcom-apq8074-dragonboard.dtb \
>  	qcom-ipq4018-ap120c-ac.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-samsung-jflte.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-samsung-jflte.dts
> new file mode 100644
> index 000000000000..9e5faf7c086f
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064-samsung-jflte.dts
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +#include "qcom-apq8064-v2.0.dtsi"
> +#include "pm8821.dtsi"
> +#include "pm8921.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy S4 (jflte)";
> +	compatible = "samsung,jflte", "qcom,apq8064";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &gsbi7_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		ramoops@88d00000 {
> +			compatible = "ramoops";
> +			reg = <0x88d00000 0x100000>;
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_default>;
> +
> +		key-home {
> +			label = "Home";
> +			gpios = <&pm8921_gpio 30 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <5>;
> +			linux,code = <KEY_HOME>;
> +			wakeup-source;
> +		};
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&pm8921_gpio 35 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <5>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +		};
> +
> +		key-volume-down {
> +			label = "Volume Down";
> +			gpios = <&pm8921_gpio 37 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <5>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	i2c-muic {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm_pinmux 22 GPIO_ACTIVE_HIGH>;
> +		scl-gpios = <&tlmm_pinmux 23 GPIO_ACTIVE_HIGH>;
> +		i2c-gpio,delay-us = <2>;

[...]

> +	};
> +
> +	i2c-led {

i2c-led should be before i2c-muic

> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm_pinmux 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm_pinmux 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;

[...]

> +};
> +

-- 
With best wishes
Dmitry
