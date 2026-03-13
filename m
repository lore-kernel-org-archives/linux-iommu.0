Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326842DF6F4
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397449; cv=none; b=I90ZAqH9sHa7QKhBOcDP1A2z1JJumrBSyxXubwFvsJegkYU4iOrbEl+eHB6li0yupKYAyK4tu5mRki5YOJaJ6cTaaIDBo5XvWxdUptKzjm7fYblgv/1En3TZ024aOkGBQ5dD1mqZl4goIwm1dEXW+4Rbkmgr8Arf56vSKdKdOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397449; c=relaxed/simple;
	bh=QhBtjbDloLdUGe4ameEFnwT0gkXTioWGK4diNOa+ibA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGLl/dMGUcDBwdV5YGE47Ma3hAvALWA2FcrZkEthzao0q3FopAzRAEhM8W6dyqT1lBtVQgNfXGlSInVT6enksGBvPfTtRsIWEfp6l/uL/jI6P0Yu4zGeam5fylDQDUD8yxVNsCIXNaDj8QVFmG1eJ+YS4podQwjJP1RBdqGADRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEgHuo5s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7FkZMjc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEgHuo5s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7FkZMjc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tgUs3229964
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xdroUf42OnaRsZaNXVIwjI
	uoiVOsASCk4ZWCqNs2gp8=; b=nEgHuo5sHIlSGtourKRKx/NaKjQE0MTjlXa1ae
	JlsOEV2ZJ1aS72PzqWf504d/PBjC8yqUYg2RJ2yE6K7/6EeGztR6zH6ZX3vSUbe3
	BVUt9ES9/gT8I4J6R95nnMcERZDKH5/qo+hWjFT7g4Hk3Edvc6Nw0wl0PT4IOrY3
	idi26aY1Y0w4rq7ybs7miaupTsAzn/HdfT2KmK2ZoObRgv9ntU3raX9cqTeTv49F
	NC47V4wEs7TDZ5UoAYiwF4MWuFkGH0P0euZxOSunNsekQH29ealV5Sorsr2rc18q
	VlF6p+litw26pjqsy5rBa6choxenef97ZC6xoGxK+Fu8PZjA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7hqcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 10:24:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35a1a752191so1405081a91.2
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773397446; x=1774002246; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdroUf42OnaRsZaNXVIwjIuoiVOsASCk4ZWCqNs2gp8=;
        b=J7FkZMjcauZyq4Qe6GRJNhypUW6pRHyeWE9C3+LHBve2hsoaq2slpRBQEeGOQD9aVh
         +l2krjfSoQLK8cljdgnZv/ChhqY7nLt/JUgCDxPvF3dhfB8jW9fAQhtCTxeg02Q8NN5s
         swCW6m+P621Ubkl2zkQrx6LsNWaMKRTSvtbZhGYGdL4wDASaDQ73g36ZNJdX+iQiywhG
         AOZPrFRaBeDFRAq4rluc7rgnxpX6avZtiO4ptfoRfuwy1OSxMr3TRDDqNXcJuwSK0KzV
         qJnWn3oamoZuriq5iHyvTf4AXk8imzw+gk4U5z7qQt0Dfw6Fp3MZDFPgXPIai7eYsNQ9
         Nszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773397446; x=1774002246;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdroUf42OnaRsZaNXVIwjIuoiVOsASCk4ZWCqNs2gp8=;
        b=G22twDRsSjmr4lRMUsArwhoB/toLcxSwe9YXaOE7dCdEd2drHFBIY0xZlDpFBti0tA
         q1Q15lMpMVVEPuBKSaX3tCdAApkXh8+onxJYo5D7HL4WkH+ifvXHov1/ih4gJ5hPjNKt
         RmR2CNTVxZxpHgMbdjsEAXTp72erfHQ9R1Q4GmEsgyQvBdj4SKfcuJ/cBaidYG6jwR0K
         sLCwMeN6KJEuP02VaxHb07ogiw5+XAWY5RhbLm6SdxU1yuHYXj8rcaw4p8BugfOXcjFz
         7cOur5A+c/68tWknzooWHkysUq6q4o8B3+FwJAAwa+DCy0qsg8Xa2TRJYz7pUZiilYxE
         rsBw==
