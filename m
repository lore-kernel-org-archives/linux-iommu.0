Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894791;
	b=O6E3Rlqqj/H2dG0KagsV4TBcPPW5uGOebHct/7mZctVYQVrTbltYDwjAyvZ1ibikCKhj
	 KyB7XY/14MusmTVcISzoETLcQCC/mvRae6YT69O13PQpVHY7rbsL5X0/ZHtZ4TSqMfh9z
	 YH8tsNtU9Iz300FOqtv87FlY7n1KcY6xcKoqvYvTClYsJnx3+lWLzwBogIZOX5gf8xHb9
	 IiczKAFNhBlIasmoPxCS4FWn1ry4Km1X22ZjFiVZwBO6vCqHk9FgDaA4cqI96Zm+8wso7
	 PJEH+1cnBc3pLZQGuAwJqQjU0IFojJQRk91emeDF3NUvvlTo/o+6RiMKzf4fZdQzxYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=azjzNd21S7LRST9Q8tfME+3K2xaAPb9EecEg7A0cFe0=;
	b=BVOOjnCBgOC65TfjAck1tfiF+m09Ft5dpHhVawshbowMx/dQRRosp0AeNOaJVCZ0zoiF
	 L8vbPoTiU+59wAG5QslEj6ss6H96+BVEz1sGz/fD1fgQg95RyNYL/Cw4B+wnQCfWZLg3D
	 fPfd1ySibyot4KZ3EZuLIqwdArig5cwaiXgr09s/e4ugoEHTdhvWPMx0/w6eumKAwk+gC
	 8HN6JgW0/2pNuq0bnZqScpW91lW6oLph3Er4t1rodA4JWeJTN+yLz5t3VFzgvXHN9cZvW
	 XNrv7ueqnY5NCrK/isCok4U03EvDwVqprkNXzZx9EF+UDxbSBPYn3McmxxzV8+4/SMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oeHOobps;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201A606BF73
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E201A606BF73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oeHOobps
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso1636195a91.1
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894790; x=1793499590; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azjzNd21S7LRST9Q8tfME+3K2xaAPb9EecEg7A0cFe0=;
        b=oeHOobpsAZRMAXsqHuETbjk0OkM0/hZG0qSKEvTbVv3s/GpadSK5z4tjtZ5Tr92ezO
         FeDQd6zlgPv643pQXQZLHZY0mJcKlJMBrl42GnAuTX1jhT/JpC3S2eZDRyZlErGAakGJ
         N+oC7jwTjzdEHttmfv5P2wJzwUkkm+uKbHeH/RrytBJ3HxjnZ9/J9EEX5xixcjhLneLa
         5LhrNwdK7K2B9KR/WoFkDlQ7Thl55+Nr2MJZRaVRkdkRbCKJbbfKguUp3isxivHnrUWi
         +pa9i1BQmDV/9WjRI5N4Acv3ttWdmvp7dhc7EmRkUEvOSotO69VCHIki/k76yCQbXI9M
         STSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894790; x=1793499590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azjzNd21S7LRST9Q8tfME+3K2xaAPb9EecEg7A0cFe0=;
        b=Q4jalHZr0TolUTN73+PiZbHLlAttKVg5JqjgYukwFFIsHW/d+NbvXUTr+iqpAKjKfF
         TeUAMM0Yy1OLLaW9DwVcsyLQ5deiKt3VvgiGsvNk9e9UX2krwb9I3NBro3AJEby0uSjM
         Zni9MDOWse+GVkbK3s+cyzVT4CRhMP3ETZrjDsWBYLJJxX8IkymBc7Paoj0Ixz+EeT7e
         4Xh2t0iYWURZ6mQWkUrKIIgdgHStMoajkfTHWxrBp4W/sg6kMtyuTWCevPEH28cSPIk8
         DEUKi220IT+k9Am+NbuPEKX76UDPA7Y2BnHd2bIG4XBCpPvbuCJlCKo9UbWwAk+JaRvN
         +ISw==
X-Forwarded-Encrypted: i=1; AKwUvBw/Me7ZAY9vKnRp9WEKueDH91U0WiKvgmsv9lovVuyafgsOvBmQMUjJmhfj+YsYGfLnziiSvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIDKSBlrDGPJuXIsByjuk3kBXWJelt8HHbnZK0OH7DP1XgzErHF
	gtMWGawM1kseSj+ef7feQBRXvOi5+IpoGdogUgisvyzqRgxqycg7kKNjVT4wvWo+yC+MD32m0Nl
	kz3DeQMT38vkAdg==
X-Received: from pgla37.prod.google.com ([2002:a63:b65:0:b0:cc9:f7f0:57ef])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5408:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3ade9b2f216mr2862170a91.7.1792894790236;
 Sat, 24 Oct 2026 19:19:50 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:23 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-13-skhawaja@google.com>
Subject: [PATCH v6 12/18] iommu: Restore and reattach preserved domains to devices
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
index a66363789ca9..d40cfe87052e 100644
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
@@ -550,6 +552,10 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	iommu_init_device_preserved_data(dev);
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -614,7 +620,8 @@ static void iommu_deinit_device(struct device *dev)
 	 * Regardless, if a delayed attach never occurred, then the release
 	 * should still avoid touching any hardware configuration either.
 	 */
-	if (!dev->iommu->attach_deferred && ops->release_domain) {
+	if (!dev->iommu->attach_deferred && ops->release_domain &&
+	    !dev_iommu_restored_state(dev)) {
 		struct iommu_domain *release_domain = ops->release_domain;
 
 		/*
@@ -704,7 +711,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	for_each_group_device(group, gdev2) {
-		if (dev_iommu_has_preserved_state(gdev2->dev)) {
+		if (dev_iommu_has_preserved_state(gdev2->dev) ||
+		    dev_iommu_has_preserved_state(dev)) {
 			ret = -EBUSY;
 			goto err_free_gdev;
 		}
@@ -774,6 +782,27 @@ int iommu_probe_device(struct device *dev)
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
@@ -785,13 +814,16 @@ static void __iommu_group_free_device(struct iommu_group *group,
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
@@ -804,6 +836,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	struct group_device *device;
 
 	mutex_lock(&group->mutex);
+	__iommu_group_remove_restored_device(group, dev);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
 			continue;
@@ -3185,6 +3218,59 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
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
@@ -3201,9 +3287,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct iommu_domain *old_dom = group->default_domain;
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	struct device *dev;
 	bool direct_failed;
 	int req_type;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&group->mutex);
 
@@ -3243,6 +3330,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
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
@@ -4112,6 +4207,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return 0;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
@@ -4223,6 +4321,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
 
+	if (dev_iommu_restored_state(&pdev->dev))
+		return;
+
 	guard(mutex)(&group->mutex);
 
 	gdev = __dev_to_gdev(&pdev->dev);
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index eace110322ec..428c8dcdd497 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -635,3 +635,109 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
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
+EXPORT_SYMBOL(iommu_init_device_preserved_data);
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
index 10fcdd41c7a1..5ac85c9739f3 100644
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
 int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
 				    void *arg);
+void iommu_init_device_preserved_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
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
2.56.0.257.gf7497c7d27-goog

