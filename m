Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F43F86E1
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722822; cv=none; b=bvch4OWy00KPITM8y4hrj0PXsSN/HFC3Z7YWELiPeMusOKJuiTU/F0un+RZ/YIjUG/PeBTZk2XPN4O5I14l3C1/b9RRPT6bu/xetSRW89mLafWf9dWzVroUBErJRyUDVd55OnxHCLnIqmD7FogaHTIK3GQCPZV2VUjEzYxk9djA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722822; c=relaxed/simple;
	bh=IZDSvvIWTvxeOc6vAT6CTmA1TxSwSVLPm0tS8B76Bdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFLUYuEw0ySE/GQCA6xlPLUEvCYLKqjKL/wjNO/eaex/40gi8GVhnAim+9tvFjjYXUdUUMolAa3XRrFN3AM650Y0f5UPj0rP9Cj8UV1NLuuCprMNtVEkNbmG1JI11D0E1Ll0lkQ6BsfwcH5uD1cPIQPnO7g0VWTvtaEipeASJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5v1Oid/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dXLPEszy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5v1Oid/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXLPEszy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rP952097376
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=; b=S5v1Oid/YK8zkt6J
	2ItjNKJhX4moBJ+xFFnUfRz7spo1b7QPzxRTMwHqM6TOXp7IZl9+etshzKHNQ2rz
	i8xUonlPASvKY+E0gX+DsEkgdmdjL8iV4rAzMh/hFyB88f+QRqDRE/LLHLRQlLi9
	IpQcxAeTgjRc+k5mu42tticXPsqjKzVTtE8BYoA6yky3gI5xFv+Cqj6pu1r+A+gk
	rAnUY3QSJEYk4vDJnN8Jarv0mR/jFbeb4re3zvxWlJQ7g2jMik0hamPAGO168iyi
	ypMG0IKeeleScoOwHOtgelvOflQSlXJE5WE+2ubIBIOFSEzNDKahIp5iVb9gTuvB
	maH2kA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7we58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:47:00 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9693b69c4c0so32745241.3
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782722820; x=1783327620; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=;
        b=dXLPEszy+krHBgg5niHiz9i4sp06kZvO/Dv8zYwQHxOlnziIXIVhZjmdeeFZB4qbJN
         P1kYqD7VQnT1OmC+ybpkPKwZh09Oi87f6w+E2wE8fd25VM45sd8YtB1ugc2+Zu2azaqZ
         EctFGVcOJQPv46QlcKapcGAbhlqcFU3Dpc7119S4TKPaXusYFBq8Nd+G6pAF0V8T3d9G
         QudUmEuSUyHFf+vCT/40Wh8NY1BEP5VbhllMWawsu4bs0yuB23uI5J/IdowuCMlOLKYD
         fWNnHqFeMRPM8SpIk30RBW94OD0FD64/0JzBxsLG8MuplCaZsU1tNJYMBu/W6IOTrDoJ
         6jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782722820; x=1783327620;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dsuvkNF0CRvWMwPOO/jhGrruMUfqUKJkLRonqqcBpsg=;
        b=f9SSj6QwTH0yLI9qTKc5HMNMetIDTm7N73UX2tcLY2bA3IITNjV4lNU1RbKMrilMGx
         yZwvEYBryPmRHhV9zQ+dRPcHvLfLCf5llAK8oDeR0THt+nXRVQO0bbd+D3GK6sMl7MP2
         zskPGKCO8PG05ZDl+1rISiQ4VVwRXf6y12GTB/JRBZTEYQBzjtBLVYgLAMwNPL5WqOzB
         hMqr9X20vUNvMvJN6edkHbXSk6A7hvm8H1AHEB13JejMWF3YkuzYISVYJNweX2mOGw5s
         RyZFPdKAPC6HUQNroKRcrJYuSHU9H5pbmYt3Pxq9WhtK31LnT0PlVJd63LIhv73gjTAJ
         ucaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpN7fZ8HWZtNOv+p8J9eGfYhqe5oLFv/6TYDIrTHWeLZcKkbjR+nY1cvcDDUBPhyx8quU6HIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ9rkeZnHnD91gw6NmKOhEWoJQ82+pFZ4EnQAa3KiOWg2NjDzC
	Zkl42wZWwxkUDczKDZ+bwhDa73AkBz8VW3fvFQFoP3QBrLqazWzhwCqg3xPrNH2LFp2XE+9v6wG
	d92HkrW+mESBG+9oM2CcBd9p/+ivJaz4IGP9SW2e7fBmNFM2sHhqroZLV7Q==
