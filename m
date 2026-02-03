Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37C385ECF
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156614; cv=none; b=dr19OditqXUGUmhj3DFW0YyhceOff9aPXRilA21nJJCMdc3FDZf9P4JrdKYzE8UpqVaebx8IWUTI7OYGixU1TLdZltbNszHR0WqAVBFaZ79H4jtH1I9tliYNwq2rOPpeGnmirjGfGE7KD2UYjx84T/flI4mwHN85G1CShxjpAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156614; c=relaxed/simple;
	bh=OvnjKmtuP+/pnyWLrwtRVT2pKYDknDMFSdYGBTZusD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxO/uTXYGdQCdtVMhf5C5EXfMkjc6AV1jI3xbAk/xJCGhqUO1KDDSYLH7b/2ESUibK8VrnsTUViRcwVz8F3zowOuYtbWDfFubL0lJmgqD22PLzNO/Nt+W0v4Ldzxd7Tq/+c4jgR7XhUOM6q4X29CNLbZ0POJFqcxIN2xxMIH0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sj34ShP9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sj34ShP9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81ed3e6b917so5130676b3a.1
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156611; x=1770761411; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8ncc0FKC3TXUBMo9gNfkA/biCGmORiTT+jCw4LASx4=;
        b=Sj34ShP9mMH3Y8zg0YfXL58xaaoykkYDzu+xKI41zZohJuFDCLhbsKSJ9fdBHN8/BG
         jzlbhq5jXmsSlbAGtC2WkMC4QyMQl/17Ud0SnP9AH15FDWhjtsOhTg33UmB3ip8VnqC/
         Vc3Rr3/e6jLRQeuG/RWrsFR7KD099nKzc8mX3S5OF/rW+8Q3f7Yjsn7BeHhr+jJ+e7FY
         8t/B3/ZGdL2445xhXWqTaatQ8UH4Ejpxnp+XH++KhrgiZGJUVKZVho4DLa+VeCNKW4lP
         97oWmd1pVuk6pMoZpqPgOnyFFEXNiEJBj1n2y4YP/MEiMeTk51hxEXdMuHxWv3Ev2zUF
         uWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156611; x=1770761411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8ncc0FKC3TXUBMo9gNfkA/biCGmORiTT+jCw4LASx4=;
        b=J4AmJpgxvKAu+iv5yRZIpye1eQ8u5s24aTl4D53poJRx62SmvroX51Lu8sJ9g8lno1
         X5XTcHklLsYtvvDOue2TAGA8eMEDROtFT8BPiV+2jJY9oFCT2Yi0Pfjy+/pMtCrnbRQt
         /+VsKbI62G79IaomG94s2P7YGppJRWsxii4KR+X8Q2xqLBCry0Rpyux4rEyVOfHFjBHE
         5AenF17p46794sMvOapgNlYeayNsp+HGHh8Lfq9sGIjK/qkK/girYMuAaLhIIdSmVm4x
         w28uR9g2bKRTEWkIlIcyvoE9vJtPnIcdLRJGgeDuOknm6T8HbwMS2mFu38w8Swp14mGt
         FMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwaRZSgMgzGBEKTiY5oeAHqNL/AbYHz+eXTwODENRyEQVgb/6YnSU4spMwpV8XoLU8vGWlSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLi0N4c4eWC3c4Kqb3xAuGxDp9DlXhUaFIVUCJ8A0/RvrTOEVG
	67YhCHAgMS50CMLMpRVfVyplxImhuOi8XE3t1IlW5Ckgyvwwy/nyMWsvhbS6eiJQK5YvPqh/SGZ
	Jy64NhrHZsl5lCQ==
X-Received: from pfblr43.prod.google.com ([2002:a05:6a00:73ab:b0:7dd:8bba:6394])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e8f:b0:821:81ef:5de8 with SMTP id d2e1a72fcca58-8241c1ab516mr847226b3a.12.1770156610959;
 Tue, 03 Feb 2026 14:10:10 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:47 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-14-skhawaja@google.com>
Subject: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio cdev
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
attached iommufd also. Basically preserve the iommu state of the device
and also the attached domain. The token returned by the preservation API
will be used to restore/rebind to the iommufd state after liveupdate.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 28 +++++++++++++++++++++++++-
 include/linux/kho/abi/vfio_pci.h       | 10 +++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index c52d6bdb455f..af6fbfb7a65c 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -15,6 +15,7 @@
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
 #include <linux/vfio.h>
+#include <linux/iommufd.h>
 
 #include "vfio_pci_priv.h"
 
@@ -39,6 +40,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
+	u64 token = 0;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
@@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (vfio_pci_is_intel_display(pdev))
 		return -EINVAL;
 
+#if CONFIG_IOMMU_LIVEUPDATE
+	/* If iommufd is attached, preserve the underlying domain */
+	if (device->iommufd_attached) {
+		int err = iommufd_device_preserve(args->session,
+						  device->iommufd_device,
+						  &token);
+		if (err < 0)
+			return err;
+	}
+#endif
+
 	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser))
+	if (IS_ERR(ser)) {
+		if (device->iommufd_attached)
+			iommufd_device_unpreserve(args->session,
+						  device->iommufd_device, token);
+
 		return PTR_ERR(ser);
+	}
 
 	pci_liveupdate_outgoing_preserve(pdev);
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 	ser->reset_works = vdev->reset_works;
+	ser->iommufd_ser.token = token;
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
@@ -66,6 +85,13 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+
+	ser = phys_to_virt(args->serialized_data);
+	if (device->iommufd_attached)
+		iommufd_device_unpreserve(args->session,
+					  device->iommufd_device,
+					  ser->iommufd_ser.token);
 
 	pci_liveupdate_outgoing_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 6c3d3c6dfc09..d01bd58711c2 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -28,6 +28,15 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
+ *
+ * @token: The token of the bound iommufd state.
+ */
+struct vfio_iommufd_ser {
+	u32 token;
+} __packed;
+
 /**
  * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
  * device.
@@ -40,6 +49,7 @@ struct vfio_pci_core_device_ser {
 	u16 bdf;
 	u16 domain;
 	u8 reset_works;
+	struct vfio_iommufd_ser iommufd_ser;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.53.0.rc2.204.g2597b5adb4-goog

