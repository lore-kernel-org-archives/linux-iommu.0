Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6C21441F
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430560; cv=none; b=cdYE1342UwvD1b/d/0skMBnS0MATeZpRobtevAqe94Z4HGhtvFxMdGyHS5TsUnlQxsKCUErwAR7IWju/zJzPwyzkKED4shV1E1FDIRqGpePepoYldk1IvvsQV2fXVqnBVCCqIfgs+TPM4WqDqm9+nh7rplPMTytqhq2O2iyMTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430560; c=relaxed/simple;
	bh=CXtZ+PaPn/nkVw1bXLGecyOZdbbB46QA4QY3jiBrGw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYigg6nrU3yjF8KBOqlkBKaxDE2ZdB5agFRsjz50BV5CcovBxXCyqgdcIr9nqlSLOtHLkKwZhWXkabGQwqwVLPZz8LgRFobrUdK000RNLopj4Oi866szPFYTBKFY3PggWU16ONywx4MIll+yoY3XPEKCTJQGLgSjOlRhfRrDjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WZjFVdyT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WZjFVdyT"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCbCRu015822;
	Tue, 12 Nov 2024 16:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PPIsNByjG9dF2PwiVs+mc7dHm6mYJURBXoCSGmZI260=; b=WZjFVdyTnNQvlTO0
	Xk9WzfdHl/R0JzIvJOK9F0etlxyQzQwyJ+U1ttWdDeD9PMHBGZT7gDWs/h0sNfm7
	LJQYMWaUdgZrM59E7VvqCXb9NVVmcnBdNlymxFShyn8CsCANnRE16qhZ6np+S3K9
	/Cil16oEOx6AVkmOy5tebAGR0JzjYH7Zs0nJJ4d9vzxgT0sBoGN9iu9tY4tue48w
	JoBBJZ0jzy6IF3nXA/Ftu7XU6NYdGhvT5kZVQJXuvrnQb08IaiJsKynvBcSL34JP
	FYWOJjcI3QwoFEhnRax8GL64GV0/2s4Ohiv9tlFbbb7GR+jyF5etfP5KRZwKoaGd
	AS/eaQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t04682fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:55:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACGtivJ029153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:55:44 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 08:55:40 -0800
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_bibekkum@quicinc.com>
Subject: [PATCH v17 3/5] iommu/arm-smmu: add support for PRR bit setup
Date: Tue, 12 Nov 2024 22:24:52 +0530
Message-ID: <20241112165454.2698269-4-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112165454.2698269-1-quic_bibekkum@quicinc.com>
References: <20241112165454.2698269-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oeWvhSmWu-QC79lS-iTJBBNaNsnupXg8
X-Proofpoint-ORIG-GUID: oeWvhSmWu-QC79lS-iTJBBNaNsnupXg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120135

Add an adreno-smmu-priv interface for drm/msm to call
into arm-smmu-qcom and initiate the PRR bit setup or reset
sequence as per request.

This will be used by GPU to setup the PRR bit and related
configuration registers through adreno-smmu private
interface instead of directly poking the smmu hardware.

Suggested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 37 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
 include/linux/adreno-smmu-priv.h           | 14 ++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d26f5aea248e..0e4f3fbda961 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -16,6 +16,8 @@

 #define QCOM_DUMMY_VAL	-1

+#define GFX_ACTLR_PRR          (1 << 5)
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -99,6 +101,32 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
 	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
 }

+static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	u32 reg = 0;
+
+	reg =  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
+	reg &= ~GFX_ACTLR_PRR;
+	if (set)
+		reg |= FIELD_PREP(GFX_ACTLR_PRR, 1);
+	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
+}
+
+static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_addr)
+{
+	struct arm_smmu_domain *smmu_domain = (void *)cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	writel_relaxed(lower_32_bits(page_addr),
+				smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
+
+	writel_relaxed(upper_32_bits(page_addr),
+				smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
+}
+
 #define QCOM_ADRENO_SMMU_GPU_SID 0

 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
@@ -210,6 +238,7 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	const struct device_node *np = smmu_domain->smmu->dev->of_node;
 	struct adreno_smmu_priv *priv;

 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
@@ -239,6 +268,14 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;
+	priv->set_prr_bit = NULL;
+	priv->set_prr_addr = NULL;
+
+	if (of_device_is_compatible(np, "qcom,smmu-500") &&
+			of_device_is_compatible(np, "qcom,adreno-smmu")) {
+		priv->set_prr_bit = qcom_adreno_smmu_set_prr_bit;
+		priv->set_prr_addr = qcom_adreno_smmu_set_prr_addr;
+	}

 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index e2aeb511ae90..2dbf3243b5ad 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_SCTLR_M		BIT(0)

 #define ARM_SMMU_CB_ACTLR		0x4
+#define ARM_SMMU_GFX_PRR_CFG_LADDR	0x6008
+#define ARM_SMMU_GFX_PRR_CFG_UADDR	0x600C

 #define ARM_SMMU_CB_RESUME		0x8
 #define ARM_SMMU_RESUME_TERMINATE	BIT(0)
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index c637e0997f6d..614665153b3e 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -50,6 +50,18 @@ struct adreno_smmu_fault_info {
  *                 the GPU driver must call resume_translation()
  * @resume_translation: Resume translation after a fault
  *
+ * *CAUTION* : PRR callbacks (set_prr_bit/set_prr_addr) are NULL terminated for
+ *             targets without PRR support. Exercise caution and verify target
+ *             capabilities before invoking these callbacks to prevent potential
+ *             runtime errors or unexpected behavior.
+ *
+ * @set_prr_bit:   Extendible interface to be used by GPU to modify the
+ *		   ACTLR register bits, currently used to configure
+ *		   Partially-Resident-Region (PRR) bit for feature's
+ *		   setup and reset sequence as requested.
+ * @set_prr_addr:  Configure the PRR_CFG_*ADDR register with the
+ *		   physical address of PRR page passed from
+ *		   GPU driver.
  *
  * The GPU driver (drm/msm) and adreno-smmu work together for controlling
  * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
@@ -67,6 +79,8 @@ struct adreno_smmu_priv {
     void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
     void (*set_stall)(const void *cookie, bool enabled);
     void (*resume_translation)(const void *cookie, bool terminate);
+    void (*set_prr_bit)(const void *cookie, bool set);
+    void (*set_prr_addr)(const void *cookie, phys_addr_t page_addr);
 };

 #endif /* __ADRENO_SMMU_PRIV_H */
--
2.34.1

