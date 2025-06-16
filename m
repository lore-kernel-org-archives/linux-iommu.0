Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB21E3DFE
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105969; cv=none; b=S3P7YiQd3ifbqCHKwuxfMR0vYE+P/+bqVVup7IOEsJSheniRhoLpz/s2VLy7kvDsQgGpEeCbkTj5KWn7t2ktW35jTKO5LGr6CThJNNML/EbVO8SI15jG/30sgz1rJ7J1fSoNy1JLivN/y3QXAqMJAnvK1aT/nRukb6mJ4CxC6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105969; c=relaxed/simple;
	bh=zIDgesGHOhg8luIhFg19xN+rvD6CVBfAfWVgXjIuAIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CrWNsicSSkMnk1iOQukcAdaccdnGnlbWs77V526qYKlaz48TYkHnGw1lamnBn0MmTwFiWwUsg+2BkRZhPdz07mPf6tZPH5elyEKq/GXoy0qBnuDEwTkKLu4hy1nUOhMy0g6wBetux0ExhO1PPRSCTngXeLZk4Fqg9FRFCVeLWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBPsqvJL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBPsqvJL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d394f45fso3984944b3a.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105967; x=1750710767; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3QDKnB3AmPZ+J9trBYF7fgFz4vFgIhYL0Dmefu0bg=;
        b=jBPsqvJLeMfqVsrl6aXzRtwtqBKobj1J5aP8JrwJWQRNsCr8pynvgXPdxdQh4D0WNd
         YktqDQKV4aReIgDO39ah99ojFSlmVg1ZEI1yW11YCJhhzqNtyINKxsrJ+RIFolC9rtRw
         Vb0R4M8DPCCsOhpmkfqqzqhNhEwjJ6hDdsYHLLk8ZUUdrZp6a4CzbAHGJDmfJEcaXsFy
         MreO7+Aj4bKMGgMKC/Ldtu2T2A2n+x6Nw/RdeUAidLn7SrsqmihdMWSBFnFynJssaGKS
         QOg6iOE7j2tOQ7BSaWd8aJ8+wCAqTBFGNR8qc5ukgpFpZvRfQF1drwmbcGEovSJ/Wj7+
         7AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105967; x=1750710767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3QDKnB3AmPZ+J9trBYF7fgFz4vFgIhYL0Dmefu0bg=;
        b=ArjdAH7nsbQ871+ddEGAZkareJmShXQwUQJztrAdLwtDo1iZCDYxMSosIERiPrgQaZ
         mbQ7gU6dHFIbvLdAWdDPQtOw5txAmzamZ5xJecKYz2iw1n4gJtNmiO5JnmPbqEiDvHVQ
         jYhHBhdPHcaVr+WtIHiGMPvZNhZB9tpu6ZqI9QjKx1PGNla7LlGTtJKCsEK01the5EuA
         HNfQw+/G/Q15KRdxauIAhMteiefoRug7RIrZLIGVSxeh9LespkhzW4Hy5XlpsSH8IAHj
         ZbCYsb75TJWoQd9hDvPYXeGeJ+FHAJ/kO8CML0+ZlkXWmiruJDb7Y5iY8fe4X+1F4mXw
         4yNA==
X-Forwarded-Encrypted: i=1; AJvYcCWXpSq0upxckc+tBcFku/JU/3pNpwnZU/vt28MVhP97yN421YlR6NAb9QB29/HvCipuRs8Rqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTenm1ONly/BXRKkSSF4lXOYHMevHLKms9y0xoCarHS/9hLD4h
	SnaoF762m7jSKQA10vwO3z0RJu6fejqKIs89xpJ9atTvymJin6s/PEcUpbD41VwMuUEgAovi6Ym
	2+w==
X-Google-Smtp-Source: AGHT+IGZa6FtT9T+k8sZ/Xw0d1hRb6m0ps6eUZTnaIMyXkry8x5dy4twPfiPEOZQEpGGAMMZGP5hv22hNA==
X-Received: from pflr18.prod.google.com ([2002:aa7:9892:0:b0:746:270f:79c0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1797:b0:736:5438:ccc
 with SMTP id d2e1a72fcca58-7489ce3cee8mr12720663b3a.9.1750105966999; Mon, 16
 Jun 2025 13:32:46 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:47 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-7-praan@google.com>
Subject: [RFC PATCH v3 6/8] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
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
index 4699d3294d3e..5736f08e3af7 100644
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
+static int arm_smmu_rpm_get_if_not_suspended(struct arm_smmu_device *smmu)
+{
+	if (pm_runtime_enabled(smmu->dev))
+		return pm_runtime_get_if_not_suspended(smmu->dev);
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
@@ -4932,6 +4968,62 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
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
@@ -4948,6 +5040,7 @@ static struct platform_driver arm_smmu_driver = {
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
2.50.0.rc2.692.g299adb8693-goog

