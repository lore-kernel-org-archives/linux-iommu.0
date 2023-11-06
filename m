Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7302F58
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="buQOsQ/p"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A66CSYK016028;
	Mon, 6 Nov 2023 06:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VkGpU/7TQ31sXBgHpHKZUeIBvHPYj4KVKVTF9OXiVTU=;
 b=buQOsQ/pWY2cRdnNbTH1ID+aNuBwT0dlLB9zzAMRrdxMDK9Qg8HhDR5AMTsLTS2Zg015
 YOPmH+nFL4BcQxLOzcdMotJoBF9a3yXPyqsvkb0+EJxRJANGuosQLLAibVkBuZj0NgqQ
 wmsPZk2p+nEzKK5Zb9AqxkXeck1m06LGH5Twom6pmTx00wwD/gXUMiSy+OeKjcwwFvKi
 MNTWEf08I6dZBfh7Ly39QZ59RH+ljdLQYvIYGat1vFFMGIPT0t1pBoHwk2ztPphXDyQ2
 VN/JalVAaCIYY4X1HuvnPVomIZ1uFDZhACWgi/K3fNM9zslCqwfwdiyDWlsvlkxXFFVc NQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eg8k7hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 06:26:53 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66QqB3017170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Nov 2023 06:26:52 GMT
Received: from [10.214.227.50] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 22:26:46 -0800
Message-ID: <5fb7b0ac-8cd5-4fa2-ad0f-ddce5588e805@quicinc.com>
Date: Mon, 6 Nov 2023 11:56:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <quic_saipraka@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-3-quic_bibekkum@quicinc.com>
 <27b4a561-a2af-47a4-912e-6ee6961f0f6b@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <27b4a561-a2af-47a4-912e-6ee6961f0f6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ou52aC1zwgzC_qB4cw8SX9XTKBUxsjmw
X-Proofpoint-ORIG-GUID: Ou52aC1zwgzC_qB4cw8SX9XTKBUxsjmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060054



On 11/4/2023 4:59 PM, Konrad Dybcio wrote:
> 
> 
> On 11/3/23 22:51, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
>>   1 file changed, 81 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 68c1f4908473..590b7c285299 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -25,6 +25,64 @@ struct actlr_data {
>>       u32 actlr;
>>   };
>>
>> +static const struct actlr_data sm8550_apps_actlr_data[] = {
> I assume this data will be different for each SoC.. perhaps
> moving this to a separate file (not sure if dt makes sense if
> it's hardcoded per platform) makes sense.
> 

Yes, this data will be different for each SoC.
Right, adding these properties in dt won't be a right thing
since this is a register setting and not a hardware defining property.
As per my understanding passing register content via device tree is 
highly discouraged, so hosting this data inside the driver.
For reference, adding the RFC link archiving this discussion:
https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/#t
If my recollection is correct, some drivers like llcc is also
following similar implementation
drivers/phy/qualcomm/phy-qcom-qmp-combo.c
drivers/soc/qcom/llcc-qcom.c


> This will also assume that these can not differ between firmware
> versions.
>

Right, these won't differ between firmware versions.

Thanks & regards,
Bibek

> Konrad
