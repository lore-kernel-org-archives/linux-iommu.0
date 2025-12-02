Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EA3074BA
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716616; cv=none; b=tU3q7PGjeeMRh4E6w6iCa0VNHahNahjS/GO0xS5iRrFdI9mvOKlXFwdt5ZmH1OPpGjcXYbLe0CFrL/bUvONK81GJOMp4+caQmbvBMD9iIeRLITG1RTwPvnge9ghIATYWsbvZBrCDZcA1DWIO612UVHNVCtNaj9c5LHZCMrIsNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716616; c=relaxed/simple;
	bh=17TLyZ7NAJhMejOsqwXU6VTVIJcq0EySjDEiRvPt3yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/CBMNVDhXB5YcRis9yze5KhUs+xTQmE92/TxsYwfVrqi6Z28bto2jpBKbbbQ3xIXmMYvoZ5FPUCCflIIpFWt36Ei7dp9cIVGHdzOsD6UxsN1z3HPo0gYkMG+a4VqFy+erbkmcDh3FvJ0g1XfeXteOitxS86krf8NRxlBur11UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0k0uhK6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0k0uhK6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7d481452732so6151712b3a.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716614; x=1765321414; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SOT8K49LtwTsG7RfVvoMzCrFv50BV70/2oRvQ12P5c=;
        b=d0k0uhK6Qm0JOXReeBcjAbyot1Z16AreRnJoPMCvRf1UuEsixBYNbPm067vwP6QMTc
         GJV26XHYo2+byoQfvtoZWmfzs2vwpY7FS/84pik9AhaAJHiKMlHnqvLMMCYYS+iDzEZ6
         Wl9/dDEmowaJuRNAnp9oIh0x9RBAI6nKsI1JnUGB68+lN6gIqKITD8iJd10SW6VL5XrX
         G+xrVd2lKXG30Kk/Rhr9IBP/OrM7rw8eOoUPYGtJ07+mERlXcxnlkuzHS8pceDkSn0Pd
         fIchSpbTPsSD6n9lrBTIg6q0yRtzwrZCbNxCLn0nPj2Jgk4UJr4i8kCn1TWCoiVpECwo
         lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716614; x=1765321414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SOT8K49LtwTsG7RfVvoMzCrFv50BV70/2oRvQ12P5c=;
        b=V5VFbanq+S3rp2hgISLfeQCdTxK5Q/vZiyGWfAgZ54qWjjvwdlHkFoT4LN9Bb4vUWr
         twzx2EU5bc0H4fHxIcDzK9yOPgX+D0F9i8sOQxrS7uAwYt9Q6y3XOYT0YNlFniBkSO+z
         1mKG216S/1YKTFDzVaWUX04Sr89HoBCD43ouluRa+6XxlTaYAsrevMScCPIog01JFSQz
         AJ2PG0dLhD4JcIBuKwI+MNj04Abhp0a2wb4IVeVEIHuoaaVV14htly25hoifCzsUO5im
         M6UUS6zXNXVGogd+Aye2vxd1uAGhCFfvBUwK0S4WHu3ZAelBzzBkePjbetkrUFy5Bgz7
         4Urg==
X-Forwarded-Encrypted: i=1; AJvYcCX7kNff2PLPl+Pilj46jdUOrKleXIGPm36QKGkC2I/isytErYlnuDA9pbJzKnCQUcYhU5mZNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE7n2r/FQYM/BlCueu34y5KsPmXXBK+Y87dBEYTLUAqAwppz9H
	YESyL8FlIQTaErJOsnIqw9MgNgqJJVhBymiJFfCHCflnFYR/8apo0vbeOEuA2KFxNV7fmUl1H4z
	gWHuX5JLfaAyEZg==
X-Google-Smtp-Source: AGHT+IEcuP7p0pMPfljCS082qx09HbScKKr0PxJnv71nQzkwGoiDBsND32iUweTwZ1Nrc3sZw3DhZl6u27Ra3Q==
X-Received: from pfwo10.prod.google.com ([2002:a05:6a00:1bca:b0:7cf:2dad:ff88])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a1a:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7e00f321535mr190120b3a.17.1764716613746;
 Tue, 02 Dec 2025 15:03:33 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:49 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-20-skhawaja@google.com>
Subject: [RFC PATCH v2 19/32] vfio/pci: Preserve the iommufd state of the vfio cdev
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

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu state of the device
and also the attached domain. The token returned by the preservation API
will be used to restore/rebind to the iommufd state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 23 +++++++++++++++++++----
 include/linux/kho/abi/vfio_pci.h       | 10 ++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index bcaf9de8a823..b721080599d5 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -15,6 +15,7 @@
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
 #include <linux/vfio.h>
+#include <linux/iommufd.h>
 
 #include "vfio_pci_priv.h"
 
@@ -38,9 +39,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_device *device = vfio_device_from_file(args->file);
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
+	int err, iommufd_token;
 	struct pci_dev *pdev;
 	struct folio *folio;
-	int err;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
@@ -51,15 +52,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (vfio_pci_is_intel_display(pdev))
 		return -EINVAL;
 
+	/* If iommufd is attached, preserve the underlying domain */
+	if (device->iommufd_attached) {
+		iommufd_token = iommufd_device_preserve(device->iommufd_device,
+							IOMMU_NO_PASID);
+		if (iommufd_token < 0)
+			return iommufd_token;
+	}
+
 	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(sizeof(*ser)));
-	if (!folio)
-		return -ENOMEM;
+	if (!folio) {
+		err = -ENOMEM;
+		goto error_folio;
+	}
 
 	ser = folio_address(folio);
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 	ser->reset_works = vdev->reset_works;
+	ser->iommufd_ser.token = iommufd_token;
 
 	err = kho_preserve_folio(folio);
 	if (err)
@@ -69,8 +81,11 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
 
-error:
+error_folio:
 	folio_put(folio);
+error:
+	if (device->iommufd_attached)
+		iommufd_device_unpreserve(device->iommufd_device);
 	return err;
 }
 
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 6c3d3c6dfc09..28d6eac5fd65 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -28,6 +28,15 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * struct vfio_iommufd_ser - Serialized state relevant attached iommufd.
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
2.52.0.158.g65b55ccf14-goog

