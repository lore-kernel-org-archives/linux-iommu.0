Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757103D524F
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384981; cv=none; b=CVGFqOTjeNxRrvcdj2YsPi+2iWsr5t8Z52hTP2VTLJEZyFJ/gEdrFvc0yArvecAi6AzI1Z8hZUQinBlfSduzQmGRt8lNVbXXsEnLd5TIsfqyn8gvgr+SQ/7X3kdY4DG5l+8VLnRm1HLQX3GN0d4b3nGt8ngvU2TSiuq4cHfrt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384981; c=relaxed/simple;
	bh=qB15Tu0wQgvflvACMlEZFwV6PZUUfZT9UV5fY5oJj88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GU9fAiwmux87tphLw8RGezLugMwt/DnMGHXu5KqBggVkAFpE6HUUaVYzjLyMNnkX3oNu7GjTkVJZUUKIWRKOmVS1MXDvIQv8Re2zrGtKKGxp3rpDFatACb33xGLR9esd8bhjMtXoElBpyn3RmRQP9LLJiB2v+UNG5vhF5hlc2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6eXEJqa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LFmasp5G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6eXEJqa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFmasp5G"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAlxUY1460642
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=; b=V6eXEJqaW52sruVW
	KmAWqHedQKN92ge5YENWkiPjd+G4FUiYoi+rXuXHOXCHct/s2ruBO47fL403iyAH
	2SylfxfndayU9tuNs74mBf0Xj12d3kC5/2MhrMELYG8moOkZhHp5DR7YyqO0kNHs
	0Lw7qkc35AhQS+AgFCbu3IoOaFGpMQF7HP0nvezpOH9EjkcQG7/eI1EGSaOHqhHE
	tAFRbnOZo/0zdY6LMW69aKrcmdFxfdNVAuR98oQs9x/NZr3V+VuTPtOnn+xGBeb6
	5M5JFDIf2VvoFSBwfEjJixhhuEPdxOYVn7knVSt6iSa8pTvUSJQzCq5yrtQwVTO8
	3nO8Vw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeex8e2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 11:22:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9106a836457so8828446d6.1
        for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789384978; x=1789989778; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=;
        b=LFmasp5GImByMq4XPwW7KN9XJuZJO1aSANGAcX9cWjQKGP0qUh8bYZ55uIqG4ctKVF
         SUXfijCQF81kzMC549Q6lzLOvBLRpy9p629K+Pu6DsCgSuRncY2lzM1l36PKXOgW3KIr
         MpC64og5EKck8F5AJGYBvICK08zilAWuJ+B2FfeUPkss5BvIwmO6jMKG7zoXtyIWG8ke
         EC26W7UOhuAZifDglUn4W4Eb5u/Sl31XuNIYRNM4KNuVQTsK3MBHaJwZQRa5PgtNd6W2
         Vh1ffYYbyGYKQq8fmSeWH6aq5rCGr9w8Opr6iYLuxLDiXELUpqxOhSyoc7sTYMLKvNfo
         9kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384978; x=1789989778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=htoucfNJ1NBOznj2ucEtPoE5fys137bATrwbrwYNEEg=;
        b=QO0dJf8zF65FDEUEa3LTnjgEjy0xFm7ijzbNzOMCmgPXJYY/bLgblhMDZEMoZyfvLD
         F1YDU5Ehm1d6tCdT0UzK54jl2bBIO0geiG0hHlIouGo/HDym9gPEDg5nFhZiWbYSOruG
         TeloZC09Wcbx0kcyS/Q9/5h4zKrJDvvZzMB7gS4oBHhzD43YAqU1R3jI+p0zxuqNFnrm
         mLLog+ITaGMGU4TvwHueFZGOCkYiRUa9FKGVNVVtnboi5EW8mT+GXhVoDggwdRyVfJuL
         JgoMG2hKZMMohzoUsLpJd1CNMph0ZxGFMcBL5fs5Vq0+ZADTiMh3eHvMD93u9RmMskS+
         qcYQ==
X-Forwarded-Encrypted: i=1; AKwUvByoctrcvj4kUX9RicpACUqKw0CQNxwwkB3W+py48pXLMe86S5RSR7G2twmlqkZM8t/qNoNgHw==@lists.linux.dev
X-Gm-Message-State: AFuF++l0RWIpAXrnUj2KrVbKMi8i9Yq/rJuC+habriOZH6W5LxBdjsmc
	rDbpFgH9ltJJrJMXS5GeWN2hmKg9Afd/ugFEjRbDDWcPycc1RdeBy2FRmT7xZE30FQ5jn4QyYbw
	OFWg3ZwVEgMeBiSqQDsX+ZfgGMqgxRgwZ3UfGB04gQUIY3SDLfCDKCEP0ew==
