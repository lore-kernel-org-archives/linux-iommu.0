Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595671802A8
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726862368; cv=none; b=RbltQBjdJgXC4TzGnKcqxbi4kR/ZEHyLhbnnQWYzInyaGVe/PV2Yi4uCdUGUIv5gLsfLV0b+mMr/vx8c278iHmVWoK1ufrQ0OX9/PeSTWf1yDdiRZvuZhkJUBK5OP+l1m/6Ork9nJYJ3Du4p/ypUKXDPPHE4WJFXKF9CFav/TzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726862368; c=relaxed/simple;
	bh=0POx3q8JKAKOeUM6fqCXAUT0QuxaG3/ymjhihPYVVaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PBw7jBxrCh/oIAOxeUgsVN8BgNIfH8eRHq3cTmaQL0o7U7dpmpc4bblo4uLTs5XlvXD37gz7GtcdH3S6kgT7xWSYKJX0+ykXEc/8X81cdgw27sFkECe79jRWJHclmPdtlhoQoqK8RxbeY1n3+oTYLRRMQsIrGrbTks5vCHFo1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PyzSAqYL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PyzSAqYL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KHTrDP022730;
	Fri, 20 Sep 2024 19:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EmbrJ8ikRa2foOylVG97VSAY77d3x1ML6sTMBnN1rNY=; b=PyzSAqYLRQJp1vG1
	M04uEqOvy2Lc3t6vXG5goFI6zhsMMrDCOmDs321fyMoAI7WIOzz8sBSzdxBNH9ow
	hvTKhcnCXqOJzGvrN4aeaGyL5KvSv/6gNcJySY045Cyrt105ja+tr+rrbTvecNeb
	l8wOZiNCOGsKWgeL4WbtCOew6cGCpVq+XbRQyamGu8VgJCKhQ/dTuixJZOCYtLMH
	1p+5P8eECz8lXF7x6oinjwVCISdxQVZpLDQB+d6mbPYWMuvAYKpuONBejgkqzvKt
	uQkwwPRZjWxvqI7fHE6TQWq3w9A4+3JzT4Lgc60RNd8m4VFYm6PCIUN+Yy4GxfdW
	QnaMwQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gp2cvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 19:59:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48KJxCRC031866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 19:59:12 GMT
Received: from [10.216.31.199] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 20 Sep
 2024 12:59:08 -0700
Message-ID: <66af599b-85a7-40fd-b550-346013028394@quicinc.com>
Date: Sat, 21 Sep 2024 01:29:04 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/5] iommu/arm-smmu: add ACTLR data and support for
 qcom_smmu_500
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <iommu@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240920155813.3434021-1-quic_bibekkum@quicinc.com>
 <20240920155813.3434021-6-quic_bibekkum@quicinc.com>
 <xxd74r5zzobcsg6joty4rxxmj4gaiezmj6bqlcdbcyhshchqq2@ljpxtgq2dthg>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <xxd74r5zzobcsg6joty4rxxmj4gaiezmj6bqlcdbcyhshchqq2@ljpxtgq2dthg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: asbPLQWjL2K2PWBJQ6CplrzY8pjMvCub
X-Proofpoint-ORIG-GUID: asbPLQWjL2K2PWBJQ6CplrzY8pjMvCub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200144



On 9/20/2024 9:48 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 20, 2024 at 09:28:13PM GMT, Bibek Kumar Patro wrote:
>> Add ACTLR data table for qcom_smmu_500 including
>> corresponding data entry and set prefetch value by
>> way of a list of compatible strings.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 4ac272d05843..e8f936a446df 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -25,8 +25,31 @@
>>
>>   #define CPRE			(1 << 1)
>>   #define CMTLB			(1 << 0)
>> +#define PREFETCH_SHIFT		8
>> +#define PREFETCH_DEFAULT	0
>> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
>> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
>> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
>>   #define GFX_ACTLR_PRR		(1 << 5)
>>
>> +static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>> +	{ .compatible = "qcom,adreno",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,adreno-gmu",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,adreno-smmu",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,fastrpc",
>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sc7280-mdss",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sc7280-venus",
>> +			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +	{ .compatible = "qcom,sm8550-mdss",
>> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +	{ }
>> +};
> 
> Wow, this looks really nice now!
> 

I am also in favor of this compatible based approach now,
as it looks to be much cleaner implementation.

>> +
>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>   {
>>   	return container_of(smmu, struct qcom_smmu, smmu);
>> @@ -640,6 +663,7 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>>   	.impl = &qcom_smmu_500_impl,
>>   	.adreno_impl = &qcom_adreno_smmu_500_impl,
>>   	.cfg = &qcom_smmu_impl0_cfg,
>> +	.client_match = qcom_smmu_actlr_client_of_match,
>>   };
>>
>>   /*
>> --
>> 2.34.1
>>
> 
