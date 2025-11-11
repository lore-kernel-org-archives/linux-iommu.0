Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388F2E3387
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869762; cv=none; b=o7GhgyPZvOK1LENfYsXY3NNhRQ8C5CVyUluZKaY9HL+uMvr1zppYTjsGbDwKF4dxBlTfTyyHCS7RYqzknmoPql8CgXFCvWcz3gF4jUmYvLC4CZ9UwE7yyCmzSkicZ4gWVXxdQ8CULDtdUByJsy8rVW/wTBxt5AH70p+yaAlpTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869762; c=relaxed/simple;
	bh=3zBadCHd+/KC7ZT3xoUIUn7dtJivjsgHW8BdJhLYvtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+/55PJesmiVDft/4zmC2WqqCIkeJERxD5nRki0ANBXgg/aUaisG5ZEKR57z52o6QcZrVh8M5iS1t6ePPMvc51hyhO+6csICydJORIcP0aAG9KElwM3+Nn3gZbOqFpvF8SSjevC42QoWoB09hxCRdGZbyTvezDf2ezzvh/siHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hf+dU4YR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kPiY/xHu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hf+dU4YR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kPiY/xHu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBG4UY2425123
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=; b=Hf+dU4YRLIcNKlJ2
	gsE2oqcvGqftfY55dYlz2tvEImqUMg+zak1iZQw0gFeTs24slS4jAFe6jb8f8+s3
	G/bJSaTa8zUmXad5g3x02ijwM289tY6YlMfeaalZxvaNKGl5P4BpkkPOZ7VJtzMs
	itGgCaNkaiHDoIrhUakom2LYrr/timiYMyFOOcvpgbt14f+xBXvlTkD6M4Jn4zyL
	a0+7M+Qs5gFTZLTR4x7omxmi6jhI/j6dWkLerdIpheuOA4yMwSZtqUSqEpYJufR0
	ckkMop/c7WlX09PYtktzACIcslNqrIZEk7hrsbIsryTI6WvIxtWBYAt6x099Zx2n
	Se3/0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac2350tn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:02:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29848363458so6122595ad.2
        for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 06:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762869758; x=1763474558; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=;
        b=kPiY/xHuTphA5tcT4KZmNObBfk06UPkbFhVjqycmhyubILsfoXsFcDul/52CCA+Uv3
         V0OQS18O2siUmQlZMriFsJNNzTcJlKLe4nVnB3Q7bM5EKBT7CbFM67Yjrq9DvwvHAaqU
         NTnJrpeiZk9XZPg8hxBAnEHFcwSOIOpURfmugU9zJT2GROY7FpCl2L6Vrl1fnyjAXUa8
         bpuKITf8VSucmo1jzpRjBSS4Nhx5kw0YL13BhwyoNTDtLEoF4G91lNvk9vrQuRwt1GCs
         kMdCXCXlw+4ZmiwFjXrE3aq1eZwgp+kv5OpmNtiheZs9DTluQqHKBxisD6KbxyBZqLhQ
         n2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869758; x=1763474558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJWfgwNrtdyvBnMHITe3KIM5EMQeUThouMLka/eC6JE=;
        b=uau1l8jAeC8GS9r5x4tPqzU19vr0O/Iy/dloNSW81vahwdmTqZN47aO8WWxtwqxi1x
         ko2DV2VvysPgFSFkUxenxnyOUKClPJpaDuLL1g8IohFhwU0w9C5zygzKWjNkZ8ehmJNz
         KxnyZbXnM9tjiITGLeUhZf84Y3l83VhW/MAvOzFBEgI2+wV4I4mgEDBgO2mnRPuNTUHz
         AfyUAw69/sxaX5LsCucbia72mQJK4NTnRRy+0Y9GyFgpLI2R/4EykK1hRpUFwn+t8d9u
         YZKD1AcQo5SF4zDAtbME5ZHGFyApPsfKsk1SL1NvHWN2HnVMGITumYCMUEyboxDGXkDf
         JpUA==
X-Gm-Message-State: AOJu0Ywod0jjiWyUO8z1sQpCtLz8y3LGgeWc7Tf6Vghj7pJ8GghqW2ZW
	6CcbknWiyKl12ruTvuoLjSQ2K8KtXy5srJ4uhR0ZpCmcaONsnFheOLAsT3SWS1av1QTfGEiHPJt
	T6efRj3Ur4HKMXOXm9L0uRzC+iDnLjXOfclKL7+jwktZqijJcVA/New9dAQ==
