Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283719;
	b=kZKX+IQ7LBaWuXPC3X9axw6KDYJHxndn1d7nKHJ3096zKlNomYcTlI9VdEMb+r/NxeCz
	 jnBGKE+UjW+84s9yV62+5uaZLYTnZGbFhgSHeJFRSumXuK9ObUEbhI0culqW3xE9LqSZa
	 LD/9rS9/aJnrt2hQXPuMDCIL9keeXoUNrE4OHyUqNvPrEJ80mkq5zkuNSuPDpqFG2nW6S
	 dv8Zy/efIbq9741FquvJIk8BzCocY2hwXiYzMIh2xKpK2uQdcsma9w8Nex7F/mPhEsA0p
	 OMaQs9K/8ZxWgy+JJCnX6EaH4lbKEUgPgNcLwH8e/BVY2a6L/qSs0t83Nu3TCjn52vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=LBD1/sH57hD3VTKftstpSFjLfwZSbl4Oz8n3drUds3w=;
	b=rZzfpW3UdawThy+Mu1SBN7YtWxd7GTPi1sLigTdeFSadfrRnhbLuIb9m30vJJ4dAkQDZ
	 g4I5YV6D+pMSfo2hV6mQIOJsit85L3PD8DSkhLcVhSpQyH9jYn6XIYRdIuZo1jx/VDjk/
	 TEn/LB4tA0KhZ0IRzBj+pAfWEaw5+MeuerSMddE1rBQMrqts8qE8uEttPmKP8DZnJNCHo
	 3DeVxA+dGUfeo7SwA6iYT9X1M0MIiGMiaNS0w2XFmA7vfwEQj7WoW4u8itauWmFQmCopi
	 G8Y3eMJhtWpj9kmuDlf1fxR2S9hv+z8U4YiHNRuNBfNMwsyPgpxj1IWy/a0XC19Q/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsqSExO5;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388460A381C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F388460A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsqSExO5
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea0fe07201so11260615ad.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283718; x=1794888518; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBD1/sH57hD3VTKftstpSFjLfwZSbl4Oz8n3drUds3w=;
        b=gsqSExO5wMau/2j6tVwxQFU2yyfnZNpZk/ZYVaqd4iJUX4pOLxMzv4zbp439oHlg8G
         2VvhGoEC+imIbtvREebvhxZ6ZtTcYUqLst1fHVj37pXHQJrFCsdkxQcz73ji1fS9ANuA
         EZ0UqHs3v25Npc2jTQcJoNYzrd1gIySm6Gh62mNWDEBSWgYka80fxH2wl1+IGo0ynBtA
         q65fPHg5FYPtbETwQEh4ZJOtL3VsCFH9D23nc3iI0Ti8DfoirJLwb2pXAMZyxSjji5oQ
         qViYMYi0wkuXm/fitrL76M6EhIri/2efObAXsxN1II6sP1CnZAaj0WGSn2doPR3eUb7G
         cJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283718; x=1794888518;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBD1/sH57hD3VTKftstpSFjLfwZSbl4Oz8n3drUds3w=;
        b=WSZd1L41m9AR4aQ1tNBGpPkNwDgYiKmAD+Db2mV6hsvjX3VxhLr9EBYf4wW1PC4QMh
         7i2lZq6XPQo++gJs/DHHo3o5E6zhRF7R/q+XNUa2D1rHzTw6aQmi4tFjnPGX8Jh5AvDF
         OoF3DkFOTnM3pRFWKwDZy2SRg6bQ2y5rjNlrHsKiWkKy26UmQK5lbVZffoISVIA9CdNz
         UlyhuML02IL5TUlVn8mnxB2Y/wPPU7zead6IL7467i8cSOBCcCuwQrpkuAvhGwHc8INr
         pCTSfAgsdy/RzQKv2rhHlD15+ihooKPx/WWJ5Oim1/hUW5i6xe7mezljgxPDNk0hqVu4
         G77w==
