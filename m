Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810D2E7373
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951734; cv=none; b=VfXgUWjElOtcp1rSBslYcY0lMmFGkzE/Z+a1l6hFhT169gZYRyAAfPopOZSTaFkzxXdd4M+YsRBGlGLRiyxQmTPH7lAXMrxkN8z3XXPeHPpv15RFhKfiK/l08btodH4HN8E2XbGj/pgL1LGjbJEd52UtjGGXr3dLjHga+CINgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951734; c=relaxed/simple;
	bh=gwAv+wRVw3t/fG51U9Ec6hw3eDnLX/9UJyVoiPX5g7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nU9LsvwOnzXTuYh7OUlis0CKfijiMEuKlL/sh8Wq5XnKGW4I86yPFsgHYtm/xcmrJroz051ABGlqnvNgpD6TeIrVP5GGmt7oKyyuj21K0q4cjd9imUhYeqVSF7Ep+chzzuiz6bsrTXlCGgy4YNFpq4SDvhBPnUTFOusb/9m/lPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IR0vYEES; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR0vYEES"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db87f759c5so50275175ad.1
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951730; x=1790556530; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vboebmTOKLm+aioJh8qWJMYwNYCO/nAezbpt/kP9hZc=;
        b=IR0vYEESEcovPvkylLmimVpUotUnvV7EDxs6JIhnVv2qjyUDIhXEWlSgBTT+/TrZFZ
         XgFQoe/QCiVL9Kl73FefeELYlXjnVSLU1jwj3no1sxdkVyr4ES/uPaR2R455FCTGMTLx
         xEkEmOQmVGMm70fcrz/oNLP1ZV9uAnPs4whOcmOQHZ5DH7WhJ7JZ1WVYKZN6S8NKnDjb
         comcjY543ffbkx3KB3KzOLHuBLA3gwq9OmPoAAnGJQ2CRX5tJTD2D/0NM0ZKhf9VldWy
         1X76FPmZ6+jAbqRvTFMw1IJ143rnAYUSnL7yH07a3mQrwmPJIGhAya1xeRYIMey39VXJ
         TAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951730; x=1790556530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vboebmTOKLm+aioJh8qWJMYwNYCO/nAezbpt/kP9hZc=;
        b=h20VshJA+sfMpXkwBU8OhuCL6JnVuY+04CN7VZrj11SwWSqH/5dta0Mvcv3LVjux3Q
         QKhD2YcKLrqmOgki9uJ7HiosmKXPKZDTcEvjGx7c+wDvTgW1NaOXNK+tPSSzHw0Dx6zX
         /As8hJjKPkBo8/pGGa7N4j+5M4HrVD+YS+i+dl9Jva5uamvnOxssY9pVurltu3hGIORN
         cdH537o1pveZOftfxYL0i8hUPIwAuMLMXpzNeSM32ElEruoxfm7ghTF5KniRiJjz4LHF
         7Jwhz8L8y4zsvueEwXN7kpBmnEjvHoOHp4TTTj/yIscJ/EFiJUT4Lm4jOmC3sWmlrTf5
         zRWA==
X-Forwarded-Encrypted: i=1; AKwUvByvNLDB0cvPzx1/wBCGQ4xVXyQ55PGC146aY+EXa/sHj8umEwstmfXqKvOX/wnb3QKJZ0weFQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k4nDlyz0FEf6QBtMgZqXzy++KaIyyUmXbxgIMXKRf0kyEbHuxi
	E/JyoJDOalim6xYpLxrplge1SlYP7FAHGtpIvOyMBFy/1VzZ0FoFbiR7+I9eTBSFhpcTENtjKAx
	OOUfszHUZ8Tr21A==
