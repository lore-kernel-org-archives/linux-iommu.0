Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB8C2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:57:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D020769
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5uB+9G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D020769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5497D86B2C;
	Wed,  8 Apr 2020 15:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXFZEWnyXAQu; Wed,  8 Apr 2020 15:57:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67DD085450;
	Wed,  8 Apr 2020 15:57:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF97C1AE8;
	Wed,  8 Apr 2020 15:57:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD5DC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 465CB8792F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1JWy-p684QB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 15:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 48A90875DA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:57:06 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id a81so461786wmf.5
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gVWLg7g8zGLzZKUEw8XMNx1PprIGyTRvc/hXCWSPx/g=;
 b=X5uB+9G0lObktZBFJvTyqewndkmqC1DnEQLugpBwhqjDqNkkjnNwNYAdfQcn4bO1Xe
 QjB/uJFYhclC3jLy15gSZItLRf7lGu6a3xq4cmlV+8TF0gZ0bxoOH8xNs5y/QmjYk1Ep
 DJIdxuipUU1I/IgSZHkEroo5Vnoz9HBDk4YHZwqFzoapxRDYlKtcpNrj6Bw6zZB1iJ3d
 K3K483S4V5oMJ9JmrqQDPpc2KYb2k4zWLbAFkVIatPMrMaf7kP7fi/1tDeYheKw5vqM4
 qIBPljp62Qwi6f/UBPsnDb5P7N0oManTNstvjjj2uYygPtiI9lLq38RxOuvt2NcGLSR5
 Gjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gVWLg7g8zGLzZKUEw8XMNx1PprIGyTRvc/hXCWSPx/g=;
 b=cqskzqv1xT65+865xR09RkAs61nPnzj98ne9TIcBkQt/cFrw7eZ18bFlerX/68Gvc3
 UMM+Sba1XcPio4fMGCYZPkhn2soqiJ7u1gwV7V4QOf4a3mxB7Yb4TFKolAsOnuCvdniM
 YpI3rm9U0mTKHpGMhYPBlAXFM/ls0QgKxru1hzRK8hUeE6ZBCEnwaUx9cPw1IXgwkndW
 /+kwIg+4vYIbUmSGDEIwwouRfPKi66elHGH/CvO/YpC9DqaiIT62RerounUqORwA/5Ia
 xJSOkDYqfPRpQQb7PL8dhcziwiBIeLgC3AZpsag0rlwOg3XyaO4ACYiMBCnxjbIq0Fxe
 c9rQ==
X-Gm-Message-State: AGi0PuaStoW+4QtnbYIfJl9PrSFCl7lVxSPtmigxWRDOyqUHX1yWrsaz
 VB6TKW4P8/4D4d5f/KKYH8R7C7LomNF0Ig==
X-Google-Smtp-Source: APiQypISBDYsrDGM6CMELav0TRSKwTB3TOccG0acrHZTrKGUulk958cdURhKomsFHkgK0y1Zgton5w==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr4839638wmy.30.1586354788860; 
 Wed, 08 Apr 2020 07:06:28 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm6788351wmb.16.2020.04.08.07.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 07:06:28 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-accelerators@lists.ozlabs.org
Subject: [PATCH 1/2] uacce: Remove mm_exit() op
Date: Wed,  8 Apr 2020 16:04:26 +0200
Message-Id: <20200408140427.212807-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408140427.212807-1-jean-philippe@linaro.org>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, jgg@ziepe.ca, zhangfei.gao@linaro.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The mm_exit() op will be removed from the SVA API. When a process dies
and its mm goes away, the IOMMU driver won't notify device drivers
anymore. Drivers should expect to handle a lot more aborted DMA. On the
upside, it does greatly simplify the queue management.

The uacce_mm struct, that tracks all queues bound to an mm, was only
used by the mm_exit() callback. Remove it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/uacce.h      |  34 ++------
 drivers/misc/uacce/uacce.c | 171 +++++++++----------------------------
 2 files changed, 50 insertions(+), 155 deletions(-)

diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 0e215e6d0534a..454c2f6672d79 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -68,19 +68,21 @@ enum uacce_q_state {
  * @uacce: pointer to uacce
  * @priv: private pointer
  * @wait: wait queue head
- * @list: index into uacce_mm
- * @uacce_mm: the corresponding mm
+ * @list: index into uacce queues list
  * @qfrs: pointer of qfr regions
  * @state: queue state machine
+ * @pasid: pasid associated to the mm
+ * @handle: iommu_sva handle returned by iommu_sva_bind_device()
  */
 struct uacce_queue {
 	struct uacce_device *uacce;
 	void *priv;
 	wait_queue_head_t wait;
 	struct list_head list;
-	struct uacce_mm *uacce_mm;
 	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
 	enum uacce_q_state state;
+	int pasid;
+	struct iommu_sva *handle;
 };
 
 /**
@@ -96,8 +98,8 @@ struct uacce_queue {
  * @cdev: cdev of the uacce
  * @dev: dev of the uacce
  * @priv: private pointer of the uacce
- * @mm_list: list head of uacce_mm->list
- * @mm_lock: lock for mm_list
+ * @queues: list of queues
+ * @queues_lock: lock for queues list
  * @inode: core vfs
  */
 struct uacce_device {
@@ -112,27 +114,9 @@ struct uacce_device {
 	struct cdev *cdev;
 	struct device dev;
 	void *priv;
-	struct list_head mm_list;
-	struct mutex mm_lock;
-	struct inode *inode;
-};
-
-/**
- * struct uacce_mm - keep track of queues bound to a process
- * @list: index into uacce_device
- * @queues: list of queues
- * @mm: the mm struct
- * @lock: protects the list of queues
- * @pasid: pasid of the uacce_mm
- * @handle: iommu_sva handle return from iommu_sva_bind_device
- */
-struct uacce_mm {
-	struct list_head list;
 	struct list_head queues;
-	struct mm_struct *mm;
-	struct mutex lock;
-	int pasid;
-	struct iommu_sva *handle;
+	struct mutex queues_lock;
+	struct inode *inode;
 };
 
 #if IS_ENABLED(CONFIG_UACCE)
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d39307f060bd6..0598dbf1499ad 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -90,109 +90,38 @@ static long uacce_fops_compat_ioctl(struct file *filep,
 }
 #endif
 
-static int uacce_sva_exit(struct device *dev, struct iommu_sva *handle,
-			  void *data)
+static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 {
-	struct uacce_mm *uacce_mm = data;
-	struct uacce_queue *q;
-
-	/*
-	 * No new queue can be added concurrently because no caller can have a
-	 * reference to this mm. But there may be concurrent calls to
-	 * uacce_mm_put(), so we need the lock.
-	 */
-	mutex_lock(&uacce_mm->lock);
-	list_for_each_entry(q, &uacce_mm->queues, list)
-		uacce_put_queue(q);
-	uacce_mm->mm = NULL;
-	mutex_unlock(&uacce_mm->lock);
+	int pasid;
+	struct iommu_sva *handle;
 
-	return 0;
-}
-
-static struct iommu_sva_ops uacce_sva_ops = {
-	.mm_exit = uacce_sva_exit,
-};
-
-static struct uacce_mm *uacce_mm_get(struct uacce_device *uacce,
-				     struct uacce_queue *q,
-				     struct mm_struct *mm)
-{
-	struct uacce_mm *uacce_mm = NULL;
-	struct iommu_sva *handle = NULL;
-	int ret;
-
-	lockdep_assert_held(&uacce->mm_lock);
-
-	list_for_each_entry(uacce_mm, &uacce->mm_list, list) {
-		if (uacce_mm->mm == mm) {
-			mutex_lock(&uacce_mm->lock);
-			list_add(&q->list, &uacce_mm->queues);
-			mutex_unlock(&uacce_mm->lock);
-			return uacce_mm;
-		}
-	}
-
-	uacce_mm = kzalloc(sizeof(*uacce_mm), GFP_KERNEL);
-	if (!uacce_mm)
-		return NULL;
+	if (!(uacce->flags & UACCE_DEV_SVA))
+		return 0;
 
-	if (uacce->flags & UACCE_DEV_SVA) {
-		/*
-		 * Safe to pass an incomplete uacce_mm, since mm_exit cannot
-		 * fire while we hold a reference to the mm.
-		 */
-		handle = iommu_sva_bind_device(uacce->parent, mm, uacce_mm);
-		if (IS_ERR(handle))
-			goto err_free;
+	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
-		ret = iommu_sva_set_ops(handle, &uacce_sva_ops);
-		if (ret)
-			goto err_unbind;
-
-		uacce_mm->pasid = iommu_sva_get_pasid(handle);
-		if (uacce_mm->pasid == IOMMU_PASID_INVALID)
-			goto err_unbind;
+	pasid = iommu_sva_get_pasid(handle);
+	if (pasid == IOMMU_PASID_INVALID) {
+		iommu_sva_unbind_device(handle);
+		return -ENODEV;
 	}
 
-	uacce_mm->mm = mm;
-	uacce_mm->handle = handle;
-	INIT_LIST_HEAD(&uacce_mm->queues);
-	mutex_init(&uacce_mm->lock);
-	list_add(&q->list, &uacce_mm->queues);
-	list_add(&uacce_mm->list, &uacce->mm_list);
-
-	return uacce_mm;
-
-err_unbind:
-	if (handle)
-		iommu_sva_unbind_device(handle);
-err_free:
-	kfree(uacce_mm);
-	return NULL;
+	q->handle = handle;
+	q->pasid = pasid;
+	return 0;
 }
 
-static void uacce_mm_put(struct uacce_queue *q)
+static void uacce_unbind_queue(struct uacce_queue *q)
 {
-	struct uacce_mm *uacce_mm = q->uacce_mm;
-
-	lockdep_assert_held(&q->uacce->mm_lock);
-
-	mutex_lock(&uacce_mm->lock);
-	list_del(&q->list);
-	mutex_unlock(&uacce_mm->lock);
-
-	if (list_empty(&uacce_mm->queues)) {
-		if (uacce_mm->handle)
-			iommu_sva_unbind_device(uacce_mm->handle);
-		list_del(&uacce_mm->list);
-		kfree(uacce_mm);
-	}
+	if (!q->handle)
+		return;
+	iommu_sva_unbind_device(q->handle);
 }
 
 static int uacce_fops_open(struct inode *inode, struct file *filep)
 {
-	struct uacce_mm *uacce_mm = NULL;
 	struct uacce_device *uacce;
 	struct uacce_queue *q;
 	int ret = 0;
@@ -205,21 +134,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	if (!q)
 		return -ENOMEM;
 
-	mutex_lock(&uacce->mm_lock);
-	uacce_mm = uacce_mm_get(uacce, q, current->mm);
-	mutex_unlock(&uacce->mm_lock);
-	if (!uacce_mm) {
-		ret = -ENOMEM;
+	ret = uacce_bind_queue(uacce, q);
+	if (ret)
 		goto out_with_mem;
-	}
 
 	q->uacce = uacce;
-	q->uacce_mm = uacce_mm;
 
 	if (uacce->ops->get_queue) {
-		ret = uacce->ops->get_queue(uacce, uacce_mm->pasid, q);
+		ret = uacce->ops->get_queue(uacce, q->pasid, q);
 		if (ret < 0)
-			goto out_with_mm;
+			goto out_with_bond;
 	}
 
 	init_waitqueue_head(&q->wait);
@@ -227,12 +151,14 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
 
+	mutex_lock(&uacce->queues_lock);
+	list_add(&q->list, &uacce->queues);
+	mutex_unlock(&uacce->queues_lock);
+
 	return 0;
 
-out_with_mm:
-	mutex_lock(&uacce->mm_lock);
-	uacce_mm_put(q);
-	mutex_unlock(&uacce->mm_lock);
+out_with_bond:
+	uacce_unbind_queue(q);
 out_with_mem:
 	kfree(q);
 	return ret;
@@ -241,14 +167,12 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 static int uacce_fops_release(struct inode *inode, struct file *filep)
 {
 	struct uacce_queue *q = filep->private_data;
-	struct uacce_device *uacce = q->uacce;
 
+	mutex_lock(&q->uacce->queues_lock);
+	list_del(&q->list);
+	mutex_unlock(&q->uacce->queues_lock);
 	uacce_put_queue(q);
-
-	mutex_lock(&uacce->mm_lock);
-	uacce_mm_put(q);
-	mutex_unlock(&uacce->mm_lock);
-
+	uacce_unbind_queue(q);
 	kfree(q);
 
 	return 0;
@@ -513,8 +437,8 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (ret < 0)
 		goto err_with_uacce;
 
-	INIT_LIST_HEAD(&uacce->mm_list);
-	mutex_init(&uacce->mm_lock);
+	INIT_LIST_HEAD(&uacce->queues);
+	mutex_init(&uacce->queues_lock);
 	device_initialize(&uacce->dev);
 	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
 	uacce->dev.class = uacce_class;
@@ -561,8 +485,7 @@ EXPORT_SYMBOL_GPL(uacce_register);
  */
 void uacce_remove(struct uacce_device *uacce)
 {
-	struct uacce_mm *uacce_mm;
-	struct uacce_queue *q;
+	struct uacce_queue *q, *next_q;
 
 	if (!uacce)
 		return;
@@ -574,24 +497,12 @@ void uacce_remove(struct uacce_device *uacce)
 		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
 	/* ensure no open queue remains */
-	mutex_lock(&uacce->mm_lock);
-	list_for_each_entry(uacce_mm, &uacce->mm_list, list) {
-		/*
-		 * We don't take the uacce_mm->lock here. Since we hold the
-		 * device's mm_lock, no queue can be added to or removed from
-		 * this uacce_mm. We may run concurrently with mm_exit, but
-		 * uacce_put_queue() is serialized and iommu_sva_unbind_device()
-		 * waits for the lock that mm_exit is holding.
-		 */
-		list_for_each_entry(q, &uacce_mm->queues, list)
-			uacce_put_queue(q);
-
-		if (uacce->flags & UACCE_DEV_SVA) {
-			iommu_sva_unbind_device(uacce_mm->handle);
-			uacce_mm->handle = NULL;
-		}
+	mutex_lock(&uacce->queues_lock);
+	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
+		uacce_put_queue(q);
+		uacce_unbind_queue(q);
 	}
-	mutex_unlock(&uacce->mm_lock);
+	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
 	if (uacce->flags & UACCE_DEV_SVA)
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
