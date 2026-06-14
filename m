Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C8385D67
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480261; cv=none; b=nZJ5cB7PBmUEm3x43Lx2yhVyv/tMLprnSC7HznCqz6XG1fO8qpgk7U5IFZXtLK/MuWBiEQy+12u6tlTO8CjN1itR893qxVrEx/0Zcgdk3wxCmEFZV/1czqRPwnym9/qliLkyaHTkd+qcjh9t9vBnkDE8vV+qt/HYttOXEQV/bUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480261; c=relaxed/simple;
	bh=gJcCWuSa2tPgXxQm52WqQaf0NsMtzV5lBuq1/jQnXAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prxySfv40xo+W2PBmDV7SmhdxY7PSGVXG433ML9Su7gibtdGliN12FZ6HxUcRBBjuIiavYX5KW7fXEwig5GrEr1pbJcKwyVhqR8q3CG5OSr2H28aqX9v9EJN++4JEwDGG4ckxpTm+4b+Kogd3raMGHn8eY/20HOR1Al3Mj32Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcPZDIOE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcPZDIOE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso4988397a91.2
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480259; x=1782085059; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTbSdIBLoQ3ymz5Oo8C6SttlitRISpaU0y1we7JmTLI=;
        b=LcPZDIOEXd3+Su5ITVIfYAiOCLYzw5abAJ8ee7rHKg2YGF9BMrBX1Bw+Rlr6OAdnuL
         wHHkOr4h8J0CUSCrOtTo5Pg15nqM83g2AEw6UiPhhPA/emRebDhJjrWFioH8igz2A40B
         gWxyIZkm/vBhPDHOcubpTcKKUrYBJXHFx7J1CjbCAS+94kJE62xPYvwYiTpqy2NRCrOE
         0dDGaxnb8+HQeD3/+Yf6XWi7a/MoykXvhfuQpyfHP9EVciD+00B+Gj3b/dC8P2eJy8kB
         BSmkWq9SkJcH51fpM65uLBIq/mq/yeQy0jDZXm9ClPgA+USd0eo48KTGjVw1r5+g4rcD
         VkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480259; x=1782085059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTbSdIBLoQ3ymz5Oo8C6SttlitRISpaU0y1we7JmTLI=;
        b=CmztmSAnMfLeLoqa4jIudsTxKW9mnqz84fYEZnpAoJOsuFjwwdIZxchzR/Aa023fBd
         NB+ba1fSq3A6cpJZgz9Gpi9DHmInLehiSW6eQwIGeYM3TRy2LpM7D0bP1OSVCIuBaNPl
         yNHArCcHf70TG+xl1eVLVF5x0yM3diYB96GCBM+34Nm8bJXFCtPQwWEZP7mpow8q4H/M
         ZyLBL79ClKF7Q2OjwkDAlYpvSEJnA1Of8P2cP8GvfWpl2Uk6Y4emIedtXweL+9gdhDIO
         5o9FvHFQR2qPAo/fr1LPK1VUJygc3MH0fqGEpr5v3Q0VldlN584YqhiOhfiXCHAs/3Ij
         FVXA==
X-Forwarded-Encrypted: i=1; AFNElJ9LVQ2GSwpAGF7x/Odet8ghAfwfFmzH4TDX8kFZl8hcp3oW34xlsq3XilBIp1saOXlkj9dwYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycIm7oZmzq2frUPlB9/TIsFkaFdQs38UfQCUiGQmIM3TzsHG/8
	vcAekyFor48ghZkuivqe6ykZX25J3lbeUtKLc+d8ka0s7MKdygInHoa5vu5jEm8V2ZLACV331DY
	Ec2AWS+uxc6XDFA==
X-Received: from plblv16.prod.google.com ([2002:a17:903:2a90:b0:2c0:bd65:1a98])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc3:b0:2c2:27be:39a8 with SMTP id d9443c01a7336-2c66428edefmr91597125ad.31.1781480258491;
 Sun, 14 Jun 2026 16:37:38 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:21 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-12-skhawaja@google.com>
