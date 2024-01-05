Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BD328C9
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bN0VxM6L"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78102c516a7so124994185a.2
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704477221; x=1705082021; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miRb0rXpWLb9jsTXLzk36Q4Oua5evPe+9mfQTaGdXj0=;
        b=bN0VxM6L2DnfYk7+aj/9U6ityy1FhRmiFZcpkZRvAVZ0nd4JcXRCtsHOkcbO1zD7sZ
         3UCDr/d2UThn+xXH4ywBcl7XxI2h+VA/pkjzuP7n5UHX0vGxqY0Wi195IlPvrYGs4Qep
         7j+E08ElcOBaD/GRl+W5F4EgSwybdO0UaRm0z/E6V3GKpILPVllFkuuSvIsaLnefZvDB
         WsTUBDt+SWkjWDJ+QIA6xNEgLOGfu9rWsoQAAfSR4MEI6Sf30a8e9MR69qcUJS/3aeAp
         2FDxBDUTnbXg8ldvmixDrBXiZO9rdM941I+furVDg0kohJwD57I8jYdS1MGN2kYlAnzs
         k1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477221; x=1705082021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miRb0rXpWLb9jsTXLzk36Q4Oua5evPe+9mfQTaGdXj0=;
        b=LEWeq9MWiz6/IvhzZTEE//DD7cG3XG8NRvcD2b4wE7/GzMtHLS9U6Zi+SSSuZ6Iji/
         XEmf3bTFWA2MyScW5ltvbOOQdGOXSZBi8lMPK511CUlf8i0KiBLYziRXFsil+b5HR67U
         ER0QhKaeL/N8XRkIrThk+XmxN4VdtJkZCD16G1AChbx6q0iTt46OOjff/ynxS249f/jE
         31YFO7YqnG+BDrL6WlvtuiIdx/myvQxUmjr9pVKIyEHfgYxCR+bII4v6aaWpZ5osurzB
         TrvMcTsCC+aahdkycyLDfWjySHTID6FnoulpD+C17ZYZMm6QUznjKg9nPF716Twu3ecP
         Oc4w==
X-Gm-Message-State: AOJu0YwSMw1WW4nnBH5OLWetOj6HOsauzm+A9kcBxMMk1PvHGWmF8/iy
	TJ31GSiVj4iNsLFspME7FoAblcJgPGU5vA==
X-Google-Smtp-Source: AGHT+IGCN+T44qrgo6UkyBazOh1o48d2ZcobTN86dpi+/kaYtJEFnysKgJ7G5TwzHG1++RItZhDUPg==
X-Received: by 2002:a05:620a:4798:b0:781:1411:9383 with SMTP id dt24-20020a05620a479800b0078114119383mr2669210qkb.94.1704477221299;
        Fri, 05 Jan 2024 09:53:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b007815a43d297sm746129qkm.40.2024.01.05.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:53:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLoO3-001UdP-Ju;
	Fri, 05 Jan 2024 13:53:39 -0400
Date: Fri, 5 Jan 2024 13:53:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 14/14] iommu: Track iopf group instead of last fault
Message-ID: <20240105175339.GI50608@ziepe.ca>
References: <20231220012332.168188-1-baolu.lu@linux.intel.com>
 <20231220012332.168188-15-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220012332.168188-15-baolu.lu@linux.intel.com>

