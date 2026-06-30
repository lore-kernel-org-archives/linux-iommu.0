Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F971263F5E
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810177; cv=none; b=F9v4objIH7u6ps2m6olCgqhJm+4vUmBTJJ/YOzrDUL4JUoTN7oyZfrnfXc8kd2p/YKZWPJkfx84zn/uPFHth4rSPMPJPX2waqoy7ecgzFQFgqrpvQj/89drCR/MVuJHsQrmM3krZtRa3aIIqqjnT7B+5XFA5sPjOj3jwXPN2/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810177; c=relaxed/simple;
	bh=ClzjTDByFdtV1hOdXvvbIGOspmbUT9SEv8vZOG9G0qM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YhH1cIv7O4mDI3wT3w65uLspW6vXRXPJKSd/7ggB5HfboejfMPvubxROPPDLejckRpi/NmMo8lym/m0y3cL49n4MVkDTPBugiASJKZGj9kSLpT0FSnoI2pkgZR6c5oXQd6d0gjRsLFLWZBjju5yMt2+X3/UPPYdvup2tOJsuLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JkrWGodw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ju7GAK22; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JkrWGodw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ju7GAK22"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CKQZ1096358
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 09:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5pgrFdf6l/LP8HdUy9LmfA
	ejKky5DKLGarNpceFhpEo=; b=JkrWGodwPk4peLAk+qMWZC0AXyzy2Q+fkc7M+d
	TH/GbQibgMmRAQbv+eBwrN5zg/UBUc7Ggqmo9DHdNDX7Cm8dteG+c9/c9jAn3enK
	FWMO45aCZTNrTaL7lS/GFpP/exxKV0hctZbyh+xP/grKQPDmgfjyqXucGm5LZ3B8
	HZLDQoBxBoKpuco6yizfi4P5lE7XbkxOtgdCqlP0egZTYGNcZtMDKWonrpq4Q76z
	61j64nFvKyxiqkne8TKaV4jShKJ5cqbARHfVzuIcJEGMHrwUCHRND19WJrH4eJWc
	h4ERVFLU0ghKuek20KERTdqTS6kUdTao3+1qp/fT5x9zu/fg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gsnv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 09:02:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30eec544cc2so343826eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782810175; x=1783414975; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pgrFdf6l/LP8HdUy9LmfAejKky5DKLGarNpceFhpEo=;
        b=Ju7GAK223FpQ3vGxA0FEUIy7eUH2c4OwEjLhdyw3Hs+yEL73iRUyyvEUcXOelVM5oQ
         bZqVrSnWfJt93F92Nq5+9z+Cio1JQiVxZry8/uVbM5YElUoxT2niiqV7kCVpTRcNuVA7
         68w78GqPyN4MzE7mzYwwAejTAFbX43dfMF+AFhmL93GvvgHkIY8PTdtr7w6+UGSp5DiI
         dwMXrq4u8wmAesjEv9gqbGBTnPDD5eagb0kTzHabyDhTt8sEiktqyj+wDmv7oY0eQwNJ
         /rUgXH5WmWIc1A1qayD0yFZUmM6vWq5C3YcnytFJnb0P8mwU5sFkHe5aYLKXyNcyD+bi
         R+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782810175; x=1783414975;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pgrFdf6l/LP8HdUy9LmfAejKky5DKLGarNpceFhpEo=;
        b=qaJd2n0evCChLibd1GjqxboLm1yKt7hTWM1DLodGsF1AM324wdn2vF9lWMITUIZufI
         xfPXBo8ScgdpxpZwkInZydku+4kDpWhCQIUkHrGU12LhcgDqd0+RCTuFu31I95TtswJF
         b7W4rZKwLrvPgbyTdOU8UQKaz6iAgeYrf1LvtpHPwd3ZFFZ4JQlnLzdDwACcEYxpFRy4
         aVKHw+ZS/p7YkcPVWy8ZOHt2rHw0EkxCDovwPRs+uGXfSGiDN8X2PU0wImq3cmTBbnD/
         TSJOgL3EQQM4vgKjC6TwJGZupatIIWRcDWb9CypxpdyJTIizQxruDXdDcNw/SglWftU7
         NXnA==
X-Forwarded-Encrypted: i=1; AHgh+Rod+iy/48Zli9P9yskocAkSyU8qxDUJyj9Pe/fc2MCD8D2ZqB+O37HLrCrM9OUIFclcVVpz/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv/5oRjW6W8wH9XUXuHPIvl9olQ9iaJzhHFhrHpgTs/0PNeeio
	IuFNO8S0ANhJ247at8+A9jUNLcLBFs70XoNXKDfkAdk/zSI475QtNTxbczK1SdUgbF+sw/Yf3XR
	4RXFZ/b+0ICQ3PWgkRfdE2dLqcLadIkbBK81VVUfnGLKWw4r67y+5/7ER/w==
