Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB4346AC3
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515923; cv=none; b=Z93kRY7Hj1buvRY6qPC51SwNuzwUTeKPQTR78hJY5lpoqNe6Yq6sYHHIwW0smCWAKOcXdoeJ4M+DEp9fBdyGZ0FsXHalMn5kgdJQHBP2yZxvAuK3Gwgeo9zl2LALMwjBG/UgN3VMUtrlwk8v97boU87rXnIPqYzfM+J6OX+ZC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515923; c=relaxed/simple;
	bh=TeDy3t3Fs7sFv6et8Ck2qBnwLTCzre+JdzVVG14n6ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q5O/HZ0UYgpFKfKoLey1KjTZRqgV04XvCUT1KiZU4pPNdQtdxbop/i8vqf3cbPGkonvT+L2n31atsrpKHffeYUtA2fajTt+uAzE5ezXW8Yb1OdvnCPcgFf8h2kD6Li9P4I1WUqJW//5XQNpNDCCIghyUUnYzdMOp4txIHWR/59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NnoQkF2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjEHl/k9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnoQkF2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jjEHl/k9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBwwu01793628
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ds2ZJGE2krsn4P3tEHEukV
	hMuBmMD5Z71E4XCCNGtXw=; b=NnoQkF2rmO4tVZEjiDNcK1ybXCDrgwGdusJNVW
	lBKCM+RTyjlJQNHAUzhIOY2COeOx/nNrcyJV+/zhVxPL6Y5BzRUsje0hVzQfzDhy
	rNwhVjlCjA3kkrkxKqOKiWjHmOkNHlEykoNE8ZotZMCE+6wZv3TgvYzD6ymHU0uI
	5xtmQncwi0xJCyjP3Z84yDNXxswAVSuD6ar2X5Cy8WA+6vQK+oLWNVhRjHSRpr7G
	V+uppQdq0D3MP0DH2sWU3Mfj6ryj1wu8EojE+TPS9OP7ZP1inENOM3NFWbKX30k7
	xdFIgpc4uSDX7u6db3GVdlVfHFdesB/J6bwpD6/5IlJtzBIA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93jg4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 12:12:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso5065055a91.3
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 04:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769515919; x=1770120719; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds2ZJGE2krsn4P3tEHEukVhMuBmMD5Z71E4XCCNGtXw=;
        b=jjEHl/k9HSCxzWLRqLdHcnjvb3xFu2Uc3pavu3z4OhcnDJCe0Hef/PhGRfCLm+Dh83
         yomfQW4kZGO8bPGK3GNBH32eA/lYzPB722i02ad+zSNHXeBjPawesyKvJAwzaYgmXbFm
         3O93fZhhuk1g+wVwwFnq7yk+A8qpY2ZZUSNxz6QpYQ0U+bC4AVYTILmqv97Ecfoue+fF
         mump8P0B+qWuvrcFh6DhaIuU5MA/sdEtiauWueqIr1CxXhVktC0HaZ91f7X25Y0dHDMn
         Li8OYgWdLKVOS9MnpTxJRG3wP+/o+wYGMV+s58E/QvG8R9WWjwx5UZbzkiMblCLrK407
         bkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515919; x=1770120719;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds2ZJGE2krsn4P3tEHEukVhMuBmMD5Z71E4XCCNGtXw=;
        b=ObhexukaDdVUCpSORD6K4YP/PpgI2faHHZJ6B2bijRud9PadY+ICgQvxGD5pqle6Hp
         gAU6NHeFuSN+c//7CLazdeB1veYCKDASffgwffIyXoHykFI/0UyKSNcp7WjjhfYlzv/G
         EqwhxNwPUWL3qfiqm6hFojrjlMU//48lq+Q4kpUEBlq76HE3fC+Sbumx1ARQN02ekfCy
         DAJOGrMruXBTTj7uFyN8yn3FX3ysOZ3iGeerO5CcduBPEaYzZ+AarwpVGcN4h/YMXEsW
         HFdyMQTuiCRatUK+FzUXydjlglQJmdOghWrqSPavFFgs4NFXXQ9xrbvuDhKXGgXSZzAt
         IvUg==
