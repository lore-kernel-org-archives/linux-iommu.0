Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036E1C0068
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583561; cv=none; b=ryY+T2JMgkhOW8sxnEYM/gDfg9tc+gFfL1POubogxoRM2bs42ssUccBYUASoy4DiEXzdlKSJYljl5TjkxoosnngeTRwgH3IIbr2BnR81R/VbxmUCAhmcDhfbaRWaAawamqQh7wsnzWjoQVh0JCf4J+2wIQbt7fUhH+14F0u+Lu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583561; c=relaxed/simple;
	bh=it19IheeE2hCORAR1MAcTTypTSRLVKmc9hMQIuAmbL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7SNGwj8yP6Lg9XavbxesutH2+OAfQySY1+kuTTopgPowRK44DYrUDO+vTVd0Io/vSLTxCBNd8FAK5f75kdMf2nSn+jtpeh/on2jcQ/znOBoy0Zfa6QxM/pUtsJSfChBZti/8eg5H1FV2UEDFrIT8JOO9mm7vyKIkwADSUBZKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I0lWY5mg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I0lWY5mg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SCQvuq016563;
	Fri, 28 Jun 2024 14:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ePgUfKZIPR/DG4FR3Sxet8R775qj3y3ubRTBsl+A2w=; b=I0lWY5mgn/cOQ+Sq
	o2uhUp2eqkt6l7nSnAr1vw7F95gOE6c841+H5jEsQBPFmHxwfdJ860XiCx6EK4Ve
	U4cO9AXPtg4Pq5LPIjoIGpUgSlZ4+Mv2NkVhuPt6KH5kBr47IskpvQNcT7l96pjr
	MvuBRBGVkbOV8uSj+ssjJqX3lkoTgdwYjRA/Z62FXORtp2gCUBc+Hs9AAXaAPp+H
	dGLTOWmsf6UJYX+8FWv4dfVatLKXiL5dLEURdd/SnX1RgAEs4pGHXVuYzXvNd83D
	XuhlVuJ2fzb2J1KmcK5CQxpZoXFh3yHNPvPjmPwnfd4Q3hkuun8k2Q72IHHtCX3i
	cfaXxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm5sg1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 14:05:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SE5lnN002709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 14:05:47 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 07:05:42 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v13 5/6] iommu/arm-smmu: add ACTLR data and support for SC7280
Date: Fri, 28 Jun 2024 19:34:34 +0530
Message-ID: <20240628140435.1652374-6-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lLHyEk7v82urozZ-R6CyTHXbgf8Kdd3O
X-Proofpoint-GUID: lLHyEk7v82urozZ-R6CyTHXbgf8Kdd3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280105

Add ACTLR data table for SC7280 along with support for
same including SC7280 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 58 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b4521471ffe9..bd101a161d04 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -29,6 +29,55 @@
 #define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
 #define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)

+static const struct actlr_config sc7280_apps_actlr_cfg[] = {
+	{ 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2040, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2000, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2062, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2080, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x20c0, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2100, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2140, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0900, 0x0402, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x0901, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x0d01, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1181, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1182, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1183, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1184, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1185, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1186, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1187, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1188, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1189, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x118b, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x118c, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x118d, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x118e, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x118f, 0x0420, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x2180, 0x0020, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2181, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2183, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2184, 0x0020, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2187, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
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
@@ -685,6 +734,13 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
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
@@ -711,7 +767,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
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

