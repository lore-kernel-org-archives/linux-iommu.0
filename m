Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283731;
	b=JBoLNtmSyYow4a0N6ZMo9rB9Edo3Az4miC8WZmfuvqi+JQ4uttxNb2M84MtokxUlGGHj
	 bO6oOxungcX+VIDUJMz4mGvdQGk5CgKO1jU5dv39i2U4OP0vqO8tQAEKofRYXQON8pdTj
	 6Te7js5aXUEeHwhc7qHUSj8/CZibA8941eIlyZR12PA2fo7qVbHSbRx4E+C+tpVjdj8yC
	 e8fMYBb1wkDIzpzTpHstGlOoVXetvTPwQpVjkfOiq+w6ElzJ/rh/ZC1IJTz1gIn3+0Dka
	 +ORkl/euB3zV7FEiBEbsO8C1Y7WKVv/PbgLkvLMZBf690WTnBBBYW7Y5NVC4Bnn/OaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0rub+xln4n/D2nMP5gbX7vqe3u4SS7wL4MYPrcjQOIM=;
	b=0xgpGXPOQT5VgnLGoqiORtIPhIhvD/2IIv1I+Sf84w2033HlV7fz4qgyJRFd67lp+4rF
	 YU1S3Njn20tvyrD9B9/7scXSUNbmORZxDgfpm73iugjtE4LIFOO9um79WXhv9D2stu04t
	 Bx20glykzx9gJK5mtXgp7yGBDesTJiRFyjfUTykcUAWcMEDZnI6r/D6Ye+JhHxKCpIi7v
	 A9/B4S5OxSkq+8h0Bbxhyz/Og/zKP7PoqcrNKXfzG7KB57tXWGNGD1BlhR6owwnrCzx3B
	 Vid3TMz4hzUD1Jg3FwCJpZHxCsK1TmjBiUxUjpfQtOlZZ4TZqKCM1su7FiK1xaMa0bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a8ardXlr;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD660A5BD5
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DD660A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a8ardXlr
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed00709df0so15707445ad.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283730; x=1794888530; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0rub+xln4n/D2nMP5gbX7vqe3u4SS7wL4MYPrcjQOIM=;
        b=a8ardXlrd/7qo+eLmWQdsBeOKQh7HuU3pyNf4TD8X0nP9N8zThNmPtBRz2NLsMF7Bw
         GKd6yUSF+M15WKAvJi1r2o0uAPtRxMWrOEOYLKYzo7m4PckMRi92Mn88/k65g0/Gd5FZ
         +nfTSQQ6XtlJ05/B0pSQhfigwwgBvPbyIaedNLPFigUCVU4czWq/kFK/KUnhPkW3XmbZ
         XHegeHDkHpA0ZTl+3ALw6VqjTTOg3PBl2ym7iyrvfv0ZeuMk1U5w7H2JrSIiajom4zav
         AJ+ctWk9NXR1+80rrIhVDEedel8uhAR3J0shISQsDCT9LcZkqXdHUwrVa8yyVLipcUvz
         fjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283730; x=1794888530;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rub+xln4n/D2nMP5gbX7vqe3u4SS7wL4MYPrcjQOIM=;
        b=gU8xVHgGix887nNEawKiXi1+AXppBxb8n5//HQmp6Plh51tjKOSrt+QunjaxKE3OVF
         rLkzRiPwLQ2GPZq5/zz8FnuKCxCJ67/ick8YQt+BRrqxZhrcjc1ZkerFX5k/7KWtGSc5
         VgP1Bj5AcpMqa5vjcAukcz9r9ehrARSp6LTZaoaEaw3nodepjbTvK8UkND/7B3t4VBVG
         pQaeFPZCHIy2+kpB8GQGJCNsBz+zV9zlbHc0H/gl111XV3TjDsS0zVcMWPl5z5Pkipmx
         OSVujCdrSgBD4EpGw9YioIKvMK+XUTLUHmolQONSNtdnkDwxS8QmZaH0RhDUH2Owyg6l
         q3Jw==
