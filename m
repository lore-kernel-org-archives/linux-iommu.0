Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623377;
	b=RVAbI88aEnLOeLgb122ZsCTpZfjRJJ715Yz289M3+k77y0cMnrkHTI1+dtOZcEWd/JOO
	 1MIVuTRN69va2JqUm5nffQf2BXZ2rfDX/2UNRbgxKj2QI/JJaPrzOt2U/C6lBR8TZbdS+
	 WWLkieziFDsml8PSG3ARR4+VwV7bak9T4MlzLgPZs65UfjIkibX0AyGn0BA7ghXV532rI
	 hQuKdB41RGqOHhY/ViYhwJhwJanvpbYtjA3+EqNKx22u+PNOQ8bFa8zxVi8SNk50M+PSs
	 rSjPYqZgiuurh+w4zKXnbeaRWhBXzk/pGrejKRWvTTxoOhfzFSCNPP/oHrRq0jZ5B9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
	b=jIjciMasvJf9r0FSWgvdIdnqXHJ7uY5X+IvuXMdjWQWNOQiDu7qUf98/FTBQqXQGkrb1
	 j98IEweL3TbGkOzpaMhMk2SA8W150WJkiqE3rGP62efRlKs+ghosyKbBgG1p5wcy+aJp+
	 PzztZrGwtpe4Q+wkFmtbxRdNH1TXYExtIRvK4rAxYWcqkS8FzL41AS7Wm9/uaHJn7XfSX
	 mRViocLeuVkcuz7R0lnuWnalqYVW/UiFnxdTsavJRnH4XlAXu5W9d6vIwLlSuSbLDTA2r
	 kd0/HE5FeONGfjAH59z4QN4jFmWghrNd6wSQD3Wl1rCaqTTQ0vNwmFg8YfH5M53C4dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XdKOXmy2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D9606A327
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404D9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=imzn9mgE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XdKOXmy2
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2BZ1fK3763140
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=; b=imzn9mgE7jpQF7UJ
	l5NhN9P2tCVnLxb4TdTBR2FOSNJYdj8wTOT26//AF1GPF5PuPIQFSP5ViGDCvCa2
	4mmGrgG3D6wFmc0KCDipUueSrm3NRhQkBzh3GoNpLwmwC9BYu7cq7Ua57vaYcUdl
	7YgM3f7Fj1J108Q1ZgoO2WvAuWPIwY2sapviVFR5lXCi3+SLKGXIo/izg2gXY3oL
	7iTbK1ENuliAtSaY73WLoFYMb56uptzP5XHbepiephZGbLxaLYsO/JhzEU4QKGII
	YlJK7qieMGwQeYo3B/Q8gJ8RC+Ywd4G10lvOIH5zpCYXkTkGoH1cH/FMvobYmo0l
	TdgZ3g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpss5g807-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 12:42:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c7fe5576bso20579376d6.2
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623365; x=1794228165; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=XdKOXmy2Fbw4rc4z5RululOJtVilgoLddFAQCG8h5GWGompLl6lNjLkHZxiIvStu75
         ef0zHN5aT+J/8BZWuRZaT8G075B7KN5BQg0q5FsND0jrVe4WE1ZySxycUXhmkUqlHx+a
         QupCbhfE42SEmf3XwFVoQ3sKDIK/WM7Canxz3rwPaxua4vvM3i3gMx27BZcixgCv7tYP
         oA+U6qTcCQp5QoZEyHGj3e6fVriMQkJeNVk4yybYutW0Ixbf/Pvqv5xzhPXjPtCawHAg
         sgtWz3daD8TjldMF7d36q+cEpC+nK7tBharm9zrrdT6D+VgKcK+K2tojSmJCSnN+vZqS
         b+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623365; x=1794228165;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfJHL+LnVRB1R76oNOPPOaL+uw2rvGjVXvhT2Xe2FZo=;
        b=ITybLg3B+BCIGraf7gGsP4NCftqYMDi51P9RUDiebjWrhDdqBBPyjWfGyGkCs0uF5w
         CnwwUitwV0rVNRuWJ08lLFphM1LHeah1rmuj55VRXA+QpvbHXHSWYmnL8Ejo/4XIg/J0
         Hkq1WI/+wzEzawHoJwG5kwB4MHI4UqKH+BKyleoQfIroF0BL3ySfMlT3xEXxKf5l+nh8
         pSuHBvQIXwFVUn/8AahHjRsl9M3O9tvDcocGMQ8MrfJl8/hHy8FKfbrwewozYxi7SPSd
         wUWlQUmDjBzb3H/VcTV6S6rE7lXgG6g8WHH02PEVHuzq2tWrqXcRAqSPoTQn/0Dlys2F
         VvmA==
