Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47F2E7198
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222134; cv=none; b=e038RmYiDzdgrHM3dq0pyx0Y3fGBbcoImh8o5IMkx6SrYFS6qpOsjnmB2gDfIe20t46kl1WZuFvCxc9vRpVj5zqtLJcp6B+9pULSnknk7wbSpTMT1if9IM52rNkxnfsFBdhmHgPPLkyd/97Zs5V2DDPARWFhdG3jfaut+UnYjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222134; c=relaxed/simple;
	bh=YlJ8V1+ApZkC/r28q9PHGeBZL7AI9JgB0OQJYpZ9wHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m87kEWvLhCR3hMj3t06zW97W49QWA1kfa1C2EzIIqlSyyJN9L0QLbG2EkuAmcNhHeLXONhavfazUcIyw0ZHUYFUJmrGF8mmgYYmpSkKeH8+W+r4fxBCpqwHDiuDkntg2jqmof1bfXKMCLtxsrwsjZjxKLtre63aA2GLoklqUvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvSBS+OY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNEBPQus; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvSBS+OY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNEBPQus"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8Hl27P008940
	for <iommu@lists.linux.dev>; Mon, 8 Dec 2025 19:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8yjmOYzXN+OctMZKMBsFTo1QqywLTcddJM6KrHURgSQ=; b=LvSBS+OYd+2eregL
	O0PXOxOfNBD1FHgof/+gg1nBzVqqG6ydlVohK3Wggpd/klUdsMhpbVe8yGfKjcio
	QUa6v6/8hzB1/vAU5KP4850ZHQe3smd7FDJHjiwQdpL18WwbyydMak0RMUt2Keml
	JBLwUtzKxXHF5j/8xRiSaHPUWe9VQ80GkwANv0aS/01MmxN1E84aklIB621bea5e
	PG+fCNCF8jNe6R5cpWQTIeNLSHFzqj2Lmd8yEC8YwNTwReCCMcKOj+q+YD4ZogwN
	pR5nwa08x2xaQPOVaO87zo769f6/UG1/1f5vbeNxvimfVnNuabop95FE4EF1vV7P
	v2hPtA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awvke1nr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 19:28:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7c240728e2aso8843469b3a.3
        for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765222130; x=1765826930; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yjmOYzXN+OctMZKMBsFTo1QqywLTcddJM6KrHURgSQ=;
        b=TNEBPQusKVRhP7nsRZMk4bO2w4jT0vKTx5EhzWMg2OeqTBAo+zpQGPNqpMJznF42OU
         /E2VX9/rGbmq3exLd+JWOe12tiBk42/z5mVua+oGO52h5YJZ27o6xPqBGqC1xWIFyJrP
         SAI28/MgB5yQPW/F60Rd3GyiW598xaievY3ZvEk3Lxazyq1MLw7uWD+RVrR1HCeKHtVr
         19cIUBm9cTdODlq5AKbWeVKqMB26nWXackZ9woRQ0pg0pwwFsGKydrojWYAc551bWh4F
         vDL4h9pwDDz07i8Qp+v5blHnbQGniCcJMBKXZPfsfce1IXC4ZiJ5vlqVpkjxfLmgpX5O
         utAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765222130; x=1765826930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yjmOYzXN+OctMZKMBsFTo1QqywLTcddJM6KrHURgSQ=;
        b=cMQG+zA6jVxJAAs/u5UKZ7Z+7FkYLtndjt/0t2AT8b7mklp5uXU3c2RKyUo0J9pzH/
         WT3Mf+5XyI2ML53+ZkE/u1+Kr7FkemGR0h2JeZltPmHatnHqsn5gyeIxmais4nhTKdxe
         pWQ7taSJxBDdsUd+ikIFjShLHtBOKgsMy0YLjcPvWL0IWagZLw4VVyfK0eITQiBPvElT
         eomiAHwVNJfyj9jYuoNUyvsA2kWLIA7ZiPgvIxpBTJ3SSUw1UwOZl2Dslj1ETcrucovv
         +YGOIyFPUP7bLCVrj8Tvgg4uMji50DZMaEfcV9IbNid9Mm8tW2v4jn5heVKLIfWjDQkb
         n3/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZTXDm62cnaikC0Mb2ASGq0+eaT+bIIFtobLYGib6j9h1wg9an6L8Gomnm4dlJH5Jqb665hw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2IJApExJq9sP4hQu2gfaUJ0LS7KWNlZhUnCVjRjm7v6ZRf6hQ
	NQmgxTXSWT08bY8UVYeBrC4hmkKStBcBrgFNVs5P6MXZZ3b9RbgytU/XCn4AE2tqNssKiVfE5Z8
	NO6oFICzvYFEkrrhAtNWGiKpq4qTZZHJ7ltef3XlL7sn5uMYbxro/5pWpIQ==
X-Gm-Gg: ASbGnctHNxX9CvF2T+jC+Msc9JCp781q06JKI8CuD5k9h7R4X8qOsQh51Q1XiYAXbj+
	4l+bgHPSDCUjoIlUxzpzW+Y9HWKKOXRn6Lkaa6YkH7r6B3DBnHlM1ZV7vh4iLYGDPlUi58hCRVz
	jh3S0eHlhexa1a5ylb1HbQaCKDWvVzquk/mjREyso4lQhNYIzyqckCLD0fp1X5kYuc54zGoXK+S
	D8o/G2UES5U59qhlShIx+BD1hBidrmWO/YzvMIM2cm1HSvBTLmMzPGlsylwO5GAVUllKLGypU7u
	k19Y6slokmBhUDV6vnIsfLVlVvL3tr31d/cf3rYc0d/Gde6Bnp5ECU/4kVif9p7If3rH0tt/MAI
	4rnyA5yj26gbDizATDxgKaKOiuoecydUcwWQ9DQ==