X-Gm-Gg: ASbGncueLvO6M0B71MmFu+q5TeIRBkTA7qRcVVw9G5VWbdwkPHtKquo2HPYPrsxtgdL
	1XRZw26+uFen23CmYBqfO5asua/AlJOZees5UQXVGzVLpNNPpfRR1s1qKJEpXFOtrWCdRcj01Iz
	dhKZ+vPgSquW12dt04pgZNFVOdv/oeKSmtz8NvYbfqQdHgnEJpPEIK/GqP1xB9cIgP7NwwS6C8O
	7jPWXkIOVfVQSRvnYI/KCHaqgl8RB9nVfUQC0BTBBEPXHjR8OUFzeGfv9H9aDI3RL5nXVRtkQPn
	uxas6+X43wRYX5QLSEmm2w6+jZvD/z7ndg+5N+maEKdgWaK0h89KEltrR6BYda0D9amXgGC3cIS
	DVJwNvulZlxfWKPIGCcECIYKxd40=
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr148629185ad.27.1762869758237;
        Tue, 11 Nov 2025 06:02:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiZPxmew9Sypb7WTasJeWopHkpr+MEmcvloHkOX1op3HrOtm8qCTT3mhOislac4qaeDoTYnQ==
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr148628355ad.27.1762869757396;
        Tue, 11 Nov 2025 06:02:37 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff848bsm15461660b3a.29.2025.11.11.06.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:02:36 -0800 (PST)
Message-ID: <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:32:31 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bibek.patro@oss.qualcomm.com
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMyBTYWx0ZWRfX+rnu8dMFNseA
 HEpT5ZM/nZWCxge5c6DY9oMfF+pt/UU/DDtyy2fUSKyEsRJOmp1isua4N+EJOtlCuX8RG4l+L4O
 n+1HG9RPcP6gh/E4vERPNDY3l/HvwdQSodRY9rPhnDyB6w2HsU2cBwoZwtNZ4aiWphNRKIoojJA
 GCBx6U19zK5/nSjFcoPT5MJuy4h4AK46s3xaXxySIRRwwXarrTI294VZUqjqHBs4jkmUmBIXHIq
 u/8u3VJcMg/8Yq1HfTvRLXLqb5r7eeJU5ZVCYiogFtaUNhw5R+5UhFZv1l616SrCR7wsCMZ/BJ5
 ZaKbs507fOJLpvKd+L3PCvTqa6UlHg2OKsWuo8YDLPJq8vYWjyNlajPGkHghP05Geze+Gq1tQCF
 nZmzgC8XkFQeBG0oyb381Uu99pl3Yw==
X-Proofpoint-ORIG-GUID: FFS7n8m-CSxas27zZ3NLQKENcpdQVHBM
X-Proofpoint-GUID: FFS7n8m-CSxas27zZ3NLQKENcpdQVHBM
X-Authority-Analysis: v=2.4 cv=O8I0fR9W c=1 sm=1 tr=0 ts=691341ff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=K3xFcsKITfcsgejFPk0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110113



On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> This will be globally applied to all smmu-v2 targets with fastrpc,
> starting from MSM8996 ending at Kaanapali and everything inbetween
> 
> Are these settings always valid?
Oops, you are correct...this settings are not always applicable it seems.

Example: lpass compute and cdsp compute node uses the
"qcom,fastrpc-compute-cb", but it is for the later that ACTLR settings
are valid.

Then for these cases, should we be extending the actlr match array with
additional compatible string and then add them in all the device nodes
that require actlr setting? example:

@@ -3119,7 +3119,8 @@ fastrpc {
      compute-cb@1 {
-         compatible = "qcom,fastrpc-compute-cb";
+         compatible = "qcom,fastrpc-compute-cb",
+                      "qcom,fastrpc-compute-cb-actlr";


--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -49,7 +49,7 @@ static const struct of_device_id
qcom_smmu_actlr_client_of_match[] = {
+       { .compatible = "qcom,fastrpc-compute-cb-actlr",
                        .data = (const void *) (PREFETCH_DEEP | CPRE |
CMTLB) },
        { }


or any other better way, please lmk.

Thanks,
Charan


