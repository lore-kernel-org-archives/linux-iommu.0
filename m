Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996854594A
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537603; cv=none; b=lX7TjOqTRdJ9REMLaKVowSrnfq5QEB+mFoV6B51pEPDf9hykZGpuO0cKvSWrelIPigVQwQJcZeSOjGk0WOG5T8dp5+gCJGjvgNbkIhtp3/Fz13GyLlGXBwp6clevZfTc1UiQJpeFRTJ+TnturiKkr1ssKuiXNo44aV7JUMqa/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537603; c=relaxed/simple;
	bh=obP6OVvB8qYN4k+kHxYN+e9ZFHylj4W8ZjBHULe/n6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB0zU6tr/kx5EOcyFQXa/GUCSVtwevGF2f02s3EuP7DFte2o14y1Sm5ZMitdR2dmWKXlJfzEY92Do332Y11Qr2D0/vt54TagK8grkTW/0A9XMgMPQTuy333W6JHQcSZSNkIX2kchXXkr4bnpFB5sge/FBvhu2R1GavVKvP/idog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=1yxA/v7Z; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="1yxA/v7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784537535;
	bh=iYJ4BxGfF8rQdyYR0EM7JNA/OLN7WYqHfnnhq0bavgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=1yxA/v7ZD35gAVsOpYT4i2dCS+VlCCY9aNRkJ35pUmXHCaGQ1t+TUGBRKeTf8MMfA
	 /NUEAEKjq0BQwiJN3ik+R8uFI71cX+eTHMKiXHnCGqZxvD93+gLWVPrdZOMa66OURK
	 Z3savaE/gjZwJ/hL6OGhB2q5FU5p6QqmAIcGW0xw=
X-QQ-mid: zesmtpsz6t1784537527t0646a3cb
X-QQ-Originating-IP: 2Iqv/XkHSknFf9FN1LCmg9lSIcwa36hmEkePuFwqHII=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 16:52:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2424918922759967125
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH v3 2/2] iommu: Make iopf_group_response() free groups
Date: Mon, 20 Jul 2026 16:50:17 +0800
Message-ID: <80BDADA0C8AB6928+20260720085017.3998878-3-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NEAuM+RWOySTvCGFuFuW3aJSFTbYd+xmUvRznoIr0RqOwoBK28bN9gsv
	yVvJIlA+D80VQrnUdYCxV70x4eyD4s5XwHTd1q0HLRrbXTK+47Fgxq3+B95lHWFcQ1Ek77H
	LacOyqNM3vufYJHSMEXQX/PdwUJl5Sfq+2cA2++/2TAOQ9Azdw5twQ8Dv+MfUwg4poei2nn
	iee6gNJdtJhlADtDzFRy3eUo2LUkA/gsD0X+097WU3VUJ5FuumQ2/CPcP+ie9SDd3fTAX/S
	fmNWV1sxQ6895NWpGLFPrq5Wsm9Qop1rFQfzCQJYiR7XRvsCk7YR0b8TelG43npz++kflwt
	/WKX16XiPLiTgHUSN+kSEgziS7HZoEZYpwtbcKHGjoAoaOqQETN5031mex3DswEQFzJbIJy
	Xkc+Ht6ISv/4KCSfuOAJRDHNQStYpM0/2GGmuO2RNO9HPTLc7tWGNM4stAfAFgclAW3a/Gu
	pi2ucBYIzOwn3s0fwzLmveLU8pOGQiZnydZ0ZUU8sII2AkWM5p5mKvRt+sSbMtuNpKAQF7f
	XWGXZyqt6kKoCzkzMlSwVxfvtAjKOAl4WmKJZiUcaCjZdkwAfcJ5PT9lD5Tb4NSiGKdUbNr
	f9x4i1scvAg6jAoWjcMTwMWJgzyRnj2VLGYZyYqyf5d4gMR/QSswM03UbZKL8ZUD9wmkj+5
	SXjaYAPZCD+IFmormILqBAkYZj9T7Qftfcu0ASURjBC4C5tFGwbhH93vUvijQBmeiKPYduE
	VyySNDr9o9h/e9QtrHdZfT+CHo1XpQXQcGDwRsO0+NTp4bAoDEpYXpneXXct/t1njFwHyu2
	0SH1zDKACBcgW2ZLEx8//tXguhtPLV1TIBECABWMlQo+/smxKCB5cx18G53bWw0gg8xgDTD
	2yNRnq8+mQG74vAewwduX0+vLRPmYG1vM+flmXMVU+L2TssaQlsSGtyHd4mtkM730+hIuUm
	B5pqhrckom4BIqfBABXJdHEQ6QfvJt+RV8CfXujvQfHcUny1lQjAegqcbPtyVZVG6vFkwsG
	sxHe1i0YZVeMHW1bsQmsNC6jmHYqj6n/0JrOu937L1CtnZCiw4
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Every normal iopf_group_response() caller frees the group immediately
after sending the response. Make iopf_group_response() do both operations,
so callers no longer have to free the group separately.

Split the response operation into a helper that requires fault_param->lock,
a helper that acquires the lock without freeing, and the exported helper
that sends the response and frees the group.

