Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894798;
	b=X+TO04WJ6LLOqNzgTcFH4it9Rm2TNlG/PtjUlnQ7372HjAIHIAgwW9YV2ZBGUG4qDIuC
	 askxDTHgu5+R4Q+oJsYsl4JT4aFsB8oR5KoABnB1JdqSmXW4bd5P9w2n7EijWTLH/SIAU
	 myBm3MljP2XqbK9+6rBdyMz0dXLK+AICckzDXa7srYkvsxIXpAbLu7VUrmzXTk5FG509y
	 IZmW+Jnt8uwWG9vjtlVxU4ywrFEmUOiUPKgblivrHMlEUK58wtJgRoGRzRj6akvBTbRAG
	 IWABzL9jssEXotrIOOwxX/3ZpZz9J1nD8Bd4sfbu+jTXAHoGNqaKGTRb4WOw4MkPbsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
	b=3GWl7VOAIVJ+dOfBUy3gMxvFUzssT0Fh7K/woBXs5nFhoJkYSi6tdRfxfmYK4TLpp5FP
	 2wT/W+rOOppK5LGT2WAXfIKtxCp9wdSJBLMZkEuUBMtHO6zC/NeJixKf9rSjb4/rLH4/Q
	 TWRf0Ir3zUMtWVnoXeT82EgPxWTeR3YMwgiXoF9/HToH+Ik6PMper+MIrlVIVn0KkrhWz
	 aIheKe6Ch/kheX3SmkSdmR58kudiwvAW3ZiIYlTnRs71CqSH9zG0WjdRrioYq9BT3WynC
	 rXr2IRFIi6U20AJcAturjtWeMDAn57uNpTtkt2avFjmn+PfES15hZfYx5dFfHZ/ApdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SEWi1ZzR;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205D60A3822
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A205D60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SEWi1ZzR
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89e05d31e54so1175753b3a.1
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894797; x=1793499597; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
        b=SEWi1ZzRhcBkMjDOeuvq7lPHqJYjwHvrON54i8z3J8sDFEKLQc5c5gFJT6Jh2EE13+
         fhznmbxbtz+p5YUlezI3hGO7WogHfQprjEclXhN9lNyUxUq4V3FPN5+e+uFa9JFEzHq1
         1U5C4taGonE8u/WyJbtA8AxUdKWSBHjFgvaSL/WlZsHOrshwciowZwzZ3cPZYUOs8McI
         /3StRUjs7mPZfni7B9+oABMhtYu3KqyQX4GCoP6XVsIJPDx9sjTXLVl85Alb4LbIZvUQ
         XOF/IL3DmGU5nHAs6a2sZfF300t5E2Bi3cYa7Y3GOHg24jyF5zMNQQYeASvP9CgZGLCc
         M5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894797; x=1793499597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48N2AMcTrYa16h3G9vjbROJdW72agyVjx8wRXS/VtRI=;
        b=D42TF3wZLdwUP2fDAq5jF3pYt/AA6LxjCK60kjpyixSkGW+a2IZUxhm9s91PBoAUUC
         UoKx9+0rJCx2K0tbaurEIZBwYGt16s5IGZ2fzbCcPzCyx0zyZ6uP3E9Ovk1G9CKUeR7j
         Ay7uZgXUNbqWfEf7BV9m8hCK4ZJNg0OyzoLe3ZIuJknYI7PxKmm8Ojng0me4kjk3aRIm
         qExx33+t7DUpeVYNe2VpFReI9ZTt0Et22PcRfPeFQKtho8tAlA/tFk4l6mj1quHXLG2i
         TYCVTGhCrUBkTSeovZXwNsof6mZpQyH4Zd3HmmzY72zSeQ9aT3I2lscpo7e4LnxtY+Yz
         UDNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPnq9pODT5g6F4VrDrW9ndWjZucbn6bnl+9vYjtcs/rZUgNkUIwzZb6qDgo9UxpXSOnVDrsA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJmVffuXXhJ3tVwQd5y6oO5hrl7vs9Cz8J6wgv1jz9omlTxwnmI
	xVnI8svI/7flHB2H3W3GO8ogzDuXIwv3PFKKgB/TH14wXMDYozahvUwI1514LIP6Kkz3X0oAdTE
	wLVOnIvQBaiFVtA==
X-Received: from pgp10-n1.prod.google.com ([2002:a05:6a02:62ca:10b0:cd6:1e1f:43b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3f94:b0:3d3:adbf:7781 with SMTP id adf61e73a8af0-3e7bfa200afmr2334050637.22.1792894796861;
 Sat, 24 Oct 2026 19:19:56 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:28 +0000
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
Message-ID: <20261025021930.674647-18-skhawaja@google.com>
Subject: [PATCH v6 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
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
2.56.0.257.gf7497c7d27-goog

