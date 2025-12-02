Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E61E8332
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716588; cv=none; b=exdnKQOWuKEpCbXVLN0MtI8N+bRNUR9c5KMt0+gNiWhDmoSHkt9/FjvmkSExhWxxb2DH9AECd+QnJC401qmxw6M2ABlqZwru232NKCb5FDLh+oLOm7BdCPs2A+K93eUyiApPNGwf+KheeZQkSIhNLQhJiUogG/h3QYyBaO0+II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716588; c=relaxed/simple;
	bh=3dpv2T/KPouo6biL8naEZoBVqMmu70tshpBj6mjBqss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AEUMgDt3+4CcVZxdEvOghSIeGYagPQz9594ssWdupFmu56WLYOOZQ2RE3wxfYDnewd+jx7cJ29zH26PvFSlvYHls3vdTXUgiJF6pHrg2b1HOa9v6n5u5wI6cO9WpyqF+VF0XUveblDuXrn8YBh64cgliuiKUlU21PVIpHagnxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cogIYNJd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cogIYNJd"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7aa148105a2so5424501b3a.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716586; x=1765321386; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBZlFP/EB2P+WVJQqIikPs/rswuiFST1UO20sqZFKaw=;
        b=cogIYNJdYwS9gUhJfIAIRNXAHX0ftTVp42AiZTZZkQ1CudUW9iaAUj2mxh48hS4pX7
         Qlre1FxFFWncaTldh+4PrtJ6ixbwXeyaO949lVvl+8mKCAMlBVE6n/3ERfPIvSZS02Td
         hUMmbyFYDjgWUEiCBg8/WbTS5Drah3sFLsX9e10VnLrhUczZYWSg0lzJ9x/3dHZw6r+P
         zWWU+xJogXrRupgQg5oVCq3fTQGSBXYcf/NwYLdA3IQvrM9vF3z3ug1eEsR3gKsPqqZ7
         ya2OrA9t8fio2OI/1OrK08jmUj3jvY37WzQNAg0f1Q3jspNCOqPH+eL/PU0HAORIAeFL
         6KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716586; x=1765321386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBZlFP/EB2P+WVJQqIikPs/rswuiFST1UO20sqZFKaw=;
        b=G5NIyrPO0uqmdYwt8zwnspM4KBTwne2PEvEBJQIMsRu/jzIdteRo3rJLwS9u03ax/Y
         0fJ/kVdzYUnfPw2DE4/OslAW/i8BjVnAjyfcdbL0oV34mq9yXnpdUUHIb/68iEnA4Z6F
         TfQ5+P1pFBpePxVeKOKN7m7gX4Jzie5Z3Glc9tc4z+t/6R0YM+rJ76hSUI4HPf6ghLAO
         QyKijtdq49CFETmGsdQRxv8PkxX7fVyRxZN2yqfcBWudiSe5W5c3SyABy1/l2jkG9ZMj
         55fV5FPIgm2kFhtW42ZTd5iNtmvWWVnip2HWpxKR8nsWzHP9ZiAc+DLOYI7dwYFSR1qC
         db9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCTnuAHb312ub8rpl03DxvxFjCBp6mXxlUyygJC0gqNLCnBJCFd5lDhEj+d/WuULeOAZyk3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX9ydo6CoOTewCxjhGGxubEJ3gStdzbIu0IgOLzkvenDcudOew
	EXfuUgQjBlFTUUiJGXtKxkkH8X2A1ShZ8qU9V+90NOxG9DouhmB0UvcdODUJ1e0cHpQtWPEXsuZ
	WJDeSFg4TFSQfHA==
X-Google-Smtp-Source: AGHT+IGwm2qNuoclKb/WRJ/9e/2T50mKMClCoHj5CFtiQtnpImqfROZN2V64QnmfFa0SmkASiofdI1wDFOJAOA==
X-Received: from pfbg6.prod.google.com ([2002:a05:6a00:ae06:b0:7b8:fc17:3960])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a24:b0:7ab:e007:deec with SMTP id d2e1a72fcca58-7e00eb6dc8cmr178184b3a.32.1764716586477;
 Tue, 02 Dec 2025 15:03:06 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:31 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-2-skhawaja@google.com>
