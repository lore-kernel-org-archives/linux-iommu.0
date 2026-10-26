Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027086;
	b=QleSBPV0nNzWrWfrbW4947t7Vs9V3fl+clhoYieWZ/bn3AphuDreq04zgZR8KuxQaAYk
	 t7kqm/mgotkqzOQHihey2sFZqixEZrLcDurX7DxnwHkKybqMI4qjcNOTxB1BoAixqCh1v
	 L6I2VWfPyxIlN/dnMYdnaHm24TTDYLcW43mgm8iKNwID2yGfQZ4MB0drBB0rlQvTpFJwr
	 P6wSNpK2ajnMWc3HDgjGPUyX0i6LU7MqE30fRYiiizewxzoJu0VSaQwzbzzsWmZUauvXW
	 4bFj3cqa32Hv/YvZ3npEClFu30dDnnZ67lGYrWIDzwoiuOZHM/OSKx3q2q2HAtCsExg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
	b=PRCfCSKDBD1ffYYNFg3QPxcPHwGC6sMxfKoVqSFbegLhunXQyPYOlpbiRoep485LWzkp
	 caBW6Zz8Ie1weXb10/QF1YIne01TRbgRPFw9PFSv4QH9Tn/br7GAJNJ21EEfNc5KQxqTd
	 PB4ec8Lv0wyXmpAQNqNk03csbNK/fP9DHeTvbuaCVkvDvz69rUuahXxssm4irW3hLAvlq
	 IyKlwdVDlgGMX1DGkvQdFWxE+dOT2EHog6Xxc5Nh211pXSY96hFxhjbdpES78tXTfVkiV
	 Mf2f3SlOobBMu6Oc3vE0cvVRUQs8TGQmryMHdUQNVcT0oBM+V1Pp8WGz7W3R/1cI85w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kuhLLtYd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73199606A33D
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73199606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MQCM+Rmp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kuhLLtYd
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEw6MT3584354
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=; b=MQCM+Rmp+OZKHlj/
	ciKNByeD1VCOEeHm/cod6l/pyvN2YTQHAFlhorvZqwiKHrUqvJkCMMcy5+8NzsJe
	dMMeh21KUtXzbdhwyWnjSTWfoqDqaz+ua+npTwqYYVPbVaR4wcuIPmXxaV+Z0Soj
	7bvziDtshD6feN3rD3xS4cQSlN466v/4zq9C1aaPSG7sL5YezH66fQWFD4B1SgW2
	ANjibawOqc4WYIMXjujy6A1t0z72lzPVBkAtQJQnbGl+/fMMAOcyHF6r9cpgBhJE
	oDxNwtLwXz3Hw58HMTyQswM9SIaYHH9TunVE28H5F6B9VDmUJRw/Q2bHUg0ZM1dv
	zrVBdQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvddaqq0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 15:04:45 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-555eaa3ff0dso601491b6e.3
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793027084; x=1793631884; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=kuhLLtYdKvcj7FbMI4Ifx1OeqZud7p2Cc3FEq5K+JZCNkBUTn5WKYZ+bhOInjzcAWO
         /pn2dZUjmfkXQYEOJL3patFc012bEnGTeGQRLgSJKL6Dq0Xqs3SqoFZGrNlfEyV7ZG7H
         D3O2Vd+kpP63K7x6NOLcMubngDkb3mUFX6mBS5KSQRHKZXTMXaNvtDojEbs2O/Ze65Jj
         Pnb0snGkuuKd0EfrEcV7OS+/wzL8EQNFBuQ1QK5SFq4x4jRTSfeJKTtF3yzOpRWILOvS
         eZ5SJOyaoFUDMrm4SPL3Qz2CzPCY5sPMZLJJAe61RaJ8Xq7AioPeEdVrH3gJCqkDAuDM
         oPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027084; x=1793631884;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etnV3nBisIEN4CK2x4XO1LJb3qrvWzkEtTmrYybBqqo=;
        b=emH0RD9TCNxjnNTxtQoYk3wuyXfv/upUIVWD2GLXAs/m+CZeCKe5kT4v6R/M9opE3h
         G7CU+9vxj3ILtnadlENGFVMuiOgpec87+yw6cThbBesgoD0fUDsavFzBh40X1E8m0uqJ
         Iyl+dW09pUON86HF8hd0QPaiQJOj3Dj/06mhCnd9lMLdUlFcndzxdQGDfEIPmF4IxHpe
         ZtEKMWFJrqMUVeCEjSJ9A52EKciNZFj4lRAPU+LPqryzeVu2z0/oRlxrJi5EmbVstKRk
         v9z3C2I922TtIHR5E4MlgRzSN6VLcoT5YxJf+9/Yv5nRtvnxnmz82rn8uzq4wgeeFdlB
         I0Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwad6iyv0bZqhygSjG/+AhZRpCSZg15jJ94lK4bSJr9Un4PyPSmxJ7dOkMxb16LDNr9nZaqAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJWfwH6Ic5z0RwxeadoSjwTt5KZoH4gdFsfxO+eO5h8IydchQ0q
	kWtopnLvKMJpAkZMpiNqVBSBB/ahfgmrYpFFmVONs1tVHFU1p0j9dgvcloUnKh3jOWyFPTvitGs
	mWy7C9BVpNJySCJCwOLFSb8HtlRghSI2F5sjvBFwgX1BHMPIY8fodHucPvg==
