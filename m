Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF84AEE9
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746326; cv=none; b=pq+w347oqEbGayWsDyuFH8BtDhLYnNcKrXxMzLsaa9KPpehthcKj+1aBBrjv41i3QnnsVlyxYWJZa+lUgCGSJXc/YfSInZHP23nSqF7kmN9ZSpi13/COrWP1C41d7uSlWWqmActJ9Jr12keiFvFYQ0ZOcDahRPiNFz/eq4KSEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746326; c=relaxed/simple;
	bh=d4Fdp0sCqUr6KNhHx/EoU3hAKBbepT+zyGGyPZwpgWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hqtv4Ogy/aUEYcTynjX7f581tlPJqdEu2xHsCt/1Rm9jKvfETrLYSY4v8yNNDIRtoOiQCC83HK+iZqwiQpaWi3fijyZOHIe1cFl8vfq7Jprp/GD7NIZIo4bERA0cEDoz+NBiLFINyVte1RnoJKlLpg1saCiGaym4Ks3GSFA6C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9gQer3Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9gQer3Z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad9ffa0d77so23598077b3.2
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723746323; x=1724351123; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynR0z3KVlE5E8JyNrTJUgi1tTmoJzECYBL4GiMb+KXo=;
        b=m9gQer3Zd4BPx7H74EaiZdX2+o+wJjG78K2F0zoXzopTbgSNe9n98iSHd6bn4sP5G2
         AAcwuX2sVyRWYjicu0dzbnIfsIxY4lq80BFschCETAjHLLov6EuRiz9q/rpM2huWHh31
         hInm8U97C2TsLTO+eUiC2jWsBWp3nR122T288127ynttKy9Q29+rQXkSG3VQQh3PGX0o
         FVfbDyGPh+//z+ErtxLZ2K8KCpeVmwaoNvKWmi2/FeWGhQe0VFkhWKxYDPmoxpjmsKyj
         PwjPBrRLHvp1BCQzlBSOGIOwypBF+B4jqf7pXqHl4AqOS6zCCntEb/oH5s/9lq9+O5A2
         R/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746323; x=1724351123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynR0z3KVlE5E8JyNrTJUgi1tTmoJzECYBL4GiMb+KXo=;
        b=tqLc+mxrwJuyfyfU0x53F1uFMAan3bDsixigjfTuW6kt1kwXK8tVtah6Cg62ArXh7N
         4e2n2iIeF2/Vg/KVD/a5Di4WI6VGmsL0uZLINOMFk+Xp6GsJq+bmhqju3RZ6kLKoYWwz
         NeyUzsYq0x/lKdX45l5delhI62WnF16QfY9a9RSdO0HFojvT3O7HDFXLiBac9EG9FDfI
         SLAZwtQxEFc4XL+ydB6LaiVqNAxhIWFgpxmdE4/rhwSjh0m+9HiicC7lT+m+DFddswF+
         vvH+hAC3Sf1yUEfeMMPrHkS7Z5aO+Lp11HwOI0GyZRp4ckbWLT0HkjwZsfjCcsyDXqJS
         UDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf5Kf5NK/mXALt+eojDJ5JHrDlvdtAIFvnR8deBlt+ho8dLcA+bXp/mD1RTJ78J3fpMF4Xci0yddh8nkvP7hCwd1upVrQ=
X-Gm-Message-State: AOJu0YzY6BGjs6ir43SfPrSb6lNuCps7E418MhfrvyCHYmjOdYzEGQ0u
	lkvP3ss1T0lNNDRYTh/cGMPozceLArAPs9eNx7DVC4feDISaB9ugn2E7wmf55nUXl61Ggud0Jw=
	=
X-Google-Smtp-Source: AGHT+IFui8I54LcNBR75OZJL1ck/03Q9252XsNDxFFAZzcfwhttYo1wYc3wuA5vSahJhZwBLTdo2PqDDOQ==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a05:690c:2d8a:b0:691:55ea:8572 with SMTP id
 00721157ae682-6b1bc5e52c9mr24637b3.8.1723746323243; Thu, 15 Aug 2024 11:25:23
 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:24:23 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815182423.446137-1-praan@google.com>
Subject: [PATCH rc v3] iommu: Handle iommu faults for a bad iopf setup
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Kunkun Jiang <jiangkunkun@huawei.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The iommu_report_device_fault function was updated to return void while
assuming that drivers only need to call iommu_report_device_fault() for
reporting an iopf. This implementation causes following problems:

1. The drivers rely on the core code to call it's page_reponse,
   however, when a fault is received and no fault capable domain is
   attached / iopf_param is NULL, the ops->page_response is NOT called
   causing the device to stall in case the fault type was PAGE_REQ.

2. The arm_smmu_v3 driver relies on the returned value to log errors
   returning void from iommu_report_device_fault causes these events to
   be missed while logging.

