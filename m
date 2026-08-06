Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165A442FB6
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011772; cv=none; b=Xmd8REW7R7lhauzVoklRTnLuByK3mhf08lk1/rI+Dc5oXs3nSWt0vZKwngxQYBQMbOR0pO7wZZZNh1PvhlNg4TQFjPX0xRPYVHKbOa1ES4AlRLMXJ36CTL4pwtzUJJJ6vvoambwfTCKi6Udra63cwQcMqrOdY5WQ94aw8ikZ/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011772; c=relaxed/simple;
	bh=aSg9jpX2CoqCLHDTDsxXF221c2zU9V4bm/h++Iwji+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K/NM9USZCW+DKzIFn71sMzrRMxSX0XA+G2CGOyQ0QPHiyzk8atpyZslLbsTO6Libzs5ilQJzYFuDlqSjM9qmrZ7PwE3HMwvUtRnPh7ZrbYWpxjtIkXsk+hZbIpkleQiFzb8rULoK9gcqXuHhmDpqfSBueskgxlGA08O610/LGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ik4U82jd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMp83ysB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ik4U82jd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMp83ysB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nfhA2724651
	for <iommu@lists.linux.dev>; Thu, 6 Aug 2026 10:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gWhfiMx2w5cOtpnBFaw016
	s4+kUO8dNkcA9O8SsxAjQ=; b=Ik4U82jdxbFNz5LF+BlfJY8pG86xTQtGpNGjVg
	doQgD9ibeMoOjH+Be+3IWWNSepV/dniCVDXZcM+d+05K/aPLXQAleBRCaJjVZBrF
	N6kiG/4ZhdfpZjQmHv/N6eMGeVA7nFgzZK0q/93MMhHLb7qFWbN47TT2cmcJpoGC
	1SshvUvC9ErajcFH6FrMWqEYlcHe8+EYutxwlgTEWzpRC73A3dr6Pz49j48H2kUT
	0QsFjzBBPjxJFy0PJUzB7hpX5Gm6Rhx/BdlHq5zI/mKsw+5UQA9vicZvMnwpRC8Z
	tt+20OtlnsGJP/aaSS7PQLmOQ4N/5BkUfCRg2CPkUSj8ny7A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9dmkpd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 10:22:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so3284565a91.1
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786011768; x=1786616568; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gWhfiMx2w5cOtpnBFaw016s4+kUO8dNkcA9O8SsxAjQ=;
        b=TMp83ysBkyGzNRi3sOR9RhL+CMXSnhnfjG/glorwZR9LsYO6t0bs20cuyKqGOAtgSr
         81exjxoAhFl7pzyy5JFR6icBwxRQbKyhowU/o2RrDoCuwkTRmvyMIFWo4d6Scg/CVlf2
         O4iCU2jQKsWZtNhX4CfS1JQZpybT3D9wpwuJJRl/kReWdz8sUyw4I7wJrnhQNYdnsTCv
         pdMWxZB8Q7vTqacUfQZPGBnPtO4191jj6gVVoQhc9h37jqSd9kyRj7RM13vVk+B2DoVQ
         lKWRyUFYNU8eF0b/kEYO8Nnm16jlUPNMV3SrilXIR5Sc5ZMHXEI3BDvZ/J5CIQmPm+nu
         DhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011768; x=1786616568;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gWhfiMx2w5cOtpnBFaw016s4+kUO8dNkcA9O8SsxAjQ=;
        b=m9zzN6ugiqYNx4FTIghiCV6hlHkKjlDPw3o84WixjeSpwfzLTJkheE6AnfyluN5jkY
         5Ynp8kJt7VG0ECHrpSZLE31JxDQyiB9Bo2GG1AuQg6uZJIEgPYUMQfQV0YiXtEHOuOW7
         ek5FbKF2QdcYmA0/iFJV7RZChA2BX9Uh+QKibQRGkCgN2ix/6KjoWQs/OzzRT+L+x/Oh
         2RzKJakvNXTo3whBo8RLk4oIEy8TMObgE6FtclRIUoE2QUJb2P9lg8iWIV+L5ia+GsZ2
         GLJ0yGiIH9kAjtHaA/RhZ3TUVHs7DZ4G5Z/YAhRUw79RAKLNhIhH8s+OphgjEkmUQ932
         UU3Q==
X-Forwarded-Encrypted: i=1; AHgh+RprLKrVCtKCDTrNcLTrFcwoVSZ+deZYmF2cfGuz1N5Fx3FfL6Q2vWopEFksCkqP03swc2bu6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZe9vLXN0htIbn+06GZefAsYMD++PlIhoU4oq76xYPSFYMfUhh
	FX1yakfnn37S5O/uXZHpzyN6TJ7iiUsXTglnLxn0TL9y1cAnKz48yBMou9s6pu37MOlA62p8Ynl
	dpSd0RHptZtEP5t2vpxAHONYNJNkgld1kdi9dN1otduH117I/+ETNvoKutQ==