X-Forwarded-Encrypted: i=1; AL+hErGpPbOgUvLMO6/yAEjjcww3GK6B5i+4mYKMuLg3wTQMCxmLFyrNNRCd+FklV/74tTfMY37cWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8i6sTC3YB5ffSt3qQlE/b1ptMkc9CaJE/vWqbLFyPXWfoBWSIR
	aFFKieuytkz2ZYKn5TJU+o/Ub63HaFvvtqE1gEmtVDor46f2mnAA1ISsfn3NDN2u5vXUbgv9jOz
	4ja7E9dVCt3hYbg==
X-Received: from plim16.prod.google.com ([2002:a17:903:3b50:b0:2e3:bd2:38ec])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:11d0:b0:2e9:a090:dd69 with SMTP id d9443c01a7336-2edb923d06dmr12701625ad.39.1794283729862;
 Mon, 09 Nov 2026 20:08:49 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:23 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-18-skhawaja@google.com>
Subject: [PATCH v7 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
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
Content-Transfer-Encoding: quoted-printable

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

VFIO PCI live update currently supports only devices in noiommu mode.
Lift that restriction for IOMMU-backed devices that are preserved with
their iommufd state.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/device_cdev.c             |  10 ++
 drivers/vfio/pci/Kconfig               |  13 ++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 129 +++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_priv.h       |  12 ++-
 include/linux/kho/abi/vfio_pci.h       |  15 ++-
 5 files changed, 141 insertions(+), 38 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index a53922adc388..edcec2824e18 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -316,6 +316,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *d=
f,
 	}
=20
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		ret =3D -EBUSY;
+		goto out_unlock;
+	}
+
 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
 		ret =3D device->ops->pasid_attach_ioas(device,
 						     attach.pasid,
@@ -374,6 +379,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *d=
f,
 	}
=20
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		mutex_unlock(&device->dev_set->lock);
+		return -EBUSY;
+	}
+
 	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
 		device->ops->pasid_detach_ioas(device, detach.pasid);
 	else
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 71289d8908f6..a9884d3ec864 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -44,12 +44,15 @@ config VFIO_PCI_IGD
 	  To enable Intel IGD assignment through vfio-pci, say Y.
=20
 config VFIO_PCI_LIVEUPDATE
-	bool "VFIO PCI support for Live Update in no-iommu mode"
-	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU && VFIO_DEVICE_CDEV
+	bool "VFIO PCI support for Live Update"
+	depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
+	depends on VFIO_NOIOMMU || IOMMU_LIVEUPDATE
 	help
-	  Support for preserving devices bound to vfio-pci in no-iommu mode
-	  across a Live Update. It enables a device to continue working (DMA)
-	  while host kernel is going through a kexec live update.
+	  Support for preserving devices bound to vfio-pci across a Live
+	  Update. It enables a device to continue working (DMA) while host
+	  kernel is going through a kexec live update. Devices in no-iommu
+	  mode need VFIO_NOIOMMU, and IOMMU-backed devices need
+	  IOMMU_LIVEUPDATE to preserve their IOMMU state.
=20
 	  If you don't know what to do here, say N.
