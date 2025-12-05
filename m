Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8E331A4E
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953260; cv=none; b=YJf2czdCBx/BhI/1Mwim9LMawjjZoTbE9JK8g9XT621wc7SPAmBeUUFqoQpgH1Vzn05UeDzTHcWNfXnTvLPyrmS0HV7h7UWsqAe/PdZsXqyWyDG4Ne212m+Z6FdyEYeEWS2KwMRsMAr1He5K6LaOSQmk9T81b4vVkfzkGl/S+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953260; c=relaxed/simple;
	bh=al+Zeq/KhoUTK3Nukkf1s4vVMOh8XPIsPB0Rx8paY2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8iTMeVMYNnWAhMb6xPXQE6dod7rVFsXUhV6kZ5z/kgP7IceV8waHnV+q8Szl2RfqhSTwpvfWQiTAkIBZPYAkOgSSpe/i8OlAd8VXNfmWr3HYc2yAGfsPBmGpgPmh2DRiyNJOMq0bITP4pMQEJGmhe0Kg+4mzszMilvueffBgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTCe6oyU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MTWhBj/T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTCe6oyU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MTWhBj/T"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FBLKn1342288
	for <iommu@lists.linux.dev>; Fri, 5 Dec 2025 16:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6gQ4phfn6ife2ezaMBOzgck5fHXd8kJlqOvlD6vM3lA=; b=GTCe6oyUVthJBYZX
	XKkmsuKvAE6WOzCnY9xNnFDw8x4tIW2x3PUF38cCNa91j8GntPhsV80ld0yAKlZn
	kLbxj+oNmoTFwqJ3v8VUtGlmMK1iFWTxeJ6xhtpoBlW0k0+vmWVQrHh/zXtz/iu5
	LnQBNUVkpAwHgTZ2VQGg+vuiQTXoyK6azmWh3mFPkVgN843fyIIWTXDc4Vi7H9L6
	HNswLQ09iGzoOOYpGZyna5qYRIzOjrT5mhoLQ4uK9ia3JA6AncDahcNcXt9XOaf+
	f5XvGIBr1bvSWs9HwOlqAjwDSD9H/d0hRgakXqzMzqEI1d7bHRVOtWAK02aSGp+X
	CZQZTg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aur9at12q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 16:47:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1d8f56e24so499664785a.2
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764953251; x=1765558051; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gQ4phfn6ife2ezaMBOzgck5fHXd8kJlqOvlD6vM3lA=;
        b=MTWhBj/TRUa60D23OFZ/2AyLIla9Cn7/Emcb1FwH1ft7J5hUv+MsovShXd3w+Cf1i1
         tjtAFZ+JQ1OjLw6oOvIQNpMmNpCgdm6ZM666nUm8PBQiLkioDv1lHZ7rWrRvpddWrSTu
         NWcbmsF52xH2W1Aqs7Sz0IyelLpcX2JcNg68MfjDBOHKMtOGBWJQQVn3hyrbxfIhB60s
         QfRuH4B4Xgzlgikmjg0tR33qcIcXjjxix16Yq5mOKJawUd2309AfEO+Vv28yPNXatLrK
         +szYmoGEVxNSM/KZwN65p7QJ7dDjtv9SUks8T4ZWsU9OL2JcdO2jwaVU+AtVfWtZiKjX
         pcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764953251; x=1765558051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gQ4phfn6ife2ezaMBOzgck5fHXd8kJlqOvlD6vM3lA=;
        b=b6oGregV9hJ7PBntQPaqcRsyiRu3HWiz542yvSZkBp3xnIVVHXxSNchJVUx4KkGY6R
         ESZGvpAK0Vj+uwQDbSRyLLtxh/DBOiG5FAPlvXgFpVpmSJj7qaslQSSE+JI3NBQxjJyR
         PVOhYWLnhzqoZqfLik8PriVlAF1MYnA+Q9zJheGfeo/2SmcJwKvOlh5xoHA0Bi+N+JIJ
         wcU7AH2MHU4l15nsCFm02FLED1bRSx9cEIIsqZVyTY1DYQMlEB7lam4IsG0NfVrj1Ulp
         cZ7xBzCl+KIgTYJMumHjSgVppgK8rJuMlBO19T4OTV2lzZEDgUHMpVQhej6NFouPEfqC
         xYZQ==
