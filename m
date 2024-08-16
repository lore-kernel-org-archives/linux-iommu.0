Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0931C3F3B
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830245; cv=none; b=h74tB6yYsFJlW/+8MZ80QeARGtWFp/JycJngzDjbyYfJG7TqeGEHganE9AxuxIye9WcZNvXv+GJOLLXZvNGRr3kWBfYXkCZSkvt07P4GQAweYQJVxyC9r3AnUoT4o5RVDqWBGnBIj8f5mjbLctKGON0KIvIaFtgzVxemhByaReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830245; c=relaxed/simple;
	bh=UlJLW4VajG/W1Sg0FjYTf4N6uG1NBMm1QNb8MHliAN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u86T/FP93ec08Vki0pxPFhUQAfNOW7ALf4WzubFPB0Q4MNQBGXfPcROauiMee5DnRSHvDbU94qYh7UDG86pwiKIqMYUuJ1rPf7lEwx6OELXzKxe7yNOoRQsJnt23alWR9NucUMC1cLLlGay9v/1txlHwVKEvO07o4NjKFiSKn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POCf4O5Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POCf4O5Z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G9Fs8T016985;
	Fri, 16 Aug 2024 17:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gE0mM/B23z5ypQZnNCmMo8ijg17pajgKAYvEA2yh5aE=; b=POCf4O5Zkiu8FXf9
	O0P1wWbA3DPwmvwkGULfBdKsy4vmPg1jOADu0dZ08BY0h+zTkmSTxCHIfpFRcvXD
	5HX1FBdqzxH9mNNy72R3pP7DSdL1xf4vynSTVJZgc5vrUIqhAmhsrioYxKCG7ogr
	9JyM8RBYiZMYmC0L4n9G5L9cZ+Ff9ttLqOBc70OYC03htYb+sL8dubgmfDmmNefT
	ZzNMH/ccxKBNhS8QbhVrtu58Y1LiyVhyNFe5mRYJBnwUyRluGrnVnFZzUGMkOLlz
	qqohbSnu0Xst48eEiERyJw937QK58YKOWoYHIx7ShMG4BkUdDnw1ozsgGtpBdxf3
	demzOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410kywr5fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GHhqax012752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:52 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 10:43:47 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v14 5/6] iommu/arm-smmu: add ACTLR data and support for SC7280
Date: Fri, 16 Aug 2024 23:12:58 +0530
Message-ID: <20240816174259.2056829-6-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
References: <20240816174259.2056829-1-quic_bibekkum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RQ9PZy63Gwdij8t1x1Ju7g950VcbqGml
X-Proofpoint-GUID: RQ9PZy63Gwdij8t1x1Ju7g950VcbqGml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160124

Add ACTLR data table for SC7280 along with support for
same including SC7280 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 58 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index dc143b250704..a776c7906c76 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -31,6 +31,55 @@
 #define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
 #define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)

+static const struct actlr_config sc7280_apps_actlr_cfg[] = {
+	{ 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
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
+	{ 0x2000, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2040, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2062, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2080, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x20c0, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2100, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2140, 0x0000, PREFETCH_DEFAULT | CMTLB },
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
 	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
 	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
@@ -689,6 +738,13 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
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
@@ -715,7 +771,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
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

