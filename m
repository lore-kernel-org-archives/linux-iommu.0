Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942172E8B8A
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944202; cv=none; b=lobj8dddkASHUvA8Q4ef2JTGOgCCurIE12/LliQ6mtvxuaFAvgi13zMdI4AvixVYMGaL2RmoeiNb4PeQgvsLbB9VSeYd3I0Rad6k+EJIkSCwk/VFcWRsWSWnBlpa3QASqoYqRMxBsp2cHnHAospcDOpfHIW0Z93hdgQln30XK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944202; c=relaxed/simple;
	bh=ycCYcFDws687lzPHf4a7ZDQa8w8dkehTffSeJoBHKeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqL32PrDNcA9UnOwZ3MWHhx06uYDymlYURd448OhZ2Zx5Uw49NT1i61Js8eo1Dh3bJL2wnFmiEfNzWbuKyLr1pfzA00K8U0xEAOg24tUdeipZUubbbpJoksA7ztSy3BzUSU2dW6GIAK0ppGCwOJNKtZsVgJjSWbjwDPPE2hjoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgZfOxAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzL2YL1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgZfOxAj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzL2YL1K"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8u2qp366204
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 11:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4IVUQBFdsEG3fN5g34uqrFUD35jsuqyNZ/138Z4VVw=; b=ZgZfOxAjPxVx5KBz
	M4gXrD1z8OdjWaxuRMaot0/RjOdVU1RYD/dM1HTr//hRHN+xF3/na5P2y6mrg90e
	YwgldGzrmoeJgyfeEEzINXBV/Z20joUkbIBPMq66Y2vw30egfAKkzKnBTumdOjdy
	vd8ecnk/zxAHGM4aL9YtFLmwLQlY0KcEvqiw4rLF38LnKidn1MdjsJAu7pXTo+mG
	KPQ/c1VPaiGvpw7IlBi0ejPtjBKDVOqawKr28ODDmB2pJwXA+sn0DJUF3kDm0R15
	nwEob8lA+70+zFhOFMqpo9Z2JmrBx/FsE9wYYOGIg2mD1y/0HESSSRc7U3tELC/u
	zNkHPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rb7nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 11:36:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eab57f0e8bso95612985a.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776944199; x=1777548999; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4IVUQBFdsEG3fN5g34uqrFUD35jsuqyNZ/138Z4VVw=;
        b=TzL2YL1KhOAk0067HOB8qiehzVFloWo/sEq27/OzGO/LZX4/A4QVMAdE+ZGA2aa70n
         Sm3vkCdQe896P2yeqHQH24zVazKHXcA3yzjlc4eQMpaGHzg58bF25eVOAn1Q/oQXho77
         4sP1BsbLbLjadfGZ3DZ5fikpxFj6pkccxQIyJLNyz65kV8NvEkXxQxZ2lcpLJM2YDuQx
         2XmDwMV02Sr/WxOkN+U8Qv4Kz7T8As2AiU2O10qCSIlbTTsuJCXbnw+JNpTuWYGvT9O4
         WRIVAMwDiy4TqCkbJ03RdKYYQnpd5ZEke4wqG9+g+anGSLL7Pf9N3S4B4t857IBoN97W
         S5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776944199; x=1777548999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4IVUQBFdsEG3fN5g34uqrFUD35jsuqyNZ/138Z4VVw=;
        b=YnhfdRqyXdsBeeslWp5EXDIuVDwM/L3/UBhjUtkKo5CImGQMZO/ITnAJAPfHqCG1NS
         d2tiXGLmCIFXvxmt758kfYgJUyfjiHBmPK/rECLw5YwmNlaMQBc/3EDbG8ttIx0SFkjR
         jWL2fch2Efxq2fdqc3pEL6aOOYicU3M669iVpEdOam+A5bjytc19IVHQf6B6HaU8CmwO
         qmsTFqwbpmpFkd5LZk9JIr4R0Ay6zJFpbocHIP0zmMEeHiQ8QtWtIQPlBAnoHmsQ32Jr
         iB7XTCCMHWTygW+pM8yduXPBM74ZwLFz86uPnYy5gatYZF8zsWf310/vTpdSGRERgGhL
         DbKw==
X-Forwarded-Encrypted: i=1; AFNElJ90WKX1JAeIXnqu478vTIeQkvWTHgDyglp50gKl6NJqdeEdCPMQ3Nqq0avdtCTLbVHjMpVY/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDpxwcv7FYeSuxrGyplu853yOfknEOjnQ6HnRe2yCLcRxZ31yh
	FOcd03eyjYdw4nqMnXirgVzLrp5TJbHWwUMToY4Kigkaar+M6kQWVuVGVECG0MEI3/rBYPFmwbs
	SvjgZtumXzQshxMekCMkH1lWqVTgxq7CYCQkBNzwOGSp3Y4RTHj66467liQ==