X-Forwarded-Encrypted: i=1; AJvYcCU+4DLNxgc5hZLlzq4VvOrvD/OQbxfffPNEzLDTOlMoHBVPMTBxzgqHZn8qLPO85V4Sr6swkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOz1a8RMiIZZqWYjX+8C8QIFhHpY7yxXn6uWf67WMFXkY1Kggr
	//WxB7s4KpxMc6/7eeJ7VL8KFSPecSAPWiXMpAx8OF5zVU6k/JI7VhvZsIWF9URuYAsvszdwF7y
	QFZngZdZdXekw6DuPqaChToDJ6ycEcR/4EbsF3+vw1DFHTpbSbXDqsSEcoHX6KjygUw==
X-Gm-Gg: AZuq6aL3fJygWxUk7jyWQ4baHDtXbu5w/gFTy2qrqyUcI4WyQlTTV9GNJy3bmd/TTPS
	WJ6raUNzzGgVIbjWHDzYQoqkGpLyVSup5HKchGVEoKyIFbirxwRWBw3ZUZI+BY71opZZ1NnqiGM
	Cq2wCBrVatqNMZ5+rUcicHgkaArvEEQbz2nrzWBrrIAVMl+2uM3BcukD4SwIOpuwVPUAvvFwTfL
	GQfnRm28rOb8tgtwp6qcHI312664Wm7pSJez2WTgnowaTKOumP81Q+3yVRnN4b1vlliIBRK+cex
	L+xkHB8s2TT9FEmE7bPsDWGjqBzP44RYBNTvEkDAoIqoa3COYgmOa5SFpLnU2MhrHLJuPfxa2OL
	k9qebAhCk7L8unlWB/V5BiUItaEaaa19wvXsce3tv
X-Received: by 2002:a17:90b:28ce:b0:353:3977:a082 with SMTP id 98e67ed59e1d1-353fecc6684mr1373179a91.1.1769515919141;
        Tue, 27 Jan 2026 04:11:59 -0800 (PST)
X-Received: by 2002:a17:90b:28ce:b0:353:3977:a082 with SMTP id 98e67ed59e1d1-353fecc6684mr1373156a91.1.1769515918627;
        Tue, 27 Jan 2026 04:11:58 -0800 (PST)
Received: from hu-guptap-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6159ad6sm2489474a91.14.2026.01.27.04.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:11:58 -0800 (PST)
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 17:41:45 +0530
Subject: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAICreGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwML3eLc3FLdooJcXYukFDPzlCRL45TkRCWg8oKi1LTMCrBR0bG1tQB
 3HEI/WgAAAA==
X-Change-ID: 20251208-smmu-rpm-8bd67db93dca
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5OSBTYWx0ZWRfXw8nSPLpSDHyE
 Dnq4ASeihWiy1eBiHrOtnOjff7pwAl6jpDi/mqUwoftcATer/kkGiLstufhHjPWT2jBA2FD8iR1
 L05J7HmeMhygI41YkLLYd0GrIULh+JK/ANgRprmWK598mcM4dwhP+8uoMKqeIFzhRC/F141BefE
 2MnURid+Ot/VD7y0Kb/YXHn/2Wf0ftPNElc5ECfDl2wNJ9B6LGLGDkO9CVG57NgMs+mr5Y+OnJ1
 Elku9NzJ4jPyhpkPftq9dawz2/ZMb090ts+a7tO097xjjPMCve393PE564QI9/C0lU9lZhuXvZg
 mzpOss09qfcDL6AKk1R1ulaqhZHGzzBuWAz2egPEq+BjYTOO0zjQExN2YRlR/CFORJJUPWHe/Mu
 xr+TRClC8jRayF4YzLVSyro3l6FJxXNp8TvtRs1pJF5CgfvxD9IxM0YkKZ4xFF01jfHxmVTzvkx
 YE3qsFOLMN3zs1Oiv5A==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=6978ab90 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-SalRf7IlQZ7Iv0L3QwA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 2RClVzbv2pRWRJ7qCidn1ztCN1C9YBwu
X-Proofpoint-GUID: 2RClVzbv2pRWRJ7qCidn1ztCN1C9YBwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270099

Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
enabled pm_runtime for the arm-smmu device. On systems where the SMMU
sits in a power domain, all register accesses must be done while the
device is runtime-resumed to avoid unclocked register reads and
potential NoC errors.

