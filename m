Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75290313554
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716628; cv=none; b=rcsPx4a1UuCg+NubH+bNtQ9uTnMpNuhmioTWHg6EwowW6m/7h3p+WP7HOq1HWBOL+HkVO9SnRnreKsVlmT7n4HgHo1M2cObKYxEolrzxFg2B0G4hYRzgDWh9SBtzHYhVELPc7xJXNM/ySnidS5BBQm2l+Nh7SX1ukC014CTbh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716628; c=relaxed/simple;
	bh=trC+TNdN6VLVn3UOdV3aInOJKLZeApPzbmZ2TRA5JhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoNPSBHuOcUKx+9LMdA5LyjIL93Tw5hKDNALgtZfi9g6qTaFoUOyMNQYvJfuduGr5qp2FGOjkGRhXMuRKhYC5WEs4E5OrHrY/H95fTlZsrU5Wa+7tuFaFq36cYDbYRx/vJSUuuuG8cA2nyD5xGXlX5OQU7OE0YLUaNQ8oprlbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojPGcTDj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojPGcTDj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dde580c8so153154175ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716626; x=1765321426; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3UibQVWg0fC/MfVYBeY3d9nYlOGX58qpOdLisvdcHU=;
        b=ojPGcTDj6EAqI/UTWE1EC4+98bnbtR0pdkQsMsEZSCQsIh6oRA57jllRGKt9mGOhls
         EMySvawk5P709liNagTaMzN+fPqYMJar7QWLy2A3QyiJIivbqn9hJGIyOjsJk8qy+j0/
         O0Iw6qc4P4nSohXXzcem2fd0HJKGmEz4WuHN3qKg+hbiE6lMizEBQjHjRm8rN79cQ8RH
         euGlKlpl1qJDrUdfYm0C37i9B0ymFFRUeBs2wzsstqnU7VlDxGrZaYjmG/yFLYwQHRCC
         iHfUA1jLSwMn/lr5QUw/fk/eZR9TtQVFzR+KEj1ZFlYPEZMu4U8qnfFGJ+FG/b5RWkM7
         ECYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716626; x=1765321426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3UibQVWg0fC/MfVYBeY3d9nYlOGX58qpOdLisvdcHU=;
        b=bg/iDOHLDJcOfJAXI9tIJ65pHpYpZ+K1pPJSRlZJ0zsDpUZicZt6yrAIiYf1KwUpi3
         On4SecEaOlKa5XefOV6byS5plVtiznu16+inUGeMd5HMx4kmZyZgZXljuBxQVXpr5c0Y
         SMDdKMGZ58M8PWqLgpo7z97In55HjxZl1nhskwhV85F2wAT+3eBpo77evkRe9mFsN91n
         M7oYpXwPO8yDRHFlTTftajSxjIu3rkwU+2rM+cMfa1tIpNiv71rM6NS6vSScmVnHdSC7
         bkEswcZbbgpw+9+ux/JKlrQOHnlr9kUYvhZQBErtqXYNkJvrGtWMQ8uN/TCJL2TLviHn
         gUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkYtAwUlCbpRL5k7XedBl66J3b++EcbgK2jEqG57YV1O93dRumxCoTPRXpUHHifBAOGRBK/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDkGJWGz1hqkGRqUhIzPAxs9VpdTWjJqyifU/lGaWXcpg85SKn
	yigwej8eMsdlOTnvcPd5vXoiMx5TxMoyABVYxzaW0ZmKHnHZ0dG4VJbqd9Z9A+gmKWQacDo7grC
	VrlTZI9XyXV9k/w==
