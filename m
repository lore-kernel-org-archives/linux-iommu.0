Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409404;
	b=JtdQVf1CKbbYmiCtayCNb/TZToSGL9csafQibVkVoOtra2yGMvZSJ36Xk1euQdjdJxfE
	 gi8r2/fBfi5tTSQTOYbLtSDLy3hv/cb1FHyfWHe+WYIaRS7jM8xiNpMTw9dtcn0V+RE62
	 +RGqC2L7M8ZTRlifwwWpNOGTtw+JCIiwMnUe8BpRh69AX+tg7GO1nGMhFhQUfjDfYkQxa
	 1SMdFTHjpdPyB4k79SgrMhz4aRqLQvpyWpKsrCLvOhzCyWPfrqWoaKlUAHN/vM98rV5KD
	 dtaGn5BAaW2IhqxBA7rnCwqus27Va2uOY/nzb2KYw7+dFVIsq1P5FQ5u7VwDsS3t2bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
	b=VggUpizqaAmwEMGzALuzm/FhoXzKM5Gp+FFYltoIab3PvxNmkySwU9J/09eikZ5lvpAj
	 C6I2/cVLEMEJrrv71pAX2/XBYN/7PoY8kqfj9A7uHCxr/IUStCe16V0ypnJZN0saEgj+w
	 +TtJFE8u/yl1vu2VhSTcqjzjQVw0q3JCPZeh/rv91ul5Aq9b2WkeEyCKE06bGQC9Sg9f5
	 fs/Tme++2Hfxs8tN7+kRFOiSMBfgM/AaerLql752eBglP6DPpBPV96x67/KuuSuFLIuHL
	 UqyuILvH92parldDjeOSmDeOVApw60TuQZ1UfaFDtQafIAt7Ybvx0vxI/paBhWRZJJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WvX6+s4Z;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DE60A6F4B
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739DE60A6F4B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WvX6+s4Z
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so3582416a91.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409403; x=1796014203; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
        b=WvX6+s4ZF+Cf6594SIslUBKPGWPlT9N1Xo6nIBMKra5pGT7g9kakHixOHQx/UZPPDm
         6XLh4Kpl+8zSHitFLKobyr6b7q1rXJrwIg0US78UnojYL5aW/SFXCjw4c5kUrH0vgWpl
         AucY1Y/3zdHOHTLBC5cVXjGNEvXNjK95vFRwL9bwPFiXWI0mVULLZgNj7dgwm7XCABxm
         jJaYWSDNMHM8Rc9/1Es0Hm2DrYq3hK1KP3lkbgN94qq7UJWQAlL6zsWfiE4eRgnG6Aeu
         7rlXTYZHSvV5LTK1ucCBo4px+hgk3jrjZcYSqQ9+rFedaAWv6XpthiZamO6m1WFal24u
         Om9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409403; x=1796014203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrWN2KLbXY+MmIuqHS0oLS7GsgkDZp6/iC325lkJYKI=;
        b=wdLX3qpDtGRXjCGR4jVmlDh4Qcot60vr5mvenY4GsRcN+Xqe338sjhYOJvPoHOznnP
         Z813kghMiY8XPFNoLON0+nNt2xkt/yMhvtVLQ52m2Ee/v7+bXwEOWcs/iF3+etlMwdAF
         hteddhfG4IC4+jiZP4jQwzWR3SSlBOMT0Kj4oO0Mp3/+DtHnSigPjUNojRIzfi0nWYQM
         FylIyaYZYReuvFd9JJufC10r1FB/ZIZ9IJmSe6kd3V5yyxCa1FGZku/DQosnUiHX91cU
         Xmd/iaAPECD6I5HozfIJug+5peknRKC8PRPlYrcyHPvomtHydbnhLzbLPrTcf0xeR4C0
         yxQQ==
X-Forwarded-Encrypted: i=1; AL+hErGeAER2MSpXQO8nwUa91ITalFDSxcv16PD6UD789Ex91Ngdyu4CkEyaBe2m32Cw8T7ekTf7dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+oSz7gk4TUK/RfQJdNwmbdbiHOt8ESzo6+dJ46kFdiabg6R/6q
	h1NPkNMDSwNZQIVPDEIei72jtI5Ewsn4RdEdhXOjih/ZkK/PpWOmGnrM2ye/kkiq/xz934IB1oV
	aGdqA8xCCCWk4VQ==
