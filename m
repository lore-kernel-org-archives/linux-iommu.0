Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8043D47AB
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366635; cv=none; b=M+7gDCRtEUipYhEs0uiMZ8HQPqdbWyPrRMEIfWyz3QU0XLMbjhgby7W0Eiy9hT8AX+BGa0koZCjgb621zOC5Ej1FVDt/QsxTj3EVd8dvJuJDpI7Z/99LxJuYpDA5SoISknUPmdK++NVaJyIDL1yPPKsPq+8i+l8Yh9nF4yjimhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366635; c=relaxed/simple;
	bh=6/kXOpIPrMyYeAZQVyerbvyBh4ZULLVmilh78gfeyXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8dVAOXYchuzm4My6sIEdnt36Sio6bUoWcmcVvWaaTQ6cuJ3JVQKsKn0oTnxSy/cp8K0PSqLYOvlZOTKWWH4+WAzfKTnL/NEx6CNZBoGbll2a/v4Twowmt7aKJrQsPfDZAdoPiKoahJbPBGI4B98wgxGtzZ6kvc6FKo2d5lrCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SnbT/UeZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RNfPz+tf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SnbT/UeZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RNfPz+tf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5lWmv1625526
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZrIv032C0RLaUKbrdVzoDDiJxw7RgWufz1Fjh7XtFuQ=; b=SnbT/UeZ9SYbGdo4
	0WzyD5jTFOmk3wtQ71JvXsSaDGkEc0WhrOO4rBTVFrbs2Yl7ChxzVnYs27d8rjla
	2TjFrPGnn5N1LoADoXEuDPOtk+9uipRVs+3UW00ztwBfY2kPIHgkz29//pU8JcQZ
	MXkwcdp+jr0K5CJWJcK6ujQRx3eIOb+2z+CSNHsgX/U+J48VsApo/HMylPnJC0G/
	AnbW5wQlEMYHWK6c2Mg2AtJrbCkMbaEPQyAI4UyBFqP7AxfpmUp52HhvcIVkr0rd
	SZg4gEsCY78pPaBtnklnmMkvBfuUcDmIxPHoWFIFPIRoKwcwB8fzQRgV6KJR6S/k
	xpV12A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsa3rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:57:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8954b9b5da7so27708336d6.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777366632; x=1777971432; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrIv032C0RLaUKbrdVzoDDiJxw7RgWufz1Fjh7XtFuQ=;
        b=RNfPz+tfP/ye1GbUIu2VsTEhzg38FRgFyVau+s3YUFKT+5lJysq4eXqZbdfrtE+ilp
         QARDk4HNiuNWVaQRLCIRA5yNDizNW+PAbYhACO72z6Q4SZJs3V5ufc0L17FhsdXzqyP7
         K2gSSZEC3LqziFl0EdQZ9D4QVLsRq3RMQJzZRVhVNWFEcH0foHxwhmn8uXUHD166gyUX
         fqkHu0C+/djL3IxIWAII+oq9T+O/cgJDPzjIPJPl96SyOekMB7gVzyjrFmrci+tuy5f8
         jzA0l8GJ92oX7+GBw5G934QBTo/ND3B6zSYusSxXWBpCBOy7ww2ytdE/I3r9nhM6iey3
         psOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366632; x=1777971432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrIv032C0RLaUKbrdVzoDDiJxw7RgWufz1Fjh7XtFuQ=;
        b=LIW89rDH2QUGzSf4TwrV8OyQAnAh/MJEVCtpACYj/+d2zUeMt5N61vMB8L0q6Bf9sM
         lAr+9rX1+jnGLsf6DRIYG8vNWr29FnQh3psd3wDGpW5mamGrE4MM/NgAsxHbcOV46PpZ
         evZ6URZQ3d8Eoh0UJ6IPxU2mTyXPlor10RPkq/T0MpkIe23cu+pW477QG8YDMrQ41Hlt
         bBxqO8zX4xiveCRcxPt1fs13ZiMDnUM+1T+KcXCUnE5zTnfbtcuMXeri3dHW9JD682wD
         soLzg2Mx9nnbvR6wSoCcMNF83A8Ij71EB9gGOl1Lbaz3F739dtkLkfcWhO3L93biNhX9
         GG1Q==
