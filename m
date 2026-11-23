Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409397;
	b=oICCi9942TWDBwO4afJ90BPS8jA5XO3/CzN+BoGh3CjF3vqCd5O6SdMYWEcgAVjnggiX
	 XSV6iOggTHEsKKwGL/paWoGHxV7JjMSks7sUdp/OYIxHP3MBlVZZy4PW2Ge/8fLjRw9kB
	 yrKJ+MpfVlf9epRVAvWrc3pCntE+8FGKgT398QcPGLJSfohMDTANRHsBhWVyDDw4S5TgA
	 rCdnqRpSy484BOadYFExM4Np/qSmkrfyd3YUcsCTTGNzbsl8Mf/QPleUTYemrsNCiqgVB
	 OUlbT9F7nimBI3qtcXEBpiJb4zGRVhT3hb/8ziWMbP7Sckq4tE+KscULbQ9yT624JGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=1nscTIjzkflfsiEX0Gd2Dm/eGwYDV5E77MwcV56znWU=;
	b=0uxO9Zb9KZ73ov1/p2M/UZMTTw8ff85fvx4ufPNSAzPI6IJ8BsRNUMl40lA0JsaVrjnm
	 Ci51H/RFbWtc1sU1hUikqMtre9lWthTpXGLX7G9M52/3LptbutC0l+TibOKViTrQuL0G/
	 PeeVf57br/fscY0qgV38e+IjxmizE5pkHyWvqRNN3WODPZbhkFy6Z23Kap34ImxILG34B
	 gDoOm9AXfj3sYgDh1CToc4ddnqgZfMP6zDfjW+fZcd+qmYnoNMDlS7PC16WlyFIbP6sbk
	 W3IKXLlVQiLtt78LpZJANnMFezuoOWQ6fHs0zsBEl3c/+bRNqM3vx5x3rvhqo16qjCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J35hG2iw;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692F60A261E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6692F60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J35hG2iw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f0381f07a0so31342425ad.1
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409397; x=1796014197; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nscTIjzkflfsiEX0Gd2Dm/eGwYDV5E77MwcV56znWU=;
        b=J35hG2iwFiyvDwicOwTzlRV7BVwUr0NncZtGcat6hCjkRICawr6oZO+DaiX9GHsRSV
         agM7/UIuapNHM/6cIvgYEOrnR3oZVu2k2xu2rJZdpETrcp0Y5TLYeSJotsXeJ5iDFowK
         x3JOaDgHzLUFiPMmD069yTzGnR06MyrzhPQG8kjtgF6JQAmHdiNM4GWOEJQuN3cJIVer
         I4hY7LLbGMXMuaA3D338ePCnOhlr0dldTOzL3Fo4oW85kUNt6WmeyiSlT61uXsSC/EWz
         4rCoMNIuZ7aDoT58hP2k3CTFguYVvAIagDxTaTV8nzcGtyk2tu0YuZNKLXlhhQVoqMh9
         1HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409397; x=1796014197;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nscTIjzkflfsiEX0Gd2Dm/eGwYDV5E77MwcV56znWU=;
        b=H2rlt1+R/A9YLpbIBQvBqgRFshOGkFHqlxTh3OCSluSpgDC/+RDdv44JgfBksyaxPL
         3hhJ1hs7GFDDekIDetnYO9yiIel94f2u+atbVxMG7o+5w160hXg7+tKQrogSQXdfwsG1
         ucL8AkwqMeAU8SnIfo4Se05uwbuLHaYbj6HWsZ3m2WykF/sLO68Ja6mt1w5VhLW/SdXR
         ahNnH1JmiZtulnZM/LYC90zRRErrDLWQM9Q3bH1xtPthaKvsbe+1QSyOOP7bgG/tzDDs
         9pUQo7j/k6Obyek6w5eMICZoRzv1ixN2WgCGj4lKC7RtJ6Ghib9pANNzeuORhqWddDpO
         Tgmg==
X-Forwarded-Encrypted: i=1; AL+hErFa1ty/8+8aBY9Do+DAInbTu5kwEbYPFj4XWm4btjnoWoTltP0HeLGCBR7EcvWfXatHr18b3Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dRw/1s0mJnGTMkkXTzHXwQnz0HH02QkCrOh+SHcGioCHP4nzo
	88Au+66G4s56hYVS5XkPrbXEAdRWjz1F5eTEUc5d37PKXG7SIwf46csB8fB7ebb5nDINtQNLmXA
	kN5QVtt8zEC7mMg==