iommu_report_device_fault() retains its special stack-allocated abort_group
handling. It uses the non-freeing helper, then keeps the existing choice
between __iopf_free_group() and iopf_free_group().
iopf_queue_remove_device() already holds the fault-parameter lock, so it
uses the locked helper before freeing each pending group.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/io-pgfault.c     | 69 +++++++++++++++++++---------------
 drivers/iommu/iommu-sva.c      |  1 -
 drivers/iommu/iommufd/eventq.c |  5 ---
 include/linux/iommu.h          |  5 ---
 4 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index c16ff1fc4b95..52366e2e9d76 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -52,12 +52,11 @@ static void __iopf_free_group(struct iopf_group *group)
 	iopf_put_dev_fault_param(group->fault_param);
 }
 
-void iopf_free_group(struct iopf_group *group)
+static void iopf_free_group(struct iopf_group *group)
 {
 	__iopf_free_group(group);
 	kfree(group);
 }
-EXPORT_SYMBOL_GPL(iopf_free_group);
 
 /* Non-last request of a group. Postpone until the last one. */
 static int report_partial_fault(struct iommu_fault_param *fault_param,
@@ -168,6 +167,35 @@ static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
 	ops->page_response(dev, evt, &resp);
 }
 
+static void __iopf_group_response_locked(struct iopf_group *group,
+					 enum iommu_page_response_code status)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+	struct iopf_fault *iopf = &group->last_fault;
+	struct device *dev = fault_param->dev;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_page_response resp = {
+		.pasid = iopf->fault.prm.pasid,
+		.grpid = iopf->fault.prm.grpid,
+		.code = status,
+	};
+
+	lockdep_assert_held(&fault_param->lock);
+
+	ops->page_response(dev, &group->last_fault, &resp);
+	list_del_init(&group->pending_node);
+}
+
+static void __iopf_group_response(struct iopf_group *group,
+				  enum iommu_page_response_code status)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+
+	mutex_lock(&fault_param->lock);
+	__iopf_group_response_locked(group, status);
+	mutex_unlock(&fault_param->lock);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -255,10 +283,7 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 
 	group->attach_handle = attach_handle;
 
-	/*
-	 * On success iopf_handler must call iopf_group_response() and
-	 * iopf_free_group()
-	 */
+	/* On success iopf_handler must call iopf_group_response(). */
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
@@ -267,7 +292,7 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
 			     fault->prm.pasid);
-	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
+	__iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
 	if (group == &abort_group)
 		__iopf_free_group(group);
 	else
@@ -318,24 +343,15 @@ EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
  * iopf_group_response - Respond a group of page faults
  * @group: the group of faults with the same group id
  * @status: the response code
+ *
+ * The group will be freed as well and must not be accessed after
+ * this function returns.
  */
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status)
 {
-	struct iommu_fault_param *fault_param = group->fault_param;
-	struct iopf_fault *iopf = &group->last_fault;
-	struct device *dev = group->fault_param->dev;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-	struct iommu_page_response resp = {
-		.pasid = iopf->fault.prm.pasid,
-		.grpid = iopf->fault.prm.grpid,
-		.code = status,
-	};
-
-	mutex_lock(&fault_param->lock);
-	ops->page_response(dev, &group->last_fault, &resp);
-	list_del_init(&group->pending_node);
-	mutex_unlock(&fault_param->lock);
+	__iopf_group_response(group, status);
+	iopf_free_group(group);
 }
 EXPORT_SYMBOL_GPL(iopf_group_response);
 
@@ -468,7 +484,6 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	struct iopf_group *group, *temp;
 	struct dev_iommu *param = dev->iommu;
 	struct iommu_fault_param *fault_param;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
@@ -483,15 +498,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		kfree(partial_iopf);
 
 	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
-		struct iopf_fault *iopf = &group->last_fault;
-		struct iommu_page_response resp = {
-			.pasid = iopf->fault.prm.pasid,
-			.grpid = iopf->fault.prm.grpid,
-			.code = IOMMU_PAGE_RESP_INVALID
-		};
-
-		ops->page_response(dev, iopf, &resp);
-		list_del_init(&group->pending_node);
+		__iopf_group_response_locked(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
 	mutex_unlock(&fault_param->lock);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e..caccaa315461 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -292,7 +292,6 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 	}
 
 	iopf_group_response(group, status);
-	iopf_free_group(group);
 }
 
 static int iommu_sva_iopf_handler(struct iopf_group *group)
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 747dd5155121..62110fe8f78f 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -40,7 +40,6 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	list_for_each_entry_safe(group, next, &free_list, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 
 	xa_for_each(&fault->response, index, group) {
@@ -48,7 +47,6 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 			continue;
 		xa_erase(&fault->response, index);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	mutex_unlock(&fault->mutex);
 }
@@ -70,12 +68,10 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	xa_for_each(&fault->response, index, group) {
 		xa_erase(&fault->response, index);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	xa_destroy(&fault->response);
 	mutex_destroy(&fault->mutex);
@@ -217,7 +213,6 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		}
 
 		iopf_group_response(group, response.code);
-		iopf_free_group(group);
 		done += response_size;
 	}
 	mutex_unlock(&fault->mutex);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..f16c88d92661 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1700,7 +1700,6 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
-void iopf_free_group(struct iopf_group *group);
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
@@ -1736,10 +1735,6 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 	return -ENODEV;
 }
 
-static inline void iopf_free_group(struct iopf_group *group)
-{
-}
-
 static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
-- 
2.43.0

