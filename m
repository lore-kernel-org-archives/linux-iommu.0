Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BC325705
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716632; cv=none; b=IqSm8F+OyOquP+x5xkG43VBWQh+wsTQUPso3jna2IZfXRRbGM0GcU33lhsRceJF12kTdJRvQr6+JdOu2VpYZC/IJp4v+OnSb6PRXaWzJ3fDo6ZpFO2rLZLdM4zcxBAKS+8vj50Vt8L/hPVr8/V0IVZpw8gQu/Uz2+89reP06DZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716632; c=relaxed/simple;
	bh=+X/igxpWYbym8Lq2K8U3FvHxmMI9iy8P5an2zYQCOJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jc8+VtLGlyp8kXj69fJ8sgd6im0x+UZdCMljWqAqMBoTOPfdgR+bcUSD7NhkrBBLfZv7xcn7sdEFpKq/7gXSiSSLy8GOsp0meFq4KK+yk+JxEeSQYjyRJi3s4h1g0vshMYnWx5eukd6To1ti6JOS4qIW92Q8MFUc8s+D6neUpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFMTouwA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFMTouwA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7dd05696910so1981943b3a.2
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716630; x=1765321430; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObKCfrsAgc8UQ63j1UenvXsxyQCjATZcdfWGPdhOtzg=;
        b=IFMTouwAR2C4A42OU5/c6LqP3aj5QrSrQR0yH1NOFMFvs9sNBl64xDw6AmfsPi1bh/
         RqVfC5j5bzQH4X32zXm7YqLPu5esbfzCmJLA/4RozOSh1eL7fHgTt5O6A+hD9qQPBuje
         LPwwbwF6N9h4kJ+cDJMOWPZ9UZ+oRUQ5oqmra/MHtQ90dKarKy6UJ41fJ8F8LJ84UAOT
         YI5o2KR0nZXcAv5/r1Ts4Y7Bt8K7nMD+OYk7I0by+4F5WEnjgMtGHk2HpRCcdYtzvNyh
         6eS4Zb9zz1IDp8B7o0QROc8KAWXKjJ4EJUH6a8dWa7JAX2B3qrUblTcU/bdDKzDOWCSF
         X/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716630; x=1765321430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObKCfrsAgc8UQ63j1UenvXsxyQCjATZcdfWGPdhOtzg=;
        b=bHq3UyU091WbmvCEBUohpBacBj2Pz4ukpHhRVAL9sQax3o1peGJCj2RVTv36vPocu/
         iJgbf+scxjok8H2r44K+9qZPrZAC5ksPJqm5jsU89vHajw++M4fvvprA/6mEDP74j32p
         +wR82kc1rv/BDDOTnGxYp69bE7N/lgPCVrIuzr9wobbaNJ0+YuuMSNIgxG/Nq+u2jeLw
         u/r71CEXcx4/9NFvKscC/uaCaoi3ujl8mfFiDpVeVC3de5iiymtrXp+sn+oiGrJ8hAEK
         Xjs33e9lTlQ8hRUPC+jbZ6UazD3Vj+o7P8A/qKPWocPckfXJVCxt1wKvLJ22nuCrPWym
         GN2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrimNbpj5pF3/GM1UnMpLzuY5eT6CdYdP3IejNlR1VtUAPmCOpo3ec2O46ge3sp347XQQlaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdqsxu4rEJifvKoBek+89HCL6B+sriNl0O7VMS0tJbfHUkc/E8
	JCqA6aYtNUNADD6ryNK5IRgW6YF6sz+Gl4A1JjWNhgRD7jv73Wo/Vfscv9P3vjKBui874LeJ0yg
	4uX5HIPzOv9EDnQ==
X-Google-Smtp-Source: AGHT+IE9fgiX8tgftECdPtUdVwHNX6qc96EWrVZ738NQpyQQhNwNJBfEeHT3cEUoujgQO7S9C+LLdEcrdogANQ==
X-Received: from pfbey1.prod.google.com ([2002:a05:6a00:38c1:b0:781:26f4:7855])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:84a:b0:7c2:60c6:8ca0 with SMTP id d2e1a72fcca58-7e00b91ebaamr189721b3a.5.1764716630226;
 Tue, 02 Dec 2025 15:03:50 -0800 (PST)
Date: Tue,  2 Dec 2025 23:03:00 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-31-skhawaja@google.com>
Subject: [RFC PATCH v2 30/32] iommu: Transfer device ownership after liveupdate
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

