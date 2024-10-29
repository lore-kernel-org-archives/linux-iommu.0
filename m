Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDCC13D
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205661; cv=none; b=Hs70zWZ2oGVfVBp26mok17wfNjZBE6se7FGmLnGQSIOj+pPcP3VPbIrV9vTAZJsMa80e/tfVM/8PieA7Bzv5C6jHhByD04dQ4Nn+JlMk5RHPDfO67Nn+lS69RW8sHucGXzKFHrczNq5jUWOy2nSPFodmRThnioLZ/ny3mvnfEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205661; c=relaxed/simple;
	bh=GFVptMt7j5UPyeDTmnLsWXd0TUp9FSvwUHfPswHg9BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RglrpB2Qbk0KF++Stp9Mk/xYmAkXu+YWiiuiYJ+gudyo9GRlWjVK3Ljok1Html4v6iXCQP4/zD0zVYVBRE/JZTYCwONN7TkEbRcecK8ZSBbKGUtmIcxcSq2+rFjHGZ4FLglbBOaTNQfyMrFCJmyJnsv9SEX3OHu1wv5gn1RfzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UvdtcJjU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UvdtcJjU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAB1o6027417;
	Tue, 29 Oct 2024 12:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uR2QnOB4FjsWmv6ZTuBOqwwcWWeLGPQ3m1e3eLUEECw=; b=UvdtcJjUFPJmnOBs
	DXcG3e5Z6VBw64zqbB6BQCstf9DENnEGkElNpDRfA1/PaPNN6gpNMvO0x1Lky4rj
	TZb00AwUx9Z/fXTRRQ/gPLPNG6XnwLqPzfJeMwR2cRIYc2WgBNBQXY/9DwfWv7sZ
	siKtZukBOjbGuqDGrvXdLh5cSGwnFqGSAYYqZeizFjAtjHPMP65xNUYs7soJBuhl
	kRxCFLhxNllDYMchgZ02BTOx0cnXUh+Nk7P7PVQHhrqnj23LSifxjqs61HCCZBxF
	TZkmAszBSGS/2cfkOtVnqenM2yRA4OpCm9G8EhbMYZZNZlilrNmifTpuVdeoDtY4
	+DLyOQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x8cjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:40:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TCei0a008098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 12:40:44 GMT
Received: from [10.214.227.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 05:40:39 -0700
Message-ID: <1e495126-e398-42fb-b53c-99a07a0e8320@quicinc.com>
Date: Tue, 29 Oct 2024 18:10:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/5] iommu/arm-smmu: add ACTLR data and support for
 qcom_smmu_500
To: Rob Clark <robdclark@gmail.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jgg@ziepe.ca>, <jsnitsel@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <quic_c_gdjako@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <iommu@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-6-quic_bibekkum@quicinc.com>
 <CAF6AEGtOn3+99KMVRvpH=8Qs-g52ajVQyeBkxThSES_dEdVH+Q@mail.gmail.com>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAF6AEGtOn3+99KMVRvpH=8Qs-g52ajVQyeBkxThSES_dEdVH+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OUA74DkuIRlYApguRMjf4zSgb0mtrHmy
X-Proofpoint-GUID: OUA74DkuIRlYApguRMjf4zSgb0mtrHmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290097



On 10/29/2024 2:46 AM, Rob Clark wrote:
> On Tue, Oct 8, 2024 at 5:55 AM Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> Add ACTLR data table for qcom_smmu_500 including
>> corresponding data entry and set prefetch value by
>> way of a list of compatible strings.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 2d2c1e75632c..dd4fb883ebcd 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -25,8 +25,31 @@
>>
>>   #define CPRE                   (1 << 1)
>>   #define CMTLB                  (1 << 0)
>> +#define PREFETCH_SHIFT         8
>> +#define PREFETCH_DEFAULT       0
>> +#define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
>> +#define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
>> +#define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
>>   #define GFX_ACTLR_PRR          (1 << 5)
>>
>> +static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>> +       { .compatible = "qcom,adreno",
>> +                       .data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +       { .compatible = "qcom,adreno-gmu",
>> +                       .data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +       { .compatible = "qcom,adreno-smmu",
>> +                       .data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +       { .compatible = "qcom,fastrpc",
>> +                       .data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> +       { .compatible = "qcom,sc7280-mdss",
>> +                       .data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +       { .compatible = "qcom,sc7280-venus",
>> +                       .data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>> +       { .compatible = "qcom,sm8550-mdss",
>> +                       .data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>> +       { }
>> +};
> 
> I guess by now there are some more entries to add
> ("qcom,x1e80100-mdss", for example), but I guess those could be
> followup patches
> 
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> 

Thanks everyone for valuable inputs, reviews and ack.

regards,
Bibek

>> +
>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>   {
>>          return container_of(smmu, struct qcom_smmu, smmu);
>> @@ -640,6 +663,7 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>>          .impl = &qcom_smmu_500_impl,
>>          .adreno_impl = &qcom_adreno_smmu_500_impl,
>>          .cfg = &qcom_smmu_impl0_cfg,
>> +       .client_match = qcom_smmu_actlr_client_of_match,
>>   };
>>
>>   /*
>> --
>> 2.34.1
>>