X-Forwarded-Encrypted: i=1; AL+hErGhqCbqLj/I6ArmptbJKUx9uOWHWISrh1kfgRTN4cUlcLSRRERcU0N2GKu0XIopjHRRAylCHw==@lists.linux.dev
X-Gm-Message-State: APuU4Z96J0z1eopAZhEMJanMoQ/3wyXdfyjQYd1QQnJoBFNrer+YVJc1
	hpF+Kt+OEegGfvO7oP/SaX0m07eJzdj4cvHSNqn3Ya5FWWuxARSadHkjrCj5/FDjX4u4lomjRPT
	vOTq7BzIs+LrXOA==
X-Received: from pjbco24.prod.google.com ([2002:a17:90a:fe98:b0:3a5:f1d:43a6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2550:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b166cf7863mr1563573a91.61.1794283717808;
 Mon, 09 Nov 2026 20:08:37 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:11 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-6-skhawaja@google.com>
Subject: [PATCH v7 05/18] iommu: Implement device and IOMMU HW preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU ops to preserve/unpreserve the device state handled by the
IOMMU driver. This is IOMMU specific state of the device that needs to
be preserved for liveupdate. These ops can be implemented by the IOMMU
drivers that support preservation of devices that have their IOMMU
domains preserved. During device preservation the state of the
associated IOMMU is also preserved as dependency.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu-priv.h       |   2 +
 drivers/iommu/iommu.c            |  32 +++++-
 drivers/iommu/liveupdate.c       | 191 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  76 ++++++++++++
 include/linux/iommu.h            |  21 ++++
 5 files changed, 321 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 1f9f886b2c10..8a14d38a3e70 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 void dev_iommu_free(struct device *dev);
 
+size_t iommu_group_device_count(struct iommu_group *group);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..932325e0af41 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -626,8 +627,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
+	struct group_device *gdev, *gdev2;
 	struct iommu_group *group;
-	struct group_device *gdev;
 	int ret;
 
 	/*
@@ -661,6 +662,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	for_each_group_device(group, gdev2) {
+		if (dev_iommu_has_preserved_state(gdev2->dev)) {
+			ret = -EBUSY;
+			goto err_free_gdev;
+		}
+	}
+
 	/*
 	 * The gdev must be in the list before calling
 	 * iommu_setup_default_domain()
@@ -697,6 +705,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del(&gdev->list);
+err_free_gdev:
 	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
@@ -3543,6 +3552,27 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+/**
+ * iommu_group_device_count() - Get the number of devices in a group
+ * @group: The group.
+ *
+ * The device count may change after this function returns, as devices can
+ * be added to or removed from the group. The caller must recheck it if it
+ * needs the count to stay the same.
+ *
+ * Return: the number of devices in the group.
+ */
+size_t iommu_group_device_count(struct iommu_group *group)
+{
+	size_t count;
+
+	mutex_lock(&group->mutex);
+	count = list_count_nodes(&group->devices);
+	mutex_unlock(&group->mutex);
+
+	return count;
+}
+
 static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a98f16d11727..2dcac82b453b 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -43,6 +43,9 @@
 #include <linux/kexec_handover.h>
 #include <linux/kho_block.h>
 #include <linux/liveupdate.h>
+#include <linux/pci.h>
+
+#include "iommu-priv.h"
 
 /**
  * struct iommu_ser_set - Set of serialized objects of one type
@@ -358,3 +361,191 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
 	liveupdate_flb_put_outgoing(&iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
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
+	if (iommu->iommu_ser) {
+		iommu->iommu_ser->hdr.ref_count++;
+		return 0;
+	}
+
+	iommu_hw_ser = iommu_ser_set_alloc(&flb_obj->iommu_set);
+	if (IS_ERR(iommu_hw_ser))
+		return PTR_ERR(iommu_hw_ser);
+
+	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
+	if (ret) {
+		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	iommu->iommu_ser = iommu_hw_ser;
+	return ret;
+}
+
+static void iommu_unpreserve_locked(struct iommu_device *iommu,
+				    struct iommu_flb_obj *flb_obj)
+{
+	struct iommu_hw_ser *iommu_hw_ser = iommu->iommu_ser;
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
+	iommu->iommu_ser = NULL;
+	iommu->ops->unpreserve(iommu, iommu_hw_ser);
+	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+}
+
+/**
+ * iommu_preserve_device() - Preserve device state across live update
+ * @domain: Associated IOMMU domain
+ * @dev: Device to preserve
+ * @dma_owner_token: Token to identify DMA owner of this device
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 dma_owner_token)
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
+	if (iommu_group_device_count(dev->iommu_group) != 1)
+		return -EOPNOTSUPP;
+
+	if (iommu_get_domain_for_dev(dev) != domain)
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
+	if (!domain->domain_ser) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (dev_iommu_preserved_state(dev)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
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
+	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
+	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
+	device_ser->devid = pci_dev_id(pdev);
+	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
+	device_ser->dma_owner_token = dma_owner_token;
+
+	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
+	if (!ret) {
+		WRITE_ONCE(dev->iommu->device_ser, device_ser);
+
+		/* Validate that no sibling device was added concurrently */
+		if (iommu_group_device_count(dev->iommu_group) != 1) {
+			iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
+			WRITE_ONCE(dev->iommu->device_ser, NULL);
+			ret = -EOPNOTSUPP;
+		}
+	}
+
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+		goto out_unlock;
+	}
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
+ * @dev: Device to unpreserve
+ */
+void iommu_unpreserve_device(struct device *dev)
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
+	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	WRITE_ONCE(dev->iommu->device_ser, NULL);
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index caa9778eee2d..2d49885b9fcd 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_IOMMU_LIVEUPDATE_H
 #define _LINUX_IOMMU_LIVEUPDATE_H
 
