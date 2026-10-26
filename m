Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026921;
	b=Sh5zi9NQlx8YyDUKVGibRP+0Acc/AZ624o+H1H9GTsBEqFIS2qCwZ5xx9nWToTnNpS9f
	 TvS00/H7vIq/1jf8aaKgmpVhlDDOucizWC0qjjt7fKRT1Qc4wyUkwXanjUizmkPuR1Kcm
	 X9pX99KnDiSUmcBMDWv+xX2M0o5/ZdwCauv8ZFYq3ULjpk6ffP1jWf58MgCrr9CmSGgIA
	 0+p/35iGIM5+CQBOSerd10IBHlNhfpWbtfM8NPW4wJ0qLtD76Iaf6sL+hBaL71h+6S8Dc
	 EpPKawkieB+ERHmflW1PXTfQKoS2s2M7LryR37ROl6GGLjo/wn9P9GQji1gcJJPPD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026921;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
	b=XtN9R5gnqI6fQ0cEHwcPhdmaAbzpFU2XCn9PfX9SiTkDzs+LDZXF/qdSjOvjJ78pQQWz
	 n1cehIIdjHWmjvXcWnhBlK63AnBSGa1jWT71RpbjBPaQQHqOcjVz+G9YriarnM6Okrb6X
	 1qZWozU2gmXSCgRIE6fymiZVv/vuUFM4wq+5MStrVCS6oFUCJ9hRT4AIzvXTCaYXV1ip4
	 HnuqabjnBQfq3PUS0Gs3vP1Uau/C0exTxPOs2Towglw4ORMyZrtSksHOeIslPxqWVbb3K
	 thak7EpTReSUbSacUFuaxlowoott4M1tjJyxhwpAvqISgNDE2RDW0mavb5gX33sKGrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OTKp1JuX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C1b+pawl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C7606A33C
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9C7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OTKp1JuX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C1b+pawl
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvZw9470744
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=; b=OTKp1JuXO6ngGHdb
	CxbYX1WhhHvfgBeGckmjHW90sgY/QNxRNnbYF0Lja0LmSz49rWN5E3mTHg+oRfgn
	ELF15Z+2RuqOucq6t+f3km/qRww5kKoY/Zasc0NV5oiIqebIQq7lullQ3e9QqgkN
	02NjhTCacHKhEGpj0i+Q7/za6qljNsHxOaH/O/RqYppQ1MD0iPVND04Gxsuulm/f
	n/ArG5EcKR7D7DBmYlu1/31X1JfIjJlCC7ym1gflyU1NssaSsT/h6YkRBRX6qwYO
	ewmwDyrqRzOUZAljTLZSpxAe568pfsGLksNeEe8xDu5UYZ2WlBcNbpLTGLy0Us59
	OhG8cA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q10ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:02:00 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988bcc2f50fso148992241.2
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793026919; x=1793631719; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
        b=C1b+pawlYZSTYVOtKjDMCRTQcczYdBBhKatc5qWcTDL/vnjVbM88ySsqbxRQshPXu/
         H+HGn3hTTwleB0FBWccvLlASz6QiM0mr64ITkgXPKybBzPAk1uV3fUi8/7cwhfSrBhtU
         6+shyV2s8fPLl55WKrKIPXGBLRV2bT6kP4VO2T8m/7OhYxzrmLaWg8Eb9jVreIWrPOwe
         K4sqI7BWdzhxpeAljA3WoJw3HHEvDbGa5dSov6UIGlvYpObOStiu13kaEKQFwTk5kLQc
         PPbwkcknftLAyUC3SYof7XuOFNlHkzN1dB5wbxK228bvcHsshKrlDzVyFtlAltgZiX+1
         6/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026919; x=1793631719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CD3Du/kC//dk/9ggBqhnp23Dvqb48YN55ouEt/7rfd8=;
        b=kXBROL5zCj+JwywymjaY5p++aEQeJBBBmE3eQ95WMOtH91OJExAp0llwc9TlhTXfEU
         HYIqUjg1bZc5zV1Kc/0hcVPWL1Pflhd1bfMFz4DWapU6jXJXIWwXhL320mc98ydkhHoL
         Jlp7/POPD7cabQq55shlcw954h5RyfsDVMEKWo7RgQE4JrclPxW2hjMur6uzxAoRGWjg
         5ppulvGZU/TGN7g8t2tYDc5IgUvjyZpXsa4F+0uvuLwk1E3yLwTVf/Fyzae4By5y5UvJ
         EzhkzL3mCj+rlm00Qzt1NataCZ+OJjD/WWzKEj8fptfBK+xMcYxeYXXrGITtv3SL46Zt
         g3Bg==