So far, this has not been an issue for most SMMU clients because
stall-on-fault is enabled by default. While a translation fault is
being handled, the SMMU stalls further translations for that context
bank, so the fault handler would not race with a powered-down
SMMU.

Adreno SMMU now disables stall-on-fault in the presence of fault
storms to avoid saturating SMMU resources and hanging the GMU. With
stall-on-fault disabled, the SMMU can generate faults while its power
domain may no longer be enabled, which makes unclocked accesses to
fault-status registers in the SMMU fault handlers possible.

Guard the context and global fault handlers with arm_smmu_rpm_get() /
arm_smmu_rpm_put() so that all SMMU fault register accesses are done
with the SMMU powered.

Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  5 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 53 ++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 573085349df3..2d03df72612d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -317,6 +317,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
 	const struct of_device_id *client_match;
+	const struct arm_smmu_impl *impl = qsmmu->data->impl;
 	int cbndx = smmu_domain->cfg.cbndx;
 	struct adreno_smmu_priv *priv;
 
@@ -350,10 +351,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
-	priv->set_stall = qcom_adreno_smmu_set_stall;
 	priv->set_prr_bit = NULL;
 	priv->set_prr_addr = NULL;
 
+	if (impl->context_fault_needs_threaded_irq)
+		priv->set_stall = qcom_adreno_smmu_set_stall;
+
 	if (of_device_is_compatible(np, "qcom,smmu-500") &&
 	    !of_device_is_compatible(np, "qcom,sm8250-smmu-500") &&
 	    of_device_is_compatible(np, "qcom,adreno-smmu")) {
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 5e690cf85ec9..183f12e45b02 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -462,10 +462,23 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
+	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq) {
+		ret = arm_smmu_rpm_get(smmu);
+		if (ret < 0)
+			return IRQ_NONE;
+	}
+
+	if (smmu->impl && smmu->impl->context_fault) {
+		ret = smmu->impl->context_fault(irq, dev);
+		goto out_power_off;
+	}
+
 	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
 
-	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
-		return IRQ_NONE;
+	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT)) {
+		ret = IRQ_NONE;
+		goto out_power_off;
+	}
 
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
 		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
@@ -480,7 +493,14 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 				  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
 	}
 
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
+
+out_power_off:
+
+	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
+		arm_smmu_rpm_put(smmu);
+
+	return ret;
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
@@ -489,14 +509,21 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
+	int ret;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
 
 	gfsr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSR);
 	gfsynr0 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR0);
 	gfsynr1 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR1);
 	gfsynr2 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR2);
 
-	if (!gfsr)
-		return IRQ_NONE;
+	if (!gfsr) {
+		ret = IRQ_NONE;
+		goto out_power_off;
+	}
 
 	if (__ratelimit(&rs)) {
 		if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
@@ -513,7 +540,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	}
 
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
+
+out_power_off:
+	arm_smmu_rpm_put(smmu);
+	return ret;
 }
 
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
@@ -683,7 +714,6 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	enum io_pgtable_fmt fmt;
 	struct iommu_domain *domain = &smmu_domain->domain;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	irqreturn_t (*context_fault)(int irq, void *dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -850,19 +880,14 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	 */
 	irq = smmu->irqs[cfg->irptndx];
 
-	if (smmu->impl && smmu->impl->context_fault)
-		context_fault = smmu->impl->context_fault;
-	else
-		context_fault = arm_smmu_context_fault;
-
 	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
 		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
-						context_fault,
+						arm_smmu_context_fault,
 						IRQF_ONESHOT | IRQF_SHARED,
 						"arm-smmu-context-fault",
 						smmu_domain);
 	else
-		ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
+		ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault, IRQF_SHARED,
 				       "arm-smmu-context-fault", smmu_domain);
 
 	if (ret < 0) {

---
base-commit: fcb70a56f4d81450114034b2c61f48ce7444a0e2
change-id: 20251208-smmu-rpm-8bd67db93dca

Best regards,
--  
Prakash Gupta <prakash.gupta@oss.qualcomm.com>