=20
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio=
_pci_liveupdate.c
index 00c008117259..86f532e4c9f1 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -9,15 +9,16 @@
 /**
  * DOC: VFIO PCI Preservation via LUO
  *
- * VFIO PCI devices in noiommu mode can be preserved over a kexec using th=
e Live
+ * VFIO PCI devices can be preserved over a kexec using the Live
  * Update Orchestrator (LUO) file preservation while keeping the device ru=
nning
  * and performing DMA across the kexec transition. This allows userspace (=
such
  * as a VMM or userspace driver) to transfer an in-use device to the next =
kernel
  * without resetting it.
  *
  * .. note::
- *    This support is enabled by ``CONFIG_VFIO_PCI_LIVEUPDATE`` and is lim=
ited
- *    to devices in noiommu mode (see Restrictions below).
+ *    This support is enabled by ``CONFIG_VFIO_PCI_LIVEUPDATE``. Devices i=
n
+ *    noiommu mode are supported. IOMMU-backed devices are supported when
+ *    ``CONFIG_IOMMU_LIVEUPDATE`` is enabled (see Restrictions below).
  *
  * Usage Example
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -54,15 +55,22 @@
  *
  * The kernel imposes the following restrictions when preserving VFIO devi=
ces:
  *
- *  * The device must be bound to the ``vfio-pci`` driver (not a variant d=
river)
- *    and registered in **noiommu** mode (``vfio.enable_unsafe_noiommu_mod=
e=3D1``
- *    with no IOMMU group attached to the device). Attempting to preserve =
an
- *    IOMMU-backed device fails with ``-EOPNOTSUPP``.
+ *  * The device must be bound to the ``vfio-pci`` driver (not a variant d=
river).
+ *
+ *  * A device in **noiommu** mode (``vfio.enable_unsafe_noiommu_mode=3D1`=
` with
+ *    no IOMMU group attached to the device) is preserved on its own.
+ *
+ *  * An IOMMU-backed device is preserved together with its iommufd state.=
 The
+ *    device must be attached to a HWPT marked for preservation with
+ *    ``IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE``, and the iommufd must be pre=
served
+ *    in the same session before the device. Otherwise preserving the devi=
ce
+ *    fails. After kexec, the device can only be retrieved if the iommufd =
it
+ *    was preserved with can be retrieved.
  *
  *  * The device file descriptor must be obtained by opening the VFIO char=
acter
- *    device (``/dev/vfio/devices/noiommu-vfioX``) and not via
- *    ``VFIO_GROUP_GET_DEVICE_FD``, and ``VFIO_DEVICE_BIND_IOMMUFD`` must =
have
- *    completed on that file descriptor before it is preserved.
+ *    device (``/dev/vfio/devices/vfioX`` or ``/dev/vfio/devices/noiommu-v=
fioX``)
+ *    and not via ``VFIO_GROUP_GET_DEVICE_FD``, and ``VFIO_DEVICE_BIND_IOM=
MUFD``
+ *    must have completed on that file descriptor before it is preserved.
  *
  *  * ``CONFIG_VFIO_PCI_ZDEV_KVM`` must not be enabled. This may be relaxe=
d in
  *    the future.
@@ -189,6 +197,7 @@
 #include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/iommufd.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -202,6 +211,8 @@
=20
 #include "vfio_pci_priv.h"
=20
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handle=
r *handler,
 					     struct file *file)
 {
@@ -245,12 +256,11 @@ static int vfio_pci_liveupdate_preserve(struct liveup=
date_file_op_args *args)
 	struct vfio_pci_core_device *vdev;
 	size_t saved_size =3D 0, total_size;
 	struct pci_dev *pdev;
+	u64 iommufd_token =3D 0;
+	u32 flags =3D 0;
 	u16 cfg_size;
 	int err;
=20
-	if (!vfio_device_is_noiommu(device))
-		return -EOPNOTSUPP;
-
 	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
 	pdev =3D vdev->pdev;
 	cfg_size =3D pdev->cfg_size;
@@ -263,56 +273,89 @@ static int vfio_pci_liveupdate_preserve(struct liveup=
date_file_op_args *args)
 	if (!vfio_file_is_bound_cdev(args->file))
 		return -EINVAL;
=20
+	/*
+	 * Devices that are not in noiommu mode are preserved together with
+	 * their iommufd state, so that their DMA keeps being translated across
+	 * kexec.
+	 */
+	if (!vfio_device_is_noiommu(device)) {
+		err =3D iommufd_device_preserve(args->session,
+					      device->iommufd_device,
+					      &iommufd_token);
+		if (err)
+			return err;
+
+		flags |=3D VFIO_PCI_SER_IOMMUFD;
+	}
+
 	if (vdev->pci_saved_state) {
 		saved_size =3D pci_liveupdate_saved_state_ser_size(vdev->pci_saved_state=
);
-		if (!saved_size)
-			return -EINVAL;
+		if (!saved_size) {
+			err =3D -EINVAL;
+			goto err_iommufd_unpreserve;
+		}
 	}
