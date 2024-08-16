Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E31C37B9
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830235; cv=none; b=HHeBO0uHEb0LtFBUHmYbLpMBEwIcGFCcrjvEdexpsW7GqWroJHFlH66z4gFP3tXX+94dZGyk3EMzuZZJaIuTB4WIvsqIlyBl4WZTG4GdZRY96hS6mybLArd4RCK7VEgn0PPBDrZa9CvLAbSItgwfqSvMogTBzisa4PbqgBlgzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830235; c=relaxed/simple;
	bh=d2rTuWGzZWwcuTpa1lSByr08jFHdSHlOeR+9BIa3XkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmJk6906KpLTDbr6ST5vlfWPJlg9AJBx8xRCdq0znjxnZXcjZCjS7w3cAhGEzjWUbi6hK32ebSMqE7kWMDg5oSNOPt8YYl/JW3cfsgFiMwA6a8I/1GqV5UvJGR7bI8VXiqA+/815L6O4y/ZPFlNhSzkRoP7pu6XWycTp5FU19zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XcrhUns9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XcrhUns9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G7pGQe022989;
	Fri, 16 Aug 2024 17:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5QgJIzvZ1bkrkErrJ1MrYPpRmISh13kwlgu6oexgsY=; b=XcrhUns99kMqgSIL
	dBbCr1Gx1G9GDuGR5PF4ltZaOMXad7xD2B7YWnjZTAmYJdAGaG28/tORX1XnUaoy
	vjMj1CMXasn2+DWsMmM4fCqjoYKEa2aK/cKThOcRh6vNztrbVfmY9hE0sKtra3+3
	cl2Y+zuw13GmF7sLnwk0g5Rn9xfHnWxd8znswwsZdQTViyfzMKYK07Wk7VVtZV8a
	1t7gut/ca3PyNEw+4OmWR2AUMjXkVQ2wPtUaMI1acR2yU9bitP1i2nW4HwG8ok5L
	hKVWphbdzfDSPhxPDzwQ358vTpSdk/qoX7cYaYJb0Y0P9aSZBxCfdF1P1yyKGl2Y
	n5/D+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410m298956-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GHhfGv000712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:43:41 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 10:43:36 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Bibek Kumar Patro" <quic_bibekkum@quicinc.com>
Subject: [PATCH v14 3/6] iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
Date: Fri, 16 Aug 2024 23:12:56 +0530
Message-ID: <20240816174259.2056829-4-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: mx-VZ7vvkQZtS1wDDHfFzYJvGoUCwJru
X-Proofpoint-ORIG-GUID: mx-VZ7vvkQZtS1wDDHfFzYJvGoUCwJru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160124

Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
the TLB to fetch just the next page table. MMU-500 features ACTLR
register which is implementation defined and is used for Qualcomm SoCs
to have a custom prefetch setting enabling TLB to prefetch the next set
of page tables accordingly allowing for faster translations.

ACTLR value is unique for each SMR (Stream matching register) and stored
in a pre-populated table. This value is set to the register during
context bank initialisation.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 62 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
 4 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 90e831f1c0ec..ebbbbfe4e0bd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -217,10 +217,43 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
 	return true;
 }

+static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
+		const struct actlr_config *actlrcfg, const size_t num_actlrcfg)
+{
+	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_smr actlrcfg_smr;
+	u16 mask;
+	int idx;
+	u16 id;
+	int i;
+	int j;
+
+	for (i = 0; i < num_actlrcfg; i++) {
+		actlrcfg_smr.id = actlrcfg[i].sid;
+		actlrcfg_smr.mask = actlrcfg[i].mask;
+
+		for_each_cfg_sme(cfg, fwspec, j, idx) {
+			id = smmu->smrs[idx].id;
+			mask = smmu->smrs[idx].mask;
+			if (smr_is_subset(&actlrcfg_smr, id, mask)) {
+				arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
+						actlrcfg[i].actlr);
+				break;
+			}
+		}
+	}
+}
+
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct actlr_variant *actlrvar;
+	int cbndx = smmu_domain->cfg.cbndx;
 	struct adreno_smmu_priv *priv;
+	int i;

 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

@@ -250,6 +283,18 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->resume_translation = qcom_adreno_smmu_resume_translation;

+	actlrvar = qsmmu->data->actlrvar;
+	if (!actlrvar)
+		return 0;
+
+	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
+		if (actlrvar[i].io_start == smmu->ioaddr) {
+			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
+				       actlrvar[i].num_actlrcfg);
+			break;
+		}
+	}
+
 	return 0;
 }

@@ -279,7 +324,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct actlr_variant *actlrvar;
+	int cbndx = smmu_domain->cfg.cbndx;
+	int i;
+
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
+	actlrvar = qsmmu->data->actlrvar;
+	if (!actlrvar)
+		return 0;
+
+	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
+		if (actlrvar[i].io_start == smmu->ioaddr) {
+			qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar[i].actlrcfg,
+				       actlrvar[i].num_actlrcfg);
+			break;
+		}
+	}

 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index b55cd3e3ae48..5f2dc90ca879 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */

 #ifndef _ARM_SMMU_QCOM_H
@@ -24,8 +24,22 @@ struct qcom_smmu_config {
 	const u32 *reg_offset;
 };

+struct actlr_config {
+	u16 sid;
+	u16 mask;
+	u32 actlr;
+};
+
+struct actlr_variant {
+	const resource_size_t io_start;
+	const struct actlr_config * const actlrcfg;
+	const size_t num_actlrcfg;
+};
+
 struct qcom_smmu_match_data {
+	const struct actlr_variant * const actlrvar;
 	const struct qcom_smmu_config *cfg;
+	const size_t num_smmu;
 	const struct arm_smmu_impl *impl;
 	const struct arm_smmu_impl *adreno_impl;
 };
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 723273440c21..82d2a95cc259 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1042,9 +1042,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
 		 * expect simply identical entries for this case, but there's
 		 * no harm in accommodating the generalisation.
 		 */
-		if ((mask & smrs[i].mask) == mask &&
-		    !((id ^ smrs[i].id) & ~smrs[i].mask))
+
+		if (smr_is_subset(&smrs[i], id, mask))
 			return i;
+
 		/*
 		 * If the new entry has any other overlap with an existing one,
 		 * though, then there always exists at least one stream ID
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index e2aeb511ae90..172f1b56b879 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -511,6 +511,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
 }

+static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
+{
+	return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
+}
+
 #define ARM_SMMU_GR0		0
 #define ARM_SMMU_GR1		1
 #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
--
2.34.1

