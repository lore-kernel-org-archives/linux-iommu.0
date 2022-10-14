Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359B4680
	for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 22:11:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EIE0Uo011559;
	Fri, 14 Oct 2022 22:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FPyzwEtcJbBPcIiJlL3YvkFOzDcHrcosjSjnmq1JvJo=;
 b=I6leZrbZp0Jl0zTZz1enbSAr2kl3Lc2Y7vOfAXXUAjdJIXYFieRVvb3YWD5LOAK1XzzS
 XSM+EnvEpVgcGVmJFloFtN5hbxrlhizQkyxv8K2CxDKQY6vyPl7Be0Qll3dX9vA3LpWa
 Pllolgms3SGa4J9yvQ0KYkHc4aIPVkepY9g5g1mKvMq9CGewaXjHrrUbW1X9BMB3OKLg
 0xCMuxy7AVUL2UGlrFbGWfNGh/dOqDXS7CqBy79F/MAvu9pJYBkatfHTDCB/NTznS/2C
 8ErmXpuGi/6G+QaRN/9BK9XfRzGIXXgYyvWoXEyhUtuiIeL4zhBWQNchpkCJ5wP2jeH0 uA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k74eck7d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Oct 2022 22:11:13 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29EMBCiG005979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Oct 2022 22:11:13 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:01 -0700
From: Melody Olvera <quic_molvera@quicinc.com>
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH v2 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation
Date: Fri, 14 Oct 2022 15:10:51 -0700
Message-ID: <20221014221051.7434-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221051.7434-1-quic_molvera@quicinc.com>
References: <20221014221051.7434-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MmdzQArU2WKSIxMi2N-yoRe0Gm0P11cN
X-Proofpoint-ORIG-GUID: MmdzQArU2WKSIxMi2N-yoRe0Gm0P11cN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=851 mlxscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140122

Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
support for them.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..4f976cfb20d4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -426,6 +426,8 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8998-smmu-v2" },
 	{ .compatible = "qcom,qcm2290-smmu-500" },
+	{ .compatible = "qcom,qdu1000-smmu-500" },
+	{ .compatible = "qcom,qru1000-smmu-500" },
 	{ .compatible = "qcom,sc7180-smmu-500" },
 	{ .compatible = "qcom,sc7280-smmu-500" },
 	{ .compatible = "qcom,sc8180x-smmu-500" },
-- 
2.38.0

