Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3262F5339
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871235; cv=none; b=M+7PKUjijL54Vbfay6hO8hDsB3iP4dIeK43VSWv2Ph0Hf52ZIvtwLKnb0xhd+5+/NYydrEgIF/4rEmZ0WNkotn5uBARidKLKCfgrITV4X34MoVhnoasGL/pp0ZwbfT3L/1cuIferG1u66BJupwwgi6qOHvREzgdFVaLG1yfIez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871235; c=relaxed/simple;
	bh=At3jsEqPyxFdSaRWeiEomMCAUDUz26XIRWm1MrjFu5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6FyD4nSo47nqr9KnNUOZ00rwSTEWm/l2/FdDR2rK/zt85qeI+xTGMxFODkp3JSbC6x/Mzo2Zk7i2BXwql1YO77HD3hxiA+KIGLRWfZzw8YDB6+Fkh/ZHWQMcCtKpd5Jqk7IEA+7A7EoBKfw7RYwYzQSOEfQd5OMX/L1wU8Wg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELmNGRaY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHaTQ8QN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELmNGRaY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHaTQ8QN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYZf1937346
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=; b=ELmNGRaYr3Ek/O6D
	IZP2qD4dyHqpwVTbQTB5Yw3o7cHSgiJmwqmKEAZZuu/Enh+gW8oEjFXL/nEAT3Kr
	BF3WhBOaHZgcNJEUMFuq6hqLxo8WqaeE1epEsVy6qbmYVSYc9PWsbkAIXUpnh+Gn
	FjjokjwRWSwj07XNlHaB94Sun9WFZfj5zsYISJ7hHCGfQunpODwWgXSfrhtoR0g2
	DDJvIWFa4vjpKY04ixCA4UYNl5IsESmhuJhQJbJuUqxwr5P5XR5DfoOHWvKn5tCo
	CfxfwSfKOxzJdYrZs6Z7LeJ3AevlDHLGPuwe0BXz/SyUqlIgLS7uxuvJ1vt6H3fD
	OGAqFg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9pjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:27:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a43210187cso3984431b3a.3
        for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762871233; x=1763476033; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=;
        b=XHaTQ8QNobxsXEWzOxOo6wm3mzjWtHeC3b4PH8Zof2x5pUxjL9FmLChy4bOx7GhOM5
         CEL1dsZsjOsJYz6LqDq87aYc3reSOAk88aLMmxsxMKTZ82CDc0mRyG9qgpbuVWvoyprz
         ZtXDDk82aMkRpr0DlWF/a5GhVJYVyMJjJF5Q9BE0G5dzFFYuF1e/VXCBehqHHwWIU+1J
         u1j511hzoY7mGoLLyc6Hh4CHsVScBI3aPQOn3Hj6h2pCQkg/w1GBeAsrtJAEH62JB0K8
         srm7mKm47T/qREgO2MelwfdS5MIdCKYs9ekFXkOSwqPBk0fvTwMhq4ypDgmjAAAdjHGz
         RGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871233; x=1763476033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLUjnRdYKOuu5qj1KoQzXxsr2RycgjfhzOqnzAirtEk=;
        b=VJ4YjHHtn8vFOb8HAvMDy/MLQ1RyagbCk4Mrxci1CCCXUZEjOzLusKJlENqt+G8dz9
         YjzuqHoNDneWa8M5Evw+ubfn0P9JKbOIZcd4k2JqARFJv1YRUwdFhl6m4OKrt752QDuZ
         0Fcek4dwPqo8HWP6ca/LlqIqhgX33IzJsmJwuMVxjTKiO4lY8VoPUulmSZ9Q/xb8wZ6+
         XpuucKrZUSMlP77hLNG1RfabdrxhZNeKLPZVkKv7spjzOPWHECgXXgByLMZr0E1+DLDA
         LFpTFBvxYDDcORhkydZB30l76MsmYn4aXbd1DlEac0huE6C4pTafB8eQKw8K3AHi3qDj
         s51g==