X-Gm-Gg: AfdE7cnWkUjhz6xOUybV6VJkHB7tiQxlueTUfwdHM/MUt/mAEA5ypf68WXZOLMBUWcI
	e7ev7mKrTWtaeLThlofy5ZQ+eOgJQh+e7OYWw8bDVeaO3OOeYZjsIT4WvL/MYHEtz+S+KAnXVxh
	JjbeSFykKHZzk4TbKC/Z+JhAg0ZpJgErH+2f3ei7yp3KHa17qs41uqPIM26FaVB6kDcXsSC+cYu
	cs+Qinz8SMI6xeMzOMelq1pwR+3BfmqM6WOR98FgDSjQDhF0zTgXe1QzPEOoWR64INc9G4yaso0
	2rr6CGzHS6gimPloW6yLK1QMcIJ/+P4XMxzR8aGJ3dwKYOa7CS2NISzQtPiW6HACSeCQPWGoN5O
	oF6d8OYn+rdiseOfL3dxVaGNtw7VReJbVwWwOdRXP+w==
X-Received: by 2002:a05:7300:430f:b0:30c:9f31:b631 with SMTP id 5a478bee46e88-30ee13a1086mr2218006eec.33.1782810174634;
        Tue, 30 Jun 2026 02:02:54 -0700 (PDT)
X-Received: by 2002:a05:7300:430f:b0:30c:9f31:b631 with SMTP id 5a478bee46e88-30ee13a1086mr2217975eec.33.1782810173961;
        Tue, 30 Jun 2026 02:02:53 -0700 (PDT)
Received: from hu-guptap-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3264f52sm6022612eec.28.2026.06.30.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:02:53 -0700 (PDT)
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:32:46 +0530
Subject: [PATCH v3] iommu/arm-smmu: Use pm_runtime in fault handlers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADaGQ2oC/22Myw7CIBBFf6VhLQ0MfaAr/8O4KI9aEpHKWKJp+
 u/SburCzSRncs+ZCdroLJJTMZNok0MXHhnEoSB66B43S53JTIBBzYFJit5PNI6eSmWa1qijMLo
 jeT5G27v3lrpcMw8OXyF+tnLi63eNNIxDu0cSp5yC7aGvtKwFq88BsXxO3V0H78t8yNpKsPuCi
 x8fsi81gGhUxUCxP/6yLF+i5uQI5wAAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3OSBTYWx0ZWRfX/OHXp4A7uekm
 kWFatrDToj3V0ekj7lFjdNVoZR+OQz32j1hieJnpjgosUU1NlRtZ4f/mWxvBcVfGoX7fSgAKeuv
 J7FLAZLbIdbBGt8dRFVBSLSeqoezvPg=
X-Proofpoint-ORIG-GUID: 8gFX2gHKXl6E9WuTN-j2dc48bx3miW3y
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a43863f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=44HM8yHCulYeUOODjvgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3OSBTYWx0ZWRfXzSv/pdlNOahz
 QAW8wIOfr5IQoc6D0phvdDHNqLa2Udk0luKAoyGii8A/79vOOtRs2AgoP54am2cbF6Rc3FlCF7M
 ObzjncH3wSIIQHpWz8zH0g3so0sI86yMqwD+Q0MdDPL/TWfauGUJFdWhu/AIqPQKAx5RmoZmOXR
 C3J0c1VkgOVisnWPXyQ3OP0hOslTUlHNZlVSBQ2oLiw9r2/ZhOvLtdW1XoYjPnT7me9PnMu5bHm
 dZhx6PGfupg/KtxNq8qDdqVzIre7tdBF7gJJ9HTdJDneZdOBWHMtaJj65wB29DQOziHck5KbQe+
 /QXrj7KiqIAdjxBVLGSAqDjpTMMceywYWUWGk1Ny33ZSVvuHojD8GinZ7jUwRzEKEz8bU/knO2h
 JhdSWOIw0sk7+s/jD0uz0KQbjtSeF8MQJaaAHktqIizHlTVZg0gV9oH13bWZMIKVoCc7qPFG3Qr
 ly8z/68OkdvBWIt077A==
X-Proofpoint-GUID: 8gFX2gHKXl6E9WuTN-j2dc48bx3miW3y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300079

Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
enabled pm_runtime for the arm-smmu device. On systems where the SMMU
sits in a power domain, all register accesses must be done while the
device is runtime active to avoid unclocked register reads and
potential NoC errors.