Get the token of the preserved device and use that to reclaim the
ownership of the preserved device.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c                  | 23 ++++++++++++++---------
 drivers/iommu/iommufd/device.c         |  6 ++++--
 drivers/vfio/iommufd.c                 |  7 ++++++-
 drivers/vfio/pci/vfio_pci_liveupdate.c |  1 +
 include/linux/iommu.h                  |  2 +-
 include/linux/iommufd.h                |  3 ++-
 include/linux/vfio.h                   |  4 ++++
 7 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 07453611cf8e..ad47597baa04 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3297,20 +3297,24 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	return 0;
 }
 
-static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
+static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner, bool transfer)
 {
 	int ret;
 
-	if ((group->domain && group->domain != group->default_domain) ||
-	    !xa_empty(&group->pasid_array))
+	if (!transfer &&
+	    ((group->domain && group->domain != group->default_domain) ||
+	     !xa_empty(&group->pasid_array)))
 		return -EBUSY;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
 		return ret;
-	ret = __iommu_group_set_domain(group, group->blocking_domain);
-	if (ret)
-		return ret;
+
+	if (!transfer) {
+		ret = __iommu_group_set_domain(group, group->blocking_domain);
+		if (ret)
+			return ret;
+	}
 
 	group->owner = owner;
 	group->owner_cnt++;
@@ -3339,7 +3343,7 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 		goto unlock_out;
 	}
 
-	ret = __iommu_take_dma_ownership(group, owner);
+	ret = __iommu_take_dma_ownership(group, owner, false);
 unlock_out:
 	mutex_unlock(&group->mutex);
 
@@ -3351,12 +3355,13 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
  * iommu_device_claim_dma_owner() - Set DMA ownership of a device
  * @dev: The device.
  * @owner: Caller specified pointer. Used for exclusive ownership.
+ * @transfer: Transfer ownership even if domain attached.
  *
  * Claim the DMA ownership of a device. Multiple devices in the same group may
  * concurrently claim ownership if they present the same owner value. Returns 0
  * on success and error code on failure
  */
-int iommu_device_claim_dma_owner(struct device *dev, void *owner)
+int iommu_device_claim_dma_owner(struct device *dev, void *owner, bool transfer)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
@@ -3378,7 +3383,7 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 		goto unlock_out;
 	}
 
-	ret = __iommu_take_dma_ownership(group, owner);
+	ret = __iommu_take_dma_ownership(group, owner, transfer);
 unlock_out:
 	mutex_unlock(&group->mutex);
 	return ret;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2c81bfa7dedd..c7b48de53f66 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -205,6 +205,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
  * @ictx: iommufd file descriptor
  * @dev: Pointer to a physical device struct
  * @id: Output ID number to return to userspace for this device
+ * @restore_token: Preserved state token if restoring.
  *
  * A successful bind establishes an ownership over the device and returns
  * struct iommufd_device pointer, otherwise returns error pointer.
@@ -217,7 +218,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
  * The caller must undo this with iommufd_device_unbind()
  */
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id)
+					   struct device *dev, u32 *id,
+					   u32 restore_token)
 {
 	struct iommufd_device *idev;
 	struct iommufd_group *igroup;
@@ -254,7 +256,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
 	}
 
-	rc = iommu_device_claim_dma_owner(dev, ictx);
+	rc = iommu_device_claim_dma_owner(dev, ictx, restore_token);
 	if (rc)
 		goto out_group_put;
 
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..57f0f395408d 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -118,8 +118,13 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 			       struct iommufd_ctx *ictx, u32 *out_device_id)
 {
 	struct iommufd_device *idev;
+	u32 restore_token = 0;
 
-	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
+#ifdef CONFIG_LIVEUPDATE
+	restore_token = vdev->preserved_iommufd_token;
+#endif
+
+	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id, restore_token);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b721080599d5..208a0b60c10e 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -205,6 +205,7 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	vdev->liveupdate_state = ser;
+	device->preserved_iommufd_token = ser->iommufd_ser.token;
 
 	args->file = file;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 45da5b88f35d..111a892fba1b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1211,7 +1211,7 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
-int iommu_device_claim_dma_owner(struct device *dev, void *owner);
+int iommu_device_claim_dma_owner(struct device *dev, void *owner, bool transfer);
 void iommu_device_release_dma_owner(struct device *dev);
 
 int iommu_attach_device_pasid(struct iommu_domain *domain,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ba433fb1a481..59d31c76f50d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -60,7 +60,8 @@ struct iommufd_object {
 };
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id);
+					   struct device *dev, u32 *id,
+					   u32 restore_token);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0e9df71e17ab..eacdc025e26a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -80,6 +80,10 @@ struct vfio_device {
 	 */
 	struct dentry *debug_root;
 #endif
+
+#ifdef CONFIG_LIVEUPDATE
+	u32 preserved_iommufd_token;
+#endif
 };
 
 struct vfio_device_file {
-- 
2.52.0.158.g65b55ccf14-goog