X-Received: by 2002:a05:6a00:23d2:b0:7e8:4398:b364 with SMTP id d2e1a72fcca58-7e8c580c004mr6248317b3a.55.1765222130207;
        Mon, 08 Dec 2025 11:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgn8R1nKUS0tnoxZy4qldCHnZ4XqbLpBA9yEzu93LuDAdycaH4O4tgmsv1jTQ8CYb1UTfXdg==
X-Received: by 2002:a05:6a00:23d2:b0:7e8:4398:b364 with SMTP id d2e1a72fcca58-7e8c580c004mr6248289b3a.55.1765222129672;
        Mon, 08 Dec 2025 11:28:49 -0800 (PST)
Received: from [192.168.0.7] ([49.205.254.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2adc5c17esm13814703b3a.34.2025.12.08.11.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 11:28:49 -0800 (PST)
Message-ID: <0bcd5a92-5213-4862-9a31-8ea539b1b72c@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 00:58:24 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] iommu/arm-smmu: add actlr settings for mdss on
 Qualcomm platforms
To: Bjorn Andersson <andersson@kernel.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, robin.clark@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251202125447.2102658-1-charan.kalla@oss.qualcomm.com>
 <gsjyj3arwoqcjln6nlmyhohlowyvkwqmxppdq5y7c3m4khoyq3@npzixjpibh5g>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <gsjyj3arwoqcjln6nlmyhohlowyvkwqmxppdq5y7c3m4khoyq3@npzixjpibh5g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SeY_CqYb68sZrY9DbyRdxq2PlP1L3zfm
X-Proofpoint-ORIG-GUID: SeY_CqYb68sZrY9DbyRdxq2PlP1L3zfm
X-Authority-Analysis: v=2.4 cv=UvBu9uwB c=1 sm=1 tr=0 ts=693726f3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=21F0Ij6J+em9RIwR2lrOkw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SVaDBRFF2uN27j_ulVgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDE2NSBTYWx0ZWRfX5Hvsw0Rsx6Tg
 50iCxVgl3yXsMmVB0AbmseRKDnj53o6CU5tYILKDbhajK0gifuwca4t4Gvkb7HT5iun7KmRPBZw
 b9VD3WrLP/p8HJ6tzREKgvXNqsJBvEMn4EApsfYZl2Ghe95ehnVfLFOlkjJzq59yu93yNMfFTqz
 OoWvQ84CHxij2Lg+RGIltV6AlNgAW+FCKrqUGKKjPMiuOnJoxlwAaVlh1a2eeIhc55i1FGC16El
 l8XFLrZPgSx2P0X9JiTcSXsmqkbYf6ZnsXXwvU7aExRsNP9WODRkeqEG8GS/p9o3rr7F6XvfuD1
 wQxxfV1XPIS9P0XDAZkmd0r91GtXzTnLmOGkXYrPOxDnuO1BYRzHvwWBiNcXlifyTADWu3IsB0a
 1aUah/Oh+/MyU39gXTJbaTT6nrHk4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080165



On 12/6/2025 2:36 AM, Bjorn Andersson wrote:
> On Tue, Dec 02, 2025 at 06:24:47PM +0530, Charan Teja Kalla wrote:
> 
> Based on the other changes to this file, the subject prefix should be
> "iommu/arm-smmu-qcom:"
> 

Sure Bjorn, I will address this in v4 RESEND and collect all reviewed-by
tags.
Let me know if you feel this change needs a revision update to v5
instead of v4-RESEND.

Thanks & regards,
Bibek

> Regards,
> Bjorn
> 
>> Add ACTLR settings for missing MDSS devices on Qualcomm platforms.
>>
>> These are QoS settings and are specific to per SoC thus different
>> settings, eg: some have shallow prefetch while others have no
>> prefetch.
>>
>> Aswell, this prefetch feature is not implemented for all the
>> platforms, capturing to those are implemented to the best of my
>> knowledge.
>>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> ---
>> Changes from V3:
>>   1) Add actlr setting for missing sc8180x & sm6115.
>>   2) Improved commit message.
>> https://lore.kernel.org/all/20251124171030.323989-1-charan.kalla@oss.qualcomm.com/
>>
>> Changes from V2:
>>   1) Add actlr settings for all the mdss devices on Qualcomm platforms.
>>   2) Improved the commit message that explain why different ACTLR
>>      settings
>> https://lore.kernel.org/lkml/20251118171822.3539062-1-charan.kalla@oss.qualcomm.com/#t
>>
>> Changes from V1:
>>    1) Added actlr setting only for MDSS and dropped for fastrpc. --
>> konrad
>>    2) ACTLR table is updated per alphanumeric order -- konrad
>>    https://lore.kernel.org/all/20251105075307.1658329-1-charan.kalla@oss.qualcomm.com/
>>
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index c21a401c71eb..149da53091de 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -41,12 +41,38 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>>   			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>   	{ .compatible = "qcom,fastrpc",
>>   			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,qcm2290-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>   	{ .compatible = "qcom,sc7280-mdss",
>>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>>   	{ .compatible = "qcom,sc7280-venus",
>>   			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sc8180x-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sc8280xp-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm6115-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm6125-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm6350-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm8150-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm8250-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm8350-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm8450-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>>   	{ .compatible = "qcom,sm8550-mdss",
>>   			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ .compatible = "qcom,sm8650-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ .compatible = "qcom,sm8750-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ .compatible = "qcom,x1e80100-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>>   	{ }
>>   };
>>   
>> -- 
>> 2.34.1
>>
>>

