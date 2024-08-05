Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3E5339D
	for <iommu@lists.linux.dev>; Mon,  5 Aug 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871984; cv=none; b=vBxeUB4GpwYC9jqnI7JtC3/TEpssu5+f4BSnH+y6m0CBJ6XBcicRL0J6MQO3nUmJt4U9deCAkNLnR3HQZS8fsoX6XqHpoc174bAQCYz2iLeRfn7MR5Pwxqs+jguvg+tobyQO8t/aSsqpgjp4yc94ZwtzpwlbRX8qCvwcN8mmPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871984; c=relaxed/simple;
	bh=ObhQo0NIBF7fkK3/fc10cMDFxImwHpd6CQhGU19xU9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvc0WaTM5iGlKF4nFOa3AE1yw36XlSCUpzSUI1VN6OCulsj35538OOui3QgzzjbxFPR/tJeYUzoe8r+bpkBMAb9SHNg+M5a7Hyma7e7gNjnJsrru5ZWkq8bsDt3/h/Puj5wdJvvmKVIFpwDImRVnK8hwCKKGNeWpXpRPmrVXUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdZqnUXa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdZqnUXa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fed726aefcso282075ad.1
        for <iommu@lists.linux.dev>; Mon, 05 Aug 2024 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722871982; x=1723476782; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DR2Ju8LDhr3rpntIRm0P+3tYJwG3Xz4lVqo/4/g7Pb8=;
        b=GdZqnUXaF9i97vWCYHwI8ho3liyPshKQ3TQhBdEth8EEdkjYXtuKWR2aM3Itkhp5uk
         ap2cclfyeM/WRUieFstctTYvu6M8zKIFPM4Sai4jMusNSaqWuxyxbn+gdpu4VUDrl4Vi
         5NAo8WqSs5asbapiINh/zN4T3Zr6EPpdwhNA3PiJFCiT1DsHLG7S8p513rUvbJsVm2A/
         3xTAswYszEWfDc7+uTmNZyCdNDWIOsE+YnV7rUI/Bky18b3sujhPjyczkJKmHvebZtcZ
         +Xp5B49cAOblny8aQ/tM55M3lsVhzwqYAiDzYBpeTQGpwV1618aiKH95E4RLaolSAjCY
         Kw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871982; x=1723476782;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR2Ju8LDhr3rpntIRm0P+3tYJwG3Xz4lVqo/4/g7Pb8=;
        b=NcVMxxTmJ30rh9JnqxcOHyDD4WKfXn051hsCzIkX5Sh9gvcwKK9ulPxzJWKIJiCriE
         D30TsnbdQveMdnIM2whvTHwf2qJwcA691PIMH3uPP59vHW1rOB+PvithNxRVyYaLheP3
         zubAd+EgMcBpQjGc1cLlPvT+2vak3nKjF/78CXxa96qWpye12UzIs0OeL/GvbErsqoDl
         087qQz6RbnDvPeaKIC3TaIiEsQDtwoVjz6ICRhza6L7GSUNmsfM9CKIz1LsgQAnXTpAh
         4G+7LXSh09O7o+oktlBu+LuqUa3u+utMq7zLUKJYRuixA9PFD+qqMdN+ITV5iNeQEH41
         mcSA==
X-Forwarded-Encrypted: i=1; AJvYcCVkyiWkpClfn6cock8tjf2V5/49XyLC0ta8qW5j+kiIf3YEmLg+qLqr0gbX/bny3bw6bpCszhLKVZ2S9OZTTsAW6IOzFwc=
X-Gm-Message-State: AOJu0YxxBxlOYrbJSmzOzV9d43OK/miMwTITDOJFaUknI4KmcIXGm8Ad
	wy4qwc1y05W87/AyHOhqIzcONy9+lTDKQ73ikXAIJRPKFTRBK6gWy+YXG61BYg==
X-Google-Smtp-Source: AGHT+IFN4mU4JAnf6/7PYt5ljgOl6pjIfnrCUXu7Ml6OlpZ6Wn7MTxSHNwvC9HD+aaGq8ciqftJDmw==
X-Received: by 2002:a17:902:d4c1:b0:1fc:719c:5d9 with SMTP id d9443c01a7336-1ff6b5a0371mr4866135ad.25.1722871981263;
        Mon, 05 Aug 2024 08:33:01 -0700 (PDT)