X-Forwarded-Encrypted: i=1; AJvYcCURAGmuEqsdy0dJlzqmSk52Z9Fatc9bJRqGHSfkx2flOtY2gsM5nF5xbFHkpaKuxWtbvXmnTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPtHSt10QSeUfSMDgm8JwFVv/Nbgo1FcpkoYKXbp65bQdcyThm
	/XP8iZbBtP2b+A+5e8GnDaAlMQ/I8NaP5gzlPahKUxCBAntbDnrTgT4ztFl6/6BStuudEz0iJjQ
	Vd4du16sslHV8XU4lrynXZ6kg86ZLxnR98Isl6foC7wTND1fSopGUDli6AA==
X-Gm-Gg: ASbGnctMQ7/DcDbxiOkNWpqY+yuXd76hqPcBermcv4VnlbcaT9CrE/2VVr+e9VoG6xO
	0pqRNpZtSKvnMjZaH2oPunDEROjoop0afqT1/8akXYfJP1XpggZWj6Oum6ZQ8MkvSWWo/3lVe7+
	FvcDx+DPBNUcyPeWnigEP7w5ZK3zYcKfsWUmODdZ/i7FUF95jB4iogtfS3Ofv1B0fqPNtRHG8u9
	0voK02i+D/EOlDE9ss4uDbCb51Vxp7Ts9qqTpNy5R7us/oQFjgy2lUGuLyLVh8pqZ4bBzH3fuhR
	cNhoKIwtF4I1N+SUlNjzDitrqE6f+gf6+hg/j9pj1b+ns0KfuRYlXxIhz2s7SugPLxugt4rsAtZ
	zxqu/DQd5pRZbLJ/ubtTg1g==
X-Received: by 2002:a05:6a00:b44:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-7b2266a8d96mr16270330b3a.15.1762871232985;
        Tue, 11 Nov 2025 06:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGS/7Y+JCV0WL0rDJJwpThYAOraNVEcFIM32zGMLfnISD9Q77+PeHDE8FGvMX6ZgCVDRIoTA==
X-Received: by 2002:a05:6a00:b44:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-7b2266a8d96mr16270287b3a.15.1762871232438;
        Tue, 11 Nov 2025 06:27:12 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b75bda9f77sm100571b3a.15.2025.11.11.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:27:12 -0800 (PST)
Message-ID: <08f8de55-52a5-4942-9a39-222fafb093a5@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:57:03 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/21] dt-bindings: arm-smmu: Add Glymur GPU SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-21-bef18acd5e94@oss.qualcomm.com>
 <20251111-mighty-aromatic-urchin-f80cd9@kuoka>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251111-mighty-aromatic-urchin-f80cd9@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExNiBTYWx0ZWRfX+bCs3s2BNFzQ
 /urg78O6P78M5thhcjsCp+JrCST6vDTvqSCsNfxjP2VSyLoJ6Qj1f8wwzM7Gy5ItTTkA/+S6wmK
 zrGuEeSu2FFAiUa4XddI/py5VcZd/YXyoBxKH3SaCBOY+AJ1ANP5aGQCbwfJE33Fr+FCPxgH4xG
 Q9EGcgWhfxK4g1wGLKB+/4AamO7RKme67k0q5cBwyzLcz/HPOsTnuMuw6tSEGwHHPDKNL3t4dE8
 u8Q484HEhutU/6KvXZ5pZUAZ1YoV3QVqQiSIBOTSEh5lqXmVcQLfkg9HRvO37a8jZ1FoE29jGI5
 brCuxYSaWmR8fleIjE4gJBGFS3ryVX1tCKN4TCxDpf+pv3CKBkhR/r+0x0/GwyEYJCvYzU46S9J
 EJ/tJFetXocWs+a/eFs9Lm4KoO2AOQ==
X-Proofpoint-GUID: -UjZAYP_LrhYXr2tKtHPEWAxzjgQxo1V
X-Proofpoint-ORIG-GUID: -UjZAYP_LrhYXr2tKtHPEWAxzjgQxo1V
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=691347c1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WzT3ZZK9S2hwGh7ljtQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110116

On 11/11/2025 1:20 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 10:07:27PM +0530, Akhil P Oommen wrote:
>> Update the devicetree bindings to support the gpu smmu present in
>> the Glymur chipset.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> So you ignored entire review? I drop the patcshet from DT patchwork.

Same here. This is a new patch. :)

-Akhil

> 
> Best regards,
> Krzysztof
> 

