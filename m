Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF1156F20
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826206; cv=none; b=L0SJl2F9c6LqSuir99LxRg9cyZPVg1eDLTardE/Al2PccW3tRioCXB7t3UGv7yjiSMgdIenpXb0xhdrZ1XabsvRy5OCdHjvSYBv41O5cgn+VyGrNXT9JHICZpKCMshskFWAakqvlqOt5hvVXgylH+lZ5tlMDgSsiz5DAQV6Q1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826206; c=relaxed/simple;
	bh=7FtZNSBuUZjyjaV4n2+nAbH4WuyljN9+tKRazuHH360=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwIVWkt/XDnozkKeHD7cfuRMj236x9qSF9UbaHYRK4gRF9QmVyHYl0xzeHWBCeYXLka2bgxXSQVDqtLxk2fFuZ+659mHpRkbhfrh01JbfCpwfKUi7t8hfYIwOAGi0Tsg4R80fj8XN895u76T42G/C9Bip5NSM5wPaYo022w4rIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QSCUkySN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QSCUkySN"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f323f0898so380506385a.0
        for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721826203; x=1722431003; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gVpjQRzS9NiLhrY2IoR3jKrqtPwVH9b4IVPT4YLkPVo=;
        b=QSCUkySNXa8IsG0U4nFiJFzcjS1MwxMZzl3oXLwtfBvHItDtLAFAMqFN6a1YR/dvsH
         0pdBGCyMZG7McTrbzjnJ17JdBpVdj4N8gzlGuSkd6JM1SpaV5SElLjWRTBkS0ewNdSxc
         nU7u4ISSCqPNXs5yO4kHtXOjPRjb2L2RixSTT3xkpbVc4t6sygQsl5jVJDGCPCRSZ6Rd
         4azI6QWQFJQgLUbmhk0b+uvLiXCLqd5tbRnAqlCV5ES8f2Lc+5YZP6cm8UHT3SkhZe63
         Xyc/ESQn7uhUjJTvoKutCGHovG7elCejDhx7SsYk9DluWiizxfTeuYxbxhfbfNBVXyAg
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826203; x=1722431003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVpjQRzS9NiLhrY2IoR3jKrqtPwVH9b4IVPT4YLkPVo=;
        b=giVpB0UrlqLEu1u3d7tqylzj6zoYpoYBiecq4w0clpW5r7UivyypqKVIlssmcZDtoH
         zOmnvuYtAR3MVeZefAt6+ZhtfS/4rx1Mf603y7VeH3ZwbJOAYG3lUW9Qz43CLoslCZRJ
         6/7v9jyOJsS7ZvYzUHpAER9DDDP9IdoFYkl4ohonuzynNW468/pI9x9/HbeEKYU7w5QQ
         WaZQlyRvriuPi6GBo08PxQHvmjItNVIYz4mZ/opOUb8qt5V9+VER124jvtQf6ZaKy84u
         iifFCTnPRdS+bBlzaGlkVgh8vV/Qi/vBF2bs7IGz62NRtw0BqgPsSeHZVv507FQVTijV
         M/pg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6mA3Y3MqttoFBfR0+FTrP9hiRG9RPLhybL2aRLekmQepVxaGVYnW8Z9iRQqZxQUwuwXmJgJevuP5pR4+bkdBXx/3Qug=
X-Gm-Message-State: AOJu0YzqqYloeCT40OACoScCsxpbaSQZIgnY+3Ro6+DyXQhgMkTFrIj5
	UHxeelDXu6nlw2gO+GgzE1hnWAnsWG17qATsZp8VAHipRtBFTAyKBi+jgt76dXs=
X-Google-Smtp-Source: AGHT+IGxUVbW3woayZYlmk8zyRsUT2BYFH0DiJMp3HGRfOElEFBBlHGLdlilmWNVuFn/jcXGAVyfLg==
X-Received: by 2002:a05:620a:2688:b0:7a1:c40d:5edb with SMTP id af79cd13be357-7a1c40d6a56mr461914285a.35.1721826202671;
        Wed, 24 Jul 2024 06:03:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905eb1dsm574329685a.89.2024.07.24.06.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:03:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWbeK-00AcNr-7p;
	Wed, 24 Jul 2024 10:03:20 -0300