X-Received: from plly11.prod.google.com ([2002:a17:902:7c8b:b0:2dd:c0fa:93f7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fa5:b0:2dd:c100:b2c1 with SMTP id d9443c01a7336-2ddc100b33bmr78386365ad.44.1789951729909;
 Sun, 20 Sep 2026 17:48:49 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:27 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-12-skhawaja@google.com>
Subject: [PATCH v5 11/18] iommu: Restore and reattach preserved domains to devices
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

During default domain setup, restore the preserved domains by restoring
the page tables using restore() iommupt op. Associated the restored
domain with the iommu group of the preserved device, and reattach the
domain to the device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c            | 116 +++++++++++++++++++++++++++++--
 drivers/iommu/liveupdate.c       | 116 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  64 +++++++++++++++++
 3 files changed, 290 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9c1ad8de3ad7..cca1eb332a43 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -158,6 +158,7 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 	WARN_ON(__iommu_group_set_domain_internal(
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
 
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
@@ -540,6 +541,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_preserved_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -604,7 +609,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain) {
+	if (!dev->iommu->attach_deferred && ops->release_domain &&
+	    !dev_iommu_restored_state(dev)) {
 		struct iommu_domain *release_domain = ops->release_domain;
 
 		/*
@@ -694,7 +700,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	for_each_group_device(group, gdev2) {
-		if (dev_iommu_preserved_state(gdev2->dev)) {
+		if (dev_iommu_preserved_state(gdev2->dev) ||
+		    dev_iommu_restored_state(gdev2->dev)) {
 			ret = -EBUSY;
 			goto err_free_gdev;
 		}
@@ -764,6 +771,27 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+static void __iommu_group_remove_restored_device(struct iommu_group *group,
+						 struct device *dev)
+{
+	struct iommu_device_ser *device_ser;
+
+	lockdep_assert_held(&group->mutex);
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return;
+
+	if (!group->owner_cnt || group->owner != device_ser)
+		return;
+
+	if (group->owner_cnt > 1) {
+		group->owner_cnt--;
+	} else {
+		group->owner_cnt = 0;
+		group->owner = NULL;
+	}
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -775,13 +803,15 @@ static void __iommu_group_free_device(struct iommu_group *group,
 	trace_remove_device_from_group(group->id, dev);
 
 	/*
-	 * If the group has become empty then ownership must have been
-	 * released, and the current domain must be set back to NULL or
-	 * the default domain.
+	 * If the group has become empty then ownership must have been released,
+	 * and the current domain must be set back to NULL or the default
+	 * domain. A restored domain remains attached to the restored device on
+	 * removal.
 	 */
 	if (list_empty(&group->devices))
 		WARN_ON(group->owner_cnt ||
-			group->domain != group->default_domain);
+			(group->domain != group->default_domain &&
+			 !iommu_domain_restored_state(group->domain)));
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
@@ -794,6 +824,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct group_device *device;
 
 	mutex_lock(&group->mutex);
+	__iommu_group_remove_restored_device(group, dev);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
@@ -2211,6 +2242,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
@@ -3175,6 +3207,62 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct device *__iommu_group_restored_device(struct iommu_group *group)
+{
+	struct group_device *gdev;
+
+	lockdep_assert_held(&group->mutex);
+	for_each_group_device(group, gdev) {
+		if (!dev_is_pci(gdev->dev))
+			continue;
+
+		if (dev_iommu_restored_state(gdev->dev))
+			return gdev->dev;
+	}
+
+	return NULL;
+}
+
+static int __iommu_group_restore_domain(struct iommu_group *group)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	struct device *dev;
+	void *owner;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+	if (group->domain)
+		return -EBUSY;
+
+	dev = __iommu_group_restored_device(group);
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return -ENOENT;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	domain = iommu_restore_domain(dev, device_ser, &owner);
+	if (WARN_ON(IS_ERR(domain)))
+		return PTR_ERR(domain);
+
+	/* The restored domain is attached with the restored device. */
+	ret = __iommu_group_set_domain(group, domain);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 */
+	WARN_ON(group->owner);
+	group->owner = owner;
+	group->owner_cnt = 1;
+	return ret;
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3233,6 +3321,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
+
+	/* Preserved devices need to be attached to the restore domain */
+	if (__iommu_group_restored_device(group)) {
+		ret = __iommu_group_restore_domain(group);
+		if (ret)
+			goto err_restore_def_domain;
+
+		goto out_free_old;
+	}
+
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
@@ -4102,6 +4200,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return 0;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
@@ -4213,6 +4314,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index ff76a23d9583..4fa12b4efea5 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -716,3 +716,119 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 	liveupdate_flb_put_outgoing(&iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
+
+static inline bool match_device_ser(struct iommu_device_ser *match,
+				    struct pci_dev *pdev)
+{
+	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
+}
+
+/**
+ * iommu_init_device_preserved_data() - Initialize preserved state for device
+ * @dev: Target device
+ *
+ * Looks up incoming Live Update state for @dev and attaches it to the device if
+ * found.
+ */
+void iommu_init_device_preserved_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser = NULL;
+	struct iommu_device_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_arr(array) {
+		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+			if (match_device_ser(device_ser, to_pci_dev(dev))) {
+				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+				goto out;
+			}
+		}
+	}
+
+	device_ser = NULL;
+out:
+	WRITE_ONCE(dev->iommu->device_ser, device_ser);
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+}
+EXPORT_SYMBOL(iommu_init_device_preserved_data);
+
+/**
+ * iommu_restore_domain() - Restore a preserved domain for a device
+ * @dev: Target device
+ * @ser: Serialized device state
+ * @owner: Pointer to store group owner handle
+ *
+ * Restores or reuses a restored preserved domain for @dev from serialized state
+ * @ser.
+ *
+ * Return: Restored iommu_domain pointer, or ERR_PTR.
+ */
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser,
+					  void **owner)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct iommu_domain *domain;
+	struct pt_iommu *pt;
+	int ret;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&flb_obj->lock);
+
+	/* Preserved device should have a preserved domain */
+	if (!ser->domain_iommu_ser.domain_phys) {
+		domain = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
+	if (domain_ser->restored_domain) {
+		*owner = ser;
+		domain = domain_ser->restored_domain;
+		goto out;
+	}
+
+	domain_ser->hdr.flags |=  IOMMU_SER_FLAG_INCOMING;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		goto out;
+
+	pt = iommupt_from_domain(domain);
+	if (!pt) {
+		iommu_domain_free(domain);
+		domain = ERR_PTR(-EOPNOTSUPP);
+		goto out;
+	}
+
+	ret = pt->ops->restore(pt, domain_ser);
+	if (ret) {
+		iommu_domain_free(domain);
+		domain = ERR_PTR(ret);
+		goto out;
+	}
+
+	/* The device is owned by the preserved state. */
+	*owner = ser;
+	domain->preserved_state = domain_ser;
+	domain_ser->restored_domain = domain;
+
+out:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 06f66cc8f526..3ff537ae081d 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -64,8 +64,51 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
+/**
+ * dev_iommu_restored_state() - Get restored state of a device
+ * @dev: Target device
+ *
+ * Return: Restored state pointer or NULL.
+ */
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	struct iommu_device_ser *ser;
+
+	if (!dev->iommu)
+		return NULL;
+
+	ser = READ_ONCE(dev->iommu->device_ser);
+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
+		return ser;
+
+	return NULL;
+}
+
+/**
+ * dev_iommu_restore_did() - Get restored domain ID for a device
+ * @dev: Target device
+ * @domain: Target domain
+ *
+ * Fetches the domain ID preserved for @dev and @domain across Live Update.
+ *
+ * Return: Domain ID or -1 on error.
+ */
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (ser && iommu_domain_restored_state(domain))
+		return ser->domain_iommu_ser.attachment_id;
+
+	return -1;
+}
+
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser,
+					  void **owner);
 int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
 				    void *arg);
+void iommu_init_device_preserved_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -98,16 +141,37 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
+static inline void *dev_iommu_restored_state(struct device *dev)
+{
+	return NULL;
+}
+
+static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
+{
+	return -1;
+}
+
 static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 {
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
+							struct iommu_device_ser *ser,
+							void **owner)
+{
+	return NULL;
+}
+
 static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void iommu_init_device_preserved_data(struct device *dev)
+{
+}
+
 static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
-- 
2.55.0.1082.g2b9226bbc0-goog

