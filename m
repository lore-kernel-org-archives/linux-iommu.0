Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBA3793A2
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480257; cv=none; b=Y6pwfvfL0URTgLcxuZhmFDUjTXCV9rrLuOOnwcEZBrwZi8psz6xQ4am+2Yp5WMOH8aetxbrw8pJ+LjfSmJIfwncfs7PnO+GeAiIfdINIzjR+WMRqJ2xGfk3OD5OgyPbiqClS36Dz9IweQgCpP7J5Vry0oe0ODmC9AHKqIy4b4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480257; c=relaxed/simple;
	bh=9sXr2ym6IxrPu+Q0dMfbBlEYOcUJG/q5I4xdmH/tx3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyghyKqJ30GZS2zgy1D+nSLh9OshEWhPr24by2IB1wANR6sQauxdsLcIAcRt4V1262mLuA2vnG+Hg4cBV3foAHdWtmP4/GhxSXOVYzumTOEpph7/U9JyLc8HXXdFGUO2ZVNgod0mSZAHCqFVxLcuzDxJAawb33/UCi6rQlQBF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ecc6lhLh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ecc6lhLh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso1308969a12.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480254; x=1782085054; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5WciEMhZB6XaWbjCrbBJLJCXhJPR6YJdk9HsLicGQg=;
        b=Ecc6lhLhrg9JJq+TIPus/oadSCG4fi78r32c+ZUETxhtI+4pJMgwkSBviBpn1gLvtO
         XEE79eaJOiw9QfO4IOv4C/Q8x6dBcxumfG75qGhPvu+Z1f44dTih5+rPKziiORpL3UC8
         7H9xoncav5eSoE7EBFWAs6edokP+DdNTxiGhE1gVA8TSpS1GQEvImHJuulvTIVUzz8fb
         87L3TnMR956jzbNxDgxvuof9BasQUxYkaGwYzWJJOVI2N/ND4auM+7ueXfWj2lnNPWH0
         ANwfu087lYW+veZ+dwyuAWWDuIn2L4KlJhotxjuZF+UwUcwryFHx3slHonI9O3CbHmDz
         ltYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480254; x=1782085054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5WciEMhZB6XaWbjCrbBJLJCXhJPR6YJdk9HsLicGQg=;
        b=QT+BhOBSvxZ6J+xjptzLFsEObcV/nB+PDT5qW5socH3MEyAWc1z9fV8Zs1FT0lTObL
         hmP1MRDgr/MaOK4kOY0ZgQFjgSG7C71WYLH3TVIQw1VuOCmJ8pHPpWU7PceJsP0JrOfr
         wSclvPkq2oJuzzRnSUb26ISLVDion+P8hJ5oxxV9xAmAu2mcMhWfOGfnkzETBE2CArNu
         ASjjjpzDXcv0eU50BPQgHqW1g/aF5ntVrFmedpNDy7+RGcEUtRPB/6i4tduQqmBkFvE+
         gUs2ytirP6+jp+4oKge4ZxuRLApLm9KiR4AWoLeoNBDO2H1+8yLI353cdO9/+X20hYT/
         mjag==
X-Forwarded-Encrypted: i=1; AFNElJ94kimhTMY7T0R2u72jWKuFdwlz99yLpcZnB0OBDYRcvKm70/pi2YzYw43k5jsBQ7Gf2owndw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5t5c95uOaV1wl6+VqzEI+MrZovUzAZC9BhrvLQpTSEIiuWNeR
	5kKnvj/50Ib5EY9V8NLsI7FajA7qGs0suqgRzq2UCyBq6T+wdxxWywxUgo4Bj7wrUtq4wSojcyY
	fcCorzyULKZOwKQ==
X-Received: from pgj67.prod.google.com ([2002:a63:946:0:b0:c82:74df:99cb])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:493:b0:3b3:fce3:a7f8 with SMTP id adf61e73a8af0-3b79625bfcamr9603125637.15.1781480254295;
 Sun, 14 Jun 2026 16:37:34 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:16 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-7-skhawaja@google.com>
Subject: [PATCH v3 06/18] iommu: Implement device and IOMMU HW preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU ops to preserve/unpreserve the device state handled by the
IOMMU driver. This is IOMMU specific state of the device that needs to
be preserved for liveupdate. These ops can be implemented by the IOMMU
drivers that support preservation of devices that have their IOMMU
domains preserved. During device preservation the state of the
associated IOMMU is also preserved as dependency.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c            |  18 ++++
 drivers/iommu/liveupdate.c       | 172 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  43 ++++++++
 include/linux/iommu.h            |  34 ++++++
 4 files changed, 267 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..41effee10e33 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -307,6 +307,24 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