X-Forwarded-Encrypted: i=1; AJvYcCX6HmOiqXC1AwEsREDm9wYRTSDqAMJd9OYlo6B1jE9+k47SWXHcolGYNGBRToQcw6tH+nshUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWyQOSjtzlWIfjg07L+mtW2BKdOoH82va5zYqZVa6DgwG3MiL4
	/sPEKoxDeEf4FPfsskD3qqgLvcjZboieALD1tC8+HJjQYIXnlHN50/hvkwMhj/Toy5owu9sna39
	02gRBJxDToaT6fqzEooqJIC4NRhF2i7iGkjNf8UtJzOc/j+pcsiF9TRYNSg==
X-Gm-Gg: ATEYQzzA0RLim9WMhdcsluPhhW0037L3JHMO3cwQ8GazI+iVO7dlHkMjht0lHjh6YWO
	87YK2nDpvqZve/DST8URx+QPDZNDSZzOZvsTpZmsPiXc4iZ9Mq+FvYfbPrDpCZznuflP5FUSIRL
	8y3Idx5w/U8D+5lYdsX0o5TZaMNxUbRDtdAdMpu/KqgR9IdYY23yPOKo0nNRtpALj0W2mQkymFj
	q+QdmLnBJKvFkyO3JGXWB9PlMqiXHw0EnaaEOM5NKpVIbhS7ziVugGKyitphoc3pEtxQLAaOXOh
	/5bxQrN9vHER8CXSlQxlxNkQ52/GIZsgPLfS8af+drowAxvjRaZ0ee0mT53vDSo0z781Q2L/a81
	QHFxP0CJhF3r/01aFFbi+8Vd/sj+7Ed7OVTaqfUAh5rQm9dXEvaNH
X-Received: by 2002:a17:90b:4a46:b0:359:f0e1:f8c0 with SMTP id 98e67ed59e1d1-35a21e1ca44mr2497540a91.6.1773397445736;
        Fri, 13 Mar 2026 03:24:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4a46:b0:359:f0e1:f8c0 with SMTP id 98e67ed59e1d1-35a21e1ca44mr2497521a91.6.1773397445204;
        Fri, 13 Mar 2026 03:24:05 -0700 (PDT)
Received: from hu-guptap-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffe078sm8437602a91.13.2026.03.13.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:24:04 -0700 (PDT)
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 15:53:53 +0530
Subject: [PATCH v2] iommu/arm-smmu: Use pm_runtime in fault handlers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALnls2kC/0XMQQ6DIBCF4auYWRcDY1HbVe/RuFDASlLEMpW0M
 dy96KabSf7Jy7cBmWANwbXYIJhoyfo5B54KUFM/PwyzOjcgRymQt4ycW1lYHGsHXTd6uFRa9ZD
 nSzCj/RzUvcs9WXr78D3kKPbvjtRcYPNHomCCoRlxPKtWVlzePFH5Wvun8s6V+UCXUvoBXtg2u
 6cAAAA=