X-Gm-Gg: AfdE7cl0ytEDPJP7odINHQJw9bANsJf/twZBAK85fpCcqVxnJfj9JEsvvMy0lsEk14u
	c2twCiNblMsCviXfMNKKej20FA4zhx/jFhBVyPXJ6w/UAEQBOmYi4uwdYomk8wujnNhcPLRst9w
	+2JnLC8VK7Hynofe5/fnY1f3rb12XLgDuaE3vUPoPPiY3OYpfSTXxiFE5MUt3+thCTubMrqkEwO
	Up63ttiL+qxp2ch1ooUetsA73yPxCx3yB74/R3H3C061DJ/pbPShg3d5icAxs6giTH5LNkuP+GM
	ymw/0JYIHp3Ye/Y1mZNKcBx202Tn42PAiEUZPwMLwJ7SDQAcx8Eqig+lYBWOe5+Cn9uzM60dLn6
	79YBcaUiHg4ZPnujav4TmFe3CG77QAsWkdhM=
X-Received: by 2002:a05:6102:6c5:b0:738:4343:fba9 with SMTP id ada2fe7eead31-73843441853mr493649137.6.1782722819871;
        Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
X-Received: by 2002:a05:6102:6c5:b0:738:4343:fba9 with SMTP id ada2fe7eead31-73843441853mr493642137.6.1782722819368;
        Mon, 29 Jun 2026 01:46:59 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698481d0359sm3009277a12.30.2026.06.29.01.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 01:46:57 -0700 (PDT)
Message-ID: <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:46:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfX6JhfrNVI3bLu
 /Y52eHx84GR1pnCO18d3fvu2WUGx4n8zNIfEUiyZHSpCLMXLLZijTnkhH0WDiFXNdT3zjPaILht
 rdM8iCVsQCtDfQWXHf7k4BFyO+BhxpD6Tj9hVWlq4bqeacJ5xCcGK736W5mPFBZFTwwPnX2Y3mH
 tDNk5APdfB78HPAQxMEXl4toGluyXTR/dLaJEJU9MPAo+UcOc4GkiAB3liJHvZr4FvTWmYBV68U
 JdiejbLcLA/B6SFcWLj9nUHsNzUsoYd5MO+28pD8uS9rgcxv1NQ6B3dMLyxf5OJOsuAPI3d6na5
 F9cwTd2lLw+buREZZigPYGjylhlXs1xDx0HEOyO89Xj21uigGM6+BvKmh/MHieh5kCu54knOYZe
 63S+HM2wfm48a6Y1vwjEoX4UAihzjx9eb2PsBnCv/fRgIgfCBCM2pu93jOCQVCeWJWnTTu6eqle
 EYttOWtrXXV/BkPomOg==
X-Proofpoint-GUID: gyAdrdoE0AxFR4my38rAuficfCa1Alms
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2OSBTYWx0ZWRfX00Ti0dY+HY2b
 zRzhWkvsx2cUu8YE0wCuPU0Dgzj1gLxsP8ryC0h7LqcflKo/BgbmT7Oyhwl+gEelVqFn2/kM2G6
 fL0kkm/OVlgaHmHWn9cYAAAbH4W+Uk4=
X-Proofpoint-ORIG-GUID: gyAdrdoE0AxFR4my38rAuficfCa1Alms
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a423104 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CtAqrJV6yErwifH23rQA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290069

On 6/28/26 8:23 PM, Akhil P Oommen wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Drop the sign-offs that don't apply (presumably applied as part
of shuffling around the handlers of the patch in the in-flight
tree OR missing c-d-b)

> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
