Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97C19DFA4
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725990; cv=none; b=L6pf7v5vgT2/tqQJE+v/M71kFVR9c24GlnNX23v+N1ujzEKYYp+Eslo6j6W6Bt9INALLg7nMTW2ua6Fq2RN1K3fMMcwBviFivlLKwiQGxEa6IJ0AvLurSSIxl4emTvpoQW9MdPrbZZAjsMMiyFJHvyd+aN+3u9qOJNmgwXAvoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725990; c=relaxed/simple;
	bh=SI0HLi3qNEOkJQrgePW+WgCNUHwZWBorcT5sg8jB1Nc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LHlk/XqlJb/hxXoGbt93Gkil8Fd+Fnmn1+y7v0f+tsM7WI7gCLkenyeijzy8s395Wr18eVQDlP+uLk55MnTxa7nXbUQjmGAwM+wTXDhDo+vhj9DEWtnxJuwIBrHysZoluoUkU/0dBE2mACWoAnLT1qGMxXJSFNcqkhMc57GpL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCP2sjmP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCP2sjmP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b036192efaso7752737b3.2
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723725987; x=1724330787; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8nezdy4bgQdLo1Mmr+2U4xB0GKoM5NpFnb7nJzG7Lk=;
        b=LCP2sjmPlrgQA9Q53VQshag4Mwt4brq06suI3UyPfIZ9esl2GPPzUnUUoaDlLtAXet
         VD15ziiG1vnscBGLTRn6Yx3ShIEvKeb7MDvptB8DpTMkPC48xncdqDH2nfDkKPyten3h
         QjhS2lJhk4EaLbA9KwrfqfUk9cPyyrmCpjHIrRCCTD919aPag3nvxqr+rN8GEpUSVeB4
         kZvSgSMpmzXBRP2cjCXLlEQQ4+UGEAphh0gVVxfiuxdPBhr0nOG6Luk95jmLOyFj+ZwI
         snoicrHEGzxb04bwHMv14dsuqUnQOODzxHATtAvt48S31kJYEdWV4AKJun429kQEJvaT
         bZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725987; x=1724330787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8nezdy4bgQdLo1Mmr+2U4xB0GKoM5NpFnb7nJzG7Lk=;
        b=V3qeFFVlXVoi2RzoE3sfNieIlaaoIpqctyidgnfFyUC/7T1ndvLXg2Dl661Ud3msGt
         LOLotszVuG914JAQrXF/fqqHoEaaE88B33E8IM7DbztODONJ2RhAp/H2Ki2p6YSyk4T/
         WdN+ZSzKqsbq6GNTjfWbrU8f/RfkjpYcPGCMkbmd6B5ua50zJU84xGWJtYhaxhTYVgVE
         7POJd0+Itlnieg8IF8hT1GzjVrmzKRg7CeYCIRJCBEZon2CNRN3VH8XYaBWbk7qkfqet
         VYYVP8Ht2iDIa/YZXhhCcD94HyCWNu5PNcQui9GRhtmXZdEZlrfrECCQeDodAL1SDhel
         FYNw==
X-Forwarded-Encrypted: i=1; AJvYcCXWDQAeBA8i2QJJyCk7yrnrCHZ2E4vL+iII2yC3OP9Pm+egUCTTfN2Y5GLTB7m1NaN8ZrKKh20n4zsGUTPLuBf+hFFIWzQ=
X-Gm-Message-State: AOJu0Yx8bn5BeDJeUzB2ljmB+bvNDAunHPbzm/52Kom+H2fjYeinROOy
	SZEF+8mpMJ+vNkSrPNIhJc54ErFZcOiW3sSJStwWynizXQQfRLMNn6SqrQhi7a1RREz1w1hpoA=
	=
X-Google-Smtp-Source: AGHT+IE6TdcmxzONJfsfdqQZIbo2rfa5hlhw/5Io1ZYCHrKNYuJ5dhxAKn6+cbvoJ9osURP4J0jSTfsx1g==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a0d:d385:0:b0:673:b39a:92ea with SMTP id
 00721157ae682-6ac997f8a9cmr3268827b3.7.1723725987312; Thu, 15 Aug 2024
 05:46:27 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:46:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815124602.65439-1-praan@google.com>
Subject: [PATCH v2] iommu: Handle iommu faults for a bad iopf setup
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
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
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
index 81e9cc6e3164..540ce80228fe 100644
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
@@ -155,22 +208,37 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
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
+	int ret = 0;
 
+	attach_handle = find_fault_handler(dev, evt);
+	if (!attach_handle) {
+		ret = -EINVAL;
+		goto err_bad_iopf;
+	}
+
+	/*
+	 * Something has gone wrong if a fault capable domain is attached but no
+	 * iopf_param is setup
+	 */
 	iopf_param = iopf_get_dev_fault_param(dev);
-	if (WARN_ON(!iopf_param))
-		return;
+	if (WARN_ON(!iopf_param)) {
+		ret = -EINVAL;
+		goto err_bad_iopf;
+	}
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-		report_partial_fault(iopf_param, fault);
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
+	return ret;
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

