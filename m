Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C92C026C
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156054; cv=none; b=RPlyZTMNeHUfRZ1YtB+eR7v7Nu/+VDtTCOODjXOb9I5JjkRgfv0UEYDsOpaR/73rLtng7NO80UY2O/OHJkAnTrN9hvfYOmhvWRJpHqf1k1yZa0QHWG5wlktqjGVbtd9g40EKUS7U8nyqzJlUzRseq7pET5uLK3L8cOJh9xWQGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156054; c=relaxed/simple;
	bh=ZtyGHgSH6zOMlhOHq32hXQyZpXOSALeeI1dhrCOBpvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhHU+aqteuhWdGEZRv/aCimPIF0DWpWTlDXVe+f3YX21au8I8b4Ly73k9rx3QhBGbwaZBoGlhkvJEJRlKh7I9Qn0EWiS3/Alv0fTH0kL+e9JOQncy5LkF4ah9HesGPpR3iEj9ErSdBKLiHUbOp1vqXkb/nxvbgc5X6ipPTlwMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpsuY4Lr; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpsuY4Lr"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso267917a91.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156049; x=1786760849; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xm63OpalwzRaJYEZCMZxu3HFth0lOA6UUCYpkiD5B5Y=;
        b=WpsuY4LrfecV1S9pg+pyeVbk+cTD2MhzK9cvoRJd+0hZxCKM8LO9g/9qJewPJUwyP/
         9wMEOV7DqbjKpirpFzdSnuJb2nstPrggszJpl+w7+W9UZB1l/HRjqnOcRNOj5L5KLt/F
         0Gp3EjGQYv5R5/hRZeYOR/INLIU01hMlqDGaX+XNskhmBMV+sert62xT7MwbrTpvzDgG
         8YZ0srEq4E7kiobguUlPa57pzFY0yjNs+X3mk6396fZjB6JgPA5qgwfs+BycFc2inskf
         N6fyRawTlT0vaOCQ2sCvIQPRWRDVs7D9TXeTzyTShOGGx+gMe7EgMuVqaxihzM3ElCOq
         pJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156049; x=1786760849;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm63OpalwzRaJYEZCMZxu3HFth0lOA6UUCYpkiD5B5Y=;
        b=JDgxVyNZK6X/W6Ag5Lul4bO3SOa5EcUDl4TsvbMmDAeElSJ/FWde4fddFxRlXFftGk
         ymGR4TepNGWPtQvuBgESVBY7UdMa5lU36OpGxs0mODWdTVkIHMBcbyVl87HXrJKOcInG
         RmYVMmYEaTjTfknxDA23kum0ojcNBnTFrtj2jSGXKj2Q/JbbMBXOwH7NN32etDnK2x1R
         ZjAhBjoU19nPh7XOeKrCjBhwZ+RG3bBeL96ulcDVLW0qu1h4Qx1t7ciEHsakMUOPySHr
         Ohhwwh8p+vP1FN9aO8QdF6PyFHSIcNen5VcxWP2uQclm4OACk33lPhIEW5TaOWIycCoE
         Hcsg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn0oahdMjxnHeEYVmuqr/qeNt0L8TOy+D6/xH+E3pU9Yh0QLPUC4U2tISCR720cSJcMBWZDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRyv9tm3BgtHrUKqMl2DNgxCKdprJ6vdgcVJtVfD2DCRyltuzb
	KDeyOcXBszy6AB5/3tsY1xNjTa2Badc7DS7TGpAE9nFNljnJhz/bv9P3psgsEZZa2M7h+7tA4KX
	YslvaICYBSVBUEw==
X-Received: from pjnq3.prod.google.com ([2002:a17:90a:8703:b0:38f:caed:7f27])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2785:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-3903c5e70c3mr27494552a91.19.1786156049070;
 Fri, 07 Aug 2026 19:27:29 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:11 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-7-skhawaja@google.com>
Subject: [PATCH v4 06/18] iommu: Implement device and IOMMU HW preservation
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
 drivers/iommu/iommu.c            |  31 +++++
 drivers/iommu/liveupdate.c       | 202 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  56 +++++++++
 include/linux/iommu.h            |  42 +++++++
 4 files changed, 331 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..e00934af45d4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -328,6 +328,37 @@ void iommu_device_unregister(struct iommu_device *iommu)
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
+/**
+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
+ * @iter: Device iterator context
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_for_each_dev(struct iommu_dev_iter *iter)
+{
+	int ret;
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		ret = bus_for_each_dev(iommu_buses[i], NULL, iter,
+				       _iommu_for_each_dev_cb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
+
 #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a5131e1243e4..7f349ae5a124 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -42,6 +42,7 @@
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
+#include <linux/pci.h>
 
 #define iommu_max_objs_per_page(_array) \
 	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
@@ -384,3 +385,204 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
 	liveupdate_flb_put_outgoing(&iommu_flb);
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
+/**
+ * iommu_preserve_device() - Preserve device state across live update
+ * @domain: Associated IOMMU domain
+ * @dev: Device to preserve
+ * @preserved_state: Pointer to receive physical address of preserved state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 *preserved_state)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
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
+	mutex_lock(&flb_obj->lock);
+	if (!domain->preserved_state) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (iommu->device_ser) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	device_ser = alloc_iommu_device_ser(flb_obj);
+	if (IS_ERR(device_ser)) {
+		ret = PTR_ERR(device_ser);
+		goto out_unlock;
+	}
+
+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		goto out_unlock;
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
+		goto out_unlock;
+	}
+
+	dev->iommu->device_ser = device_ser;
+	*preserved_state = virt_to_phys(device_ser);
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_device);
+
+/**
+ * iommu_unpreserve_device() - Unpreserve device state
+ * @domain: Associated IOMMU domain
+ * @dev: Device to unpreserve
+ */
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_device_ser *iommu_device_ser;
+	struct iommu_flb_obj *flb_obj;
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
+	mutex_lock(&flb_obj->lock);
+	iommu_device_ser = dev_iommu_preserved_state(dev);
+	if (WARN_ON(!iommu_device_ser))
+		goto out_unlock;
+
+	dev->iommu->device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	dev->iommu->device_ser = NULL;
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index caa9778eee2d..fd88c7e9c400 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_IOMMU_LIVEUPDATE_H
 #define _LINUX_IOMMU_LIVEUPDATE_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
@@ -15,8 +16,43 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+/**
+ * dev_iommu_preserved_state() - Get preserved state of a device
+ * @dev: Target device
+ *
+ * Return: Pointer to preserved device state, or NULL if not preserved.
+ */
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
+/**
+ * iommu_preserved_state() - Get preserved state of an IOMMU instance
+ * @iommu: IOMMU hardware instance
+ *
+ * Return: Pointer to preserved state, or NULL if not preserved.
+ */
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return iommu->outgoing_preserved_state;
+}
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -27,6 +63,11 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
 {
 }
 
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -35,5 +76,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
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
 #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 291f1e1227b0..914fffae8845 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -684,6 +684,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
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
@@ -740,6 +744,13 @@ struct iommu_ops {
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
@@ -827,6 +838,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
+ * liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -836,6 +849,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *outgoing_preserved_state;
+#endif
 };
 
 /**
@@ -890,6 +907,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -1206,6 +1226,28 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
+/**
+ * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
+ * @dev: Attached device
+ * @iommu: IOMMU instance
+ * @arg: Private argument passed to iterator
+ *
+ * Return: 0 on success, or negative error code.
+ */
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
+int iommu_for_each_dev(struct iommu_dev_iter *iter);
+
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
-- 
2.55.0.679.g6767b8d81c-goog

