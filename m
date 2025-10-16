Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D292FF176
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602206; cv=none; b=c5glKeW6HiQ2z5cfwLF+6cZm5Gd/SCpfLFyvT/lRO4luVi/34BLAOLPpLEn8mrdGPT+GP4OVVOnJxojfL0kot2xfM0bOC3vavqKbKzlSx3tA38bU+zt9caNRRKZzo1tXvPEmz66xT53Autr30Scpq7UJcx+8KmDJPIQdb6a9YdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602206; c=relaxed/simple;
	bh=jJlPsZ0mceG6nLVbkJ/VZ6In0naj2yOA2MrxmWidNXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qayW53oFN8RZSwqGDXR07JaPKf6cfGYquUHB+FymaNNHhCM7+/Sga4ZVgUHQ8zLWQZuDgrVLu6ZKla6jJh41qFEGuuX4U5QrM3rZSr1NGhjD1Nzh/u3fFog31Qgk7uFVgbjeABZlsgI/y1yrYgQEW9fhA27TDiQ0j4rI+iFZPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZXByYJ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZXByYJ8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7Ueag004070
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 08:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71eTVHWK8qTFUy2Hm8BbFVjk43WuGIVBQKth2mrE6II=; b=OZXByYJ8t+2YfDHr
	7Ry9TdhdaC4AZMnQDYQ6zdRsMQtXfuVd8Su+7xP3fraYiczQfsMoHjC/u9CAJTL2
	w/wf7JoAqhZSjv/uMZuSQ5vWvihhe9MmCPD37z8LNoZ8Af3HaInoF2DfqlyAiDj4
	gaOWnlkYv0juOrUPjHRNucNjo2l+KI/M0glqRK7sPoUPQQMVP4vCVIfFbkmJXOk2
	k+0urYpVfFWj5DL0Tb7iGK6bPRhkjTqWmyi02sKBEVszXyvO9KNbA8542ZX1fRpE
	cnR7XBHOLhLg5SckJr9DBfQlVvYxR8hblnJipe3S2L2UsXMybSRaP2CnvNLcX6wQ
	SElNWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg7chc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 08:10:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8572f379832so14634585a.3
        for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602202; x=1761207002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71eTVHWK8qTFUy2Hm8BbFVjk43WuGIVBQKth2mrE6II=;
        b=tGe6AOwu/PZOulbUFfxcsI+Es7UUpiQFYp63zYQBpA8FHaPiDCB7tPwU0Bz+QETeNG
         fWNGcOW5hB7/g3MRr/v1vOlDmkVehuSegqLWhibu2LEUmkWCIJNtyl7fbU0x4U6nGN9O
         +Y0Y6y9Yb6w8OZPkqmP6sQN5gzFBQGzYNhxOHDAzpZ+SoQXMkFLkJZuCkjhZndqAmqmD
         ghEy8VQsrpYDrP4os6gG1TN5tJA6k4b8wCjrDPCWoMWsMh1605kHCAhnadYnP3Nx1Ecn
         GE4UMmQHHFftn48ksc0rkJeDTiuMH2PhWXeH0SgJ9FkbGzfJNKfxKXq+nWPowQ2yBAPJ
         9zVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUQ+UUA4wD2iAbngherb4qJJ9vbdDHNDzxEUlGAfwDrei5/+a0CDdb9EdUkZA3mzSCodjHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm/QnR9ME0fhGKXndiqfkrvErecfZMVk2AdNtptWgb5Q2Gr2NX
	Af7bRJDBY/yWu/piObgH8JBrfJpYWOdmrDCUA3nHR1I/aEkmNW4QgRzVGVEwT+kRa/qcLlkSvwr
	vN/0I34qj8RX+EmxLo+A6QxNwHZ87MLRq9O4wyBW8YNhrC/W+vPJymN+j1w==
