Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07420C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019308; cv=none; b=QJ2/ujcoKGAOYtuPN8OQ1TJXHeOpRviyBPIVuz9GGsD5t2CTlXV9k7d/xzSss+a66+jSyMwk+JU5b+un+C4nSX0ogxNoxeCZCzZ6PTvdeUo4I74lP+gjJqrGHL5ApKdvqHCDTV9ombURKfU33A57+Kam31iivw2MdarysYF8B6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019308; c=relaxed/simple;
	bh=TJ3j342Cg3zGY02Uk2UqTZUsVwPMlp0v7nf9f7ax2Mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CotvOjsMtl2wE4/q3Xd4voxo003BR0lnFq2MTdT7r0SNU6ZatNbip0fTDXPD1LsDkIU6UjHuc8DxhiJbQl24J2WEf/3lGt/LOuBSJkUrMClN2xm7KUXLL0JpJOd6+/xOTMQw7EhyhDn9C+UyFD3c7uFcGa0ICbXES8tfdFJ10Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zC6+DHE5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zC6+DHE5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so2093717a91.1
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019304; x=1745624104; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7DsuXIK2575arMhickPkgS/ad3h66HUDJ0u88G5aw=;
        b=zC6+DHE5gintaR9lDln9n0oB8Yn4wt3sxKNwYPqMJ4W/nto/Sq/lVYOe1KX5kErG5U
         euOhwSK0YdPvELBxLqmQO4VytF7inQsAWtTR6ZasmpYzSSDl3omlwaq0ScyYFT+qcssB
         qfNYuL7UnAjUNAPSsHz2AKqGIhA/0newJl+AE1LcMCUZKF4o3xrdlb8peogicCofOwgj
         tprcLqpUKCUJmK8TqZ9fE9QNdE1AWoLdkJLWL/7Rsf4zBCoqzDow3V5qaUb0qqESg4Z/
         pXNlDPY5yvFuQp/edJuse8igc/4gePgnPe4/3yW/yQWsV+5C2zOrLLmSkbkU40i8I/UR
         xDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019304; x=1745624104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7DsuXIK2575arMhickPkgS/ad3h66HUDJ0u88G5aw=;
        b=DSuCcAuGUI7dQB+9cu7gL4FP5kkehV8laYEyALmPQDRdvkwXc119qVOovwXj49omVw
         4n46pyjB67x7dbcZU5OyCMqs4QFjvwst4IdeQ4g9FPqswjbvxnf6faCMLgrZLjFgqH1V
         SgMlqoZ4SGcdkt/Sc2WJSELH8oGWYr8HXORe1QAy3QyF6mODDkl+1K2v46LmxVeuthuP
         bJo/z0nbqaXu2HivUIhwHD8X49iFBv3vzdXcN6XAejxiy475tBqKc/u+iaJSR+K9yeVH
         ZJFzcdSDHEjmaVZDrFPKC/il1grvOk0TPc2GFeCag87xkEsA0eaKdtez2/UIF4DtAJaU
         F9xA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Xc55o60LkEEXJlhV61aSL+VWksQnPRqFeWxUxmwbBJIIThS6n98mKaUA9JI7iEdKV0GD/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKBfdnrX2cIriJzNC20q7NcAyWoHWGj8Jo+UBkp6Dx5cHXnueX
	75p3JyWX5+MYsoMcwWDLQYeI9bZUGihiyvW+ea13X7gPyVDfCQF/UVGs6Dr03xSpHCCs7wC0bQ=
	=
X-Google-Smtp-Source: AGHT+IGyVsJKGp73YBMsWfD6gegoxsN7iiABxP1HqV+ZKcCfVvMfRFBNixsP7h+BuT8cDMt0iI2JZEFD1Q==
X-Received: from pjbse16.prod.google.com ([2002:a17:90b:5190:b0:301:2679:9d9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8b:b0:2ee:aa28:79aa
 with SMTP id 98e67ed59e1d1-3087bb4074fmr5306091a91.6.1745019304422; Fri, 18
 Apr 2025 16:35:04 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:04 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-6-praan@google.com>
Subject: [RFC PATCH v2 05/10] iommu/arm-smmu-v3: Implement pm_runtime & system
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 93 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7990865059e4..3052ce1a419a 100644
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
@@ -108,6 +109,41 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
+/* Runtime PM helpers */
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
+static int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+{
+	if (pm_runtime_enabled(smmu->dev))
+		return pm_runtime_get_if_in_use(smmu->dev);
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
@@ -4935,6 +4971,62 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * Since suspend is invoked when all clients have been suspended,
+	 * we don't expect more cmds or events to be added to the queues.
+	 * Wait for all queues to be drained.
+	 */
+	ret = arm_smmu_drain_queues(smmu);
+	if (ret) {
+		dev_err(smmu->dev, "Draining queues timed-out.. retry later\n");
+		return -EAGAIN;
+	}
+
+	/* Disable all queues */
+	arm_smmu_device_disable(smmu);
+
+	/* Abort all transactions to avoid spurious bypass */
+	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
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
@@ -4951,6 +5043,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a950da2e7ed9..d4ac6adc6a30 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -506,6 +506,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define RPM_AUTOSUSPEND_DELAY_MS	15
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
-- 
2.49.0.805.g082f7c87e0-goog

