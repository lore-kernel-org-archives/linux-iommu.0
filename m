Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BE249E6
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820161; cv=none; b=bMKijkGTDzo6vElxVmkQN/yV1Ol6j144m+iLItD5ObIECNTcEPdUtQpXFuRu8aOzeY7+LkxpFBsI4vpAJNxeR370cSLVgRFondenlwSkCM4Pac4tddq2JtzHySaKuxDDiy5IVG9fZ7lc03EHTm8NH4y1F9ZhUi6LwvtSCB6Y+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820161; c=relaxed/simple;
	bh=1MtHBzrAaVaupNPIKmMCHFWFqYJTRYrNVYPx/Ra5p3o=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=DexFJeAZ/x5mhq7qHEFM3my3BC1DCSpemyJ4+KF56C176GlvlNPhtvYgAOOs27vDVmjRGeOVAL8POGFVCJkPSJg9fBa79sAie9zNtwTX2b5O1vJPQeuSIpwiGRsRDgI6RgJB0IaxYL14eAYuF/2D2cp6Elh4/tKJEAKHM4/8fR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LubQVgbX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LubQVgbX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DAQrwY015569;
	Tue, 13 Feb 2024 10:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:cc:references:subject:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VegaMagVQniNscL7KTdqEiW+htF2BU6YuYFykpHmS/k=; b=Lu
	bQVgbX395WsLssF16sxG0yO7jXQlFKhPK2rlCmFx0OKFs4WGOywUA3mZn6XojtNZ
	rZrSfzAdtk41fyBD7ulpDe7UgfoBb6rcYjO1oI7n7aY3cEodn0SX027x0e/FS4QM
	Z3ufKRxue+wJLP/LaeAA0T7+4/jWMViq16P0QfhfMW3Qua5yZNFDGI6IdjH99vvg
	uIFNwxK10Io8EBozYmlHG32NTK/Dbu8ts5OKGWdYM2qqjmdXKbmlH8NFZbYQH9cK
	5wZxh45+mz8feQMgKpoeDRYO+idPQcugWQSoM8Gqzv3n961QRlHcPep+a/H9NKu+
	iNil0VhJngyrntcPbp2w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk9207j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:29:02 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DAT0Qg024709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:29:00 GMT
Received: from [10.214.25.202] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 02:28:56 -0800
Message-ID: <a61a3561-0dde-472b-b8a5-451703f6d8ee@quicinc.com>
Date: Tue, 13 Feb 2024 15:58:53 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_saipraka@quicinc.com>,
        <robdclark@gmail.com>, <robh+dt@kernel.org>, <robin.murphy@arm.com>,
        <vkoul@kernel.org>, <will@kernel.org>
References: <20221114170635.1406534-9-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v1 08/10] iommu/arm-smmu-qcom: Merge table from
 arm-smmu-qcom-debug into match data
Content-Language: en-US
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20221114170635.1406534-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ay6v_HvyIMErZ2r65D3_MvV26FYlYaVb
X-Proofpoint-ORIG-GUID: Ay6v_HvyIMErZ2r65D3_MvV26FYlYaVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130081

Hi

Patch [1] introduces a use after free bug in the function 
"qcom_smmu_create()" in file: drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
wherein devm_krealloc() frees the old pointer marked by "smmu" but it is 
still being accessed later in qcom_smmu_impl_data() in the same function 
as:

qsmmu->cfg = qcom_smmu_impl_data(smmu);

The current patchset [2] implicitly fixes this issue as it doesn't 
access the freed ptr in the line:

qsmmu->cfg = data->cfg;

Hence, can this patchset[2] be propagated to branches where patchset[1] 
has been propagated already? The bug is currently present in all branches
that have patchset[1] but do not have patchset[2].

RFC:

This bug would be reintroduced if patchset [3] is accepted. This makes 
the path prone to such errors as it relies on the
developer's understanding on the internal implementation of devm_krealloc().

Hence, a better fix IMO, would be to remove the confusion around the 
freed "smmu" ptr in the following way:

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..6dd142ce75d1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -463,11 +463,12 @@ static struct arm_smmu_device 
*qcom_smmu_create(struct arm_smmu_device *smmu,
         qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
         if (!qsmmu)
                 return ERR_PTR(-ENOMEM);
+       smmu = &qsmmu->smmu;

         qsmmu->smmu.impl = impl;
         qsmmu->cfg = data->cfg;

-       return &qsmmu->smmu;
+       return smmu;
  }

This is similar to the patch[4] which I've sent in-reply-to patch[3]. 
Will send a formal patch if you think this approach is better.

Please let me know your thoughts.

Thanks,
Pratyush


[1] 
https://lore.kernel.org/all/20220708094230.4349-1-quic_saipraka@quicinc.com/
[2] 
https://lore.kernel.org/all/20221114170635.1406534-9-dmitry.baryshkov@linaro.org/
[3] 
https://lore.kernel.org/all/20240201210529.7728-4-quic_c_gdjako@quicinc.com/
[4] 
https://lore.kernel.org/all/20240213062608.13018-1-quic_pbrahma@quicinc.com/