X-Gm-Gg: AR+sD10xTtc7nNGfp0h5b0NPFOFlQQklcySNDHA7t7rdf/sDWdqwZH9GRIS88AsV086
	KbJfqdPJV3pTVBliAxgaVEiDYPQDaiCWr1jSaxrks985TrnrdIapjCs1GS6WyhhYo6e5HSMpFAU
	eFjbjx/9x61WaqKQhLso/xJBXtqRAtTsEd1HVn/caKfOhVu7+N0D5vaKjCez1t/1UubjPl6p6Mt
	qo8qnoArzAjzPoKoyD0vBVcygFkFaSmtVhXkjxihXV5WPnZ0ss85zZCIbWUP/VJj/fsasTTSptf
	I8hlFTJNWYny0N5XkwIfBoC+Mzk4/sfgjNqBAWj9YtHQFaVqSlx60K2iDXoljOCAKbL8FJTXbco
	i5NtOPlEPxIsQXn0m+4SmQnt9oBSS/bw=
X-Received: by 2002:a17:90b:5447:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3903c66b3bfmr15056834a91.21.1786011767941;
        Thu, 06 Aug 2026 03:22:47 -0700 (PDT)
X-Received: by 2002:a17:90b:5447:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3903c66b3bfmr15056788a91.21.1786011767428;
        Thu, 06 Aug 2026 03:22:47 -0700 (PDT)
Received: from hu-guptap-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158644a195sm24605621eec.13.2026.08.06.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:22:46 -0700 (PDT)
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 15:52:41 +0530
Subject: [PATCH v4] iommu/arm-smmu: Use pm_runtime in fault handlers
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHBgdGoC/3XMsQ6DIBSF4VcxzMXARRE79T2aDohQSYpYqKaN8
 d2LLjq0C8kh9/tnFHWwOqJzNqOgJxut79MoThlSnezvGts2bQQESgpE4OjciMPgsGhaXrVNzVo
 lUTofgjb2vaWut7Q7G18+fLbyRNffNcIJhWqPTBRTDNqAKZQoGSkvPsb8OcqH8s7l6UFra4LdM
 8oOHpIXCoDxpiDQkD+e7Z4zcvAsecNrURWyFMTIH35Zli87rUebJwEAAA==
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
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TJR1jVla c=1 sm=1 tr=0 ts=6a746078 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=EVyLOO7RdM4CSD-C3s8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: tfppZD8HARYHxF-AmDs6UiHDavHa7S26
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4MSBTYWx0ZWRfX7EchVrBXMhYU
 4AOpU86knryy5hSpWPG3iW08jIUuPUdDlX9+CqQZPJwpTrOV0CwwJ29w8mvBHrYzCCDE6/4GJb3
 Tw5PcLP5/tSwmVIvwofB+K99hcy/9FU=
X-Proofpoint-ORIG-GUID: tfppZD8HARYHxF-AmDs6UiHDavHa7S26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4MSBTYWx0ZWRfXwE46Tk8x8/wf
 CtISvNdkHGnK8HChM1m2Dyu6Mfs0LSpHOoqn3m6M/q4SsQ36N4nJwtMisfZfuBGI3TNSKzG2abj
 Gf8uU/4SBcthvn9xuTZHjLF0SNwC5RS7ckQzyuCBUOKU+YUiKdG65802JZ1tIwBzHnzXzjqvDR3
 xXLgjYkW7ii6l0AkoFBLdGXwJWYIyXeWP9wMvhlkdLdC5U5IByugIWhuA6rVSjReHwgEiPSzYfb
 lWF7T/L55ri1f3iFMvdoX1mbVNean7GMIN6ZW90GCCwedmAqVLwtFIJkldRk19tIkAFlbkfFWNj
 g9QLPGapHvEZRpB8IDB9p7hb/xkp5PAfrC+4pTnfOON8LugtEHSw5tHhs3Dff9Ex6Y0/wpIw5HD
 h7DbsZjL1VxMOFgU81F0QVQcKNaCTnELIXmtjksdUmL0gEUQ/Hv7hGDQf0l+c/Z3ojeER+PaE8t
 jobk6pRUYseSEjKb+gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060081

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

Also call synchronize_irq() for each context IRQ after masking fault
reporting but before clk_bulk_disable(). This closes a race where a
fault handler that passed arm_smmu_rpm_get_if_active() before the IRQ
was masked could still be executing MMIO accesses after the clocks are
cut.

Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
Changes in v4:
- Add synchronize_irq() loop in arm_smmu_runtime_suspend() after masking
  fault reporting but before clk_bulk_disable(), closing a race where an
  in-flight fault handler could access MMIO registers after clocks are cut
- Link to v3: https://patch.msgid.link/20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com

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
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 101 +++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206eb3..2b692a5293a2 100644
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
@@ -2306,6 +2329,34 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
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
+
+	/*
+	 * Wait for any in-flight fault handlers to complete before cutting
+	 * the clocks. Without this, a handler that passed rpm_get_if_active()
+	 * before the IRQ was masked could still be accessing MMIO registers
+	 * after clk_bulk_disable().
+	 */
+	for (i = 0; i < smmu->num_context_irqs; i++)
+		synchronize_irq(smmu->irqs[i]);
 
 	clk_bulk_disable(smmu->num_clks, smmu->clks);
 

---
base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
change-id: 20251208-smmu-rpm-8bd67db93dca

Best regards,
-- 
Prakash Gupta <prakash.gupta@oss.qualcomm.com>