X-Gm-Gg: AeBDietQCpXmPXJkDhx+f6XSlKD2+ijOU4hZAGBO4WT3v+evx34d8xExce6WqctCNlS
	SzVWal/PRBn1KaCRoZRSmSD38QQK80E81gvTg5AxVwU3+1knYSWXyp8e/+UH1WX9HAHELBW/v1g
	klWXm9tAaomptbiWXVHJT6MVWnF6M9VELlGPefvWwSOLB+8q9eXm5EGZoGjcmeMOzFld8IoG1bV
	bHQhEKGafDMa1g2pysEZBNU5uwF4qCC0Hqe6TfVTfwID5q4T+pMmjIRsCzmZwfSmDyhuKO+TClS
	D2C8Ordu4ZVWGxF3ls3x/BZZ7dA9l+75UpvQjN781eVM+h64I0ATNd5yeaBevc4nMEs+YQ/US7F
	1IVWl3653LUpqKbKMdyEkA5QKrFwa6OYOTTl2g4bIlaAKsfMKI1uzVxfILPOlJnHveqro01nQeO
	R1Jm2V5+EtfI0n2w==
X-Received: by 2002:ac8:5d53:0:b0:50f:b9a6:82ae with SMTP id d75a77b69052e-50fb9a68ec7mr100777381cf.2.1776944198957;
        Thu, 23 Apr 2026 04:36:38 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:50f:b9a6:82ae with SMTP id d75a77b69052e-50fb9a68ec7mr100776841cf.2.1776944198503;
        Thu, 23 Apr 2026 04:36:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455533bdfsm648444466b.57.2026.04.23.04.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:36:37 -0700 (PDT)
Message-ID: <ce26e0f7-a07f-4e17-a790-fd4f230c7e90@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 13:36:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
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
        iommu@lists.linux.dev
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-8-bcb0857724de@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260421-mainline-send-v1-sending-v1-8-bcb0857724de@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDExNSBTYWx0ZWRfX5Tp6+3S2N2Kt
 /jY72G154IWuD6JYbbYKrpVQIzGdTKGPjpDHaTISTit4euK7JAitndsgXZYygZMJukEXxolGucm
 Ga7oqTPX+7Q6SpI/mdgKrmT4trFrKtgOEwBWthz4kOG7egzAEVqkuCJBBM01s1ltHtN4uxzV6Y3
 SDT59GnaRcL3haBSfFqEZK5GfX3NlkI4xJuFfixlmiGTlrvInQn1mIjWG3oR1pozxtMXH68mkLK
 lhwq3KjyTL905xnX6VoFXn6uJDnPxXDiuLF5xVjHL6Nja11a2DTg8uuubZGLoVimLueTgI+h55g
 16I0wywtshdEtd5CaP7zal2vBmPWB7AUFvoD9lJA8EsQHvAKJbKSdxj1OxI36x9lum1fHR1mqsE
 fuvClWHTGAcw3jwWv5JUKxDmwLgWioEMdQyUqlubDfjRoiDrOIqLonVnB98Bc8bRU1AjHe8+9Mc
 wtttRfdyzjHIOyeg52A==
X-Proofpoint-ORIG-GUID: 122aCJrkwR5lqNFSVsdtRfBxT1jHtKu9
X-Proofpoint-GUID: 122aCJrkwR5lqNFSVsdtRfBxT1jHtKu9
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69ea0447 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7luhnmdphBsOXQ2kz_0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230115

On 4/21/26 11:45 AM, Alexandre MINETTE via B4 Relay wrote:
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

[...]

> +	i2c-muic {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm_pinmux 22 GPIO_ACTIVE_HIGH>;
> +		scl-gpios = <&tlmm_pinmux 23 GPIO_ACTIVE_HIGH>;

Is this not GSBI2?

[...]

> +	i2c-led {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm_pinmux 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm_pinmux 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

Likewise, GSBI3

[...]

> +&riva {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&riva_wlan_pin_a>, <&riva_bt_pin_a>, <&riva_fm_pin_a>;

pinctrl-n
pinctrl-names

in this order please, file-wide

[...]

> +&usb1 {
> +	dr_mode = "otg";
> +	extcon = <&muic>, <&usb_id>;
> +	status = "okay";

Nit: please keep a \n before status

looks fairly good otherwise

Konrad