X-Forwarded-Encrypted: i=1; AKwUvByXOQB373IOBhjb46j0IH2D7EOZbrLHp39ajLU2yS0Rw05vdFfyZjIsuQbqDHQ8MeNfWuKNMg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtEJp4iTAkaHCf/3kkJNtIgTERxM1wxVe8SHqiUzxP3gmA0Rjq
	JtSPOQeolNhW7Yq/HctWghZlUYQjebZU+r4Vk4reXzl6Vrhr3xxScKTcMAeYNiWW9vyvbrkTGs+
	QwxQ25CwlWTfWagdyoXWMBjtXrT8e/s9IrLemTcmsLxyX/ncYcR8c+Ro9fw==
X-Gm-Gg: AYBFou1vftb/DrctuW6QJ/1xO7QEougnxz84RmLNBnJQfMdIiLZ3yqNYkX6DnW4Da5w
	7faCsx01Wr3aD5ipenX9W7wZhhcjEqIx0omo6bTpo4EigTMRzSbseAWl2qZnaB9/TV4rcXxrQqB
	gbZ5iQCXw/LBafTskzixA+ZAX5W0snRCywmeYvweNI47WwQcZIlnGhCKW0IbL+lN8QSQiIDGtvB
	3nHBmK3DIxeTvfHTXBY7DrSxUf+Pvx1cUYSrttRslfmwo3/Y9SQ9p8TkcuC6ZB7BnIhhgQaBhsW
	x6EntTNtr97A1telSzEgw7Om5o8qImgl9BxHGd16xa1vNhi7ym0uLeBqEIreVzqlhNzi0ainfNW
	zP271ZBB2EThjBnsgO4NSlA==
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ec2331473amr2105808e0c.5.1793026916350;
        Mon, 26 Oct 2026 08:01:56 -0700 (PDT)
X-Received: by 2002:a05:6122:6b8c:20b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ec2331473amr2105731e0c.5.1793026915612;
        Mon, 26 Oct 2026 08:01:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89cesm335488366b.13.2026.10.26.08.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:01:53 -0700 (PDT)
Message-ID: <cf9aa65d-5603-425e-b09e-0a5ae86fa551@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:01:49 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] arm64: dts: qcom: Add initial support for MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
 <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-5-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfX/rKOnROH25Kg
 DzoI8oKT1QCeYchI4qseH0on+byAQDnkxVnNO6viPmQ1X/J/GkiaDY3fl/aO4+aEGzPVF5xm4Ny
 lrUOBAPipOyUeUb4mcSwAmU4sAsNgNQ=
X-Proofpoint-ORIG-GUID: g39KsY366C2nTpcOkdo8FOh-QQF3CxO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1OSBTYWx0ZWRfXy1SdIzGw0Nw3
 QJ24HJ55yZxJQvVzFR7qBwoTbEe6j+WfI/vvZyFzzaPYETLzfs/VYLGsJ/OzBp3vDsacp/5U04s
 u5ZF/YHhNYxgsy64+jw0A00x/6X8G+KsH0Q6DEmquON2W7fQVaHCn79klZMXOjYnPoahG9/yjyX
 KdC8Z+Yu867/vtvm4ajar6NVHpxj1FzfE0JFtlbV6EUQSF8slugD/M141pyBEe/0T9K83lEE1OI
 xwk6HwSvMSf2Qc87OYmMWPHYtSsyIDvvdtxOIZ9mZSq72z7owXv8waxJ3Z9c+Vsmea7EWMQ20m5
 5FFQ1xf2U/D0Ms340hXkITTb3tMA9E+oakJEACMmGNi95Qj+VH2atmHnQig/4fvP0NjOP5sY09Y
 6jEwfolgD20fAEzYN5SiG8jpb75OZ0mvCwdbiSpF6Xn/Ap/aIZ0fM9ZuoMTkvjXCyiDFfObJtPe
 O4QVyylhmcH2gCiI8Ew==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf6b68 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=OuZLqq7tAAAA:8 a=FRBEkmYdsRQmicOyHakA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: g39KsY366C2nTpcOkdo8FOh-QQF3CxO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260059

