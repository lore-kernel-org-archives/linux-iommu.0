Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A603806B6
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762227; cv=none; b=hJU/Yy/pVKYhWkm8uThC3fXYsHnIf+tQeIeuDBI5pxlaWXhGx88Cubf1IBEP/JRaTInvLfXtenCBXMqdunYRvkpwAwBhsm9ZSkdDCGlKXztzlTSZlNEJfHtpK4BncJeOhFWJ+zgj5S7CE5URKDyG8RdYcSdsXcC3zshUXDBmKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762227; c=relaxed/simple;
	bh=u1axG9TUbf6ZyYlZk8WsNItpw5u5vFUCI5cvB4d7S7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWp9FVF1IGz2suI6SY3wu5ogDoBs2DnHoy3Mgh+h3cO4jb2pWlUNKKIaLUOeHAeeFJ+71TThSK2QRjtbA/lKaHRVSEZOKILhBemz25yPkyG8rNbrMnO4wBfzQyR4IsFgr/J2GV69g1EgtWBGghegAtKvnQ4t5a3pCpyHICmc7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6BClnKN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NF0/+h5t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6BClnKN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NF0/+h5t"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeWto889438
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=; b=o6BClnKN8yNiDEuw
	15R/KC3bxZmX/hC1mXf1z8Dh5s6PM4cmyZrMI4iFZdld2n/t/5ip0XnoJe7IK0GX
	/Ped4LO/MlD30gfNsw3sartjimlpcsF4riH0Ci+x5i609eZ2gLU/7gzp6XqdrY12
	OhZcHgp99BhB8V3uf5PZJUXiUzlKJrJocWX6yVIIXBOatCb49LMnlNL76iv/n+WR
	V8URCkO75sWKLzekMwaXkX/zuA62A5SJm+AWg+JvagfgMIfH7xFoyVQ1X2UOw0NT
	gVZ+lm8GbvFZ9q/n31hEYFfyMkV371Op1xqqTgnwDHV7Kt5VMeMAk2fo4zTYT4NH
	zJf+Qw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjktvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:05 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6314bbea08dso326315137.1
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778762224; x=1779367024; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=;
        b=NF0/+h5tFbfeiz+0qdu8hOUpuZnaFIAcxpQ+Avef3NGYeL9eBnefpWVT5ugshSxWbd
         N8+LQgjLLlXHSJD394W7kU9+/LeennsWz++7jiS6KsefF7/r8q69dhfm586is429BG2C
         I3fLZd0w1zjJ2k2Hdy+nNnxqzMLnkQLJKIe4N7PbHxHXzh4F6zHuL3C10JndqDpoxsVw
         s/MU/dCmN7LgRCGQfd9SBt54v3UM9DM+vQlQbxfK7bVqv/gFE+5paYNL5ovfwlTLttnP
         ysiZf64AU81XiyJnh9iuRAShP469D83CEbIGpGsQegp8EGUJG1ffkUy1cswCFBDn7DZU
         PEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762224; x=1779367024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=;
        b=L1DTp5FYQ00HiErzUqWrRxA0urQTdu1Uab4xw6V/wGQyo8/+G2yxTRQnXx724cs5m1
         J0K2sqoB37ysKhBzcqu7+dsLOscCV1E5plBZujTkK+rh7IziEyZ5wuLUKxUn42WD7N81
         Sx29N5xmSH/y/pu0X6btDUU6+mNDdfKaL5fEK2oPLoD9P6m/P0ZXCue5L5BDvNqDMGeZ
         WrdLgkSga2alRiLqo1S6q5nz5ksHoOA/uPBhnWh2B+Fz/R2yAeBCqh68J3LBJ60lScyg
         o7MF5DyGCMl7UeXSaeLSoceWVuYeRkO5tyEEl4QxCo9wKE4JOC1y05OcedA9MzbqN2ot
         qEzg==
