Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420813E9F7D
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282829; cv=none; b=JOpAYEvboyPeP/dSY1i/afYeEx4rzQ65t1V0M+X3ToCC8KARoW3lXkCFrBODKvuRsYx+Xxq4nHkpGUZqPXra1poZXrduxETVQs0CH4eZnYLUfiTPkyPhYt/O24bScRmJr0tk0N4+1wKOiHrshrN6Ojw/But8i8FOhGDwAO7ALDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282829; c=relaxed/simple;
	bh=k66LPfKQ3cSpYtH1fqSpFHQnHK2RdIrkDszF1Co0Lh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDC7CqEc3rsZe0h0puDDFa85jldGomJhuVvSnHquf0okKzwx4VuayVxu2prlShXTiCrn/1G4iz2IsrAQWe3VprRyUw6OQnQoXdQFGa3NdIITU4Ke0iNwnzuSbw6z6Yh4TGmoXhPWPb5WxYTUqaljnjfQqugRVTfik7iJokoE8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1953pEP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMJ2O5f0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1953pEP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMJ2O5f0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cPZa1018920
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=; b=Q1953pEPD+/NGkVz
	ZccmSzyzr3NZxcAqr0OQHwGLh/pGmI4J/FZNOG4xpD2KI/TX/mD2UNjm4+T7S5Al
	L36Weu7MzZdrr8LOgN7Uv+Q/+LY5FPTfP+VY0HtwHBnPZlgyE1vZvuVvd7v6BMXK
	z2qLw7DL7Zd9zwZs7qYME601IWtkti2A2+RNuN2A2oOqjyljuvKsRgjQd2tWJh1k
	SVrrqPp1CotqPLOCRmeHRc6/LN13sIEFBncHOV1z+oxGTgwrVKicR+qMVL3IlGAS
	le5EVRjsTY6kSFbd2ycgBTtrDLXkxvZPtT3URSOyqc3GjmDk4PV67aDaNg+2ncEX
	jxzNhg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff810tby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 10:07:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5110c89eso188676585a.3
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784282825; x=1784887625; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=;
        b=NMJ2O5f0/yTey3Y1iA6IZgSwcxEe4NGHfbFn+2FZ7Jf/KjgGKeDEgS5Uw7fmk7iI1H
         4kFyqueZDRbH+vUGWCkwN7xr2MOxL80RuybS9Uwd8qVKLPly9J94GutAzT205ycEvJ/n
         VUQH5/d/9zX3xa5/G6dbpdF0Og0r9iX467CweMcQ3mLPsUjXRu7GzG8Poy0N93vJx5LT
         q/bnQibxWok1Mb3zFnaRiM2JyELtsustQ8OLxyH1boyqHBylhrAp73+dAxkkJL0aoqH7
         +e3k7lXFuqdTZ2KhxNrUxSKIka6FmBZrZWJK7TSNnnOZOyLJb0rYgljYj5HComx70gbo
         P+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784282825; x=1784887625;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6katBA3YYMgPj3qSfM8s5QF3Giyse2MBZ1kakUqCeyY=;
        b=TMffNykE2+AFBGSp9UTbalPIf7SoYhshvuvvM5pCgjXYeRj6s+ZAJgxsRfO0U3WUoW
         tuEjNNhUr8t9+f2b84tut/ay5HHy9fN7IEEDVAo+d+IETgQUgUiV9sXQEstXadgzKx86
         dHR/4tWHx80sIBsOXQdeawHbNnbBWkN5nmXVAE3RhP9QFxoi8zndwSsHAIscji6BkfNc
         IV3PxEo+WHy8CdYXgMzCtqEH1ESxLlu5BcbHWRj34Xc2X8N/y161s0NN7L4M67rhUiFx
         LSkpSGy2Ljuqs4q8NwaafrT1T0krLLewsfhzwNqMw3Q/OS5sDNAPWruirGqwiAC2OE9q
         vuMw==
X-Forwarded-Encrypted: i=1; AHgh+RokhmyHTkPb97Brftx1Sgo/XtDW3GgVz+ktN2QNC6GqYlPJhT2C/gFQD2Rp9fBq0RZVyOAv6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy3eSwhFRQKoCBY7ruazRifWMkTrN4echlUbFS0gPT+6f3T3zh
	UsGM9isauUpR7qucDD6NPn1KzCP5V16CMpp+UzXLh0+cm0lk2RndSwZr8/t89+A+rDtPMyJ7Ipf
	qnje7sCATweTBwVTeI8GtaV2J0me4nFoojbEaF97qLgT1MMdn5PItCztiZQ==
