Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73481321445
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157024; cv=none; b=U297W5m+NL6nzpwgQg/HW7HZ2hyPdsPaxw6JH0Jcm7c1ZUYpbvvToW9COuEckIGJ5uv8Saki0UJfRdoLkE1VGbQUNOCsQg27SjAnoMI/++XB4VdInGaNIY1lc61H9eBpdT4UntYap1mMrJ111s8Wuky6Rgx5S1R69S0s4f3bQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157024; c=relaxed/simple;
	bh=OroEQxNuErxkPdcefyp6oQgjJWcJq4lHntV0hjVk3Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdLtiqyDhJiLIagfRAzOOE6C5bJYfw9rFOqoozU9YBR7J4GHeC1ocW3n7wxAIZybbymBrk7nVu3wL3E3rykXDyMbz9ofhdJdlo2OP/IA3TzsVAuWwgxcPmoyo/QbtYZTaDoks1OTZDkVOCkU84Tb09QQM4Ue9Y1odNhQ7/nFRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3t49/jM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FpLIAegQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3t49/jM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FpLIAegQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQAslei1700320
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7wL86qO0oKaO/DjZXseg3w5mkQK3ruQ3+V4DE+9KOg=; b=Z3t49/jMrsKcJdlm
	Htc7/UAbA3Icdtkgo2A5+gdO7IFEpaUxkuOsAfjgIwis8MOd5DMNlvUwcmPG+VLz
	qFxe4Xyi9gHbYRtordCxbeSawPZN/8O63qTvg9EbpsP8wpNK+6cgU+tpdf4TgBG3
	XiPcgQML8hqllTl4tbm6SY+tFEgZp/U8Qt4aU9S3sJy2ukKDhtyK+eGgGPxh3Lru
	LVmSAvy8fGjggl+AkSgOWfAXyxh7iYMLf2HT6SeDFcZiBVL0DKGWTdGJ2R5cQfY+
	BcsiMErlygjjDUUJFDUVj/MHh6MfBPDxKr/LWFAeDcbtew6AMm0HihV5EtWUiAuh
	03sBcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap07a0369-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 11:37:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29557f43d56so83828325ad.3
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764157021; x=1764761821; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7wL86qO0oKaO/DjZXseg3w5mkQK3ruQ3+V4DE+9KOg=;
        b=FpLIAegQ+HuVKOzL66efXf9AJzk4LHTN2fVe6NnrbzJkBq4eDtFcOO9Lp3j0HvXTOx
         NNk39auEbmp534+CrNuBanviEHRWbsqQGqST4yMhf9yGBCWyoOyJEy98AwPryuYstxnN
         shg+tf8+alq8whddiXvoO6Ue7D6otXLhN/LsQqK3AJYCJXiCvS/EeMfk5AXI2S/bODg0
         FRuTjoSriIXcQRimeA+/Rj7kgsfYmgGZlYctBoYGfftA7dIgUoYl2Y5Ou7RPoBzZ6sgX
         0SGGePFeMCI6+FYBUMqp60g1oNpP6nO4TLjX+s+e63BlGf+DYeU+XjxagaLC/8ZhNyvL
         XuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764157021; x=1764761821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7wL86qO0oKaO/DjZXseg3w5mkQK3ruQ3+V4DE+9KOg=;
        b=StNT5JqdMIl7vu3Fx/TooKdP+9hijEShfXP7gW2TxPNz+IWhMNsmyM263qfT/EW++8
         R5nh+1iwjahMF0RNOUPSlRGrovbWiU/Y3n9++95WzNS9wPfNJNdN8aBWhjoHetYTHIav
         wHsrJqnA8WZM/l3LhnZXeuOTQ5K0214bk/0sqUmrfNzw2RNy0y98713atOKVEklrpv54
         hcvWnhrHF103czLXD+5qz62xSpDAMBQriLVr3y/XAGPMV+vA4yUc53DKvxhd+qSLKz+0
         rmZtRedq11ElhsN77GWzt2E1EPHvu4M1IX2lLvfdqvf+RFsyLR4+GAzs2rfL9BmqYtFw
         5WBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgy1k23AFrgAeY4NsP72Jezrcwu5SF3QeW5izTy/RuhrYDU1wNKpoDAvTB+yr+g+K6aNN1LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNk/Q6Q3e6dIHAhUVG1ycOL4bnc010prI97ab93RAD9YIYxfqw
	RDudxwjgIyzI4yOULzk36wvzlmT5EiWF0Etqd/ok24l4L2S/1drQ3RznqBAN9pWe6UgwDxWwSBk
	sMXgdlENMpxAUftA5jneSGKYBhJVggFm2JmE6v5sTt0qIQYgNWH9XntgTWA==
