Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2950A920
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345002; cv=none; b=VR1sID7mNZWVdGL1TIAFfZYbx0onfKwiE73QVNxoeP/5EIGZiB17M/AhsVhzGdWk7DJ4K0sbBeHutp3CKJHNhb1+EVb+7VVW/KtY7417q/e95Y1+Rr2suVB8n1b13Vyp18Jbsiy3v4snCoLtfFoqBF20OyZ+XUwn0jJzhWlc2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345002; c=relaxed/simple;
	bh=PmIAgQ1BF58ou8jj4PzUmg76OVRHq8qze6Dj/rdJsxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VY1o8jbNPbz3weP8PgPcQSjc5uXCuM44p35IRcjKvDmuT1EMYKPZL+irPdGSJP90NF9dxdKdDfazOU4wIz29YvxoUGMt5MZXqXyrfvYBsYkBNAYC8+R4VlnvPvNYGYPfaSUNNPcsL3Op4KhAYlMYPOknQFGwjikwaqk1wYO1+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whC1HQ2N; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whC1HQ2N"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223d86b4df0so180571985ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742345000; x=1742949800; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVsfUTThVOUiCf8rQ3B/+KhAqpX5OpkFj8rmaAOopxs=;
        b=whC1HQ2Nom3SloyMAH0KRe6rmzpZRLN8z+sPeMd/SRY9N0qDC446be5cHie4jVtmp0
         ABH/BU8b+sk7Hji2UJJdTqxqvUwmtAIyEr1znGRmjlP6OQeN/T94r8010HKcYb990UC5
         2ydR2iU7RE+vXZffgSnO5gT/nNDEyCvfYQxA23bYIx2yRdzA7stStTczwJYQrA7wmaJT
         23m6SwdqisUJTCHIXVy7WttpTapBdRgtTZ4+I8kkVpOd5EImY1haF+fuVUiUs3BtJMDl
         r+flfxOdI4IZZjvUr8OggscaQfTT+bSpO+ceb8/Y7v38rgIM70BomQCrwbwAbz2uI1j8
         w2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742345000; x=1742949800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVsfUTThVOUiCf8rQ3B/+KhAqpX5OpkFj8rmaAOopxs=;
        b=eTcEZMaxZk+0MIqlgSJA6KQPG7aGq/390ICvpBaSkOMYj1liUT2cKYfH0dfz486w/v
         fy5nti/ZYxBjW/6+O4cZZQ8OmQ9vcBqVYNI4CQ9+TZtEvwt9h8gWQdrehUOKJDcTA+Ez
         crUpMLN3NXMeCYq4qrhprd+ktAYs89sjLj5wJ9xLBS2z5zRDUIhjp2+hqkFZSHTm4E/n
         5Ak1zjXgg4tD0ZtX+khscylNKzU31nfbyZtxfnrvVDVaNeu49LFRTyv/C3dOVCyfebR7
         h5ZC+9+X7vEHKP1r4TVXqf/tDC6a8zIqE2TB5L9U0z0in1G4ihRZ/dZYWSe1dZweCq0Y
         EprQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh+HPGm+6JcvKLsOM0gTFm8YYrEbus98VfsxS1L+4H2XGXmXpR6/t5wI1vIub5C4Ndi2JbJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1avpiuRdUJ3lOeIVT2jNwkqeqbfnLjCuzSCtytdJ0moLDpHV6
	cGNIIJcj2H3YqGsojXp7t5dkkU2gLTlIzE83pdjzoq76J4Zwh8Ot5g/lW6l2r8tCfQ/uY/S+yQ=
	=
X-Google-Smtp-Source: AGHT+IE2yxdTUEB/0PQiB34m8WgHf0vEYEL1QpPeisJg6LGijX9uTEvxbS87qtjhjlF2E/fPOiIsr0DmnA==
X-Received: from pfsq17.prod.google.com ([2002:a05:6a00:2b1:b0:736:4313:e6bc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c9:0:b0:736:43d6:f008
 with SMTP id d2e1a72fcca58-7376d619dc8mr1058094b3a.12.1742345000012; Tue, 18
 Mar 2025 17:43:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:42:52 +0000
In-Reply-To: <20250319004254.2547950-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319004254.2547950-4-praan@google.com>
Subject: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pm_runtime and system sleep ops for arm-smmu-v3. The smmu is
disabled as part of the suspend callbacks after ensuring the completion
of all pending commands and is configured to abort any transactions that
happen after disabling the smmu. The smmu shall be reinitialized in the
resume callback by invoking the `arm_smmu_device_reset` helper.

The MSIs are freed as part of the suspend and are re-allocated during
the resume operation.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 106 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
 2 files changed, 108 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f65d9bca0392..caf750470772 100644
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
@@ -108,6 +109,32 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
+static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
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
+static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
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
@@ -4850,6 +4877,84 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	/* We might get the vcmdq */
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
+	};
+
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
+	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
+
+	/*
+	 * Since suspend is invoked when all clients have been
+	 * we don't expect more commands to be added to the cmdq.
+	 * Thus, wait for all existing commands to complete.
+	 */
+	arm_smmu_cmdq_shared_lock(cmdq);
+	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
+	arm_smmu_cmdq_shared_unlock(cmdq);
+
+	/* Disable all queues */
+	arm_smmu_device_disable(smmu);
+
+	/* Abort all transactions to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+
+	/* Free all MSIs (re-allocated on resume) */
+	arm_smmu_free_msis(dev);
+
+	dev_dbg(dev, "Suspending smmu\n");
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
+	/*
+	 * The reset will re-initialize all the queues with the base addr,
+	 * prod and cons maintained within struct arm_smmu_device as well as
+	 * re-wire the IRQs and/or enable MSIs and install relevant handlers.
+	 */
+	ret = arm_smmu_device_reset(smmu);
+
+	if (ret)
+		dev_err(dev, "Failed to reset during resume operation: %d\n", ret);
+
+	return ret;
+}
+
+static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_suspend(dev);
+}
+
+static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return arm_smmu_runtime_resume(dev);
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
+	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
+			   arm_smmu_runtime_resume, NULL)
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -4866,6 +4971,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..6bac83a511e2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -505,6 +505,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define RPM_AUTOSUSPEND_DELAY_MS	15
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
-- 
2.49.0.rc1.451.g8f38331e32-goog