X-Change-ID: 20251208-smmu-rpm-8bd67db93dca
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pranjal Shrivastava <praan@google.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Proofpoint-ORIG-GUID: 3MKNsAt-aZh8Tos2XeV9LFraZVEtNNNq
X-Proofpoint-GUID: 3MKNsAt-aZh8Tos2XeV9LFraZVEtNNNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MSBTYWx0ZWRfX+ctc2LT+8IGM
 v3GEEtRGKR5jI++uPX2xlQrnYu40S7F3Z9PiVmy8f2bHodkVIPSXnN3HjQJdE9++hBaarKtfQ9f
 B/jNZ1pBH3uCW00XodHmbOoyYLyhzNpcYsWlHBcizqPnT5Dx84VyW8UcbgYtlxH30lKFQkEVgUV
 uBeCw4389uhCRr46e9mGLSrGXHWMYlBt2E4HI8r3+ip7WzMPtSvC9eQCcPl/FP+/3tJRHgCHcVH
 hjecShcv1TPdJf8BTQ6ECcmuC+MnqpHDkWuT4bbghcgX3CACuH+aO5F29n0Yn71cIjt4XgutWLY
 vbpD6WpghXPMNmcJI6gS4x1AGoPI2XVWR2WPc8qcUsG66Dr2HuvQt1ivj6FtZjRJeI5q+Tnb8EK
 du1obfPEzSrNCUOmJ+QoPCx5lM3iRDjUgyScJlvq7cF/ywyX06/FQAYlcgd/Li0yujhNG4F1fwz
 z334ZZlo83AvTAL2Q1A==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3e5c6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=FOn0AWhus2eDxXApaSoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130081

Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
enabled pm_runtime for the arm-smmu device. On systems where the SMMU
sits in a power domain, all register accesses must be done while the
device is runtime active to avoid unclocked register reads and
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

Guard the context and global fault handlers with pm_runtime_get_if_active()
and pm_runtime_put_autosuspend() so that all SMMU fault register accesses
are done with the SMMU powered. In case pm_runtime is not active we can
safely ignore the fault as for pm runtime resume the smmu device is
reset and fault registers are cleared.

Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
Changes in v2:
- Switched from arm_smmu_rpm_get()/arm_smmu_rpm_put() wrappers to
  pm_runtime_get_if_active()/pm_runtime_put_autosuspend() APIs
- Added support for smmu->impl->global_fault callback in global fault handler
- Remove threaded irq context fault restriction to allow modifying stall
  mode for adreno smmu
- Link to v1: https://patch.msgid.link/20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 60 +++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 5e690cf85ec9..f4c46491a03d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -462,10 +462,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
+	if (!pm_runtime_get_if_active(smmu->dev))
+		return IRQ_NONE;
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
@@ -480,7 +490,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 				  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
 	}
 
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
+
+out_power_off:
+	pm_runtime_put_autosuspend(smmu->dev);
+
+	return ret;
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
@@ -489,14 +504,25 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
+	int ret;
+
+	if (!pm_runtime_get_if_active(smmu->dev))
+		return IRQ_NONE;
+
+	if (smmu->impl && smmu->impl->global_fault) {
+		ret = smmu->impl->global_fault(irq, dev);
+		goto out_power_off;
+	}
 
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
@@ -513,7 +539,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	}
 
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
+
+out_power_off:
+	pm_runtime_put_autosuspend(smmu->dev);
+	return ret;
 }
 
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
@@ -683,7 +713,6 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	enum io_pgtable_fmt fmt;
 	struct iommu_domain *domain = &smmu_domain->domain;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	irqreturn_t (*context_fault)(int irq, void *dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -850,19 +879,14 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
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
@@ -2125,7 +2149,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
 	u32 global_irqs, pmu_irqs;
-	irqreturn_t (*global_fault)(int irq, void *dev);
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2205,18 +2228,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->num_context_irqs = smmu->num_context_banks;
 	}
 
-	if (smmu->impl && smmu->impl->global_fault)
-		global_fault = smmu->impl->global_fault;
-	else
-		global_fault = arm_smmu_global_fault;
-
 	for (i = 0; i < global_irqs; i++) {
 		int irq = platform_get_irq(pdev, i);
 
 		if (irq < 0)
 			return irq;
 
-		err = devm_request_irq(dev, irq, global_fault, IRQF_SHARED,
+		err = devm_request_irq(dev, irq, arm_smmu_global_fault, IRQF_SHARED,
 				       "arm-smmu global fault", smmu);
 		if (err)
 			return dev_err_probe(dev, err,

---
base-commit: fcb70a56f4d81450114034b2c61f48ce7444a0e2
change-id: 20251208-smmu-rpm-8bd67db93dca

Best regards,
--  
Prakash Gupta <prakash.gupta@oss.qualcomm.com>