X-Gm-Message-State: AOJu0YxQ8Un3bkY67sUpcXO6X7+6N1Nn8XENx4J+5YXrS2HM6D9tFOnw
	jWxd6L53UES1elxqBx1ZolGff7eZwCSEj21VfIs7/NbbZgsnfiOGPtpPkBnx/NmM46zpE1PRt91
	RSHjfhcOHWtLx7tFJa+PLxh2R+QkJEvNRh95LqKff2zh8xJR4qxb9gJrR0g==
X-Gm-Gg: ASbGnctolqnfIZ3+n7BjdCqNcIVmTdKe9PmyW3K25eSM964raqzN3um1cSs/+Se5cn8
	CU7Q44apDmYYJL0K7lfbk6LCkZQUhY1Vd6rZA2nJ+14mHe99/yrpwPcZOdtK22GGYbUUvt4JmBQ
	l7wj+YmJJkGPtkOdUZCfqz0U3s0YsZdBdHls5ldynuPcZeoov7Sssz2nZ4REMTLKOyEtJuRYTOW
	rKO+aFxjtYpDv5A2LAhVywJu4CyK36+WZa8XACVsRNBmN1/ySzqg8fWwgx32ovu4m/iaXSRgueA
	EqloQ4wVAwDYi3YteXigI1WhKACqotCcD/1+Z+W9vTCrhfUHZ5/80AnMD6YillTlPfRT75U5jsE
	8MlAuWM8F5vxkh+k3hQ5rdorO3oca7LL2IJiw0hSQMxvanM1n0aaocX29
X-Received: by 2002:a05:620a:4152:b0:891:a03f:7c76 with SMTP id af79cd13be357-8b6181eab7emr1114489385a.76.1764953250904;
        Fri, 05 Dec 2025 08:47:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoGhlhqAsRd7FLdO2RuC2rvg878fg65NRperhyRrGPH5/dQ5/RvGkjMuZ5fanPWoPvWT1aYw==
X-Received: by 2002:a05:620a:4152:b0:891:a03f:7c76 with SMTP id af79cd13be357-8b6181eab7emr1114484085a.76.1764953250364;
        Fri, 05 Dec 2025 08:47:30 -0800 (PST)
Received: from [10.140.86.114] (87-95-1-57.bb.dnainternet.fi. [87.95.1.57])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e70621ec7sm16145501fa.41.2025.12.05.08.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 08:47:29 -0800 (PST)
Message-ID: <75d44bf2-c518-444d-9b15-fca067e25877@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 18:47:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69330ca3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6rJAVqwrXYrlrbcIgKCPAw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yyg80FiLJEQYT9IT_GYA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: t8HQ9cIfu9pKGtOGyHKhkEGKTaIdCkcY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEyMyBTYWx0ZWRfX0CBiaJW43K4l
 rGcjjc4NKMhylZ42077vsgeFAe41aHJWU7A4XtFUG3qR3hzFVpWJ7EPzyZ8K1ux+dDRSGX90vzI
 w8qYCOkCtEcWa9f5+Bx4E1B9Bq6uW9BFLksEe6SbEx/t3sHY1EcgAetHmN/9Hoi204JBi44j17f
 W392avFritH1BuQ97s4G3kX2wbEDNHtz70+NwYbAk+c+2qpN2hTNza5pW/wSXZts3okWoFHxCWA
 YB36IazEwKNGfG/mjWTZERkl3jCNzIN5K2i6t1Osxz+jYOb8cr0GVTJdpUgJDHfI0ex/e6Fq99o
 /VH3nYFRNpy6VarI9j1N80zB7fQbL9AEKbqn3uDv1F61hkY1g77Rx+FdOtpeqIafX5bVuMvvV4u
 nGPPGVhXB26JDJjYl53m/fxb6BhVrA==
X-Proofpoint-ORIG-GUID: t8HQ9cIfu9pKGtOGyHKhkEGKTaIdCkcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050123

On 04/12/2025 11:55, Vijayanand Jitta wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> Introduce a new struct type where the optional arguments passed to
> of_map_id() are in struct. Subsequent patches add additional arguments
> to the struct that the caller expects to be filled of_map_id().

Why do we need a separate struct? Can't we use of_phandle_args instead?

> 
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c              |  6 +++++-
>   drivers/of/base.c                     | 31 ++++++++++++++-------------
>   drivers/pci/controller/dwc/pci-imx6.c |  6 +++++-
>   drivers/pci/controller/pcie-apple.c   |  5 ++++-
>   drivers/xen/grant-dma-ops.c           |  5 ++++-
>   include/linux/of.h                    | 23 ++++++++++++++------
>   6 files changed, 50 insertions(+), 26 deletions(-)
> 
-- 
With best wishes
Dmitry