+#include <linux/device.h>
 #include <linux/iommu.h>
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
@@ -15,8 +16,58 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+/**
+ * dev_iommu_has_preserved_state() - Check if a device has live update state
+ * @dev: Target device
+ *
+ * Unlike dev_iommu_preserved_state() and dev_iommu_restored_state(), this does
+ * not dereference the serialized state, so it is safe to call without holding
+ * a reference on the live update FLB.
+ *
+ * Return: true if @dev has preserved (outgoing) or restored (incoming) state.
+ */
+static inline bool dev_iommu_has_preserved_state(struct device *dev)
+{
+	return dev->iommu && READ_ONCE(dev->iommu->device_ser);
+}
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
+	ser = READ_ONCE(dev->iommu->device_ser);
+	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
+int iommu_preserve_device(struct iommu_domain *domain,
+			  struct device *dev, u64 dma_owner_token);
+void iommu_unpreserve_device(struct device *dev);
+
+/**
+ * iommu_preserved_state() - Get preserved state of an IOMMU instance
+ * @iommu: IOMMU hardware instance
+ *
+ * Return: Pointer to preserved state, or NULL if not preserved.
+ */
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return iommu->iommu_ser;
+}
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -27,6 +78,16 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
 {
 }
 
+static inline bool dev_iommu_has_preserved_state(struct device *dev)
+{
+	return false;
+}
+
+static inline void *dev_iommu_preserved_state(struct device *dev)
+{
+	return NULL;
+}
+
 static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
 {
 	return -EOPNOTSUPP;
@@ -35,5 +96,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
 static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
 {
 }
+
+static inline int iommu_preserve_device(struct iommu_domain *domain,
+					struct device *dev, u64 dma_owner_token)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_device(struct device *dev)
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
index 77f78c88c627..c44f7d1c8498 100644
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
@@ -829,6 +840,7 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @iommu_ser: preserved iommu state of outgoing kernel for liveupdate.
  */
 struct iommu_device {
 	struct list_head list;
@@ -838,6 +850,10 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_hw_ser *iommu_ser;
+#endif
 };
 
 /**
@@ -877,6 +893,8 @@ struct iommu_fault_param {
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
  * @require_direct: device requires IOMMU_RESV_DIRECT regions
  * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
+ * @device_ser: preserved (outgoing) or restored (incoming) liveupdate state
+ *		of this device
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -892,6 +910,9 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_device_ser		*device_ser;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
-- 
2.56.0.506.g506a7eabc5-goog

