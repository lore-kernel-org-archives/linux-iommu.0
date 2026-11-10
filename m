Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283726;
	b=vYwTsLZuJCxvTfaazX0SXkS55KH2sVb7OyeDUKdOt3YButpAx9EWawV0pm13gWelVHLo
	 fVnek5doiLDF4TBcjDO5FzkeQqE71xvLGXSPaFtcFxiltk5MmJSQKNPVUWKvIFF103uKr
	 xwq1/bbz2RkcFLR9SX+U2ipw2TU/MzjdXE1vchTHLp9Q/jYR8FM1/xWtwkWN61w7Uwo5I
	 THKtm07hrpIhvF49651jNmZVFHlp4Kpagc39XpjAeq/vFQhZaXDj4WrG0bBJLEZiFFkB0
	 ub9Rf8o5sDmsoJYgKC99vWTsjWzFBvx8+UV/l4TkPLFlvukvS1mR6vx0CjnpgYgeHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Il8WJWuvsu7zp9BAjSSQ45XlFrgh6Gbstt4YJWl5dik=;
	b=rx/QPtzPcNWoXfPWcnqJ0B3ppVBiKiAOYX9YO/4MHe9dICIsjXURto1PZB6TLEbAcSYP
	 iN8q8VI32BtnRLvhzxUIg2v7ElEWH9e2F2ZpqHXOMu1fiXtvKUPu0z/aRrakPJinRLwHM
	 xEUjIoZZdkHESiaQhW1aLPVAdawlYWOeZP1E4zoWEHm9izS/C8VfF5D1TnX/xMO44uTPA
	 gPIAK3AdE5v1QY+sva55GDvebeoek81CJmCQLwcq8QS7XsWdHBQbaOkWeFw0SmUg7Ql7V
	 V21r4J97va7q/Jtv89iuaVgAbPKUeiuD0hLBmgaN3AlbZI09V3UzsFUatMWcfkmSAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FBwkDmgW;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BA606CF35
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4BA606CF35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FBwkDmgW
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1751234a12.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283725; x=1794888525; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Il8WJWuvsu7zp9BAjSSQ45XlFrgh6Gbstt4YJWl5dik=;
        b=FBwkDmgWuX/9wNXDwVrDy5R651/iUpEbQfkK7fDyji6O1tjLpR9gxrsTwF3Hz8lCxD
         uifzbPPCYzQ7uQzNAnkZ1Ref7GsLHfbQD1tq8X4O6E9lPcuaZlHNeU28p0zcyw7HnW6X
         7FDcjX6wZxy6uZr0HXkPwUk6dwe0tJZrCK3i+Hi4+B4RUODsCtAnbaDfB07zwsv+e97r
         xzNENY369HvK2nDqtWvDt24uUbJO2mOdfCsrZp9kinA/VJsBi7qC6KYbwTjL+4v5OLpr
         Pw2Fd3MjifmVRMDsjntf+FyTMQkhUDpssngieOp5OJbOkKVyWm0xRje43JYQfD/26tmY
         eaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283725; x=1794888525;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Il8WJWuvsu7zp9BAjSSQ45XlFrgh6Gbstt4YJWl5dik=;
        b=sPDUxKz64bgV28fFCxZcPaNgpav3E+Sa6elPRHQBgvrvlTELRxphzIgrprbJCwipaI
         1JoOE4rtdgwCbKN1lqP9kuukkKUWPSuyEe9Kg9kaFphacfekdFsHYTUfQZwbfYe3QSsM
         UodAq8/53mAwZbIKuCq6Y+2f1oZGtBhjd1dEBVeqCphja6cd272XFQtVqcnX1PbBTrVc
         dDfyCog9b2mUj9kE3Ks3YQ4yL8vH2WiDu0tOTI4ihHHPCM4sJUFuATn3iYj5NzUE3w99
         DY7xyQ9riJF2gq6jlWG1qC91J6xyzNHuUDkToXcqveeSRZK7Uj+x4/1z7NrLUBRNpcEr
         RFxQ==
X-Forwarded-Encrypted: i=1; AL+hErEH2GCbRViByd0MM350t41G/JOgSOX4vjfMxyPQxvfxGEwaaViC9wYLT3ilQf0gX/I5LaQRMw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8cM3ysbtvW8Wbyz0tKUw6eMJ2ipM45wq1Tc9dn7RPMmDLWV3HY
	MMNbGw9bLPR6ihjYoMgG2/IxJoNZO4vEnw1f5DvUt7nb48UH+XAt5BJBxQeGCEKLfcu2xoQQ8vK
	BbdltPmsmUz1fKw==
X-Received: from pgbcr10.prod.google.com ([2002:a05:6a02:410a:b0:cc7:52da:b682])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2589:b0:3e1:180b:402b with SMTP id adf61e73a8af0-3f18f0ba78dmr1337613637.39.1794283724960;
 Mon, 09 Nov 2026 20:08:44 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:18 +0000
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
Message-ID: <20261110040828.1774343-13-skhawaja@google.com>
Subject: [PATCH v7 12/18] iommu: Restore and reattach preserved domains to devices
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

During default domain setup, restore the preserved domains by restoring
the page tables using restore() iommupt op. Associated the restored
domain with the iommu group of the preserved device, and reattach the
domain to the device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c            | 115 +++++++++++++++++++++++++++++--
 drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  39 +++++++++++
 3 files changed, 253 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 932325e0af41..c2b8ab177850 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -159,6 +159,8 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
+
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
 static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