Received: from google.com (255.248.124.34.bc.googleusercontent.com. [34.124.248.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b3fa6sm69081475ad.304.2024.08.05.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:32:59 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:32:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZrDwolC6oXN44coq@google.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805123001.GB9326@willie-the-truck>

On Mon, Aug 05, 2024 at 01:30:01PM +0100, Will Deacon wrote:
> On Mon, Aug 05, 2024 at 08:13:09PM +0800, Kunkun Jiang wrote:
> > On 2024/8/2 22:38, Pranjal Shrivastava wrote:
> > > Hey,
> > > On Mon, Jul 29, 2024 at 11:02 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > > On 2024/7/24 18:24, Will Deacon wrote:
> > > > > On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
> > > > > > On 2024/7/24 9:42, Kunkun Jiang wrote:
> > > > > > > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > > > 1797                 while (!queue_remove_raw(q, evt)) {
> > > > > > > 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > > > > > 1799
> > > > > > > 1800                         ret = arm_smmu_handle_evt(smmu, evt);
> > > > > > > 1801                         if (!ret || !__ratelimit(&rs))
> > > > > > > 1802                                 continue;
> > > > > > > 1803
> > > > > > > 1804                         dev_info(smmu->dev, "event 0x%02x
> > > > > > > received:\n", id);
> > > > > > > 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > > > > > > 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
> > > > > > > 1807                                          (unsigned long
> > > > > > > long)evt[i]);
> > > > > > > 1808
> > > > > > > 1809                         cond_resched();
> > > > > > > 1810                 }
> > > > > > > 
> > > > > > > The smmu-v3 driver cannot print event information when "ret" is 0.
> > > > > > > Unfortunately due to commit 3dfa64aecbaf
> > > > > > > ("iommu: Make iommu_report_device_fault() return void"), the default
> > > > > > > return value in arm_smmu_handle_evt() is 0. Maybe a trace should
> > > > > > > be added here?
> > > > > > Additional explanation. Background introduction:
> > > > > > 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
> > > > > > 2.The SMMU has the stall feature.
> > > > > > 3.Modified guest device driver to generate an event.
> > > > > > 
> > > > > > This event handling process is as follows:
> > > > > > arm_smmu_evtq_thread
> > > > > >       ret = arm_smmu_handle_evt
> > > > > >           iommu_report_device_fault
> > > > > >               iopf_param = iopf_get_dev_fault_param(dev);
> > > > > >               // iopf is not enabled.
> > > > > > // No RESUME will be sent!
> > > > > >               if (WARN_ON(!iopf_param))
> > > > > >                   return;
> > > > > >       if (!ret || !__ratelimit(&rs))
> > > > > >           continue;
> > > > > > 
> > > > > > In this scenario, the io page-fault capability is not enabled.
> > > > > > There are two problems here:
> > > > > > 1. The event information is not printed.
> > > > > > 2. The entire device(PF level) is stalled,not just the current
> > > > > > VF. This affects other normal VFs.
> > > > > Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
> > > > > iopf_group_response() return void"). I agree that we need a way to
> > > > > propagate error handling back to the driver in the case that
> > > > > 'iopf_param' is NULL, otherwise we're making the unexpected fault
> > > > > considerably more problematic than it needs to be.
> > > > > 
> > > > > Lu -- can we add the -ENODEV return back in the case that
> > > > > iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
> > > > > the device?
> > > > Yes, of course. The commit b554e396e51c was added to consolidate the
> > > > drivers' auto response code in the core with the assumption that driver
> > > > only needs to call iommu_report_device_fault() for reporting an iopf.
> > > > 
> > > I had a go at taking Jason's diff and implementing the suggestions in
> > > this thread.
> > > Kunkun -- please can you see if this fixes the problem for you?
> > Okay, I'll test it as soon as I can.
> 
> It looks like the diff sent by Pranjal has whitespace mangling, so I
> don't think you'll be able to apply it.
> 
> Pranjal -- please can you send an unmangled version? If you want to test
> out your mail setup, I'm happy to be a guinea pig so you don't spam the
> mailing lists!

Ugh, apologies for that, something went wrong with my client.
Kunkun -- Please let me know if this fixes the problem.
Lu -- It looks like the intel->page_response callback doesn't expect a
NULL event, so, for now, I immediately return in that case. LMK what you
think?

Here's the updated diff:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..ed2b106e02dd 100644
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
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..7684e7562584 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 	bool last_page;
 	u16 sid;
 
+	if (!evt)
+		return;
+
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 7c9011992d3f..0c3b2125563e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -113,6 +113,57 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	return group;
 }
 
+static struct iommu_attach_handle *find_fault_handler(struct device *dev,
+                                                     struct iopf_fault *evt)
+{
+       struct iommu_fault *fault = &evt->fault;
+       struct iommu_attach_handle *attach_handle;
+
+       if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+               attach_handle = iommu_attach_handle_get(dev->iommu_group,
+                                                       fault->prm.pasid, 0);
+               if (IS_ERR(attach_handle)) {
+                       const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+                       if (!ops->user_pasid_table)
+                               return NULL;
+
+                       /*
+                        * The iommu driver for this device supports user-
+                        * managed PASID table. Therefore page faults for
+                        * any PASID should go through the NESTING domain
+                        * attached to the device RID.
+                        */
+                       attach_handle = iommu_attach_handle_get(
+                               dev->iommu_group, IOMMU_NO_PASID,
+                               IOMMU_DOMAIN_NESTED);
+                       if (IS_ERR(attach_handle))
+                               return NULL;
+               }
+       } else {
+               attach_handle = iommu_attach_handle_get(dev->iommu_group,
+                                                       IOMMU_NO_PASID, 0);
+               if (IS_ERR(attach_handle))
+                       return NULL;
+       }
+
+       if (!attach_handle->domain->iopf_handler)
+               return NULL;
+       return attach_handle;
+}
+
+static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_page_response resp = {
+		.pasid = fault->prm.pasid,
+		.grpid = fault->prm.grpid,
+		.code = IOMMU_PAGE_RESP_INVALID
+	};
+
+	ops->page_response(dev, NULL, &resp);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -153,16 +204,25 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
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
 		report_partial_fault(iopf_param, fault);
@@ -182,38 +242,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
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
@@ -222,7 +251,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
-	return;
+	return 0;
 
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
@@ -232,6 +261,14 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 		__iopf_free_group(group);
 	else
 		iopf_free_group(group);
+
+	return 0;
+
+err_bad_iopf:
+	if (fault->type == IOMMU_FAULT_PAGE_REQ)
+		iopf_error_response(dev, fault);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d87f9cbfc01e..062156a8d87b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1561,7 +1561,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 void iopf_free_group(struct iopf_group *group);
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
 #else
@@ -1599,9 +1599,10 @@ static inline void iopf_free_group(struct iopf_group *group)
 {
 }
 
-static inline void
+static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+	return -ENODEV;
 }
 
 static inline void iopf_group_response(struct iopf_group *group,

> 
> Cheers,
> 
> Will

Thanks,
Pranjal
