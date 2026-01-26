Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF633B6E7
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440338; cv=none; b=HnC9Ge1m392AfmD5h84C0Pv+IzhhPLj+oGOyx2/P+6SdlEvSF9kBc6IkW2XOBZlOz4ybyBUekrouVyPt7C2t1OUgv6GQLgPtIcpv8t+9V0W8QyNQ53TFGYwrGMy1OkYvZ9vBPZK/2h2XDNXvgty3xCYrB6z94J+Ok0071HdYxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440338; c=relaxed/simple;
	bh=jT/k+SkeRUFtoasGq2X/VbqdrN4LeEQbrtRO8YBqQCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CADrip/8gfKTSI8BzQLLElihP1Hg908KKi4AC7Z+tXue56XY/t5YKmNLQ7FEzEs6sSqwYXuxF/sF6+LMk8DcAMIGnDcvV1GmTqWSf4gQQU0mdEC+gQqyRT+kVjBQ9lFcvWTAjhaLLQFQ7cFftgMXYNhoB1mU4PNYDBRHWrf0jsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZA+GZ6j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZA+GZ6j"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c5539b9adbcso569363a12.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440336; x=1770045136; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7lpLLxfO+bjw6hFsv5QJXahaKu80WGt3CsypngZ1qs=;
        b=LZA+GZ6jnBN8bsnXPPjeKWvh4OHAcYuYUZpZcF9xyZDWbKZP2vV8nwHqg+8DwOsDSu
         EzsFDgocjnhTsvnyYqI32NUBm1Ut3gcYnCJ+TvMFZPPC860wZMTuP9RHzwXVSSmgsddG
         JBToZHs6/yTIvQpzRTVi5YMhVhwKRQxhD6FubFS3eC+6xN6dCyoMOV0/MJLhG5G70fpC
         sQI+t/lBrzNiibmOlLfpzJMO8M0hQCzvEx/ao1JIQy5WFKTg4WuBajw87X7Pf0uCtGyh
         wSl6orzkrU9zQawyO87PsL+mkq51PoFZx+LgQWY2pYo07WtHKCyGSTui4/E7/adsjcE8
         GAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440336; x=1770045136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7lpLLxfO+bjw6hFsv5QJXahaKu80WGt3CsypngZ1qs=;
        b=AFl9hh5HrAQnN1/SFKxBl5sitKZbjd5bp2aFKRrkUJHOLKZmtqiNIgI8eM7yqUq06f
         7SHv5nG90lTOO7LThS+8mxXVw0zQOhJubYNV59NgRflfLfUU/5/ZVWkyA+TUP9f1SStz
         Vl9/zbdpSTrzwOmIhEL6C4SEPTCqYNWVnzMbVseG34UpWj/7uDTPmJFZ6dvZInF7C2wR
         pHQ6NUMyTdLsLw09jB3O1CSwF1GLw0I/H2WSu3KUBV1G6RaKCz8vvnCtU7amwM8rKUEZ
         eUqiJ7Z8oFe+66labHrDqLZV2vL5fx6fZfZ/U3QtKBLd5wlLPuhaX/lDMBI4OkhW8EYB
         CROw==
X-Gm-Message-State: AOJu0Yy/ZucrnO8uf2lG1A4ImKk3eXPaERLmO5GLR8ElFvXO5PQ9Oc6L
	fHcIrMZfCwWkkCu9OpcAyVtkdPinznrwiPNZ5YLlT4tF03zU1MmeqDNdQQWvtGeR2QRfNSUthR/
	IIcICjpiA6u3zYrET+DasIeyNIzqda/KHdHDmmoCtJAdlWqGhRHHB7Y+dwyJlI4UGxhmNbSN0kQ
	aa+FnODFOzjHSxXVRIPs6LOwczIoUabQ==
X-Received: from pgbfy24.prod.google.com ([2002:a05:6a02:2a98:b0:c16:a39f:5b40])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9082:b0:364:13ab:4119
 with SMTP id adf61e73a8af0-38e9f0f549cmr4816625637.15.1769440336463; Mon, 26
 Jan 2026 07:12:16 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:54 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-8-praan@google.com>
Subject: [PATCH v5 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 124 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   3 +
 2 files changed, 127 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3a8d3c2a8d69..19339ac9095b 100644
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
@@ -5085,6 +5113,101 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
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
@@ -5101,6 +5224,7 @@ static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu-v3",
 		.of_match_table		= arm_smmu_of_match,
+		.pm                     = &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50a2513e4425..6a752fe06f54 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -502,11 +502,14 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
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
2.52.0.457.g6b5491de43-goog