Subject: [RFC PATCH v2 01/32] iommufd: Allow HWPTs to have a NULL IOAS
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Normally HWPTs are created with a parent IOAS to allow the mappings
to be modified. For liveupdate we want an immutable HWPT upon restore,
so no IOAS is needed. This patch prepares iommufd so it would not
crash on a NULL hwpt_paging->ioas.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 drivers/iommu/iommufd/device.c       | 11 ++++++++---
 drivers/iommu/iommufd/hw_pagetable.c | 15 +++++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4c842368289f..ba4d9c3cfa8b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -418,6 +418,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 	lockdep_assert_held(&igroup->lock);
 
+	/* unreachable if !hwpt_paging->ioas */
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
 						 idev->dev,
 						 &igroup->sw_msi_start);
@@ -603,7 +604,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
-	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID && hwpt_paging->ioas;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
 	struct iommufd_attach *attach;
@@ -707,7 +708,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 		xa_erase(&igroup->pasid_attach, pasid);
 		kfree(attach);
 	}
-	if (hwpt_paging && pasid == IOMMU_NO_PASID)
+	if (hwpt_paging && pasid == IOMMU_NO_PASID && hwpt_paging->ioas)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
 	mutex_unlock(&igroup->lock);
 
@@ -739,6 +740,9 @@ iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
+	if (!hwpt_paging->ioas)
+		return;
+
 	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
 	xa_for_each(&attach->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
@@ -756,6 +760,7 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
+	/* unreachable if !hwpt_paging->ioas */
 	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
 	old_hwpt_paging = find_hwpt_paging(attach->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
@@ -782,7 +787,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
-	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID && hwpt_paging->ioas;
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c9..78d2130e0061 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -23,6 +23,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_paging, common.obj);
 
 	if (!list_empty(&hwpt_paging->hwpt_item)) {
+		/* unreachable if !hwpt_paging->ioas */
 		mutex_lock(&hwpt_paging->ioas->mutex);
 		list_del(&hwpt_paging->hwpt_item);
 		mutex_unlock(&hwpt_paging->ioas->mutex);
@@ -32,7 +33,9 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 	}
 
 	__iommufd_hwpt_destroy(&hwpt_paging->common);
-	refcount_dec(&hwpt_paging->ioas->obj.users);
+
+	if (hwpt_paging->ioas)
+		refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
 void iommufd_hwpt_paging_abort(struct iommufd_object *obj)
@@ -41,9 +44,11 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_paging, common.obj);
 
 	/* The ioas->mutex must be held until finalize is called. */
-	lockdep_assert_held(&hwpt_paging->ioas->mutex);
+	if (hwpt_paging->ioas)
+		lockdep_assert_held(&hwpt_paging->ioas->mutex);
 
 	if (!list_empty(&hwpt_paging->hwpt_item)) {
+		/* unreachable if !hwpt_paging->ioas */
 		list_del_init(&hwpt_paging->hwpt_item);
 		iopt_table_remove_domain(&hwpt_paging->ioas->iopt,
 					 hwpt_paging->common.domain);
@@ -457,6 +462,9 @@ int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd)
 		return PTR_ERR(hwpt_paging);
 
 	ioas = hwpt_paging->ioas;
+	if (!ioas)
+		return -EINVAL;
+
 	enable = cmd->flags & IOMMU_HWPT_DIRTY_TRACKING_ENABLE;
 
 	rc = iopt_set_dirty_tracking(&ioas->iopt, hwpt_paging->common.domain,
@@ -482,6 +490,9 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 		return PTR_ERR(hwpt_paging);
 
 	ioas = hwpt_paging->ioas;
+	if (!ioas)
+		return -EINVAL;
+
 	rc = iopt_read_and_clear_dirty_data(
 		&ioas->iopt, hwpt_paging->common.domain, cmd->flags, cmd);
 
-- 
2.52.0.158.g65b55ccf14-goog

