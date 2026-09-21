Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDD3101D4
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951739; cv=none; b=WmfJA8mSCM4qHYSdZ5LokOz+6Gd3yVjK+m5K/MTjfgjbxku6Ttv1T5wpEvCep/JRH4fFDXcDY42+WxvyA8gN0lOwlKv2mXL8MPrsLmetbWGGyYOMx48dwvPdnE85jCiSzG+TKBrnosPbckqAu7ILVABWJTqIda3iMFjyKbninz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951739; c=relaxed/simple;
	bh=dNP3ug4zy6sMOnrcTiQ4lvN1PGyKC36bSNyoIpacE1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FuSkNadVT3/9wXQ2cFRxdqifdFKuu0c6m3OVN++d7jGLSU1hFUfW6pgDwWzlgI10KP72bxQfJ969YKxGmvRnBAytDcuqxwhadLRPwwYWROh6YgEpgZ0l3Ti8xjK+FMb/LfnO4bIVb0PGr2xGvnKNuxiCPGCa9UNRInPDbqA3GB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCxxGWip; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCxxGWip"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db22383e8fso35757885ad.1
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951735; x=1790556535; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnkGcHTtOCYviBMPyvl5P9OipihIRIFDETRmg21FMBU=;
        b=NCxxGWipC30Zv+Ja4xPfpIJfK+FGTg4m35ov7yhEjtiqk/S5RVuTP8Mt+GGHq2TDBA
         etsDZBMYVhn41mMTu7sGH+dGpd4FJJpWY3yKHxosObrOhTntOwzt3tdfB5Nb+q5nh+T9
         mRM1QfNh9J0Rs6v2enLR3yUa1H1rDYw/tOWRI7PfvLF+21LILnNqnW6p9YI9Ua7b25rH
         qoQEElgEaSsynMP+Gnhop3TZGPolMnTRSxg99tsUkI0y+uMJbe0YBALZD+arsCMrrZH7
         q6yI1KZXXAOkxJFkYNGPyYu5EW+3SCqlw3Bf06hizEhNERDcgSY2N27AbH+NUJWT6VIG
         ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951735; x=1790556535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnkGcHTtOCYviBMPyvl5P9OipihIRIFDETRmg21FMBU=;
        b=ErL4nprFIX0EwQNLgvMs1WKFJ7fPaajEYb3vCBmd9mMlUVv6mlgCKbJq9ysDIuG/bn
         kcNDQY9GuU3/D4S1Ca1eXtVP+UbHMwj1Ynbfx6Eis06vP/PPnEdZgho0XeTWjbkVK6J0
         3b7w7O64qlMxrPI2cM63fKYgyKjxs3crw7ZvAxdUjUR/zzzK7o3TETImM4DIla7gKT1k
         1qfu8zo+IL5DS4B2DUn+94O/YUBwQ3G+rz9GKeJzT/PgCp3KeUTXi/WF/cF2NNGVcv+T
         nd2DxgPByyNIY9/rKdHX3uxJVhUKPUe6I/putacPzbQdi381Ez2RFgSZ69pbDGWIBo6c
         01Vg==
X-Forwarded-Encrypted: i=1; AKwUvBwylk7tAiRIw4W6va+g6NZldMACLSMW6HL5oNy/NNzYJgsUWezRDDqfCns4gizlzbef3G/spw==@lists.linux.dev
X-Gm-Message-State: AFuF++lizqnC6wgZ69VoRUgoS8iXGcswDTqeVOVeufQIH45u34EQgay7
	64swhIZMFKdQtaO2n1K1PJlZGLUvrcPogEbAPUsIuvbqjQBv1K4KDlWP394IaMFXDEQXn3jmRm6
	PsuQtTafhCjcsxQ==
X-Received: from plpp18.prod.google.com ([2002:a17:902:c712:b0:2df:474d:a5c7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d487:b0:2dd:c053:b9c9 with SMTP id d9443c01a7336-2ddc053bab9mr64172125ad.26.1789951734758;
 Sun, 20 Sep 2026 17:48:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:33 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-18-skhawaja@google.com>
Subject: [PATCH v5 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index b818aab92f76..4eb7ffd489bd 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
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
@@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
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
index f0ea37d98696..fb2141ee8942 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -106,6 +106,7 @@
 
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/iommufd.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -114,6 +115,8 @@
 
 #include "vfio_pci_priv.h"
 
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
@@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
-	int ret;
+	u64 iommufd_token;
+	int ret = 0;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
-	ret = pci_liveupdate_preserve(pdev);
+	mutex_lock(&device->dev_set->lock);
+	ret = iommufd_device_preserve(args->session,
+				      device->iommufd_device,
+				      &iommufd_token);
+	mutex_unlock(&device->dev_set->lock);
+
 	if (ret)
 		return ret;
 
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		goto err_iommufd_unpreserve;
+
 	ser = kho_alloc_preserve(sizeof(*ser));
 	if (IS_ERR(ser)) {
 		ret = PTR_ERR(ser);
@@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
+
+err_iommufd_unpreserve:
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 	return ret;
 }
 
@@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
 
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
+
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

