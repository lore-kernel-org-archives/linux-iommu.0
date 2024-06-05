Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6821B4C40
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589934; cv=none; b=b9UdW/tyxKA1YCjmdMbmkUqM6U8o5sKHS0nqCSDWncNEt1WlxFHdiDn7zAIZItwgl3ppgDCxNgjoBmDwhT/9qNAffL4LiGHSbGpVJ/oSd+CmzpyzBIRNDn5r+YDHhSYdKL14RyeSPKBQglNlNWd6QmzbEZnUTYc6IEpPTTO63TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589934; c=relaxed/simple;
	bh=VYASND7DkjxIdSKvksdElZNKwr1G8BS4C2AWVcyC9ZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT5f0/7s8KJm8m8iqeACWmPo+LjNWOJGyKNIfbRQFh7/CJFxXjJ/+0F5TAOgst2wH4F2xiGTZwlkanLtLzczmBOfx77t5gECM99UT2/ylOPUQcWOhWfWWgiJN7qkdUbCLuXFbPiJoDnUPz2kNBsApjT6UKva7eaClqxfyDkj0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cDn1ci8s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cDn1ci8s"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455B1R1V014610;
	Wed, 5 Jun 2024 12:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6gTuD659RBNpe4VbArDAG26UrZnRn8ECIH/vQ20wfOg=; b=cDn1ci8sLIClZJoA
	Jh4+U5cUon+rmOs302TZoMZgulqPfQl28Ru7x7JSdzq4x/Wh4MBkFIht6bN4vAda
	XcOo6UX6c/Nzy+sGHogi5fSTlpxGAPBpQ0R/qBxS5ZJTcsafbeWm6lN/fNiKVd5c
	qOnmB0uZkqxksaI8/N++UoVKx7m343QP3xkGOfOjrDk/7yl61f1k1rqa9OmHTs95
	I8GjvSDRGCw9z35HFSv29tFy+H7hWlV4zIK4RyhyyfGh4izt9B8nHSBAVoIcE+eh
	eO3/Ai3DoFvAOxS6SmxATf/dV1q3a8zLFOQPDCjvtyYjGczqOEtcZCPIdIIu9KAB
	ezsBPw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj83021ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 12:18:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455CIeOc003525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 12:18:40 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Jun 2024 05:18:35 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v11 5/6] iommu/arm-smmu: add ACTLR data and support for SC7280
Date: Wed, 5 Jun 2024 17:47:12 +0530
Message-ID: <20240605121713.3596499-6-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605121713.3596499-1-quic_bibekkum@quicinc.com>
References: <20240605121713.3596499-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9zMrBBYAWopiT1BgbQobIbLAdT3DGXda
X-Proofpoint-ORIG-GUID: 9zMrBBYAWopiT1BgbQobIbLAdT3DGXda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406050093

Add ACTLR data table for SC7280 along with support for
same including SC7280 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b4521471ffe9..8dabc26fa10e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -29,6 +29,32 @@
 #define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
 #define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)

+static const struct actlr_config sc7280_apps_actlr_cfg[] = {
+	{ 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2000, 0x0163, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2080, 0x0461, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2100, 0x0161, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_config sc7280_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_variant sc7280_actlr[] = {
+	{
+		.io_start = 0x15000000,
+		.actlrcfg = sc7280_apps_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sc7280_apps_actlr_cfg)
+	}, {
+		.io_start = 0x03da0000,
+		.actlrcfg = sc7280_gfx_actlr_cfg,
+		.num_actlrcfg = ARRAY_SIZE(sc7280_gfx_actlr_cfg)
+	},
+};
+
 static const struct actlr_config sm8550_apps_actlr_cfg[] = {
 	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
 	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
@@ -685,6 +711,13 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+static const struct qcom_smmu_match_data sc7280_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrvar = sc7280_actlr,
+	.num_smmu = ARRAY_SIZE(sc7280_actlr),
+};

 static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
@@ -711,7 +744,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
-	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7280-smmu-500", .data = &sc7280_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
--
2.34.1

