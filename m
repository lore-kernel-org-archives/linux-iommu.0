Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87136198E92
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589914; cv=none; b=ZkgDE0MilxsKTh2AJADRnBp8OXKiLMlxp8A0dq7e22FstulEpusMlV1gAzHWIW4+Bu168U5ldj/HtYRkOTdByjcXzgtIpBEYPJlr8c/qRuZvXePf00MCl6WuBPkdvJP2QnMsYvP/4CO9//OyJYD3HjMnolmQPx5TxCjJ9m7fai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589914; c=relaxed/simple;
	bh=G/xQhtJfSJVECUMN+T0d9iXwDkBME4Om+sO3P5KPeSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKIrZdG+3jaOsx2e+mZy54WEi3jvzpfFmRKO4BwG+a8fGiRb4SfbSEY0kBcgKo0L+7L8SA9RBnwg2hRe7fILj/STGW0zcLEjlnllgW4ZXquwzeU2YGZaPxGgRvLSbOg6koInjxv0TxxVWYtkz3D4R15dY2//YGB9KSAZcWA/eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D2crwK9i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D2crwK9i"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455B1TuX016689;
	Wed, 5 Jun 2024 12:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBNF1d6gH6Rd1O/2/9XvTuf3ps3jKwjpwvy2Zcx8tZ4=; b=D2crwK9ih3TlbnWi
	XoDf5ortJk78JElNaLmOG2tI+pMhF94Gx46dXphUKYsDZLzV9Dq2SB6toMWrR6M7
	xLaGwGWOGwTJqetP60hpJ8vgoE+FnWeSqSREfEgM7OvgyB0Gg4yRbbp+b9cldF+0
	luvl4AtW1DE2S1G7y3huhpAnuzlC/CcT+YjyWl2qG4Pb6sFjtzUmzP9g1DJVwqb3
	cqabCqsSst9lBWjLHELZ+WlKVdJDqzEinC/2a9zEyhyBzXnHt9Iv7VPV2mHhSD4c
	p7fqVm2OzQoyabFEVNZeFeEdCRZKaKzex9ltRY6DlxNFWIxwMQeDoJy79ZsR86h4
	t3AazQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjan2hn46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 12:18:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455CIK4P023236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 12:18:20 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Jun 2024 05:18:15 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v11 1/6] iommu/arm-smmu: re-enable context caching in smmu reset operation
Date: Wed, 5 Jun 2024 17:47:08 +0530
Message-ID: <20240605121713.3596499-2-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: Yu1QzZQzOaYS15K6t-5U3Vfe1FavgjTC
X-Proofpoint-ORIG-GUID: Yu1QzZQzOaYS15K6t-5U3Vfe1FavgjTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050093

Default MMU-500 reset operation disables context caching in
prefetch buffer. It is however expected for context banks using
the ACTLR register to retain their prefetch value during reset
and runtime suspend.

Replace default MMU-500 reset operation with Qualcomm specific reset
operation which envelope the default reset operation and re-enables
context caching in prefetch buffer for Qualcomm SoCs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 25f034677f56..76db4c8d1a9b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -14,6 +14,16 @@

 #define QCOM_DUMMY_VAL	-1

+/*
+ * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
+ * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
+ * buffer). The remaining bits are implementation defined and vary across
+ * SoCs.
+ */
+
+#define CPRE			(1 << 1)
+#define CMTLB			(1 << 0)
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -379,11 +389,31 @@ static int qcom_smmu_def_domain_type(struct device *dev)
 	return match ? IOMMU_DOMAIN_IDENTITY : 0;
 }

+static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u32 val;
+	int i;
+
+	ret = arm_mmu500_reset(smmu);
+	if (ret)
+		return ret;
+
+	/* arm_mmu500_reset() disables CPRE which is re-enabled here */
+	for (i = 0; i < smmu->num_context_banks; ++i) {
+		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+		val |= CPRE;
+		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
+	}
+
+	return 0;
+}
+
 static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 {
 	int ret;

-	arm_mmu500_reset(smmu);
+	qcom_smmu500_reset(smmu);

 	/*
 	 * To address performance degradation in non-real time clients,
@@ -410,7 +440,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
@@ -443,7 +473,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
--
2.34.1