X-Gm-Gg: AfdE7clOne2/L/56oz8y58Uc1p959WZQD3gw7/s60Dn0Up541qKxOf1aKLT95zVIn+O
	7b7OwWVVurTKnqxWK0zvoT10IgzWNijTKmuuYENSyeMdhdfVRrCNwg4jrM/vGmRfDE4i85lcfeF
	XBpDiRg+H4KK/Ve67c0Y/pCAvsSRKFVKQ6JLtYYPjbIAgLADjHuAiM8uVNeeYOd9k8lADmxzFtt
	cQWTC91jQ/XT3B1FiWz3kJjVh1C5eRjXWb1pbS39ZQkSc6r3F2CP+vR1c8P1r8FaSqbJ4xVahQg
	QNXs9+Ksuic0h4/G9w12dHyjbXmZeLsTxv8Nq5EkX5QlY8M/U3cDDlszMXqHSMz72WntTOreZJp
	8669foAdAoYwhW5Z9Q2T68dLK
X-Received: by 2002:a05:620a:ab08:b0:92b:7420:bd58 with SMTP id af79cd13be357-930b3cdf523mr129229485a.0.1784282825232;
        Fri, 17 Jul 2026 03:07:05 -0700 (PDT)
X-Received: by 2002:a05:620a:ab08:b0:92b:7420:bd58 with SMTP id af79cd13be357-930b3cdf523mr129227785a.0.1784282824741;
        Fri, 17 Jul 2026 03:07:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705a09a4fsm51391466b.18.2026.07.17.03.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:07:03 -0700 (PDT)
Message-ID: <6d12cbb6-23de-4e41-b449-9d9b6cbab342@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:06:59 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
 <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
 <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RbqgzVtv c=1 sm=1 tr=0 ts=6a59fec9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=J1ZTZr7FdFypxrWY4IMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2iGohWw6QFjBpAKFpoAalKYbllyZ3iFd
X-Proofpoint-ORIG-GUID: 2iGohWw6QFjBpAKFpoAalKYbllyZ3iFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX+//cWwERdw5D
 XRHwlFaMDMko/SzKK8+xxiSZc6TCgdVG3R7mtqwWij7X/8Oj6FvVKTSZtj2fmPAbKUyv+gJ/2Km
 z+h/pH698OgKUSiDA3hEnfLg+EdAwnHL433/E6wVQd/yzQOcChCMwFgRLBFsL1SPKnKOJAFDBXK
 jMap15cG4p6JMOD99f4QKF71qDX1uYq1UzHRbKqr6Yg9aGxSLSblMn2H2Qdok6Ix3Vyp1ObQ7aq
 kCqy2Mm+LblUBLp/JEZ/avtUDcT9iSIAPcVznGeRTg7vMdIFypeyRMu4Jgb5T3+YvV3kKHKjad8
 6UfCkb5HYOntGNPG7D4AdBtxm0J3H1gW3UUkz64mF4K8lPABGTjwuDSfmiOMVky6WY/93tNL+NK
 y3nk7lUNhRtb+R0bd1bktshlMzgTyNB5PNNdu7VC1B/a/Uh2brZlh5YqWfPDS9/tJYYtYjyTvwv
 +KCg3gPcEiTf5t+wbJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX4JeCwP8CIhA5
 VjopFoJ8ZQOqohZtrRUuLap8gtWKTC3T2rKiFUPWmgd5W2ujTsDF7K4+lKZLOXSoJVC8eYIJ61J
 s5J0X3fqSVJ6GQFIbrLGH53Q0bJxWQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170100

On 7/13/26 9:50 PM, Akhil P Oommen wrote:
> On 7/7/2026 3:53 AM, Dmitry Baryshkov wrote:
>> On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
>>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>>
>>> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
>>> shader firmware path.
>>>
>>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> index 1374afd9d14e..b280d8e845b1 100644
>>> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>>> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>>>  	};
>>>  };
>>>  
>>> +&gpu {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&gpu_zap_shader {
>>> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
>>
>> Should it be gen71700_zap.mbn?
> 
> Downstream uses gen70e00_zap.mbn as this fw is shared between Eliza and
> another GPU. But, for upstream we can rename it. In linux-firmware, I
> will keep gen71700_zap.mbn as a symlink to gen70e00_zap.mbn.

Let's use the name you proposed. I mistook it for the GMU fw, which is
named differently.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