X-Gm-Gg: ASbGnctg/3ZyURGyYLiGgXOB3xDpOrVFp2XkGacxzK9qjDVIlcDB/hE065zMqW1gTLt
	+j8x1f4kFQ2KNGiQ4hKtW4wo8S82yq0Qi9dACyHMfZTXvesgxA+3Eb9mwZa9MDh/H1Duvt1kXS1
	Fz1YBU5qIwfzLFeL0MXdQhwGfFp1OZmAaC2o+X6+uDR7I73V5nOySnvOQY21DjGg1GAfPajsmJy
	3Cr4TWOCGFRe9Lmz0LWc4ofQA1gOdditU4Mk1tXPMt+GkZ9RNd6/TENgLfTlGhlK5zSIoxKWRZ8
	KxbCMhLhUaM+sOMc40lkO8Mr/hGTs9p0b6FacWC2hMajJOy1mVMHBwG3Ak/KE/SZ0nHQgXaNiLS
	yMq3a9dwBtwJNuXA6F28Ce7Ov1XNlrUI/ytfWdooeddmsKoYFibhLmAAY
X-Received: by 2002:a05:620a:26f4:b0:88f:561:d952 with SMTP id af79cd13be357-88f0561db13mr249392085a.12.1760602202359;
        Thu, 16 Oct 2025 01:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Qx7DNi7TWeBh4m+fWu7ED1KdauIgTL7hZB0jOsVg2aUKvUTLde6ZeWAgS3jkNEUDwPMQhA==
X-Received: by 2002:a05:620a:26f4:b0:88f:561:d952 with SMTP id af79cd13be357-88f0561db13mr249390285a.12.1760602201901;
        Thu, 16 Oct 2025 01:10:01 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06b7f6sm465031066b.30.2025.10.16.01.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:10:01 -0700 (PDT)
Message-ID: <38c3bf97-4b69-4450-9e23-32ece07e38dc@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 10:09:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20251015-topic-qciommu_bindings_fix-v2-1-a0f3c705d0f3@oss.qualcomm.com>
 <8e7a145e-6871-4974-ae19-40699747803b@arm.com>
 <56fcl2ip6ecu4inig7ecpjt7qrsdt6sehkrzrk6joysbp6tea7@4xdgxhhe3aso>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <56fcl2ip6ecu4inig7ecpjt7qrsdt6sehkrzrk6joysbp6tea7@4xdgxhhe3aso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXzOjxWFM0J4Gn
 stHd7+5CgEqMPr/Hnu+xlBf0z1GQNMcmME6f67GxzeZE7px8ZYm23zyMiBKhpmKFqrR5/piC/E6
 F4Ok8v/rDTitvIN6ySeR1t2oCesror3JEsx0p/K5w+BrgPghzE5CWKEa8fJ9/8Djy05Kfcn4lna
 NGSpc0O1d8WwIaFjGYaOUTv9d+bnrKVluOyVM69cNf1wBdeAJLhh/LCNyTfd3FdgN2B4otAZc2i
 C5fD8JZyzd2KbudioAAw77ikeb54RC4zd1JqXxQvmGq5SLYDWle42Q8FjpxMJBQehsB1RtTZkLF
 IYrbgV1Hq1Ss7kRvuBfcP4k/QwiB8ppkxiR3riNSn8SABTapT/LCuUCRaMXzgYvQAMXNxLM0LGi
 uEIwbmjsfciqrEcZFil3GD7wwsOqaw==
X-Proofpoint-GUID: Md2G_CGu0yh63FE0lbj0yo3ms5s3lDCM
X-Proofpoint-ORIG-GUID: Md2G_CGu0yh63FE0lbj0yo3ms5s3lDCM
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68f0a85b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=bEtsd_hQwJtcpMEHxR8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On 10/15/25 10:10 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 15, 2025 at 05:48:05PM +0100, Robin Murphy wrote:
>> On 2025-10-15 5:41 pm, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> Some IOMMUs on some platforms (there doesn't seem to be a good denominator
> 
> It would be nice to provide some examples here.
> 
>>> for this) require the presence of a third clock, specifically for
>>> accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
>>
>> Hmmm, but isn't the only thing that accesses TBUs the consumer of the
>> qcom,tbu binding, which already has its own clock?
> 
> qcom,tbu is only defined for normal arm,mmu-500 platforms. Here Konrad
> is fixing the older and more obscure Qualcomm virtual MMU device.

(for context: this touches upon 2014-ish platforms)

I checked the address map of the physical MMU500 that lies underneath
this virtual impl and it doesn't fully expose the same registers that
the modern ones do, I only see PWR_STATUS.

The BSP kernels for those oldies don't seem to have a notion of a TBU
either, except for toggling clocks that contain "_TBU" in their name
at both the IOMMU device and some DMA-capable multimedia blocks, which
I suppose makes some sense..

Konrad
