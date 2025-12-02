Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DA303C81
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716612; cv=none; b=VnoFzO6/ExUjx0iFZm/aGlKUtq7NJTGhDKdy+fAdav2HTT60L+uUMe4LqmcHI7iSEBMyZ3b6gCvBcGzLgBoAqOZ7h2tP6XWvngWumJcUAOuFtMwom8AoU0rHQBuglZZB1mGJwJutN5ApssSW3e8PLTZpi+gGoFOVU7MM9BRmzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716612; c=relaxed/simple;
	bh=mCNNwuyvQrPxXIJnD3o+3qG9HX5gin7Atc9BmlenXE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROGsHfhxmH13XY9PZ6GG3N9qK0DcVnHbdVqi7XmcLEHyBs5yuy+621xr6bGjQEM1WBz9QDWTShnJQKmp82IvCpBjqqwuLo3bDQ/WSKAFSkz6Ne+mhlhD8Qe4a/6N6yEQAEXbAR1fFQzNpdpSZk7rgkDiKpeFKr3c9eeE6QcjKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNzdHIDl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNzdHIDl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-342701608e2so6137393a91.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716609; x=1765321409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzO62LzLWhogZFr6q9clLaPPERMHuTUpUvC1p+wqPE0=;
        b=nNzdHIDlUBsFGTp7UEyfnMhSdyOLfOufVTBtYUO8o1za2D3nu6gWIjsd0bVlD4on+3
         4cXRhK8OTXnhHf3p1aIdUdaiixNxjCpN+28eAEF4n0M0D5E8e9+VBrU2F7DpRKFtojEx
         ACbDZLirzkkxmFCTVv+i9jq2OxovLsyJbcKw6UIpseg4g3LO7dBcN/jXNwxph4M2ANeS
         SAtjFvTOMrV4VyUGNDjZHD0mUbispteRrJhT5NqFEeddA6QGXr2bS7YARDUPzg1PM0S1
         IUmX4FHY4n/rEG/1abqKmBPrWxWYWqRKBA+q+5hgZw3A9OoknxOQGKaofWW33z0jpsVX
         HtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716609; x=1765321409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzO62LzLWhogZFr6q9clLaPPERMHuTUpUvC1p+wqPE0=;
        b=Kc88fFhaiCkhgb0JJJOcL2MrbVEK4rh/IxUGesT8YA6UrFnvr2sE/F7TaOTspstOCq
         S86bizA30tqfD0k/zFiK2rtoRHW5C7DF3x2VDeNalpXUUOLnLtJm+5hVTKch2B51K/so
         Yj4SzoqhOG+hdZstjkHhyApMw6fqWqUalFypUqLaSzNouC0egYj7LJjuVA77izu/nYug
         cNER1+ruN/nALidgCjXapH4hkv4iiDa4B8tayUjXSGasclwMjNpJSsE2BJXc2U3I4m8z
         WMcQxsjfVevh1gmrGbl8CjZ8dpyPLiXxFVQ2BpIWOUf5q6xDzc6kn3xpHpgSH3wjrRK5
         bx1A==
X-Forwarded-Encrypted: i=1; AJvYcCURFVCuMETE2mtoMEDlEJmqfsC8fzIvcrD7aJpIdvvIADTnSCN1gyFswlpNrvuoaAUlpXD0Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw06Dq6DPXNStZWYXlnF51h//8Jel6TltjIoeIbpwHhDgbKV+JY
	P+aF3TB+EqagQroXHcZfkiEaacAaQrQPDawIQUhscpLpO/ezGKbPsdWXX2f/UMtO275fr8la4fF
	WfSabJf92q1gnig==