@@ -509,6 +511,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_restored_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -573,7 +579,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain) {
+	if (!dev->iommu->attach_deferred && ops->release_domain &&
+	    !dev_iommu_restored_state(dev)) {
 		struct iommu_domain *release_domain = ops->release_domain;
 
 		/*
@@ -663,7 +670,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	for_each_group_device(group, gdev2) {
-		if (dev_iommu_has_preserved_state(gdev2->dev)) {
+		if (dev_iommu_has_preserved_state(gdev2->dev) ||
+		    dev_iommu_has_preserved_state(dev)) {
 			ret = -EBUSY;
 			goto err_free_gdev;
 		}
@@ -733,6 +741,27 @@ int iommu_probe_device(struct device *dev)
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
@@ -744,13 +773,16 @@ static void __iommu_group_free_device(struct iommu_group *group,
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
+			(group->domain &&
+			 group->domain != group->default_domain &&
+			 !iommu_domain_restored_state(group->domain)));
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
@@ -763,6 +795,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct group_device *device;
 
 	mutex_lock(&group->mutex);
+	__iommu_group_remove_restored_device(group, dev);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
@@ -3144,6 +3177,59 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct device *__iommu_group_restored_device(struct iommu_group *group)
+{
+	struct device *dev = iommu_group_first_dev(group);
+
+	if (dev_is_pci(dev) && dev_iommu_restored_state(dev))
+		return dev;
+
+	return NULL;
+}
+
+static int __iommu_device_restore_domain(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+	if (group->domain)
+		return -EBUSY;
+
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return -ENOENT;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 * Claim ownership before restoring the domain so that even if domain
+	 * restoration fails, no driver can bind to the device using
+	 * default_domain.
+	 */
+	WARN_ON(group->owner);
+	group->owner = device_ser;
+	group->owner_cnt = 1;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	/*
+	 * If attaching the restored domain fails below, the domain is not
+	 * leaked; it remains cached in domain_ser->restored_domain and will be
+	 * reused if the device is rescanned.
+	 */
+	domain = iommu_restore_domain(dev, device_ser);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	/* The restored domain is attached with the restored device. */
+	return __iommu_group_set_domain(group, domain);
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3160,9 +3246,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	struct device *dev;
 	bool direct_failed;
 	int req_type;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&group->mutex);
 
@@ -3202,6 +3289,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
+
+	/* Preserved devices need to be attached to the restore domain */
+	dev = __iommu_group_restored_device(group);
+	if (dev) {
+		WARN_ON(__iommu_device_restore_domain(dev));
+		goto out_free_old;
+	}
+
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
@@ -4072,6 +4167,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return 0;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
@@ -4183,6 +4281,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 6b88c1540658..488a8379db9b 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -637,3 +637,109 @@ void iommu_unpreserve_device(struct device *dev)
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
+ * iommu_init_device_restored_data() - Initialize restored state for device
+ * @dev: Target device
+ *
+ * Looks up incoming Live Update state for @dev and attaches it to the device if
+ * found.
+ */
+void iommu_init_device_restored_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_flb_obj *flb_obj;
+	struct kho_block_set_it it;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
+	if (ret)
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	iommu_ser_set_for_each(&flb_obj->device_set, it, device_ser) {
+		if (match_device_ser(device_ser, to_pci_dev(dev))) {
+			device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+			WRITE_ONCE(dev->iommu->device_ser, device_ser);
+			break;
+		}
+	}
+
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_init_device_restored_data);
+
+/**
+ * iommu_restore_domain() - Restore a preserved domain for a device
+ * @dev: Target device
+ * @ser: Serialized device state
+ *
+ * Restores or reuses a restored preserved domain for @dev from serialized state
+ * @ser.
+ *
+ * Return: Restored iommu_domain pointer, or ERR_PTR.
+ */
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser)
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
+	if (!ser->attachment.domain_phys) {
+		domain = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	domain_ser = phys_to_virt(ser->attachment.domain_phys);
+	if (domain_ser->restored_domain) {
+		domain = domain_ser->restored_domain;
+		goto out;
+	}
+
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
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
+	domain->domain_ser = domain_ser;
+	domain_ser->restored_domain = domain;
+
+out:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index fb1e8efac8ec..68c7ebca25f6 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -99,8 +99,31 @@ static inline void *dev_iommu_restored_state(struct device *dev)
 	return NULL;
 }
 
+/**
+ * dev_iommu_restored_attachment_id() - Get restored attachment ID for a device
+ * @dev: Target device
+ * @domain: Target domain
+ *
+ * Fetches the attachment ID preserved for @dev and @domain across Live Update.
+ *
+ * Return: Attachment ID or -1 on error.
+ */
+static inline int dev_iommu_restored_attachment_id(struct device *dev,
+						   struct iommu_domain *domain)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (ser && iommu_domain_restored_state(domain))
+		return ser->attachment.attachment_id;
+
+	return -1;
+}
+
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser);
 int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn,
 				   void *arg);
+void iommu_init_device_restored_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -143,16 +166,32 @@ static inline void *dev_iommu_restored_state(struct device *dev)
 	return NULL;
 }
 
+static inline int dev_iommu_restored_attachment_id(struct device *dev,
+						   struct iommu_domain *domain)
+{
+	return -1;
+}
+
 static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 {
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
+							struct iommu_device_ser *ser)
+{
+	return NULL;
+}
+
 static inline int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn, void *arg)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline void iommu_init_device_restored_data(struct device *dev)
+{
+}
+
 static inline struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
-- 
2.56.0.506.g506a7eabc5-goog