=20
 	total_size =3D size_add(sizeof(*ser),
 			      size_add(size_mul(2, cfg_size), saved_size));
-	if (total_size > U32_MAX)
-		return -EOVERFLOW;
+	if (total_size > U32_MAX) {
+		err =3D -EOVERFLOW;
+		goto err_iommufd_unpreserve;
+	}
=20
 	ser =3D kho_alloc_preserve(total_size);
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	if (IS_ERR(ser)) {
+		err =3D PTR_ERR(ser);
+		goto err_iommufd_unpreserve;
+	}
=20
 	if (saved_size) {
 		void *dst =3D ser->data + 2 * (size_t)cfg_size;
=20
 		err =3D pci_liveupdate_serialize_saved_state(vdev->pci_saved_state,
 							   dst, saved_size);
-		if (err) {
-			kho_unpreserve_free(ser);
-			return err;
-		}
+		if (err)
+			goto err_free;
 	}
=20
 	err =3D pci_liveupdate_preserve(pdev);
-	if (err) {
-		kho_unpreserve_free(ser);
-		return err;
-	}
+	if (err)
+		goto err_free;
=20
 	ser->domain =3D pci_domain_nr(pdev->bus);
 	ser->bdf =3D pci_dev_id(pdev);
 	ser->cfg_size =3D cfg_size;
 	ser->size =3D total_size;
-	ser->flags =3D vdev->reset_works ? VFIO_PCI_SER_RESET_WORKS : 0;
+	ser->flags =3D flags;
+	if (vdev->reset_works)
+		ser->flags |=3D VFIO_PCI_SER_RESET_WORKS;
 	ser->saved_state_size =3D saved_size;
 	ser->reserved =3D 0;
+	ser->iommufd_token =3D iommufd_token;
=20
 	args->serialized_data =3D virt_to_phys(ser);
 	return 0;
+
+err_free:
+	kho_unpreserve_free(ser);
+err_iommufd_unpreserve:
+	if (flags & VFIO_PCI_SER_IOMMUFD)
+		iommufd_device_unpreserve(args->session, device->iommufd_device);
+	return err;
 }
=20
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args =
*args)
 {
+	struct vfio_pci_core_device_ser *ser =3D phys_to_virt(args->serialized_da=
ta);
 	struct vfio_device *device =3D vfio_device_from_file(args->file);
+	bool iommufd =3D ser->flags & VFIO_PCI_SER_IOMMUFD;
+
+	guard(mutex)(&device->dev_set->lock);
=20
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
-	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+	kho_unpreserve_free(ser);
+	if (iommufd)
+		iommufd_device_unpreserve(args->session, device->iommufd_device);
 }
=20
 static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args=
)
@@ -486,6 +529,28 @@ vfio_pci_liveupdate_attach_incoming(struct vfio_pci_co=
re_device *vdev,
 	return 0;
 }
