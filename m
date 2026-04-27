Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C933EDAD2
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312623; cv=none; b=uCY4/Bmn9EGX3WzhpHowMkglm/KFBl1DKsXsJB9WY3I9B9tXApjms7OaiZ7mi3kEXMgkAaKhgspaPDuJW43OepvrXyf+wt5UH55k8TGIUACWEmEHFm6Uyegc6PQppbi33AbAq5AM5g5JqI9MGmNA2TmTt8CE36p/ehoKRmCbKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312623; c=relaxed/simple;
	bh=534PXqsRH0ZNWtMk7TNPuiF5gAIRjYEwUzbP3uo7gV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NBzs0ftvuAlxhcLjYKPXsKWMvszqWy052nQNJPOMq0Ww/Py93w6Uo3TtuOigjMY/JTe2WJI1ZWehb09VovSsYvW+ZSmsg4HfsYpNlrQr8f5nr9GK8T0R8iH8aSvs2CYYsEgpwiT+hN2Omz9Qe4EYRSYEutOsM81aQOCbNFz017o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxc2PGxA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxc2PGxA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso10064665ad.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312621; x=1777917421; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4OVoEgV8q2yYCFvxS4iHEMfYA31+l0LuQw3fH3C5DI=;
        b=kxc2PGxAZZ0wpJmoF+j4c0uDWG3uiZLD2aD+DuN9FdxqpJwQKHWtmMQp9YECgGWFxF
         cidK0HrId056GsYfRGGO9F89zHzlc9mhiDODfNjoRc4mjhY0MzHU+6HkFtNVso/dDAY8
         f6zebxy46VFk0pUrYgQbR9ncOXWgfYDJK3LlYXx3BzUM4Ebs5UeEL/uK0BJYxYxXfYk6
         2+QFj21FmMD1wf2EqPxtK5fliUdz77qLEFlJhTXqxeuj0C70wb0WQkeb7todHvLiORnv
         3SpADQaHuuZPZZaliIDpMuCzYRml81S5/5jhaQvAeu+v2a+DjfSC+MNJqBdPOL/VQ6D9
         01ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312621; x=1777917421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4OVoEgV8q2yYCFvxS4iHEMfYA31+l0LuQw3fH3C5DI=;
        b=VrvvOF6sz3nAqoeEFYcok8RniP+ugLRnraeMk3OE2FQRCFqIvVrVR+F0syeLpK5euC
         B6blRVSDWdOS6dSHgNA8O9lVRBZN7NtQ0J29uDmSYKyWlvZaI4+occMRRtECk7wkGlp8
         vXtNoDp1EW/+5P4RsZvYLmDQw4AH9qFX8QjSFOvdKYZtqBYQNGs3WrZN0tUp9dD3m4pD
         fa4VqFJDqRrXF2zt2n4n8HIHTC2rYk2iXIDT+DGytWPUD8i5s7/+w69GHPlQxeo0a4HF
         cSzEOfxfY6t3LgzMvZFOZYYYNHqI0C6wKqPqjyuJY9bOEzvwGs5KG00y3ndz325d3ZoI
         TWcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0aV2iOlaFFcNhDn57qNafbLDSqQq2Ks6HYKKXUTa3vkDEeY/tJYoQ4bjj4A/pGUSCG5IUgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYPGRQJ83Up9nb5ZNydiHxTLrJ/aLEwr54mBmJKZhvRNX1+cxS
	/S3eV5Tpuk8vx7VQygmvS1htm8MMe65Rrg9DE6X91pXtUYt+Vhtwma3W1+ij+b5OwChtBRDhNkA
	hGj+mxrPd7oL9jA==
X-Received: from plgr6.prod.google.com ([2002:a17:902:ea46:b0:2b2:a704:94d8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0b:b0:2b2:65db:8c51 with SMTP id d9443c01a7336-2b97a7aaa57mr2542145ad.8.1777312620699;
 Mon, 27 Apr 2026 10:57:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:32 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-16-skhawaja@google.com>
Subject: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 ++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 6844684a3d8e..23f083c0891a 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -271,6 +271,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
 		ret = device->ops->pasid_attach_ioas(device,
 						     attach.pasid,
@@ -329,6 +334,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		mutex_unlock(&device->dev_set->lock);
+		return -EBUSY;
+	}
+
 	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
 		device->ops->pasid_detach_ioas(device, detach.pasid);
 	else
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 976ef17e6103..b56d80379ffc 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -108,10 +108,13 @@
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
+#include <linux/iommufd.h>
 #include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
@@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* If iommufd is attached, preserve the underlying domain */
+	mutex_lock(&device->dev_set->lock);
+	if (device->iommufd_attached) {
+		u64 token, preserved_state;
+
+		ret = iommufd_device_preserve(args->session,
+					      device->iommufd_device,
+					      &token, &preserved_state);
+		if (ret) {
+			mutex_unlock(&device->dev_set->lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&device->dev_set->lock);
+#endif
+
 	ret = pci_liveupdate_preserve(pdev);
 	if (ret)
-		return ret;
+		goto err_iommufd_unpreserve;
 
 	ser = kho_alloc_preserve(sizeof(*ser));
 	if (IS_ERR(ser)) {
@@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
 
+err_iommufd_unpreserve:
+	iommufd_device_unpreserve(args->session, device->iommufd_device);
+
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
 	return ret;
@@ -178,6 +201,14 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+
+	ser = phys_to_virt(args->serialized_data);
+	mutex_lock(&device->dev_set->lock);
+	if (device->iommufd_attached)
+		iommufd_device_unpreserve(args->session,
+					  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
-- 
2.54.0.545.g6539524ca2-goog