So far, this has not been an issue for most SMMU clients because
stall-on-fault is enabled by default. While a translation fault is
being handled, the SMMU stalls further translations for that context
bank, so the fault handler would not race with a powered-down SMMU.

Adreno SMMU now disables stall-on-fault in the presence of fault
storms to avoid saturating SMMU resources and hanging the GMU. With
stall-on-fault disabled, the SMMU can generate faults while its power
domain may no longer be enabled, which makes unclocked accesses to
fault-status registers in the SMMU fault handlers possible.

Guard the context and global fault handlers with
arm_smmu_rpm_get_if_active() and arm_smmu_rpm_put() so that all SMMU
fault register accesses are done with the SMMU powered. If the SMMU is
not runtime active, the fault can be safely ignored as
arm_smmu_device_reset() clears fault registers on resume.

Additionally, disable fault reporting in arm_smmu_runtime_suspend()
before powering down. pm_runtime_get_if_active() returns 0 during
RPM_SUSPENDING, so without this, level-triggered fault interrupts would
cause an interrupt storm while the device is being suspended.
arm_smmu_device_reset() re-enables fault reporting on resume.

Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
Changes in v3:
- Add arm_smmu_rpm_get_if_active() wrapper that returns 1 when pm_runtime
  is disabled, ensuring fault handlers work on non-pm_runtime systems
- Disable fault reporting in arm_smmu_runtime_suspend() before powering
  down to prevent interrupt storms during RPM_SUSPENDING state
- Use pm_runtime_put_autosuspend() in arm_smmu_rpm_put() instead of
  private __pm_runtime_put_autosuspend()
- Link to v2: https://patch.msgid.link/20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com

Changes in v2:
- Switched from arm_smmu_rpm_get()/arm_smmu_rpm_put() wrappers to
  pm_runtime_get_if_active()/pm_runtime_put_autosuspend() APIs
- Added support for smmu->impl->global_fault callback in global fault handler
- Remove threaded irq context fault restriction to allow modifying stall
  mode for adreno smmu
- Link to v1: https://patch.msgid.link/20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 92 +++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3..045389e89484 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -79,11 +79,16 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
-	if (pm_runtime_enabled(smmu->dev)) {
-		pm_runtime_mark_last_busy(smmu->dev);
-		__pm_runtime_put_autosuspend(smmu->dev);
+	if (pm_runtime_enabled(smmu->dev))
+		pm_runtime_put_autosuspend(smmu->dev);
+}
 
-	}
+static inline int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+{
+	if (!pm_runtime_enabled(smmu->dev))
+		return 1;
+
+	return pm_runtime_get_if_active(smmu->dev);
 }
 
 static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
@@ -462,10 +467,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
+	if (!arm_smmu_rpm_get_if_active(smmu))
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
@@ -480,7 +495,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 				  ret == -EAGAIN ? 0 : ARM_SMMU_RESUME_TERMINATE);
 	}
 
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
+
+out_power_off:
+	arm_smmu_rpm_put(smmu);
+
+	return ret;
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
@@ -489,14 +509,25 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
+	int ret;
+
+	if (!arm_smmu_rpm_get_if_active(smmu))
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
@@ -513,7 +544,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
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
@@ -683,7 +718,6 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	enum io_pgtable_fmt fmt;
 	struct iommu_domain *domain = &smmu_domain->domain;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	irqreturn_t (*context_fault)(int irq, void *dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -850,19 +884,14 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
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
@@ -2125,7 +2154,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
 	u32 global_irqs, pmu_irqs;
-	irqreturn_t (*global_fault)(int irq, void *dev);
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2205,18 +2233,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -2306,6 +2329,25 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
 static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	int i;
+	u32 reg;
+
+	/*
+	 * Disable fault reporting before powering down to prevent unclocked
+	 * register accesses in the fault handlers if an interrupt races with
+	 * the suspend callback (e.g. device in RPM_SUSPENDING state).
+	 * arm_smmu_device_reset() re-enables fault reporting on resume.
+	 */
+	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
+	reg &= ~(ARM_SMMU_sCR0_GFRE | ARM_SMMU_sCR0_GFIE |
+		 ARM_SMMU_sCR0_GCFGFRE | ARM_SMMU_sCR0_GCFGFIE);
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
+
+	for (i = 0; i < smmu->num_context_banks; i++) {
+		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_SCTLR);
+		reg &= ~(ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE);
+		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_SCTLR, reg);
+	}
 
 	clk_bulk_disable(smmu->num_clks, smmu->clks);
 

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20251208-smmu-rpm-8bd67db93dca

Best regards,
--  
Prakash Gupta <prakash.gupta@oss.qualcomm.com>