X-Google-Smtp-Source: AGHT+IGZ44HWJjsQSNE+u7/5limV9AQ6F/F6G4pJhNrvWTghmZsysAgAjveAeb9VEkC56XFvr1Ap3z84/zVBdQ==
X-Received: from pjbsc13.prod.google.com ([2002:a17:90b:510d:b0:341:bc50:b0c5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3147:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-349126b815amr341784a91.11.1764716609302;
 Tue, 02 Dec 2025 15:03:29 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:46 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-17-skhawaja@google.com>
Subject: [RFC PATCH v2 16/32] iommu: Add API to preserve/unpreserve a device
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

iommu_preserve_device/iommu_unpreserve_device can be used to
preserve/unpreserve a device for liveupdate. During device preservation
the state of the associated IOMMU is also preserved. The device can only
be preseved if the attached iommu domain is preserved and the assocated
iommu supports preservation.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c      |   3 +
 drivers/iommu/liveupdate.c | 115 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu-lu.h   |   2 +
 include/linux/iommu.h      |  18 ++++++
 4 files changed, 138 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a70898d11959..3feb440de40a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -382,6 +382,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 
 	mutex_init(&param->lock);
 	dev->iommu = param;
+#ifdef CONFIG_LIVEUPDATE
+	dev->iommu->device_ser = NULL;
+#endif
 	return param;
 }
 
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 25a943e5e1e3..5780761a7024 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -11,6 +11,7 @@
 #include <linux/liveupdate.h>
 #include <linux/iommu-lu.h>
 #include <linux/iommu.h>
+#include <linux/pci.h>
 #include <linux/errno.h>
 
 static void iommu_liveupdate_free_objs(u64 next, bool incoming)
@@ -209,3 +210,117 @@ int iommu_domain_unpreserve(struct iommu_domain *domain)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
+
+static int iommu_preserve_locked(struct iommu_device *iommu)
+{
+	struct iommu_lu_flb_obj *flb_obj;
+	struct iommu_ser *iommu_ser;
+	int idx, ret;
+
+	if (!iommu->ops->preserve)
+		return -EOPNOTSUPP;
+
+	if (iommu->outgoing_preserved_state) {
+		iommu->outgoing_preserved_state->obj.ref_count++;
+		return 0;
+	}
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommus, MAX_IOMMU_SERS);
+	if (idx < 0)
+		return idx;
+
+	iommu_ser = &flb_obj->iommus->iommus[idx];
+	idx = flb_obj->ser->nr_iommus++;
+	iommu_ser->obj.idx = idx;
+	iommu_ser->obj.ref_count = 1;
+
+	ret = iommu->ops->preserve(iommu, iommu_ser);
+	if (ret)
+		iommu_ser->obj.deleted = true;
+
+	iommu->outgoing_preserved_state = iommu_ser;
+	return ret;
+}
+
+static void iommu_unpreserve_locked(struct iommu_device *iommu)
+{
+	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
+
+	iommu_ser->obj.ref_count--;
+	if (iommu_ser->obj.ref_count)
+		return;
+
+	iommu->outgoing_preserved_state = NULL;
+	iommu->ops->unpreserve(iommu, iommu_ser);
+	iommu_ser->obj.deleted = true;
+}
+
+int iommu_preserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_lu_flb_obj *flb_obj;
+	struct device_ser *device_ser;
+	struct dev_iommu *iommu;
+	struct pci_dev *pdev;
+	int ret, idx;
+
+	if (!dev_is_pci(dev))
+		return -EOPNOTSUPP;
+
+	if (!domain->preserved_state)
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	iommu = dev->iommu;
+	if (!iommu->iommu_dev->ops->preserve_device ||
+	    !iommu->iommu_dev->ops->preserve)
+		return -EOPNOTSUPP;
+
+	if (!iommu->iommu_dev->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->devices, MAX_IOMMU_SERS);
+	if (idx < 0)
+		return idx;
+
+	device_ser = &flb_obj->devices->devices[idx];
+	idx = flb_obj->ser->nr_devices++;
+	device_ser->obj.idx = idx;
+	device_ser->obj.ref_count = 1;
+
+	ret = iommu_preserve_locked(iommu->iommu_dev);
+	if (ret) {
+		device_ser->obj.deleted = true;
+		return ret;
+	}
+
+	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
+	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
+	device_ser->devid = pci_dev_id(pdev);
+	device_ser->pci_domain = pci_domain_nr(pdev->bus);
+	device_ser->token = device_ser->obj.idx + 1;
+
+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
+	if (ret) {
+		device_ser->obj.deleted = true;
+		iommu_unpreserve_locked(iommu->iommu_dev);
+		return ret;
+	}
+
+	dev->iommu->device_ser = device_ser;
+	domain->preserved_state->attach_count++;
+	return device_ser->token;
+}
+
+int iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index 2c8e5ac746ad..95375530b7be 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -13,6 +13,8 @@
 
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 int iommu_domain_unpreserve(struct iommu_domain *domain);
+int iommu_preserve_device(struct iommu_domain *domain, struct device *dev);
+int iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 387cbe20c83b..45da5b88f35d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -654,6 +654,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *               resources shared/passed to user space IOMMU instance. Associate
  *               it with a nesting @parent_domain. It is required for driver to
  *               set @viommu->ops pointing to its own viommu_ops
+ * @preserve_device: Preserve state of a device for liveupdate.
+ * @unpreserve_device: Unpreserve state that was preserved earlier.
+ * @preserve: Preserve state of iommu translation hardware for liveupdate.
+ * @unpreserve: Unpreserve state of iommu that was preserved earlier.
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
  *                   translation.
@@ -710,6 +714,11 @@ struct iommu_ops {
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
 
+	int (*preserve_device)(struct device *dev, struct device_ser *device_ser);
+	void (*unpreserve_device)(struct device *dev, struct device_ser *device_ser);
+	int (*preserve)(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+	void (*unpreserve)(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
 	struct iommu_domain *identity_domain;
@@ -805,6 +814,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
+ * liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -814,6 +825,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_LIVEUPDATE
+	struct iommu_ser *outgoing_preserved_state;
+#endif
 };
 
 /**
@@ -868,6 +883,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_LIVEUPDATE
+	struct device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.52.0.158.g65b55ccf14-goog

