Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150732ED5B
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406914; cv=none; b=AZnARRyT2hakLjElAU570h9kBjuvntVIOS3+3Z2bpUY55iVTMmNn8gXErFfatxaYEuyQDZY0U/rYB5qhWinNPhDoqNiUjrrfmK/a9sNf6nZsLytzLRWJ/ch1VTkzHbyh5FCFlZdUmxgQPg07OSn7ivG9HDPORvlquEIXFuhmuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406914; c=relaxed/simple;
	bh=6vLPH6HcP8bSCgjiQhWIfAXp3Fr8TiPMs0pas+apbJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N70qy3wCS+/60np2gSXVgLuUe32DzfMKzAvykq+tlUnyvLNgbfe0BMB7FKA0f/xDYoXRxlfS5W2a4X0b4YK7udyybsLLjRaHFcRJcAbmT+s9HoTgOY/oOvI/F3rYDLmgB1Cca9KexByMyZBId7+CW2v8Crt0Ipg2Q6H6MDyWHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOE8IQQP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOE8IQQP"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so12059915a91.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406912; x=1764011712; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfhTwhnZGXlSS35YJsmIEhxRqVk6hC17emT9e502JBU=;
        b=zOE8IQQPUkALtoMD6cmr5/AyXbYeeRDzU0jzjhwczLwiU4Y8WqK+SjYfcyxnznZGeu
         wesA9+mdE49PdjVEJb9UYkjEZ+d+s947E6TTSssluU3tsGi4J4GbDC3rVR7lBfXXiszh
         GL120KKxbD4IwRkKLKx0b/W3X0q9s/zdZTu4cJbZzYbMvO+NFIRkNCOON5v8DeAsfr8B
         9SSbwmSllXR3B3hibD12T3J3aVwjYS7wmh7RVO7j7Bjb608AzUSYuBe38jK4LY5NsTkM
         zLvvLnwZlOza/NAbwmMy3QonYWHNkCNGxryefENFshCgoPjNKFSxI5fCKSxNReBzGvy5
         1Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406912; x=1764011712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfhTwhnZGXlSS35YJsmIEhxRqVk6hC17emT9e502JBU=;
        b=qrfZ2I+Zm9V5504bcLa1iHTQ4KnKgA8Q8bZ0+bvuZo5MaQmiUlBXsfwfU4HgNJQHnV
         QpDxcLhYEtIFvPOl4aayLef4gX49VmSOlE3zS8/xxxSotQU/b8eqzmZAXLqdMWE4CzWW
         xzyconBMoD6C7CsUp4L8uzXC0/NJHbD2EMuKmPGi9Qxg91btb5PAN2MsFkazt6hxwdnR
         CW8gScN3SrTPrk4jET/zwpBBsME/N8kPQDoZ3dIpb6V0+qtnikZVZk5sbpaD34+g9Dxs
         SyR1a7nv49flT2wOd6wKVutH3n1wwpgjnt8ZcJ6sP0SJx1Yeav7kphOwOP/WSxHdEngB
         WEug==
X-Gm-Message-State: AOJu0Yy3DALlNNhvwZPqb6qqWiWFamdPmoXujd7fIFeshATyJkSn3Yl2
	tCDo3sWwhGGGQjt+HwingswtCQsmYwN+LYEcnKf0qXasnOthGPzMF1s5m/C3uzibkqNT1tn+y7B
	n0IozioPby91kF+lKQVzjZRYOhfD7qc8Vq0tcEoiB6QJdAJZHAvuZmKxNMThkdgsgFzAmlcxyBT
	tGSvVqSu9TyXBi4ro3n30Vh/OEk1Dlmw==
X-Google-Smtp-Source: AGHT+IFTUbHpo/v4HumXNTAmcCC8kGw0c06e9JloVQvceBAofAKkhJaWz3vghwItcCjCghCvtCwFmvR/aw==
X-Received: from pjbsv16.prod.google.com ([2002:a17:90b:5390:b0:340:9d73:9c06])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d004:b0:330:a228:d2c
 with SMTP id 98e67ed59e1d1-343fa0dbdbamr14966904a91.15.1763406911919; Mon, 17
 Nov 2025 11:15:11 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:31 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-7-praan@google.com>
Subject: [PATCH v4 6/8] iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pm_runtime and system sleep ops for arm-smmu-v3.

The suspend callback configures the SMMU to abort new transactions,
disables the main translation unit and then drains the command queue
to ensure completion of any in-flight commands.

The resume callback restores the MSI configuration and performs a full
device reset via `arm_smmu_device_reset` to bring the SMMU back to an
operational state. The MSIs are cached during the msi_write and are
restored during the resume operation by using the helper.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   3 +
 2 files changed, 112 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d6e75d1646d6..44875c526183 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
@@ -108,6 +109,33 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
+/* Runtime PM helpers */
+__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		ret = pm_runtime_resume_and_get(smmu->dev);
+		if (ret < 0) {
+			dev_err(smmu->dev, "Failed to resume device: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		ret = pm_runtime_put_autosuspend(smmu->dev);
+		if (ret < 0)
+			dev_err(smmu->dev, "Failed to suspend device: %d\n", ret);
+	}
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -5005,6 +5033,86 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
+	u32 enables;
+	int ret;
+
+	/* Try to suspend the device, wait for in-flight submissions */
+	do {
+		if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
+			break;
+
+		udelay(1);
+	} while (--timeout);
+
+	if (!timeout) {
+		dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
+		return -EAGAIN;
+	}
+
+	/* Abort all transactions before disable to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
+	enables = CR0_CMDQEN;
+	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret) {
+		dev_err(smmu->dev, "Timed-out while disabling smmu\n");
+		atomic_set(&smmu->nr_cmdq_users, 1);
+		return ret;
+	}
+
+	/*
+	 * At this point the SMMU is completely disabled and won't access
+	 * any translation/config structures, even speculative accesses
+	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
+	 */
+
+	/* Wait for the CMDQs to be drained to flush any pending commands */
+	ret = arm_smmu_drain_queues(smmu);
+	if (ret)
+		dev_err(smmu->dev, "Draining queues timed-out..forcing suspend\n");
+
+	/* Disable everything */
+	arm_smmu_device_disable(smmu);
+	dev_dbg(dev, "Suspended smmu\n");
+
+	return 0;
+}
+
+static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Resuming device\n");
+
+	/* Re-configure MSIs */
+	arm_smmu_resume_msis(smmu);
+
+	/*
+	 * The reset will re-initialize all the base addresses, queues,
+	 * prod and cons maintained within struct arm_smmu_device as well as
+	 * re-enable the interrupts.
+	 */
+	ret = arm_smmu_device_reset(smmu);
+
+	if (ret)
+		dev_err(dev, "Failed to reset during resume operation: %d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
+			   arm_smmu_runtime_resume, NULL)
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -5021,6 +5129,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 924580610ce0..eefa5853033c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -503,11 +503,14 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SUSPEND_TIMEOUT_US	100	/* 100us! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define RPM_AUTOSUSPEND_DELAY_MS	15
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
-- 
2.52.0.rc1.455.g30608eb744-goog