On Wed, Dec 20, 2023 at 09:23:32AM +0800, Lu Baolu wrote:
>  /**
> - * iommu_handle_iopf - IO Page Fault handler
> - * @fault: fault event
> - * @iopf_param: the fault parameter of the device.
> + * iommu_report_device_fault() - Report fault event to device driver
> + * @dev: the device
> + * @evt: fault event data
>   *
> - * Add a fault to the device workqueue, to be handled by mm.
> + * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
> + * handler. When this function fails and the fault is recoverable, it is the
> + * caller's responsibility to complete the fault.

This patch seems OK for what it does so:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

However, this seems like a strange design, surely this function should
just call ops->page_response() when it can't enqueue the fault?

It is much cleaner that way, so maybe you can take this into a
following patch (along with the driver fixes to accomodate. (and
perhaps iommu_report_device_fault() should return void too)

Also iopf_group_response() should return void (another patch!),
nothing can do anything with the failure. This implies that
ops->page_response() must also return void - which is consistent with
what the drivers do, the failure paths are all integrity validations
of the fault and should be WARN_ON'd not return codes.

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 7d11b74e4048e2..2715e24fd64234 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -39,7 +39,7 @@ static void iopf_put_dev_fault_param(struct iommu_fault_param *fault_param)
 		kfree_rcu(fault_param, rcu);
 }
 
-void iopf_free_group(struct iopf_group *group)
+static void __iopf_free_group(struct iopf_group *group)
 {
 	struct iopf_fault *iopf, *next;
 
@@ -50,6 +50,11 @@ void iopf_free_group(struct iopf_group *group)
 
 	/* Pair with iommu_report_device_fault(). */
 	iopf_put_dev_fault_param(group->fault_param);
+}
+
+void iopf_free_group(struct iopf_group *group)
+{
+	__iopf_free_group(group);
 	kfree(group);
 }
 EXPORT_SYMBOL_GPL(iopf_free_group);
@@ -97,14 +102,49 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 	return 0;
 }
 
+static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
+					   struct iopf_fault *evt,
+					   struct iopf_group *abort_group)
+{
+	struct iopf_fault *iopf, *next;
+	struct iopf_group *group;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) {
+		/*
+		 * We always need to construct the group as we need it to abort
+		 * the request at the driver if it cfan't be handled.
+		 */
+		group = abort_group;
+	}
+
+	group->fault_param = iopf_param;
+	group->last_fault.fault = evt->fault;
+	INIT_LIST_HEAD(&group->faults);
+	INIT_LIST_HEAD(&group->pending_node);
+	list_add(&group->last_fault.list, &group->faults);
+
+	/* See if we have partial faults for this group */
+	mutex_lock(&iopf_param->lock);
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
+		if (iopf->fault.prm.grpid == evt->fault.prm.grpid)
+			/* Insert *before* the last fault */
+			list_move(&iopf->list, &group->faults);
+	}
+	list_add(&group->pending_node, &iopf_param->faults);
+	mutex_unlock(&iopf_param->lock);
+
+	return group;
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
  * @evt: fault event data
  *
  * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
- * handler. When this function fails and the fault is recoverable, it is the
- * caller's responsibility to complete the fault.
+ * handler. If this function fails then ops->page_response() was called to
+ * complete evt if required.
  *
  * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
  * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
@@ -143,22 +183,24 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
 	struct iommu_fault *fault = &evt->fault;
 	struct iommu_fault_param *iopf_param;
-	struct iopf_fault *iopf, *next;
-	struct iommu_domain *domain;
+	struct iopf_group abort_group;
 	struct iopf_group *group;
 	int ret;
 
+/*
+  remove this too, it is pointless. The driver should only invoke this function on page_req faults.
 	if (fault->type != IOMMU_FAULT_PAGE_REQ)
 		return -EOPNOTSUPP;
+*/
 
 	iopf_param = iopf_get_dev_fault_param(dev);
-	if (!iopf_param)
+	if (WARN_ON(!iopf_param))
 		return -ENODEV;
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
 		ret = report_partial_fault(iopf_param, fault);
 		iopf_put_dev_fault_param(iopf_param);
-
+		/* A request that is not the last does not need to be ack'd */
 		return ret;
 	}
 
@@ -170,56 +212,34 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	 * will send a response to the hardware. We need to clean up before
 	 * leaving, otherwise partial faults will be stuck.
 	 */