X-Received: from pjbnd6.prod.google.com ([2002:a17:90b:4cc6:b0:3b4:50ed:c55e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b84:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b41c97c897mr10158123a91.66.1795409402607;
 Sun, 22 Nov 2026 20:50:02 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:44 +0000
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
Message-ID: <20261123044949.3610702-14-skhawaja@google.com>
Subject: [PATCH v8 13/18] iommu: Restore and reattach preserved domains to devices
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
 drivers/iommu/iommu.c            | 164 ++++++++++++++++++++++++++++---
 drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  13 +++
 3 files changed, 268 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f8837ab1b526..c60af471ec32 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -163,6 +163,8 @@ static void __iommu_group_set_domain_nofail(struct iommu_group *group,
 		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
 }
 
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
+
 static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type);
 static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
@@ -513,6 +515,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_restored_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -577,7 +583,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain) {
+	if (!dev->iommu->attach_deferred && ops->release_domain &&
+	    !dev_iommu_restored_state(dev)) {
 		struct iommu_domain *release_domain = ops->release_domain;
 
 		/*
@@ -635,11 +642,39 @@ static bool iommu_group_liveupdate_reserved(struct iommu_group *group)
 	lockdep_assert_held(&group->mutex);
 	return group->liveupdate_reserved;
 }
+
+static int __iommu_group_reserve_liveupdate(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
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
+static void __iommu_group_unreserve_liveupdate(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	group->liveupdate_reserved = false;
+}
 #else
 static inline bool iommu_group_liveupdate_reserved(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int __iommu_group_reserve_liveupdate(struct iommu_group *group)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void __iommu_group_unreserve_liveupdate(struct iommu_group *group)
+{
+}
 #endif
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
@@ -748,6 +783,29 @@ int iommu_probe_device(struct device *dev)
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
+	__iommu_group_unreserve_liveupdate(group);
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
@@ -759,13 +817,16 @@ static void __iommu_group_free_device(struct iommu_group *group,
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
@@ -778,6 +839,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct group_device *device;
 
 	mutex_lock(&group->mutex);
+	__iommu_group_remove_restored_device(group, dev);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
@@ -3161,6 +3223,66 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct device *__iommu_group_restored_device(struct iommu_group *group)
+{
+	struct group_device *gdev;
+
+	for_each_group_device(group, gdev) {
+		if (dev_is_pci(gdev->dev) && dev_iommu_restored_state(gdev->dev))
+			return gdev->dev;
+	}
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
+	 * Claim ownership first so that even if the reservation or the domain
+	 * restoration fails, no driver can bind to the device using
+	 * default_domain.
+	 */
+	WARN_ON(group->owner);
+	group->owner = device_ser;
+	group->owner_cnt = 1;
+
+	/* A restored device must be the only device in its group */
+	ret = __iommu_group_reserve_liveupdate(group);
+	if (ret)
+		return ret;
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
@@ -3177,9 +3299,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	struct device *dev;
 	bool direct_failed;
 	int req_type;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&group->mutex);
 
@@ -3219,6 +3342,18 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
+
+	/*
+	 * Preserved devices need to be attached to the restored domain. If the
+	 * restore fails, the group stays owned, so the default_domain is never
+	 * attached or used.
+	 */
+	dev = __iommu_group_restored_device(group);
+	if (dev) {
+		WARN_ON(__iommu_device_restore_domain(dev));
+		goto out_free_old;
+	}
+
 	if (!group->domain) {
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
@@ -3582,14 +3717,7 @@ EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 int iommu_group_reserve_liveupdate(struct iommu_group *group)
 {
 	guard(mutex)(&group->mutex);
-	if (group->liveupdate_reserved)
-		return -EBUSY;
-
-	if (!list_is_singular(&group->devices))
-		return -EOPNOTSUPP;
-
-	group->liveupdate_reserved = true;
-	return 0;
+	return __iommu_group_reserve_liveupdate(group);
 }
 
 /**
@@ -3599,7 +3727,7 @@ int iommu_group_reserve_liveupdate(struct iommu_group *group)
 void iommu_group_unreserve_liveupdate(struct iommu_group *group)
 {
 	guard(mutex)(&group->mutex);
-	group->liveupdate_reserved = false;
+	__iommu_group_unreserve_liveupdate(group);
 }
 #endif
 
@@ -4102,6 +4230,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return 0;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
@@ -4213,6 +4344,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 2c5da375f07f..6516152a1d3c 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -631,3 +631,109 @@ void iommu_unpreserve_device(struct device *dev)
 		iommu_group_unreserve_liveupdate(dev->iommu_group);
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
index fb1e8efac8ec..04dfee566b67 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -99,8 +99,11 @@ static inline void *dev_iommu_restored_state(struct device *dev)
 	return NULL;
 }
 
+struct iommu_domain *iommu_restore_domain(struct device *dev,
+					  struct iommu_device_ser *ser);
 int iommu_for_each_restored_device(iommu_restored_device_iter_fn fn,
 				   void *arg);
+void iommu_init_device_restored_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_restored_state(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -148,11 +151,21 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
+							struct iommu_device_ser *ser)
+{
+	return ERR_PTR(-EOPNOTSUPP);
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
2.56.1.809.ga0b61035b5-goog