X-Forwarded-Encrypted: i=1; AFNElJ+UFYlcZLPQn+1w8nHOPVUBFs1WddvUoCIotYDulSk0RlDTG2BdUECVikJlw7J0nZcDVJ8smA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+F0N7q3RktuQahhMYzKQtQB0iCqMcBbtSSB2DR8yJ4AKgIX8z
	DAm3w1/qxyt4sZgulD1D6Y20L+AagPjIa0eZS05V50DnXhbDGypijS+VKyHse8zPjJ0GYEeX1JM
	KdK9LbenFdyPbTlPoWBu3t9ufUw4Xi985WfCaoyUPNpZ7CUpoatbyjX8Mnw==
X-Gm-Gg: Acq92OF4Jim2OW/YU4aB4NWEdQckcMu+66SBZnojFOwsjfG4USu8Dy0uQVfJMGS3x00
	YDNKOae2g+ELqHkBL6FuXRfx5hFqs9HnixGJJU36FSDY9Kqju/dNOxrlW513G0ZpW8I8XYi/qbA
	fY4Wi6Byv4KR8zSdFEjZlaLFxeIs1JQAIIaeSTdeGV0ZeSYUMp0SLMuQ0RKp0k7u8DX2uvPwd0H
	iMTSodYYMMe1I0mlHmPfVamlR1vhLPEEX9E7X8SHwgAEhTZ+yNsUtL8HqywtNP4GlZgMY2/N+xF
	P95uMU5Tk1gkBEtZo8oMquEI3/y8aadVHrmeerQQfPZi7WqxZBm2tNm13DZozKch4kBlIu5+jL3
	y670I0WpUKvWOsNayLwJXyWtdTHccHlHSOGK4CRgekfbcOMq/uRG+pqAuVwvW9eIxByY6mdCi2E
	mbvS8=
X-Received: by 2002:a05:6102:1150:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-6377667b9efmr1125966137.8.1778762224459;
        Thu, 14 May 2026 05:37:04 -0700 (PDT)
X-Received: by 2002:a05:6102:1150:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-6377667b9efmr1125947137.8.1778762224031;
        Thu, 14 May 2026 05:37:04 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1124sm84302766b.1.2026.05.14.05.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:37:03 -0700 (PDT)
Message-ID: <6efb980a-1d88-4d22-9ed3-1cb420317b71@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:36:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mSKa0aKx-JcfXvXKxbaA5Tk02Bd7F1Ti
X-Proofpoint-ORIG-GUID: mSKa0aKx-JcfXvXKxbaA5Tk02Bd7F1Ti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfX3qMC2i+dK9tm
 JxuAARN3y3EBaequBl/e5tHseW70zAOR5k/a6j/JogD1yJq7Y8/dusNw76DDjkFONjg4HN0Lhz/
 9mCrh2PMKJ156haAcBbZf0B27tNXnI4/PQ/nDP7CrkTLWE1N9TqHhiVGL2I/SZQlnZ4goH7vQG/
 Hl63xV3/aF24alPFgu4iJvlvWhxwKisqq5Plh6F1Njsk4ckdrPjdAO50c2Kc3BRJGsW78hS1Vbq
 ah9ZHsnxxZDJSlVbPC42J2h4oe2H3wAxDoOR3zvTp7OunIFs/9kFlcuhJm4VlAehb7WKahig0Qn
 gaA/eFInran2nsgvf/1mLlpcrIBX//paTpzxrrGQYcyahrm3J1ee+vl0tbB+V1cQm0eLq2eEph7
 4R+o5dSdVTsahWy9Uj/Llx8SScAcn7IdvX8CpGHzAr8PF1ZPsdej3EcZ5Slp/uWZKoOYsDjo+3g
 BF+0AM3WOeNtGmt6JjQ==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a05c1f1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=OwxjEWw48HTU6ZCEJDcA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140126

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali MTP device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