=20
+/*
+ * A device preserved with its iommufd state can only be retrieved togethe=
r
+ * with that iommufd, so fetch it using the saved token and fail if it can=
't be
+ * retrieved.
+ */
+static int vfio_pci_liveupdate_retrieve_iommufd(struct liveupdate_session =
*s,
+						const struct vfio_pci_core_device_ser *ser)
+{
+	struct file *file;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
+		return -EOPNOTSUPP;
+
+	ret =3D liveupdate_get_file_incoming(s, ser->iommufd_token, &file);
+	if (ret)
+		return ret;
+
+	fput(file);
+	return 0;
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *ar=
gs)
 {
 	struct pci_saved_state *saved_state =3D NULL;
@@ -513,7 +578,11 @@ static int vfio_pci_liveupdate_retrieve(struct liveupd=
ate_file_op_args *args)
 	vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
 	pdev =3D vdev->pdev;
=20
-	if (!vfio_device_is_noiommu(device)) {
+	if (ser->flags & VFIO_PCI_SER_IOMMUFD) {
+		ret =3D vfio_pci_liveupdate_retrieve_iommufd(args->session, ser);
+		if (ret)
+			goto out_put_dev;
+	} else if (!vfio_device_is_noiommu(device)) {
 		ret =3D -EOPNOTSUPP;
 		goto out_put_dev;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_p=
riv.h
index 2549a5321fce..a5f6c0d3085f 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -194,10 +194,18 @@ vfio_pci_liveupdate_check_noiommu(struct vfio_pci_cor=
e_device *vdev)
 {
 	guard(mutex)(&vdev->vdev.dev_set->lock);
=20
+	/*
+	 * A device preserved with its iommufd state keeps doing DMA through
+	 * the restored IOMMU domain. The IOMMU core claims DMA ownership of its
+	 * group when it restores the domain at boot, and nothing else can own
+	 * the group before the device is opened, so an owned group means the
+	 * device was restored and can keep running.
+	 */
 	if (vdev->liveupdate_kept_running &&
-	    !vfio_device_is_noiommu(&vdev->vdev)) {
+	    !vfio_device_is_noiommu(&vdev->vdev) &&
+	    !iommu_group_dma_owner_claimed(vdev->vdev.dev->iommu_group)) {
 		pci_warn(vdev->pdev,
-			 "Stopping device kept running across Live Update: not in noiommu mode\=
n");
+			 "Stopping device kept running across Live Update: not in noiommu mode =
and IOMMU state not restored\n");
 		pci_clear_master(vdev->pdev);
 		vdev->liveupdate_stopped_early =3D true;
 	}
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_=
pci.h
index 3ace2c9d8a4f..33b410d9a026 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -38,7 +38,17 @@
  */
 #define VFIO_PCI_SER_RESET_WORKS	BIT(0)
=20
-#define VFIO_PCI_SER_KNOWN_FLAGS	VFIO_PCI_SER_RESET_WORKS
+/**
+ * define VFIO_PCI_SER_IOMMUFD - Device was preserved with its iommufd sta=
te.
+ *
+ * Set in &vfio_pci_core_device_ser.flags when the device was not in noiom=
mu
+ * mode and its iommufd state was preserved. The LUO token of the preserve=
d
+ * iommufd is stored in &vfio_pci_core_device_ser.iommufd_token.
+ */
+#define VFIO_PCI_SER_IOMMUFD		BIT(1)
+
+#define VFIO_PCI_SER_KNOWN_FLAGS	(VFIO_PCI_SER_RESET_WORKS | \
+					 VFIO_PCI_SER_IOMMUFD)
=20
 /**
  * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
@@ -54,6 +64,8 @@
  * @saved_state_size: Size in bytes of the serialized &struct pci_saved_st=
ate_ser
  *                    blob stored in @data after ``config_map``, or 0 if n=
one.
  * @reserved: Reserved for future use; must be 0.
+ * @iommufd_token: LUO token of the preserved iommufd, valid only when
+ *                 ``VFIO_PCI_SER_IOMMUFD`` is set in @flags.
  * @data: Variable-length payload containing, in order:
  *        1. ``u8 vconfig[@cfg_size]`` =E2=80=94 VFIO virtualized config s=
pace snapshot
  *           captured during ``freeze()``.
@@ -70,6 +82,7 @@ struct vfio_pci_core_device_ser {
 	u32 flags;
 	u32 saved_state_size;
 	u32 reserved;
+	u64 iommufd_token;
 	u8 data[];
 } __packed;
=20
--=20
2.56.0.506.g506a7eabc5-goog