Modify the iommu_report_device_fault function to return -EINVAL for
cases where no fault capable domain is attached or iopf_param was NULL
and calls back to the driver (ops->page_response) in case the fault type
was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
to log the fault/event as needed.

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Closes: https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
 drivers/iommu/io-pgfault.c                  | 116 +++++++++++++-------
 include/linux/iommu.h                       |   5 +-
 3 files changed, 83 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9bc50bded5af..8a6cd0adfcf2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
-	iommu_report_device_fault(master->dev, &fault_evt);
+	ret = iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 81e9cc6e3164..87b2f1d989c8 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -115,6 +115,59 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	return group;
 }
 
+static struct iommu_attach_handle *find_fault_handler(struct device *dev,
+						     struct iopf_fault *evt)
+{
+	struct iommu_fault *fault = &evt->fault;
+	struct iommu_attach_handle *attach_handle;
+
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+				fault->prm.pasid, 0);
+		if (IS_ERR(attach_handle)) {
+			const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+			if (!ops->user_pasid_table)
+				return NULL;
+			/*
+			 * The iommu driver for this device supports user-
+			 * managed PASID table. Therefore page faults for
+			 * any PASID should go through the NESTING domain
+			 * attached to the device RID.
+			 */
+			attach_handle = iommu_attach_handle_get(
+					dev->iommu_group, IOMMU_NO_PASID,
+					IOMMU_DOMAIN_NESTED);
+			if (IS_ERR(attach_handle))
+				return NULL;
+		}
+	} else {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+				IOMMU_NO_PASID, 0);
+
+		if (IS_ERR(attach_handle))
+			return NULL;
+	}
+
+	if (!attach_handle->domain->iopf_handler)
+		return NULL;
+
+	return attach_handle;
+}
+
+static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_fault *fault = &evt->fault;
+	struct iommu_page_response resp = {
+		.pasid = fault->prm.pasid,
+		.grpid = fault->prm.grpid,
+		.code = IOMMU_PAGE_RESP_INVALID
+	};
+
+	ops->page_response(dev, evt, &resp);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -155,22 +208,34 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
  * hardware has been set to block the page faults) and the pending page faults
  * have been flushed.
  */
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+	struct iommu_attach_handle *attach_handle;
 	struct iommu_fault *fault = &evt->fault;
 	struct iommu_fault_param *iopf_param;
 	struct iopf_group abort_group = {};
 	struct iopf_group *group;
 
+	attach_handle = find_fault_handler(dev, evt);
+	if (!attach_handle)
+		goto err_bad_iopf;
+
+	/*
+	 * Something has gone wrong if a fault capable domain is attached but no
+	 * iopf_param is setup
+	 */
 	iopf_param = iopf_get_dev_fault_param(dev);
 	if (WARN_ON(!iopf_param))
-		return;
+		goto err_bad_iopf;
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-		report_partial_fault(iopf_param, fault);
+		int ret;
+
+		ret = report_partial_fault(iopf_param, fault);
 		iopf_put_dev_fault_param(iopf_param);
 		/* A request that is not the last does not need to be ack'd */
-		return;
+
+		return ret;
 	}
 
 	/*
@@ -185,38 +250,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
-							       fault->prm.pasid,
-							       0);
-		if (IS_ERR(group->attach_handle)) {
-			const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-			if (!ops->user_pasid_table)
-				goto err_abort;
-
-			/*
-			 * The iommu driver for this device supports user-
-			 * managed PASID table. Therefore page faults for
-			 * any PASID should go through the NESTING domain
-			 * attached to the device RID.
-			 */
-			group->attach_handle =
-				iommu_attach_handle_get(dev->iommu_group,
-							IOMMU_NO_PASID,
-							IOMMU_DOMAIN_NESTED);
-			if (IS_ERR(group->attach_handle))
-				goto err_abort;
-		}
-	} else {
-		group->attach_handle =
-			iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
-		if (IS_ERR(group->attach_handle))
-			goto err_abort;
-	}
-
-	if (!group->attach_handle->domain->iopf_handler)
-		goto err_abort;
+	group->attach_handle = attach_handle;
 
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
@@ -225,7 +259,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
-	return;
+	return 0;
 
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
@@ -235,6 +269,14 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 		__iopf_free_group(group);
 	else
 		iopf_free_group(group);
+
+	return 0;
+
+err_bad_iopf:
+	if (fault->type == IOMMU_FAULT_PAGE_REQ)
+		iopf_error_response(dev, evt);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04cbdae0052e..bd722f473635 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1563,7 +1563,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 void iopf_free_group(struct iopf_group *group);
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
 #else
@@ -1601,9 +1601,10 @@ static inline void iopf_free_group(struct iopf_group *group)
 {
 }
 
-static inline void
+static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+	return -ENODEV;
 }
 
 static inline void iopf_group_response(struct iopf_group *group,
-- 
2.46.0.184.g6999bdac58-goog

