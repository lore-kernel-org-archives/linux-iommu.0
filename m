Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDB15A1
	for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 03:35:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R2qQOj002227;
	Thu, 27 Oct 2022 03:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=33NIuSYNzOO05hbofDZi/bF0xKHZRlSJ0hT4/S60smk=;
 b=TGJVQt+MCJCI98oJ74AMpKx3OoAM1cZtC69KgqMMWy4H3Bk6wTIGKbIDFDHkU4212+n3
 7Yditmx5s90hU/M0RT408XUjGNS0DE0UxcMO6MA5+0/WDkBtNivCPMchAtp9iKlAqYff
 KNxMRUziLKKlXTne3W0+92S2Sjq1rOCja7U0LeXTB5wWmEpERgzmPtea4FKfubfE2ko/
 UuB4DrktbV37wTA4NL9N2SwGSPriE93I29U5AW/rNfxPWIQ+Ae6GYd+OzJ1H0GC6kmWO
 sW+HXMj1WjB4rRytZ+bkPxHvshuiXrZUG0MKSyP9jQCJxnWEiAk+kPOw+DEM2wtGZxou Jw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahw8x7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Oct 2022 03:12:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29R3Ct7p027979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Oct 2022 03:12:55 GMT
Received: from [10.50.1.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 20:12:51 -0700
Message-ID: <6d15055d-2f63-c041-c9b9-46a1b03571ea@quicinc.com>
Date: Thu, 27 Oct 2022 08:42:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH 9/9] iommu/arm-smmu-qcom: Add generic qcom,smmu-500
 match entry
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel
	<joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>
CC: Vinod Koul <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <freedreno@lists.freedesktop.org>
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
 <20221021165534.2334329-10-dmitry.baryshkov@linaro.org>
From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20221021165534.2334329-10-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o6ZTWXhDcef_8RxqWU8dja1wnmP7PNzz
X-Proofpoint-ORIG-GUID: o6ZTWXhDcef_8RxqWU8dja1wnmP7PNzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270016

On 10/21/2022 10:25 PM, Dmitry Baryshkov wrote:
> Add generic qcom,smmu-500 compatibility string. Newer platforms should
> use this generic entry rather than declaring per-SoC entries.
>

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 9abc40c00f3e..3be81338a25b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -493,6 +493,10 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>   	.cfg = &qcom_smmu_impl0_cfg,
>   };
>   
> +/*
> + * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
> + * special handling and can not be covered by the qcom,smmu-500 entry.
> + */
>   static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>   	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
> @@ -511,6 +515,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>   	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>   	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
>   	{ }
>   };
>   

