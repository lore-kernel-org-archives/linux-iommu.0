Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105919644B
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805359; cv=none; b=e8J3dwsnBUA9xSRh+jRk/rDFQlzPuVocnNryEoMGQ+K5VJdnwfj7uZSCnffio8c9hln0HRuTdIskKRzL4yB5EKEgy1lXTNCcYZqtuZMK/Mn2v5qUR75pEORfR091veYu/0xFFvedGK/L0SVkPP/hZRzmMd/CS8idrt5+HB+gRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805359; c=relaxed/simple;
	bh=2082Wj0Yko0K17Sm69sNDGtxj1yeduAJOKiVcnsxqpk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bQ5cC3NRlPAdysAX8qu9UgXqk77Q+jb52iAS+l0MS8pKjerrJnFA8SZ0lvKeK2mh8HucOoZ9rvSxD4h1r2NDRT7OfYLDCTSIW7qa2pP6Dtc7GMIdCs7qcPX/BMhczJBHe+OuKaItBgS9W9L6TOgzYwz3QXsL2gFPiGKjgHn7wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saaUL8LB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saaUL8LB"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6506bfeaf64so28449987b3.1
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723805356; x=1724410156; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtYk/Ov0mCJnIuk+OY5ldTKJ3ZBw5bNM0GNfrKbI5Aw=;
        b=saaUL8LB9UCVvUaaHyYW6bZmOAAXBhZ+uKyuavcEBvOrHWvabT+oXZch1umUctPmSy
         9m03M7yri/Hq7YhpnRTXQAFrzTTaf2Sn2zbcvF/4kpuLEQ1wrrlLG97m/vihuiRatEHv
         GEQ99V1ecyIH3A+4gahRNHam7xNYjs7/j0YsTKnspxASK2xqkCoiHp7lSVg3HoMko6Ta
         j4PNkVMd8jyYMUYfDZhugrU6yXr41O6ffmMSwsfoeFLTgqd1xovOSp71LXb2ftUVrrE0
         X+bQS+1CE4ZrPotzcKY9xdFa9kmBd+aIZN4yKFA+2sqNywu9401JaSat3ZYdm9Leqt/c
         ItGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805356; x=1724410156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtYk/Ov0mCJnIuk+OY5ldTKJ3ZBw5bNM0GNfrKbI5Aw=;
        b=Y3ohlDSqhgWdIebn6I0vfRcutHBGi6cUy3v5FD8jsrENa5R/pt5MCQ0x2qv24QjS/F
         FTAQ0AH8HMBwQRMXVkgVWcJuK+lA32um717Kzu5T9GDh+aVrvPuG2dYxtaF098GmT+J5
         IbX4VfM9QHUTOkZSbWZHA7JWs9WGHlpeDXFbxUkiodrV1CfwqElPWHeYkkiBxJkEqcu8
         df6Wfec9fBoSDsSd8vRZ1l0XO7qKWXXtOOKb58E+UngB+jYOQTdy4KnoiK3a3DfmmXry
         O2dEgwIf/jZWYggl7NQy+s5OoPaoAwggm4C9ZX05KuuD8E476wEAQEXpjSDRxqooi9cU
         P7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUrJwQXIegti8B1//q0tS1A4CIdjm0ASg+NAAVZgOpBe6ZUwtIAb2+APET1je/SNQFdOTAxO+z1vGxRhnENSN+cRvCgXLE=
X-Gm-Message-State: AOJu0Yx69JSIrdoW9tOcarXH1c/IXgedUCKWw706BJJyD60Abi3xW+pn
	2+HmJPsuR3pDw3eHuV9GKrcv0OjCz6j6q42vh4qQGuiamRXfMjqv8ZJ+1gg2/hf4oUcltN/QrQ=
	=
X-Google-Smtp-Source: AGHT+IFiwxqF46XobPgNiuOpFnS7Qet836dF0O+CGy+4BrNApIMdg1Uz274VagtLtYaVfEcbnd/tUUqq7A==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:2d1f:0:b0:e08:6c33:7334 with SMTP id
 3f1490d57ef6-e1180f71134mr67209276.8.1723805355925; Fri, 16 Aug 2024 03:49:15
 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:49:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816104906.1010626-1-praan@google.com>
Subject: [PATCH rc v4] iommu: Handle iommu faults for a bad iopf setup
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
 drivers/iommu/io-pgfault.c                  | 121 ++++++++++++++------
 include/linux/iommu.h                       |   5 +-
 3 files changed, 87 insertions(+), 41 deletions(-)

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
index 81e9cc6e3164..4674e618797c 100644
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
@@ -153,24 +206,39 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
  * handling framework should guarantee that the iommu domain could only be
  * freed after the device has stopped generating page faults (or the iommu
  * hardware has been set to block the page faults) and the pending page faults
- * have been flushed.
+ * have been flushed. In case no page fault handler is attached or no iopf params
+ * are setup, then the ops->page_response() is called to complete the evt.
+ *
+ * Returns 0 on success, or an error in case of a bad/failed iopf setup.
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
@@ -185,38 +253,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
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
@@ -225,7 +262,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
-	return;
+	return 0;
 
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
@@ -235,6 +272,14 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
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

