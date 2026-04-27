Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29C3E8C62
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312604; cv=none; b=bEd/TUrcMgorU3AejRD0ZZxWAEYtFZe+R48C/pEHfEiBYmeM4KRlaaBE2zBrtnBdguYohV0siAGlc25b7MA8R2PjrGDRfN0Yo+HL6+bNT7yAZCicj/84gbWAOsgLh3q/IuVbkYBDGF/aEkibxq5hcqMeSRtvwVyro/ZRIGpxBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312604; c=relaxed/simple;
	bh=z634iQlQHxVL+/V/mdzINSU/pDtahiWzKxukHsUUYL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOSePLuMIyHttH1o83H94RxhLqA0v0vOdXNjVV+/ND7f2oWPeBTIGOemMv0CPBr6yqe0tsxodOsXU7o26QBGR8DUbyZfkhektmL4hei7LYOaA6VQGrg1tfKExkRqrppjyde9aW0TgLCV5Dc5hFsQ5cnsvHoZo1/3ko2T+pMa23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3TgyggC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3TgyggC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so12650755b3a.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312602; x=1777917402; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=efFgfxQhwhHweRQNChxYGo0qwbPbPQHcKBPz8HbiBVQ=;
        b=b3TgyggComffYZOiZemb8yH529Z6XeuLUBIRgcRsNaFgryMa6RL7XSFMt6IWs76IqC
         eM2p75MYFGnYhXwYG5eeNFBWyhXKEr2lSUxdpneaERoq0nzaB6HzggEWab4QnjMfIViX
         hC+K5JivdaZf+I5cqYNosq5A5sHO+fEw/LvrCrZ3OlOWT2diBAGrY2d3VK8CfoWMcgCp
         4dg0z4C3ybQYvD3Ho+Xb5Iojt1Ijv/BeXwdvhsr/Psqth11VpbGQlaU4dXK6Zuvfx+Dj
         Jb5I/L51kDFMyeLa8PfcsCPSj8Om0RU/eIddydKqywrk7segSVS3yELQc384+3jW8kaN
         VSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312602; x=1777917402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efFgfxQhwhHweRQNChxYGo0qwbPbPQHcKBPz8HbiBVQ=;
        b=qRBrmhOQcz8N9IPix1Y2MLkPvFnCr9ePhcqn2v6MUxkluMRyuFqBmoE/ASNBEIOWtx
         2m/K5ynxH58t1LMMc1wyRJWkSSDyIvAm/BoCST2GkVEg6wP6PoehBYxJbcVtiUYfCMMD
         DRw5AJZJ9k2f1q0IqxGFTt8OvhRdw/DhVhw9YZBjtR465gqXwfjxTUt15TuwQIrBFz3M
         5LMXl33DZQE6MmIG5i+vS0h8z58XSQFE7cVQaEmD8tu0OzCtHcGtARgOAar9h2UWOWQY
         hlsxivnIOgrAMOMQhpM32INzmHjYAQqL06wvL1LkvrVkoygtiAb5MJBOSnjkdEkmjsjQ
         DBNg==
X-Forwarded-Encrypted: i=1; AFNElJ+ynQJLZ3vJVY8tp4Y2aCT5vBLLVifveoQ/DFDuOVfjWeeTqt4kO7W0f8+wxywmAQR7scJNcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRoCTVRnxgEWM/iuqqLUeRRrdjabMdrC2cMOW0GMgoy1/tUPMx
	eu+oGG2DJGCNgmATjepoyuMn/XM8yWzZdaA+XU5ZAFaJ+8J4T3aBJUVcdN1lhWTQbcJdcny78Qx
	blx+9bhz99ZHvrw==
X-Received: from pfbhc11.prod.google.com ([2002:a05:6a00:650b:b0:82f:c44b:5d15])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88c8:0:b0:82c:e83d:a9b0 with SMTP id d2e1a72fcca58-834dc19c336mr41084b3a.21.1777312601819;
 Mon, 27 Apr 2026 10:56:41 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:21 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-5-skhawaja@google.com>
Subject: [PATCH v2 04/16] iommu: Implement device and IOMMU HW preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU ops to preserve/unpreserve a device. These can be implemented
by the IOMMU drivers that support preservation of devices that have
their IOMMU domains preserved. During device preservation the state of
the associated IOMMU is also preserved as dependency.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  33 +++++++
 include/linux/iommu.h            |  20 ++++
 3 files changed, 215 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index f71f14518248..765d042e22e3 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -11,6 +11,7 @@
 #include <linux/liveupdate.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/iommu.h>
+#include <linux/pci.h>
 #include <linux/errno.h>
 
 #define iommu_max_objs_per_page(_array) \
@@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
 	domain->preserved_state = NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
+
+static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
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
+	if (!iommu->ops->preserve)
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
+		iommu_hw_ser->hdr.deleted = true;
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
+	iommu_hw_ser->hdr.ref_count--;
+	if (iommu_hw_ser->hdr.ref_count)
+		return;
+
+	iommu->outgoing_preserved_state = NULL;
+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
+	iommu_hw_ser->hdr.deleted = true;
+}
+
+static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,
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
+	if (!domain->preserved_state)
+		return -EINVAL;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	iommu = dev->iommu;
+	if (!iommu->iommu_dev->ops->preserve_device ||
+	    !iommu->iommu_dev->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	device_ser = alloc_iommu_device_ser(flb_obj);
+	if (IS_ERR(device_ser))
+		return PTR_ERR(device_ser);
+
+	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
+	if (ret) {
+		device_ser->hdr.deleted = true;
+		return ret;
+	}
+
+	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
+	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
+	device_ser->devid = pci_dev_id(pdev);
+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
+
+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
+	if (ret) {
+		device_ser->hdr.deleted = true;
+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+		return ret;
+	}
+
+	dev->iommu->device_ser = device_ser;
+	*preserved_state = virt_to_phys(device_ser);
+	return 0;
+}
+
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_device_ser *iommu_device_ser;
+	struct dev_iommu *iommu;
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
+		return;
+
+	pdev = to_pci_dev(dev);
+	iommu = dev->iommu;
+	if (!iommu->iommu_dev->ops->unpreserve_device ||
+	    !iommu->iommu_dev->ops->unpreserve)
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
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	dev->iommu->device_ser = NULL;
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 6019cfc27428..279c7ab04f09 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,14 +8,37 @@
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
+	if (ser && !ser->hdr.incoming)
+		return ser;
+
+	return NULL;
+}
+
 int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_domain_unpreserve(struct iommu_domain *domain);
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 *preserved_state);
+void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
 #else
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -24,6 +47,16 @@ static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iomm
 static inline void iommu_domain_unpreserve(struct iommu_domain *domain)
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
 #endif
 
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3853a3946733..1c424b32c5fc 100644
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
@@ -806,6 +817,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
+ * liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -815,6 +828,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *outgoing_preserved_state;
+#endif
 };
 
 /**
@@ -869,6 +886,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.54.0.545.g6539524ca2-goog