Date: Wed, 24 Jul 2024 10:03:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240724130320.GO14050@ziepe.ca>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724102417.GA27376@willie-the-truck>

On Wed, Jul 24, 2024 at 11:24:17AM +0100, Will Deacon wrote:
> > This event handling process is as follows:
> > arm_smmu_evtq_thread
> >     ret = arm_smmu_handle_evt
> >         iommu_report_device_fault
> >             iopf_param = iopf_get_dev_fault_param(dev);
> >             // iopf is not enabled.
> > // No RESUME will be sent!
> >             if (WARN_ON(!iopf_param))
> >                 return;
> >     if (!ret || !__ratelimit(&rs))
> >         continue;
> > 
> > In this scenario, the io page-fault capability is not enabled.
> > There are two problems here:
> > 1. The event information is not printed.
> > 2. The entire device(PF level) is stalled,not just the current
> > VF. This affects other normal VFs.
> 
> Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
> iopf_group_response() return void"). I agree that we need a way to
> propagate error handling back to the driver in the case that
> 'iopf_param' is NULL, otherwise we're making the unexpected fault
> considerably more problematic than it needs to be.

The expectation was the driver would not call this function if it is
not handling a fault path, that's why there is a WARN_ON..

It seems those details were missed and drivers are not equipped to do
so..

Broadly if a fault is received and there is no domain fault handler to
process it then we should still generate all the DMA failure logging
as normal.

So maybe something like this to capture those corners as well:

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 7c9011992d3f04..52ffdb8324de50 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -113,14 +113,55 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	return group;
 }
 
+static struct iommu_attach_handle *find_fault_handler(struct device *dev,
+						      struct iopf_fault *evt)
+{
+	struct iommu_fault *fault = &evt->fault;
+	struct iommu_attach_handle *attach_handle;
+
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+							fault->prm.pasid, 0);
+		if (IS_ERR(attach_handle)) {
+			const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+			if (!ops->user_pasid_table)
+				return NULL;
+
+			/*
+			 * The iommu driver for this device supports user-
+			 * managed PASID table. Therefore page faults for
+			 * any PASID should go through the NESTING domain
+			 * attached to the device RID.
+			 */
+			attach_handle = iommu_attach_handle_get(
+				dev->iommu_group, IOMMU_NO_PASID,
+				IOMMU_DOMAIN_NESTED);
+			if (IS_ERR(attach_handle))
+				return NULL;
+		}
+	} else {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+							IOMMU_NO_PASID, 0);
+		if (IS_ERR(attach_handle))
+			return NULL;
+	}
+
+	if (!attach_handle->domain->iopf_handler)
+		return NULL;
+	return attach_handle;
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
  * @evt: fault event data
  *
  * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
- * handler. If this function fails then ops->page_response() was called to
- * complete evt if required.
+ * handler. If this function fails then their is no fault handler for this evt
+ * and the fault remains owned by the caller. The caller should log the DMA
+ * protection failure and resolve the fault. Otherwise on success the fault is
+ * always completed eventually.
  *
  * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
  * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
@@ -153,16 +194,25 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
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
+		return -EINVAL;
+
+	/*
+	 * Something has gone wrong if a fault capable domain is attached but no
+	 * iopf_param is setup.
+	 */
 	iopf_param = iopf_get_dev_fault_param(dev);
 	if (WARN_ON(!iopf_param))
-		return;
+		return -EINVAL;
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
 		report_partial_fault(iopf_param, fault);
@@ -181,39 +231,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	group = iopf_group_alloc(iopf_param, evt, &abort_group);
 	if (group == &abort_group)
 		goto err_abort;
-
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