-	domain = get_domain_for_iopf(dev, fault);
-	if (!domain) {
-		ret = -EINVAL;
-		goto cleanup_partial;
-	}
-
-	group = kzalloc(sizeof(*group), GFP_KERNEL);
-	if (!group) {
+	group = iopf_group_alloc(iopf_param, evt, &abort_group);
+	if (group == &abort_group) {
 		ret = -ENOMEM;
-		goto cleanup_partial;
+		goto err_abort;
 	}
 
-	group->fault_param = iopf_param;
-	group->last_fault.fault = *fault;
-	INIT_LIST_HEAD(&group->faults);
-	INIT_LIST_HEAD(&group->pending_node);
-	group->domain = domain;
-	list_add(&group->last_fault.list, &group->faults);
-
-	/* See if we have partial faults for this group */
-	mutex_lock(&iopf_param->lock);
-	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
-		if (iopf->fault.prm.grpid == fault->prm.grpid)
-			/* Insert *before* the last fault */
-			list_move(&iopf->list, &group->faults);
+	group->domain = get_domain_for_iopf(dev, fault);
+	if (!group->domain) {
+		ret = -EINVAL;
+		goto err_abort;
 	}
-	list_add(&group->pending_node, &iopf_param->faults);
-	mutex_unlock(&iopf_param->lock);
 
-	ret = domain->iopf_handler(group);
-	if (ret) {
-		mutex_lock(&iopf_param->lock);
-		list_del_init(&group->pending_node);
-		mutex_unlock(&iopf_param->lock);
+	/*
+	 * On success iopf_handler must call iopf_group_response() and
+	 * iopf_free_group()
+	 */
+	ret = group->domain->iopf_handler(group);
+	if (ret)
+		goto err_abort;
+	return 0;
+
+err_abort:
+	iopf_group_response(group,
+			    IOMMU_PAGE_RESP_FAILURE); //?? right code?
+	if (group == &abort_group)
+		__iopf_free_group(group);
+	else
 		iopf_free_group(group);
-	}
-
-	return ret;
-
-cleanup_partial:
-	mutex_lock(&iopf_param->lock);
-	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
-		if (iopf->fault.prm.grpid == fault->prm.grpid) {
-			list_del(&iopf->list);
-			kfree(iopf);
-		}
-	}
-	mutex_unlock(&iopf_param->lock);
-	iopf_put_dev_fault_param(iopf_param);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
@@ -262,7 +282,7 @@ EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
  *
  * Return 0 on success and <0 on error.
  */
-int iopf_group_response(struct iopf_group *group,
+void iopf_group_response(struct iopf_group *group,
 			enum iommu_page_response_code status)
 {
 	struct iommu_fault_param *fault_param = group->fault_param;
@@ -400,9 +420,9 @@ EXPORT_SYMBOL_GPL(iopf_queue_add_device);
  */
 void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 {
-	struct iopf_fault *iopf, *next;
+	struct iopf_fault *partial_iopf;
+	struct iopf_fault *next;
 	struct iopf_group *group, *temp;
-	struct iommu_page_response resp;
 	struct dev_iommu *param = dev->iommu;
 	struct iommu_fault_param *fault_param;
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -416,15 +436,16 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		goto unlock;
 
 	mutex_lock(&fault_param->lock);
-	list_for_each_entry_safe(iopf, next, &fault_param->partial, list)
-		kfree(iopf);
+	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list)
+		kfree(partial_iopf);
 
 	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
-		memset(&resp, 0, sizeof(struct iommu_page_response));
-		iopf = &group->last_fault;
-		resp.pasid = iopf->fault.prm.pasid;
-		resp.grpid = iopf->fault.prm.grpid;
-		resp.code = IOMMU_PAGE_RESP_INVALID;
+		struct iopf_fault *iopf = &group->last_fault;
+		struct iommu_page_response resp = {
+			.pasid = iopf->fault.prm.pasid,
+			.grpid = iopf->fault.prm.grpid,
+			.code = IOMMU_PAGE_RESP_INVALID
+		};
 
 		if (iopf->fault.prm.flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID)
 			resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