X-Google-Smtp-Source: AGHT+IEauqgmLCM3DCqI746jCchiGjXOAJpZy4Pe1Qioq8h3ZTfr1kGTnyJn9UdaGWBB6xpAm2BwUwSWhDnM+w==
X-Received: from plj12.prod.google.com ([2002:a17:902:c14c:b0:295:64f4:dde2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d482:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-29d6842ccf2mr2744665ad.41.1764716625733;
 Tue, 02 Dec 2025 15:03:45 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:57 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-28-skhawaja@google.com>
Subject: [RFC PATCH v2 27/32] iommu: restore preserved domain and reattach
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

During boot the preserved iommu domains need to be recreated and
reattached to the preserved devices. Once the device is reattached to
the preserved domain, the preserved_state set in the dev_iommu can be
unset.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c      | 39 ++++++++++++++++++++++++++++++++++++--
 drivers/iommu/liveupdate.c | 31 ++++++++++++++++++++++++++++++
 include/linux/iommu-lu.h   |  1 +
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3feb440de40a..07453611cf8e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-lu.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -489,6 +490,10 @@ static int iommu_init_device(struct device *dev)
 	}
 	dev->iommu->iommu_dev = iommu_dev;
 
+#ifdef CONFIG_LIVEUPDATE
+	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
+#endif
+
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
 		goto err_release;
@@ -2161,6 +2166,12 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	if (old)
 		atomic_dec(&old->attach_count);
 
+#ifdef CONFIG_LIVEUPDATE
+	/* The associated state can be unset once restored. */
+	if (dev_iommu_restored_state(dev))
+		WRITE_ONCE(dev->iommu->device_ser, NULL);
+#endif
+
 	dev->iommu->attach_deferred = 0;
 	trace_attach_device_to_domain(dev);
 	return 0;
@@ -3006,6 +3017,27 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
+static struct iommu_domain *__iommu_group_maybe_restore_domain(struct iommu_group *group)
+{
+	struct device_ser *device_ser;
+	struct iommu_domain *domain;
+	struct device *dev;
+
+	dev = iommu_group_first_dev(group);
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	device_ser = dev_iommu_restored_state(dev);
+	if (!device_ser)
+		return NULL;
+
+	domain = iommu_restore_domain(dev, device_ser);
+	if (WARN_ON(IS_ERR(domain)))
+		return NULL;
+
+	return domain;
+}
+
 /**
  * iommu_setup_default_domain - Set the default_domain for the group
  * @group: Group to change
@@ -3020,8 +3052,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 				      int target_type)
 {
 	struct iommu_domain *old_dom = group->default_domain;
+	struct iommu_domain *dom, *restored_domain;
 	struct group_device *gdev;
-	struct iommu_domain *dom;
 	bool direct_failed;
 	int req_type;
 	int ret;
@@ -3065,6 +3097,9 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	/* We must set default_domain early for __iommu_device_set_domain */
 	group->default_domain = dom;
 	if (!group->domain) {
+		restored_domain = __iommu_group_maybe_restore_domain(group);
+		if (!restored_domain)
+			restored_domain = dom;
 		/*
 		 * Drivers are not allowed to fail the first domain attach.
 		 * The only way to recover from this is to fail attaching the
@@ -3072,7 +3107,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		 * in group->default_domain so it is freed after.
 		 */
 		ret = __iommu_group_set_domain_internal(
-			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
 			goto out_free_old;
 	} else {
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 1ca97612c501..735b7d9417c7 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -467,3 +467,34 @@ int iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 {
 	return -EOPNOTSUPP;
 }
+
+struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_lu_flb_obj *flb_obj;
+	struct iommu_domain *domain;
+	int ret;
+
+	domain_ser = __va(ser->domain_iommu_ser.domain_phys);
+
+	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	guard(mutex)(&flb_obj->lock);
+	if (domain_ser->restored_domain)
+		return domain_ser->restored_domain;
+
+	domain_ser->obj.incoming =  true;
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return domain;
+
+	ret = domain->ops->restore(domain, domain_ser);
+	if (ret)
+		return ERR_PTR(ret);
+
+	domain->preserved_state = domain_ser;
+	domain_ser->restored_domain = domain;
+	return domain;
+}
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
index d0226ec19b2f..1f90f4fb0328 100644
--- a/include/linux/iommu-lu.h
+++ b/include/linux/iommu-lu.h
@@ -78,6 +78,7 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
 }
 #endif
 
+struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser);
 int iommu_for_each_preserved_device(int (*fn)(struct device_ser *ser, void *arg), void *arg);
 struct device_ser *iommu_get_device_preserved_data(struct device *dev);
 struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type);
-- 
2.52.0.158.g65b55ccf14-goog