+{
+	struct iommu_dev_iter *iter = data;
+
+	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
+		return iter->fn(dev, iter->iommu, iter->arg);
+
+	return 0;
+}
+
+void iommu_for_each_dev(struct iommu_dev_iter *iter)
+{
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
+		bus_for_each_dev(iommu_buses[i], NULL, iter,
+				 _iommu_for_each_dev_cb);
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
+
 #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 16a0f75a98e3..2d782023407d 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -13,6 +13,7 @@
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
+#include <linux/pci.h>
 
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
@@ -314,3 +315,174 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
 	domain->preserved_state = NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
+
+static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((void **)&flb->curr_iommu_array,
+			       iommu_max_objs_per_page(flb->curr_iommu_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_iommu_array->objects[idx];
+}
+
+static int iommu_preserve_locked(struct iommu_device *iommu,
+				 struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser;
+	int ret;
+
+	if (!iommu->ops->preserve || !iommu->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	lockdep_assert_held(&flb_obj->lock);
+	if (iommu->outgoing_preserved_state) {
+		iommu->outgoing_preserved_state->hdr.ref_count++;
+		return 0;
+	}
+
+	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
+	if (IS_ERR(iommu_hw_ser))
+		return PTR_ERR(iommu_hw_ser);
+
+	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
+	if (ret) {
+		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	iommu->outgoing_preserved_state = iommu_hw_ser;
+	return ret;
+}
+
+static void iommu_unpreserve_locked(struct iommu_device *iommu,
+				    struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
+
+	lockdep_assert_held(&flb_obj->lock);
+	if (WARN_ON(!iommu_hw_ser))
+		return;
+
+	if (WARN_ON_ONCE(!iommu->ops->preserve ||
+			 !iommu->ops->unpreserve))
+		return;
+
+	iommu_hw_ser->hdr.ref_count--;
+	if (iommu_hw_ser->hdr.ref_count)
+		return;
+
+	iommu->outgoing_preserved_state = NULL;
+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
+	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+}
+
+static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((void **)&flb->curr_device_array,
+			       iommu_max_objs_per_page(flb->curr_device_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_device_array->objects[idx];
+}
+
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 *preserved_state)
+{
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_device_ser *device_ser;
+	struct dev_iommu *iommu;
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return -EOPNOTSUPP;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	iommu = dev->iommu;
+	if (!iommu->iommu_dev->ops->preserve_device ||
+	    !iommu->iommu_dev->ops->unpreserve_device ||
+	    !iommu->iommu_dev->ops->preserve ||
+	    !iommu->iommu_dev->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	if (!domain->preserved_state)
+		return -EINVAL;
+
+	device_ser = alloc_iommu_device_ser(flb_obj);
+	if (IS_ERR(device_ser))
+		return PTR_ERR(device_ser);
+
+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	device_ser->domain_iommu_ser.domain_phys = virt_to_phys(domain->preserved_state);
+	device_ser->domain_iommu_ser.iommu_phys = virt_to_phys(iommu->iommu_dev->outgoing_preserved_state);
+	device_ser->devid = pci_dev_id(pdev);
+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
+
+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+		return ret;
+	}
+
+	dev->iommu->device_ser = device_ser;
+	*preserved_state = virt_to_phys(device_ser);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_device);
+
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_device_ser *iommu_device_ser;
+	struct dev_iommu *iommu;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return;
+
+	iommu = dev->iommu;
+	if (WARN_ON(!iommu->iommu_dev->ops->unpreserve_device ||
+		    !iommu->iommu_dev->ops->unpreserve))
+		return;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (WARN_ON(ret))
+		return;
+
+	guard(mutex)(&flb_obj->lock);
+	iommu_device_ser = dev_iommu_preserved_state(dev);
+	if (WARN_ON(!iommu_device_ser))
+		return;
+
+	dev->iommu->device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	dev->iommu->device_ser = NULL;
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 0204e17996b0..f9528c94979d 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,14 +8,42 @@
 #ifndef _LINUX_IOMMU_LIVEUPDATE_H
 #define _LINUX_IOMMU_LIVEUPDATE_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
 #ifdef CONFIG_IOMMU_LIVEUPDATE
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = dev->iommu->device_ser;
+	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 *preserved_state);
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
+
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return iommu->outgoing_preserved_state;
+}
 #else
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -24,6 +52,21 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
 static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
 {
 }
+
+static inline int iommu_preserve_device(struct iommu_domain *domain,
+					struct device *dev, u64 *preserved_state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+}
+
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return NULL;
+}
 #endif
 
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0bea1a57f4be..b2f614367074 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -655,6 +655,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
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
@@ -711,6 +715,13 @@ struct iommu_ops {
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
+	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
+	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
+	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
+#endif
+
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
 	struct iommu_domain *identity_domain;
@@ -798,6 +809,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
+ * liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -807,6 +820,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *outgoing_preserved_state;
+#endif
 };
 
 /**
@@ -861,6 +878,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -1177,6 +1197,20 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
+typedef int (*iommu_dev_iter_fn)(struct device *dev,
+				 struct iommu_device *iommu, void *arg);
+
+/**
+ * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
+ */
+struct iommu_dev_iter {
+	struct iommu_device *iommu;
+	iommu_dev_iter_fn fn;
+	void *arg;
+};
+
+void iommu_for_each_dev(struct iommu_dev_iter *iter);
+
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