X-Received: from plkj2.prod.google.com ([2002:a17:902:6902:b0:2f0:436f:b74f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c40e:b0:2ef:f6dd:8807 with SMTP id d9443c01a7336-2f03f246ddbmr80989265ad.40.1795409396593;
 Sun, 22 Nov 2026 20:49:56 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:37 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-7-skhawaja@google.com>
Subject: [PATCH v8 06/18] iommu: Implement device and IOMMU HW preservation
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
 drivers/iommu/iommu-priv.h       |   3 +
 drivers/iommu/iommu.c            |  58 ++++++++++
 drivers/iommu/liveupdate.c       | 185 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  76 +++++++++++++
 include/linux/iommu.h            |  21 ++++
 5 files changed, 343 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 1f9f886b2c10..9b0b9d37ebea 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -21,6 +21,9 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 void dev_iommu_free(struct device *dev);
 
+int iommu_group_reserve_liveupdate(struct iommu_group *group);
+void iommu_group_unreserve_liveupdate(struct iommu_group *group);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8da858154949..f8837ab1b526 100644
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
@@ -71,6 +72,10 @@ struct iommu_group {
 	 */
 	unsigned int recovery_cnt;
 	void *owner;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* Group is reserved for a device with live update state */
+	bool liveupdate_reserved;
+#endif
 };
 
 struct group_device {
@@ -624,6 +629,19 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static bool iommu_group_liveupdate_reserved(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	return group->liveupdate_reserved;
+}
+#else
+static inline bool iommu_group_liveupdate_reserved(struct iommu_group *group)
+{
+	return false;
+}
+#endif
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	struct iommu_group *group;
@@ -661,6 +679,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
+	if (iommu_group_liveupdate_reserved(group)) {
+		ret = -EBUSY;
+		goto err_free_gdev;
+	}
+
 	/*
 	 * The gdev must be in the list before calling
 	 * iommu_setup_default_domain()
@@ -697,6 +720,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del(&gdev->list);
+err_free_gdev:
 	__iommu_group_free_device(group, gdev);
 err_put_group:
 	iommu_deinit_device(dev);
@@ -3545,6 +3569,40 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+/**
+ * iommu_group_reserve_liveupdate() - Reserve a group for live update
+ * @group: The group.
+ *
+ * No other device can be added to a reserved group.
+ *
+ * Return: 0 on success, -EBUSY if the group is already reserved, or
+ * -EOPNOTSUPP if the group doesn't have exactly one device.
+ */
+int iommu_group_reserve_liveupdate(struct iommu_group *group)
+{
+	guard(mutex)(&group->mutex);
+	if (group->liveupdate_reserved)
+		return -EBUSY;
+
+	if (!list_is_singular(&group->devices))
+		return -EOPNOTSUPP;
+
+	group->liveupdate_reserved = true;
+	return 0;
+}
+
+/**
+ * iommu_group_unreserve_liveupdate() - Drop the live update reservation
+ * @group: The group.
+ */
+void iommu_group_unreserve_liveupdate(struct iommu_group *group)
+{
+	guard(mutex)(&group->mutex);
+	group->liveupdate_reserved = false;
+}
+#endif
+
 static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a98f16d11727..06234f9c604b 100644
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
@@ -358,3 +361,185 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
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
+	ret = iommu_group_reserve_liveupdate(dev->iommu_group);
+	if (ret)
+		return ret;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		goto out_unreserve;
+
+	mutex_lock(&flb_obj->lock);
+	if (!domain->domain_ser) {
+		ret = -EINVAL;
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
+	if (ret) {
+		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+		goto out_unlock;
+	}
+
+	WRITE_ONCE(dev->iommu->device_ser, device_ser);
+
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+out_unreserve:
+	if (ret)
+		iommu_group_unreserve_liveupdate(dev->iommu_group);
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
+	if (WARN_ON(!iommu_device_ser)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
+	WRITE_ONCE(dev->iommu->device_ser, NULL);
+
+	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+	if (!ret)
+		iommu_group_unreserve_liveupdate(dev->iommu_group);
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
2.56.1.809.ga0b61035b5-goog