X-Gm-Gg: ASbGnctiTTNoY3Ut1F8uoYT8VRPbVZUasmlJNkEviU0w2SkNRvCmo0PT8RtKw+8LR8Q
	UYuazRG5L2ybSvNQmBLXF/Z3KhEvHI+oKA1/MaiMC7XfpsbP9vzGUQHaPsRyD2GjN/uoY8zHSRB
	4LsbjtUoaJcUNdzWEsO09msY8L5VSywO81kGXE62taIcjjSU6usP1ka44aRSHTYrIfCzEMsC+y+
	lUHkOoMUb0lhkYdyqd7YQRXNq0LzjT0D3U1aH2AR7k38FS2U4zLnpO2YA0pReLMDDWQf/36f9QD
	dvt2iTNv6t5YDGK0BVyYackV6an7LRPyzSVNQAg2GnWsqBrfMd8HWhjsF6gN50jIOb2JlPusOfr
	7D5/LxYjvAQtjufU5nm+5/mWWTBrfPiE/UTjElg==
X-Received: by 2002:a17:903:298e:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-29bab1c4637mr65576615ad.50.1764157021062;
        Wed, 26 Nov 2025 03:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQXyiz49GT5zKYdi/kZ0uOjBr42OLzEjIX7mTPnUd1lYdVYntNAehTvWuyqVwPOqP1KTldPw==
X-Received: by 2002:a17:903:298e:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-29bab1c4637mr65576285ad.50.1764157020606;
        Wed, 26 Nov 2025 03:37:00 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b12f988sm192632605ad.27.2025.11.26.03.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:37:00 -0800 (PST)
Message-ID: <81cdefa8-9bc9-4fb3-ac7f-afb34f70e8de@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 17:06:54 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] iommu/arm-smmu: add actlr settings for mdss on
 Qualcomm platforms
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251124171030.323989-1-charan.kalla@oss.qualcomm.com>
 <6zyysrrq6mt447s6rg5sk5vy5w7ulzub4u5m24xw3xo7edguwu@73vtynhdp7nx>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <6zyysrrq6mt447s6rg5sk5vy5w7ulzub4u5m24xw3xo7edguwu@73vtynhdp7nx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=6926e65d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YkchOtpOlfnu4Q9Yy4sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 4-PB_UDHIdlWlX8-kiPW_aqg9dUQKprO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA5NSBTYWx0ZWRfX0oWEiaP+2rjt
 hknUCS33BteWlKj3ReqzVEJyyLk+PFw/y8645lgNBccY80IQUGyNVA/PjSPg2AHH9xHhY/hvqci
 JO0HJf56ubU+mBAzBh+OQvzijVP3cmtMNldA8F7lkd9Qi73jc570wX/NcSi/4kPgjmgovFsHvNi
 3z4WSkqHw1j4Lcs5g0hkXAJBgdyRC4yo9IdeM7YcDj+HkF9KLvrRTO+82Jzlwjddx7B4WJYttTt
 ayRvmQpnnfLVTAvEWyuZxH2bTobay/DR9KugTprPMrrHmfAijCEWK/Xz4W55scyjuVxvEMeF4oa
 PBdDkx1DVrv1l5ZGy6YFpdc/N3zPhphrtqcyUc9nr5rCluNtYVAsf0r2hQc3lTIp7gJlN8a+B7p
 9v2VRwQIBzsR7XI67yTbfqyKMaVhkQ==
X-Proofpoint-GUID: 4-PB_UDHIdlWlX8-kiPW_aqg9dUQKprO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260095



On 11/26/2025 7:21 AM, Dmitry Baryshkov wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index c21a401c71eb..ead1a59d40ae 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -41,12 +41,34 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,fastrpc",
>>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,qcm2290-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,sc7280-mdss",
>>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>  	{ .compatible = "qcom,sc7280-venus",
>>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sc8180x-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
> sc8280xp? sm6115?  sdm845? sdm660, msm8998?
8280 and 6115 is slipped....will update in next revision.

This Prefetch feature is not implemented for all the platforms, I
captured only to those that are implemented(to the best of my knowledge)
-- I will put this in commit message.

Thanks,
Charan