X-Gm-Gg: AYBFou1zjusY4RiFhUopOnu7w9bBshPXfDEavWPDkaW1qQYKszDjUEEoTatr3Ond8I/
	GWr+vFPeQk2NYXYntBZOKKHl5Mtp/83LNTT2A47LQ4niQTYCjB7rZ4iNvTA1Nsw7FMziqYIqvrm
	e1HzNN0VaZ+1HRmJivYpC5vswFgV45V5erMrrXVqcRlF3CqdQ5lX9AWgqewYx9vou3wBgdjKZ1J
	eCDmPPEKm2mDY077hVGSPWkAtxrDrd94vnfWdEuJSfmtIxZDHZ55LZhFayjdbJABto0R/++tkiN
	Gca9/nn2HP2uA5uGUTejrUf1qZovKNTntVMApMXDMkIjhNBC/ggOj382GGuPE3ZeMGnS5+JMZex
	RCtPEmB9eHbZXgQyCEt9Mng==
X-Received: by 2002:a05:6214:4883:b0:912:1f0f:b204 with SMTP id 6a1803df08f44-9122e4ccd58mr27340366d6.1.1789384978162;
        Mon, 14 Sep 2026 04:22:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4883:b0:912:1f0f:b204 with SMTP id 6a1803df08f44-9122e4ccd58mr27339976d6.1.1789384977653;
        Mon, 14 Sep 2026 04:22:57 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b594f0fasm4216719a12.25.2026.09.14.04.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:22:56 -0700 (PDT)
Message-ID: <d0d7e3d0-15bf-4850-99ec-44d429c6bae1@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:22:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/20] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-20-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX/IMpNBIhVP/r
 mspsz1f/wfPZQyu3eRtWfvrHdshfsj/zTXrtbBEChrYzoej5bK50n2PRx1f7lpiNnD02aohywBJ
 E2vMlKRIGk7OjBJWLqlcTQQP+qM0f3ueQSTr8P+ee7rWFpafALC8ccFXgK23vDc8tmZHIXqo48h
 4Z9SnuOOs7HP5WDagr2YuZkH6g94KzWkIqGdG1b+8bc/oUnEFIfntUuq7NHMWWLmnjiHnrDTSTv
 2riDFoIF4AL08oS7Kwdn99afhAv4TskxMFw393jEuKZmETUZUnhOHhWjuPuOukQk/ITYkYr6fn8
 o0EM9BK7+xuXN3YuuSnTsRdQy1QOQMtRrNbqMqCKQJ1Ee4ua6sa5t4QF784tgqjHLzdLC6MqQn/
 8LGrAh1aAtxIjY2ebdm5QXu4J1xcyjZwuv2Y5Oi2GjoBe2vAwuXRW4BBVmdScxD10Zxjx1rN+Gk
 YwVSzgWqTMOZ+kF0lgw==
X-Proofpoint-GUID: Od7nNZ7lOGrMkx-SI5rM6IQDbYMHT539
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX0sKp2KYIg+KN
 5HCf1FQLagPgIh2c4Zrxs3EQOevPYoVFTqbQkZ79W20kFTpmlEZLzgvMIz5QrJyuyapu4WUHu7J
 hz9K0mYWIhMA+cKMmHT5OphTSzLP/yI=
X-Proofpoint-ORIG-GUID: Od7nNZ7lOGrMkx-SI5rM6IQDbYMHT539
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa7d913 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=OuZLqq7tAAAA:8 a=orgwjQpZXFS75ENpSOkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140161

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus).
> Shamrock is designed similar to L9300.
> Downstream reference is [1].

Please feel free to
wrap your messages at 72
characters, otherwise they are
a bit hard to read! :D

[...]


> +/ {
> +	model = "General Mobile GM 5 Plus (shamrock)";

It's not any "policy", but other DTs tend to only put the "pretty
name" here, without the codename


[...]

> +		framebuffer {
> +			compatible = "simple-framebuffer";
> +			memory-region = <&cont_splash_mem>;
> +
> +			width = <1080>;
> +			height = <1920>;
> +			stride = <(1080 * 3)>;
> +			format = "r8g8b8";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;

Please align the '<'s, make sure your tab width is set to 8

[...]

> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;
> +		leds = <&red_status>, <&green_status>, <&blue_status>;
> +	};
> +
> +};

Stray \n above

[...]

> +&ramoops_mem {
> +	status = "okay";
> +};
> +
> +&adsp {
> +	status = "okay";
> +};
> +
> +&lpass_mem {
> +	status = "okay";
> +};

Please sort the label references alphabetically

> +
> +&pm8950_spmi_regulators {
> +	// PM8950 S5 + S6 = VDD_APC supply

Let's use /* C-style comments */

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <20 4>; // Downstream doesn't use 21,22,23. 24 is mdss_te

Let's keep a \n between the last property and the following subnode

[...]

> +	tpa6130a2_default: tpa6130a2-default-state {
> +		pins = "gpio61";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +		output-low;

Drop this property, the driver will take care of it 

Konrad