X-Forwarded-Encrypted: i=1; AKwUvBxMnaMH0xHcyo8ovImxoJl5GDmKVN3Z49+RHJ9DEJrd5YwuLoCBd9/Rzf9muYMawA1iDESftQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzdNygjE4SyUrkm7t9tWswHlGnCuzpSEDAbX4Z5Q0N7oYc6s2R
	9K3BVklTfZBICzwYMR447EwHSywVuc7b8m4T3pY5W4aMX07YHrJUVzjNLlCnupZhWk1ZVmYxWv9
	M0nUPWB1qZ+dGYt9c6Le6fN4nx+twAdvD390XnAAvLzf2AD6XxKRcKDPGkg==
X-Gm-Gg: AYBFou1kTb3NN+pGByu/fk3srwqnuxDn8Tn45GHIhoyuSkg9FKNzMsf51f+CSG9/6Vh
	JjMWHGEMUDQfJzZ/vo535BLu21Jcn48YVWQujle/ikiUjM7FBUxptt2Irw4TnjPwEDVbP9n+nKC
	bwio7BeZXQuig79VaPbs2niLWEC84R9t25qJ5+kyOq+ohVRfLn/FuDTeGss054pnPzcSx6oS5OA
	0kBTlPh4nKL3MWLA42mB0vu5tY+s8lz29Ah6n2Ybh1XIPjIqgSnaAkcPwwr9uW1CfDiyIvgpzLV
	rw3SQheREIt3mDC4bNW1osEdB2E8z+tNOGSxJQ42Qih+jn1w5+W4EsfYaUWMXSR1p21wInhysyw
	UN71L6vs3s/HQNrpAvnCSvRb3MObocjQBy0TZoF/O+88D4JaPz81AqNCWQEia+4TmUz973HE=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608068885a.2.1793623365448;
        Mon, 02 Nov 2026 04:42:45 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1608063585a.2.1793623364967;
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18e78sm399183066b.9.2026.11.02.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:42:44 -0800 (PST)
Message-ID: <99023059-0d9f-4ad4-a861-299006ae32a3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:42:40 +0100
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
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for
 MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar
 <jassisinghbrar@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
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
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VORIDNPX c=1 sm=1 tr=0 ts=6ae88546 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=OuZLqq7tAAAA:8 a=pjH4mUHWGEoP9p1cUU8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: EcdOOmMZTRcv-jPZlM11ijKi6F_TSxMv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX0q4/p+pBacrY
 GO/2Nr4FmlIlB9DdcqU7XSyCH+qsu4Z2Bx+4eno/bMl9RmazhsMY6qT7hdCkNA98CYxNSyHQ7v+
 9ZaivXZMCGrlje5VA3onQRFgv3y+Z9L7MkMSyCq7r0VTC+UE88TKT59VapAQf7i5UmRIdaJm539
 F1AlVJIj1Iafij1+AMegDMOPNtfXWpsqicAInINilOAN4iW80dhoAoJC64v8vUYzyj7MVbCsTJh
 VHj0+4yumx5w1b76BX+xIuuoMKjIFtIo3Q5dbl8ws6dEPQ69h1LVYlJ8X75elFcDOSI0uq7v2SV
 4u2hHnEBW8VmyF+dymFcPYBaf91qfzUAq9q4Rw3YFiSRInbI/XfsI5hoMyewaea4YfnPcHtIsBi
 gU/eiCs6Rp5RTUOy80L+mM+eAKGzgCfiNTkdVNoeEl05al+7zO5lFvbvyZ4cyQ1v1qshH1ZEK6u
 iGAKUiZk6GvTMlzDmHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX0YHkbwH3ScPp
 942tKxzyrhIz/JY61bXuQlPaXCaKfEygwbOO1bpW3//9+0tiqfzDtFisEQQaOiXpA7K2ZZHs67t
 JVqNEQhC33pzaHoCoQq65t7Cv0wdgYo=
X-Proofpoint-GUID: EcdOOmMZTRcv-jPZlM11ijKi6F_TSxMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.
[...]

> +		mpm: interrupt-controller {
> +			compatible = "qcom,mpm";
> +
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +
> +			mboxes = <&apcs1 1>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#power-domain-cells = <0>;
> +			interrupt-parent = <&intc>;
> +			qcom,rpm-msg-ram = <&apss_mpm>;
> +			qcom,mpm-pin-count = <64>;
> +			qcom,mpm-pin-map = <2 184>, /* TSENS UPLOW */
> +					   <49 140>, /* USB ASYNC */

USB DP> +					   <53 72>, /* MDSS */
> +					   <58 134>, /* USB */

USB DM

> +					   <62 190>; /* SPMI */



Konrad