X-Forwarded-Encrypted: i=1; AFNElJ83qfTHZhB59fXS9pfbjCfwjDWWPk/KCsq53+WD479+OdiLvnDgGFQjXPHCHp2P4+E3Z3P17Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIENYFuG5WeMANGnlWd3hCNrIlApvX9Aw9jZ1B1L5BBarWUTzo
	r8MrOfnrY4kgfHWLL4mAfHSaj9r7HktjrtIt2MWg/kZtFr+JrHtbXivkSXQXPCz4XIEo3ao8y9n
	5Jg5jpCpGR9YbTM7c0gJDRhvPiKhdyMdTICXVYi7p0m8DdjBdRnI9+M1biw==
X-Gm-Gg: AeBDieup36q1slF2of9s5Y+LXPvAhzZObvpmClXzkAYiXb9syL23hMItPg1G1+D5nuq
	TYuO9+dqi9VVz9bzzYV2tmJJxaRjP1zZexCaSXJxz6cZeNBwqtKwQdDoplpPeAi+Co3WNYJ7pqR
	elv6GwhVSk4ui+WAXEC2grnoEIywfOY3Eq2G2Kwq8WTsvYLHnJuelV2k6ZfApwJb0TcvcBHowpV
	BlJJ8G/fGSkWAEcqlAMhK8R1cIpwsgohTkpTLz6VYt7ILEjdohfrM2witmEZ28DyZXrUttqc4BP
	LIb3JbJjKMoOT9gHitxAWkGvtK5U19Ak5QkPlLMHNAMA0/ZN+6r/+Z8UTgRsVcFHl3r19Rkq1uB
	HkH34dihqwPoRSo8iz0ALZCaNNMUJezoy3Vk00ApRT9U5pk2pJWhd1GbUK6BVgfh/W9Wh08LluO
	C/gbC9tg+yioLaKA==
X-Received: by 2002:a05:6214:629:b0:89a:4741:2147 with SMTP id 6a1803df08f44-8b3e2a0dfa3mr27568956d6.8.1777366632281;
        Tue, 28 Apr 2026 01:57:12 -0700 (PDT)
X-Received: by 2002:a05:6214:629:b0:89a:4741:2147 with SMTP id 6a1803df08f44-8b3e2a0dfa3mr27568606d6.8.1777366631761;
        Tue, 28 Apr 2026 01:57:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a35e19sm70631966b.16.2026.04.28.01.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:57:10 -0700 (PDT)
Message-ID: <97969bf9-8eb2-4498-90bd-9973fb2bd638@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:57:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
To: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-8-dcaa9178007b@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-mainline-send-v1-sending-v2-8-dcaa9178007b@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gNGGk2NBw3fuXabDcwDU3iofB6GIZDpT
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f07669 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=J1_VKfl4AAOAIIosoXcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MCBTYWx0ZWRfX+ltWCPlWrhbJ
 6X1oqenJ6YuNFVmxPgMY5qF+5OsJzPJfepkgCt0I00x2OD0qaqQoKRS/8jDauKxb+HOd5NMSJ7l
 CDtMQAncTFln/fZHvWIqeLpirYPunZB1ZkFVWA1ROki9hWOLpX7C3Fz8QnNc+HDPhO3JqpcZfoD
 B3adPE3S3TzdGdb+47ykZsVqN3V6aMohz4yM3+qYn/Zm220VxzoCCJDRwzkJXc5JfWsKxuGaBmT
 093/7Ghw8x5DyKCc1RndwTrz56hJ4xYS9OUnenoMkZGhdlKgN6iAtyXql1KQq3OZ18lmypPlowo
 RjuW3B9f5LTJmcgv8jCVaoN+PE1RQzdxRzLQe+Fuge/g2Lpf0xdwTB5smHZDvfOFWWhpUSVLZyJ
 UZtKEVmtFOTgtf5bfU9U9I9WT+H81MnkTlR0sh7LCU+cCdN1Lp0QDiPk4W1nH28kgyR553h49aB
 wGqny++6Uk9qsd7luWA==
X-Proofpoint-ORIG-GUID: gNGGk2NBw3fuXabDcwDU3iofB6GIZDpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280080

On 4/27/26 9:34 PM, Alexandre MINETTE via B4 Relay wrote:
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
>  .../boot/dts/qcom/qcom-apq8064-samsung-jflte.dts   | 485 +++++++++++++++++++++
>  2 files changed, 486 insertions(+)
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

'l'g < 's'amsung

[...]

> +	i2c-led {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm_pinmux 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm_pinmux 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

Have you tried setting up the I2C-GPIO busses as GSBI devices, like
I think I suggested the last time? This will potentially bring power
and latency benefits, since there's an actual bus controller
connected to these pins

Konrad