X-Gm-Gg: AYBFou1b0KBZjpWM0CiJB35L51pUBQL8PkmW69eGm/8vMnPfEPvPeBfWhtGrsyesqyu
	IwOHvwMTM3ZlR+BAgByum2C58O7qoKhQWnJWyDWGHEuahsoaO4ez26a5dTPcYhjo8Je7Av2tzNz
	0Hmo9GXhPChyVQ5CwtSj/4HpVrxq1PxXk1b2WKt3jIdUaZt1yc22eWWeapkicTPmwRtwJKOtVSd
	Hc3MJ+OS7BHAoHsCn/YqKnvxDBSTJ65RPrCmgP61j0tlXxhie9QdtIqtq6H/TKdMQiVmdFPrkaG
	sEQiQdIFO/IwgfkH9CF7EpzNe83UmFzEEaelLnOQf6Z2z0TrIVEYKxrwyqW1RvSGqACFvEXx1Ha
	bUPKi+NttgHOtaSv67mgMag==
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808478b6e.0.1793027084564;
        Mon, 26 Oct 2026 08:04:44 -0700 (PDT)
X-Received: by 2002:a05:6808:30a6:b0:549:e9e3:9460 with SMTP id 5614622812f47-55bffd26cf3mr6808389b6e.0.1793027083999;
        Mon, 26 Oct 2026 08:04:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595e70asm3844350a12.9.2026.10.26.08.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:04:42 -0700 (PDT)
Message-ID: <2d4e66f6-7187-4642-9371-4385a46bbfed@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 16:04:38 +0100
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
Subject: Re: [PATCH v5 7/7] arm64: dts: qcom: generalmobile-shamrock: new
 device
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
 <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261011-msm8952-initial-support-v5-7-1857074992ec@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uzlSThnafQfHH9vmxqXElCBqLZeHHmJk
X-Proofpoint-GUID: uzlSThnafQfHH9vmxqXElCBqLZeHHmJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX8r2sjbGHZ3Mj
 IiCrNb82r9z1d1AH4FIM0sXPO5OKrIWJG4amNDZhqC05qIHijQ2H/LefSuqAm75oqjrXRTmXofp
 aKC+BMBmtnbmPKFwQAME1KmVIaB0ds5iDZXbRirZHFZLTGpv8ckBEubegA9xfX9CFpnt6XGfehz
 XcCAJHImrohbOz5MZvBm+56tNIoxnpXBQ4P0vu8Ostoq1kjawfAr8YJFI6zFPxbkW9gXhZxSGrb
 W/lae4wTvvhMyl1Yfmzg26PvO+fhUbnLOgHi4FbWZg7cyK/jzmTM1BdTNhdLlJ1uVbmdF917YVF
 tkDyVAethsx2QygbMEfeR2Z9hOPFzf4gaALZnhvpUdrVr+pT1fKsohahvjPeAPyUE+QIXUJhpnr
 RojRKgWNwvVXGnTE16ck823jSGw4EKn1GXYtnlarM6QrTSSdjL3kASIU89Byo42gWHW4EpjUXLJ
 WYbBf7KtsQJY1GUeqLw==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf6c0d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=CrGEZSrvnsKXYSFoqd0A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2MCBTYWx0ZWRfX4trBVOT2qqrU
 G/2HErRluptb/STDKn5qbU7aGMEskbftVv6cUckpm5u6JKMRejFznYXlxM9c/xSXKNacH5dXzuG
 3YVsow5f46EHmr+YSJ8IqOyC7cxmvD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260060

On 10/11/26 6:51 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

[...]

> +/ {
> +	model = "General Mobile GM 5 Plus";
> +	compatible = "generalmobile,shamrock", "qcom,msm8952";
> +	chassis-type = "handset";
> +	qcom,msm-id = <QCOM_ID_MSM8952 0x0>;
> +	qcom,board-id = <QCOM_BOARD_ID_QRD 1>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;

You need to enable this console if you want to use it (stdout-path
also points to it)

Konrad