On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
> 
> AI help is used for calculating qfprom nodes.
> 
> Downstream reference for port is [1] which is very lightly modified
> version of [2].

Generally this looks good, couple more comments

[...]

> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		ranges = <0 0 0 0xffffffff>;

this is equal to `ranges;`

[...]


> +		sdhc_1: mmc@7824900 {
> +			compatible = "qcom,msm8952-sdhci", "qcom,sdhci-msm-v4";
> +			reg = <0x07824900 0x500>, <0x07824000 0x800>, <0x7824e00 0x200>;
> +			reg-names = "hc", "core", "cqhci";

Please break up these into one-per-line (also for properties below)
the last reg entry needs a leading zero

(in general one-per-line is cool)

[...]


> +		usb: usb@78db000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078db000 0x200>,
> +			      <0x078db200 0x200>;
> +			interrupts-extended = <&mpm 58 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&mpm 49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface",
> +				      "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc GCC_USB_HS_BCR>;
> +			reset-names = "core";
> +			hnp-disable;
> +			srp-disable;
> +			adp-disable;
> +			ahb-burst-config = <0>;
> +			dr_mode = "otg";

dr_mode = otg is default - you can drop it

[...]

> +			pll_opp_table_c1: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-499200000 {
> +					opp-hz = /bits/ 64 <499200000>;
> +				};
> +
> +				opp-806400000 {
> +					opp-hz = /bits/ 64 <806400000>;
> +				};
> +
> +				opp-960000000 {
> +					opp-hz = /bits/ 64 <960000000>;
> +				};
> +
> +				opp-1094400000 {
> +					opp-hz = /bits/ 64 <1094400000>;
> +				};
> +
> +				opp-1344000000 {
> +					opp-hz = /bits/ 64 <1344000000>;
> +				};
> +
> +				opp-1440000000 {
> +					opp-hz = /bits/ 64 <1440000000>;
> +				};
> +
> +				opp-1516800000 {
> +					opp-hz = /bits/ 64 <1516800000>;
> +				};
> +
> +				opp-1651200000 {
> +					opp-hz = /bits/ 64 <1651200000>;
> +				};

Drop the last entry for the same reasons you explained

[...]


> +		a53pll_cci: clock@b1d0000 {
> +			compatible = "qcom,msm8939-a53pll";

This needs a 8952-specific compatible (bindings-only fallback
is fine)

> +			reg = <0x0b1d0000 0x40>;
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +			#clock-cells = <0>;
> +		};
> +
> +		apcs2: mailbox@b1d1000 {
> +			compatible = "qcom,msm8939-apcs-kpss-global", "syscon";

Likewise
> +			reg = <0x0b1d1000 0x1000>;
> +			clocks = <&a53pll_cci>,
> +				 <&gcc GPLL0_VOTE>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "pll",
> +				      "aux",
> +				      "ref";
> +			#clock-cells = <0>;
> +			#mbox-cells = <1>;
> +		};
> +
> +		adsp: remoteproc@c200000 {
> +			compatible = "qcom,msm8996-adsp-pil";

And likewise

also IMEM, DSI, RPMPD, RPMCC

[...]

> +	thermal-zones {
> +		aoss0-thermal {
> +			polling-delay-passive = <250>;

TSENS sensors are interrupt-driven so you don't need polling

AOSS is surely the wrong name - that hw didn't come until years
later than 8952 was released. I can't find a mapping of the
sensors for this SoC right now, so either drop these or give them
some generic names

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;

Drop this property, it's only needed for very broken FWs

Konrad