Subject: [PATCH v3 11/18] iommu: Restore and reattach preserved domains to devices
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
 drivers/iommu/iommu.c            | 65 ++++++++++++++++++++-
 drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 50 ++++++++++++++++
 3 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 41effee10e33..c8b09b650d24 100644
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
@@ -505,6 +506,14 @@ static int iommu_init_device(struct device *dev)
 		goto err_free;
 	}
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
+	if (IS_ERR(dev->iommu->device_ser)) {
+		ret = PTR_ERR(dev->iommu->device_ser);
+		goto err_module_put;
+	}
+#endif
+
 	iommu_dev = ops->probe_device(dev);
 	if (IS_ERR(iommu_dev)) {
 		ret = PTR_ERR(iommu_dev);
@@ -2169,6 +2178,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev, old);
 	if (ret)
 		return ret;
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* The associated state can be unset once restored. */
+	if (dev_iommu_restored_state(dev))
+		WRITE_ONCE(dev->iommu->device_ser, NULL);
+#endif
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
@@ -3124,6 +3140,47 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static inline void *__iommu_group_restored_state(struct iommu_group *group)
+{
+	struct device *dev;
+
+	dev = iommu_group_first_dev(group);
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	return dev_iommu_restored_state(dev);
+}
+
+static struct iommu_domain *__iommu_group_restore_domain(struct iommu_group *group)
+{
+	struct iommu_device_ser *device_ser;
+	struct iommu_domain *domain;
+	struct device *dev;
+	void *owner;
+
+	lockdep_assert_held(&group->mutex);
+	dev = iommu_group_first_dev(group);
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return NULL;
+
+	domain = iommu_restore_domain(dev, device_ser, &owner);
+	if (WARN_ON(IS_ERR(domain)))
+		return NULL;
+
+	/*
+	 * Ownership of groups with preserved devices is set during boot. These
+	 * will be reclaimed later by the entity (iommufd) that preserved them.
+	 */
+	WARN_ON(group->owner);
+	group->owner = owner;
+	group->owner_cnt = 1;
+	return domain;
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3138,8 +3195,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type)
 {
 	struct iommu_domain *old_dom = group->default_domain;
+	struct iommu_domain *dom, *restored_domain;
 	struct group_device *gdev;
-	struct iommu_domain *dom;
 	bool direct_failed;
 	int req_type;
 	int ret;
@@ -3183,6 +3240,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
 	if (!group->domain) {
+		if (__iommu_group_restored_state(group))
+			restored_domain = __iommu_group_restore_domain(group);
+		else
+			restored_domain = dom;
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
 		 * The only way to recover from this is to fail attaching the
@@ -3190,7 +3251,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * in group->default_domain so it is freed after.
 		 */
 		ret = __iommu_group_set_domain_internal(
-			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
 			goto out_free_old;
 	} else {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 90750e78cd2a..732c19e69e69 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -257,6 +257,47 @@ int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
 }
 EXPORT_SYMBOL(iommu_for_each_preserved_device);
 
+static inline bool match_device_ser(struct iommu_device_ser *match,
+				    struct pci_dev *pdev)
+{
+	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
+}
+
+struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
+{
+	struct iommu_device_ser *device_ser = NULL;
+	struct iommu_device_array_ser *array;
+	struct iommu_flb_obj *flb_obj;
+	int ret, idx;
+
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret == -ENODATA || ret == -ENOENT)
+		return NULL;
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!flb_obj->ser->device_array_phys)
+		return NULL;
+
+	array = phys_to_virt(flb_obj->ser->device_array_phys);
+	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
+		if (match_device_ser(device_ser, to_pci_dev(dev))) {
+			device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
+			goto out;
+		}
+	}
+
+	device_ser = NULL;
+out:
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return device_ser;
+}
+EXPORT_SYMBOL(iommu_get_device_preserved_data);
+
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	struct iommu_hw_ser *iommu_ser = NULL;
@@ -561,3 +602,59 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
 }
 EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
+
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
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&flb_obj->lock);
+
+	/* Preserved device should have a preserved domain */
+	if (!ser->domain_iommu_ser.domain_phys)
+		return ERR_PTR(-EINVAL);
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
+	liveupdate_flb_put_incoming(&iommu_flb);
+	return domain;
+}
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 5ad006892cbd..84522f180254 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -30,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
 	return NULL;
 }
 
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
 static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 {
 	struct iommu_domain_ser *ser;
@@ -41,8 +55,22 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 	return NULL;
 }
 
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
+struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev);
 struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
 int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
 void iommu_unpreserve_domain(struct iommu_domain *domain);
@@ -60,16 +88,38 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
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
 
+static inline struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
+{
+	return NULL;
+}
+
 static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
 {
 	return NULL;
-- 
2.54.0.1136.gdb2ca164c4-goog

