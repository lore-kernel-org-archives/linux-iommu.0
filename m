Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F8216E2D
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016486; cv=none; b=LTP3jiCPdTO1pvm3FRz68fheA1PrPy5K4+s7LzekXJanJuDAJqy4VfohE3whS3wwx/hTHZgApAS8EegRFOiI9tJVRxr5HrX9ey7Pn74CCCA/brW9LFgks/tCzObTu65lKdla8SSN4nqRXycW60TlFozPjc2y14uZaKrhbrfU4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016486; c=relaxed/simple;
	bh=PlchT+XiQ1/CHEhIpjvktYyhkY53vzR2SSElaI/2w4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dolxAjJRGyMjYDoFZ0Q2tTWnNrQwZ9mNE0095T800/pAMIgYpXYtt6OjiqYEz1d0ECXqd5DxSV8jlkb0/qUDgY34jm6j/3AdILn9W92xN9vuBox8PWt4M78BfG5gsluGOkqmF9/LLxWQvoObyZnGmjklfbzcCpLbQqUYBP1LDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WStYJ28b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WStYJ28b"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD1R7x000455;
	Thu, 12 Dec 2024 15:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X/bj4EVljuLLe36faJM5+8RziYdbMI4NZu4xd4aurqI=; b=WStYJ28b3DOd2rT0
	gt9KMilaBviEFWjH+Ogj/eHUYOdZKGMOjniDeJ8dhDwCbE6KJybdGqVTukc9MAfY
	TYQFtl1Z+D/PrbjKxGEhBxoB1COqloMwR7X4W1XZVEs1OOOlX1BunbnqlbUgnEqP
	mLWVkflHaNeKFwYT0uI7qwdXOao0OWvdx4Fg9fkb4uvVuEMweRVl0ZlledKw11bD
	9rQOA4a410VtMil2H6lVfgyB0I9Ki+mxlRWIlt5GtG+rD0zybw+q7EPAjoUn+t0T
	9Op0ZfEdu49B3eI4qm9cHXRqSd8nRc8dBsQLxT7h+5jtox+DLS5ahgl6p5N3Gy/z
	PFj3zQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes1v8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:14:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCFEXeO028235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:14:33 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 07:14:28 -0800
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_bibekkum@quicinc.com>
Subject: [PATCH v18 1/5] iommu/arm-smmu: re-enable context caching in smmu reset operation
Date: Thu, 12 Dec 2024 20:43:58 +0530
Message-ID: <20241212151402.159102-2-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: 7h582FV6A5RxDmHdeZcHXwjlJ56OlL5e
X-Proofpoint-ORIG-GUID: 7h582FV6A5RxDmHdeZcHXwjlJ56OlL5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120110

Default MMU-500 reset operation disables context caching in
prefetch buffer. It is however expected for context banks using
the ACTLR register to retain their prefetch value during reset
and runtime suspend.

Add config 'ARM_SMMU_MMU_500_CPRE_ERRATA' to gate this errata
workaround in default MMU-500 reset operation which defaults to
'Y' and provide option to disable workaround for context caching
in prefetch buffer as and when needed.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  3 ++-
 drivers/iommu/Kconfig                       | 12 ++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c  |  5 +++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 65bfab1b1861..92207d55fd1c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -198,7 +198,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-500         | #841119,826419  | N/A                         |
+| ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
+|                |                 | #562869,1047329 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ade4e8cf2a3e..90ba5818af81 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -367,6 +367,18 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  'arm-smmu.disable_bypass' will continue to override this
 	  config.

+config ARM_SMMU_MMU_500_CPRE_ERRATA
+	bool "Enable errata workaround for CPRE in SMMU reset path"
+	depends on ARM_SMMU
+	default y
+	help
+	  Say Y here (by default) to apply workaround to disable
+	  MMU-500's next-page prefetcher for sake of 4 known errata.
+
+	  Say N here only when it is sure that any errata related to
+	  prefetch enablement are not applicable on the platform.
+	  Refer silicon-errata.rst for info on errata IDs.
+
 config ARM_SMMU_QCOM
 	def_tristate y
 	depends on ARM_SMMU && ARCH_QCOM
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 99030e6b16e7..db9b9a8e139c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -110,7 +110,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 int arm_mmu500_reset(struct arm_smmu_device *smmu)
 {
 	u32 reg, major;
-	int i;
 	/*
 	 * On MMU-500 r2p0 onwards we need to clear ACR.CACHE_LOCK before
 	 * writes to the context bank ACTLRs will stick. And we just hope that
@@ -128,11 +127,12 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 	reg |= ARM_MMU500_ACR_SMTNMB_TLBEN | ARM_MMU500_ACR_S2CRB_TLBEN;
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sACR, reg);

+#ifdef CONFIG_ARM_SMMU_MMU_500_CPRE_ERRATA
 	/*
 	 * Disable MMU-500's not-particularly-beneficial next-page
 	 * prefetcher for the sake of at least 5 known errata.
 	 */
-	for (i = 0; i < smmu->num_context_banks; ++i) {
+	for (int i = 0; i < smmu->num_context_banks; ++i) {
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
 		reg &= ~ARM_MMU500_ACTLR_CPRE;
 		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
@@ -140,6 +140,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 		if (reg & ARM_MMU500_ACTLR_CPRE)
 			dev_warn_once(smmu->dev, "Failed to disable prefetcher for errata workarounds, check SACR.CACHE_LOCK\n");
 	}
+#endif

 	return 0;
 }
--
2.34.1

