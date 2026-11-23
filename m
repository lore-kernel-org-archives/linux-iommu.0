Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409394;
	b=TZvS7Cu2lKh+eMMM9FE4XmxxwuKdCUj7c9WIRcP704N+uyGmAYye7eL1HCdBhVi4gkIF
	 Aqiq2PtvvqCRL/LIwGzd5SUtDb61dL0McmqE2tm1ovoeMzkrscigTpaCIRCzETfHeq7Va
	 w2ThWFoE268owsUa7d0GRsHud8uqNSXQWdJ0JMkhDltLr9GInvUVjs+8bFpF8iQXkrJWt
	 uvS8ssZcI9NTfs28JHuCrTW80OjAlAOialIzH1LdjTeJ/FXR8rtAcy/yt28KJbuglKczW
	 Uem5iYacorBnzZaTQ2hlghdaSjEY5IZ+Xa6hsialVW0VXMvcuWxU73j9x2ZmxnJBIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CL5ZFyibh5FZv0RzYBn3Eh032B88L6s/yjW25GtwPg8=;
	b=3v+nd+zv/H07YNKKLGSV9agq9tmZSPzxiv1eJ5oCl6BJwLdO7skplEJNPp1sgFA5kzx/
	 k/J+stkeUyzH8/ozFgtnYGFepwTcQUGvn0f+Tsk0l5NNuLJ4Fy3oxI3597U0yaggJlZtV
	 22hPTBwFR6s4JjUcRPfR1T+e3aCOwVwnYlQFBfGk94M/GCwnkqJZSL6Izif4N++11/bK+
	 R7ssEAZiZ6H6w5exW/dPUWdUMfHDvxo5i+8XO4pj+KYZ82A/mayAgnvqjEOBbOdF1STiu
	 F2/ZfpOzZ32HCalISApsz+Dp7Rys1oDhVUmEwFlvMB853zcJnWVDh0HkH5WLkCGBh2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZnRWykPs;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A9606A338
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 594A9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZnRWykPs
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f08491d837so4934395ad.0
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409394; x=1796014194; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CL5ZFyibh5FZv0RzYBn3Eh032B88L6s/yjW25GtwPg8=;
        b=ZnRWykPsW28mT5dfhyreBMQ4MF9mvY/a+Po6/O34gdWGpdwmTbgGQYj9BiEO9rP7rM
         nCwTdMl8jHsM+W7HXB9agPQygaAooKDsj4McbUVdG/Uk5CpyzRLtoqXrEhS/wBajKgym
         evmnwVBmdzk7I/u+VQ3cxbGPbW3y1dSV9i3BfZ2UzLpqcHvDFhp0LfoLOCMocEl9HCiX
         z2M7NVjKwER6R5vCfZzctF+GFOP/xH19sBoSET0oENdHVAVvpk7vK3DA26ea4wh3Oela
         kRw0yOPKb1YyyBLcdx5Et7yV3OA94MTj0I50PoOkrpopOBVwU4V3XT0mNlljI50xhB/L
         AoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409394; x=1796014194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CL5ZFyibh5FZv0RzYBn3Eh032B88L6s/yjW25GtwPg8=;
        b=ikK+DQaS0m76XjiW3JxOzLwkjSUrMa/OzrBbSOdYD+OhBANXpIoKWr2Y8NwDFPj0il
         koQ4UHdNlicrlqlWDP9R+i5AvgLNkyRpBjs7btPe0nevk5SvficKJ4YeEO687RoLHejJ
         yPylE35ifSijLJMTrUIjcvfTpjQjFhD48GcjhMJmFffi4SrPV2xehkLfqEUSshfLQxxO
         cujMA2FWlKv5tv/SA+KSAK4j7RscLpHi9hVlMIJtACHtOQ1d3bz4xw2U4QtuNRVNdYuC
         8KaU9M9JVea3ZwSggtzFjVLIGT71DbO4WoYL4meHJ49z9QI+CRltqrtpDzBGUqF0Q/cm
         1lPQ==
X-Forwarded-Encrypted: i=1; AL+hErHiUkZWxsptM2QsMyVAEHqKHPljjs7cJc82egtXZIdPk7uIdJNThOgPVX2e2sHRgc0/qRyxZw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+EJEAWau1axpKYOkTaiIpxuU4wJ+6Kjl0X5ty5XpUiZfW80z5g
	6T/FFgZbOkG1ajWrwRU80I/qcB9jFwdglL0as2OSRvayXRa164lZAdd5DOVySLPYuLQm5FbjpUZ
	JjZtMcMLbTwp5yQ==
X-Received: from plfu17.prod.google.com ([2002:a17:902:e5d1:b0:2f0:4ed9:64dd])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacb:b0:2e9:95c0:7c50 with SMTP id d9443c01a7336-2f03f271e00mr96167465ad.71.1795409393466;
 Sun, 22 Nov 2026 20:49:53 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:33 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-3-skhawaja@google.com>
Subject: [PATCH v8 02/18] iommu: Implement IOMMU Live update FLB callbacks
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
alloc/free helper functions to allocate memory for the IOMMU Live update
FLB object and the serialization structs for device, domain and iommu.

During retrieve, walk through the preserved obj array headers and
restore each folio. Also recreate the FLB obj.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |   9 ++
 drivers/iommu/Kconfig            |  12 ++
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/liveupdate.c       | 241 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  28 ++++
 include/linux/kho/abi/iommu.h    | 190 ++++++++++++++++++++++++
 6 files changed, 481 insertions(+)
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-liveupdate.h
 create mode 100644 include/linux/kho/abi/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c00d3612c9ac..96ac907af0d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14139,6 +14139,15 @@ F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
 F:	rust/kernel/iommu/
 
+IOMMU LIVEUPDATE
+M:	Samiullah Khawaja <skhawaja@google.com>
+R:	Pranjal Shrivastava <praan@google.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+F:	drivers/iommu/liveupdate.c
+F:	include/linux/iommu-liveupdate.h
+F:	include/linux/kho/abi/iommu.h
+
 IOMMUFD
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Kevin Tian <kevin.tian@intel.com>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30..13d4759c3f4c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -421,6 +421,18 @@ config IOMMU_DEBUG_PAGEALLOC
 	  line to activate the runtime checks.
 
 	  If unsure, say N.
+
+config IOMMU_LIVEUPDATE
+	bool "IOMMU live update state preservation support"
+	depends on LIVEUPDATE && IOMMUFD && 64BIT
+	help
+	  Enable support for preserving IOMMU state across a kexec live update.
+
+	  This allows devices managed by iommufd to maintain their DMA mappings
+	  during kexec base kernel update.
+
+	  If unsure, say N.
+
 endif # IOMMU_SUPPORT
 
 source "drivers/iommu/generic_pt/Kconfig"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 29a26d2a3af1..248adfabd1bc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
new file mode 100644
index 000000000000..a1f40e242d93
--- /dev/null
+++ b/drivers/iommu/liveupdate.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+/**
+ * DOC: IOMMU Live Update
+ *
+ * The IOMMU subsystem participates in the Live Update process to preserve its
+ * IOMMU domains and IOMMU specific state of preserved devices.
+ *
+ * File-Lifecycle-Bound (FLB) Data
+ * ===============================
+ *
+ * Preserved state of IOMMU HW needs to be restored during boot when the IOMMU is
+ * initialized and registered. The preserved IOMMU domains also need to be
+ * restored and associated with the preserved devices early during boot. For
+ * this reason, IOMMU subsystem uses LUO File-Lifecycle-Bound Data to store some
+ * state globally.
+ *
+ * During preservation of IOMMUFD into LUO, some of the state is stored in the
+ * IOMMU FLB so it can be restored during boot. Once the FDs are retrieved from LUO
+ * the restored state can be reassociated with the relevant IOMMUFDs.
+ *
+ * The FLB also contains the state of IOMMU HW that might be shared between
+ * multiple devices, domains and iommufds. This is restored early during boot
+ * and no re-association of this state is needed later.
+ *
+ * As the state is preserved using KHO, the FLB handler callbacks are called by
+ * LUO only when the KHO is enabled. So there is no need to check whether KHO is
+ * enabled in the callback implementation.
+ *
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/errno.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/iommu.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho_block.h>
+#include <linux/liveupdate.h>
+
+/**
+ * struct iommu_ser_set - Set of serialized objects of one type
+ * @bs: KHO block set holding the serialized objects
+ * @it: Iterator used to reserve new objects at the end of @bs
+ * @count: Number of reserved objects, including the deleted ones
+ * @head_pa: Field of struct iommu_flb_ser that records the head of @bs
+ */
+struct iommu_ser_set {
+	struct kho_block_set bs;
+	struct kho_block_set_it it;
+	u64 count;
+	u64 *head_pa;
+};
+
+struct iommu_flb_obj {
+	/* Protects the serialized state and the object sets */
+	struct mutex lock;
+	struct iommu_flb_ser *ser;
+
+	struct iommu_ser_set iommu_set;
+	struct iommu_ser_set domain_set;
+	struct iommu_ser_set device_set;
+};
+
+/*
+ * Restore a set of serialized objects from the previous kernel. The objects
+ * are read using the size recorded by the previous kernel in their header.
+ *
+ * Failure to restore preserved IOMMU state is considered fatal. This is
+ * because the IOMMU translations for preserved IOMMUs were kept enabled in the
+ * previous kernel and the preserved devices have their IOMMU domains still
+ * present. Not being able to restore means that the memory mapped into
+ * preserved domains might be already corrupted by the preserved devices.
+ */
+static void iommu_ser_set_restore(struct iommu_ser_set *set, u64 head_pa)
+{
+	size_t entry_size = sizeof(struct iommu_hdr_ser);
+
+	if (head_pa) {
+		struct kho_block_header_ser *block = phys_to_virt(head_pa);
+		struct iommu_hdr_ser *hdr = (void *)(block + 1);
+
+		entry_size = hdr->size;
+	}
+
+	if (entry_size < sizeof(struct iommu_hdr_ser) ||
+	    entry_size > KHO_BLOCK_SIZE - sizeof(struct kho_block_header_ser))
+		goto err_fatal;
+
+	kho_block_set_init(&set->bs, entry_size);
+	if (kho_block_set_restore(&set->bs, head_pa))
+		goto err_fatal;
+
+	return;
+
+err_fatal:
+	panic("Failed to restore IOMMU Live Update FLB\n");
+}
+
+static void iommu_liveupdate_flb_free(struct iommu_flb_obj *obj)
+{
+	kho_block_set_destroy(&obj->domain_set.bs);
+	kho_block_set_destroy(&obj->device_set.bs);
+	kho_block_set_destroy(&obj->iommu_set.bs);
+
+	kho_unpreserve_free(obj->ser);
+	mutex_destroy(&obj->lock);
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj;
+	struct iommu_flb_ser *ser;
+
+	/* obj exists only in the current kernel to track preserved state */
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	/* ser is allocated via KHO and will survive the kexec */
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser)) {
+		kfree(obj);
+		return PTR_ERR(ser);
+	}
+
+	mutex_init(&obj->lock);
+	obj->ser = ser;
+	ser->version = IOMMU_LUO_FLB_VERSION;
+
+	kho_block_set_init(&obj->domain_set.bs, sizeof(struct iommu_domain_ser));
+	obj->domain_set.head_pa = &ser->domain_block_phys;
+	kho_block_set_init(&obj->device_set.bs, sizeof(struct iommu_device_ser));
+	obj->device_set.head_pa = &ser->device_block_phys;
+	kho_block_set_init(&obj->iommu_set.bs, sizeof(struct iommu_hw_ser));
+	obj->iommu_set.head_pa = &ser->iommu_block_phys;
+
+	argp->obj = obj;
+	argp->data = virt_to_phys(ser);
+	return 0;
+}
+
+static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	iommu_liveupdate_flb_free(argp->obj);
+}
+
+static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj = argp->obj;
+
+	kho_block_set_destroy(&obj->domain_set.bs);
+	kho_block_set_destroy(&obj->device_set.bs);
+	kho_block_set_destroy(&obj->iommu_set.bs);
+
+	folio_put(virt_to_folio(obj->ser));
+	mutex_destroy(&obj->lock);
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj;
+	struct iommu_flb_ser *ser;
+
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	if (!obj) {
+		/*
+		 * If retrieve fails, the finish path won't be called as
+		 * can_finish() will fail, preventing the restore.
+		 */
+		return -ENOMEM;
+	}
+
+	/* Data must be present and valid from the previous kernel */
+	if (!kho_restore_folio(argp->data))
+		panic("Failed to restore IOMMU Live Update FLB\n");
+
+	ser = phys_to_virt(argp->data);
+
+	/*
+	 * FLB version mismatch is considered fatal for security reasons for
+	 * now. Check it before restoring the arrays, as their layout depends
+	 * on the version.
+	 */
+	if (ser->version != IOMMU_LUO_FLB_VERSION)
+		panic("Incoming IOMMU FLB version (v%llu) is incompatible with this kernel (v%d)\n",
+		      ser->version, IOMMU_LUO_FLB_VERSION);
+
+	mutex_init(&obj->lock);
+	obj->ser = ser;
+
+	iommu_ser_set_restore(&obj->domain_set, ser->domain_block_phys);
+	iommu_ser_set_restore(&obj->device_set, ser->device_block_phys);
+	iommu_ser_set_restore(&obj->iommu_set, ser->iommu_block_phys);
+	argp->obj = obj;
+	return 0;
+}
+
+static struct liveupdate_flb_ops iommu_flb_ops = {
+	.preserve = iommu_liveupdate_flb_preserve,
+	.unpreserve = iommu_liveupdate_flb_unpreserve,
+	.retrieve = iommu_liveupdate_flb_retrieve,
+	.finish = iommu_liveupdate_flb_finish,
+};
+
+static struct liveupdate_flb iommu_flb = {
+	.compatible = IOMMU_LUO_FLB_COMPATIBLE,
+	.ops = &iommu_flb_ops,
+};
+
+/**
+ * iommu_liveupdate_register_flb() - Register IOMMU Live Update FLB
+ * @handler: Live Update file handler to associate FLB with
+ *
+ * Register a Live Update FLB for IOMMU state preservation with the file
+ * handler.
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
+{
+	return liveupdate_register_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_liveupdate_register_flb);
+
+/**
+ * iommu_liveupdate_unregister_flb() - Unregister IOMMU Live Update FLB
+ * @handler: Live Update file handler to associate FLB with
+ */
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+	liveupdate_unregister_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_liveupdate_unregister_flb);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
new file mode 100644
index 000000000000..4755ab3cd67a
--- /dev/null
+++ b/include/linux/iommu-liveupdate.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_IOMMU_LIVEUPDATE_H
+#define _LINUX_IOMMU_LIVEUPDATE_H
+
+#include <linux/iommu.h>
+#include <linux/liveupdate.h>
+#include <linux/kho/abi/iommu.h>
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+#else
+static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
+{
+	return 0;
+}
+
+static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+}
+#endif
+#endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
new file mode 100644
index 000000000000..a36b498941b0
--- /dev/null
+++ b/include/linux/kho/abi/iommu.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_IOMMU_H
+#define _LINUX_KHO_ABI_IOMMU_H
+
+#include <linux/mutex_types.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
+#include <linux/kho/abi/block.h>
+#include <linux/types.h>
+
+/**
+ * DOC: IOMMU File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * This header defines the ABI for preserving IOMMU state across kexec using
+ * Live Update File-Lifecycle Bound (FLB) data.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in IOMMU_LUO_FLB_VERSION.
+ *
+ * Memory Layout of Serialization Structures:
+ * ==========================================
+ *
+ * Each serialized type (IOMMU, Domain, Device) is stored in a set of KHO
+ * serialization blocks (see include/linux/kho/abi/block.h). Each block starts
+ * with a struct kho_block_header_ser, followed by the serialized objects of
+ * the respective type. Blocks are linked through the next field of the header.
+ *
+ * Top Level (struct iommu_flb_ser):
+ * +---------------------------+
+ * | - iommu_block_phys        |
+ * | - domain_block_phys       |
+ * | - device_block_phys       |
+ * +---------------------------+
+ *
+ * For example see below the representation of the domain blocks.
+ *
+ * +---------------------------+   +---------------------------+
+ * | kho_block_header_ser      |-->| kho_block_header_ser      |--> NULL
+ * | - next                    |   | - next                    |
+ * | - count                   |   | - count                   |
+ * |                           |   |                           |
+ * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
+ * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
+ * | ...                       |   | ...                       |
+ * +---------------------------+   +---------------------------+
+ *
+ * Each object in a block starts with a common header (iommu_hdr_ser). The
+ * size in the header is the size of each object in the block, so the next
+ * kernel can read the objects even if their size has changed.
+ * For example, the layout of struct iommu_domain_ser is:
+ *
+ *   +-----------------------------+
+ *   | iommu_domain_ser            |
+ *   | +-------------------------+ |
+ *   | | hdr (iommu_hdr_ser)     | |
+ *   | | - ref_count             | |
+ *   | | - deleted / incoming    | |
+ *   | +-------------------------+ |
+ *   | - top_table_phys          | |
+ *   | - top_level               | |
+ *   | - restored_domain         | |
+ *   +-----------------------------+
+ *
+ * This pattern applies identically to iommu_device_ser and iommu_hw_ser.
+ */
+
+#define IOMMU_LUO_FLB_COMPATIBLE "iommu-liveupdate"
+#define IOMMU_LUO_FLB_VERSION 1
+
+/**
+ * enum iommu_type_ser - Type of the IOMMU being preserved
+ * @IOMMU_SER_TYPE_INVALID: Invalid type of IOMMU
+ *
+ * IOMMU type is stored in the IOMMU HW state to differentiate between various
+ * IOMMU HWs.
+ */
+enum iommu_type_ser {
+	IOMMU_SER_TYPE_INVALID,
+};
+
+#define IOMMU_SER_FLAG_DELETED	BIT(0)
+#define IOMMU_SER_FLAG_INCOMING	BIT(1)
+
+/**
+ * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
+ * @ref_count: Reference count for the object
+ * @flags: Bitmask of IOMMU_SER_FLAG_* flags indicating object state
+ * @size: Size of the serialized object
+ * @features: Bitmask of object specific features used by the preserved state
+ */
+struct iommu_hdr_ser {
+	u32 ref_count;
+	u32 flags;
+	u32 size;
+	u32 features;
+} __packed;
+
+/**
+ * struct iommu_domain_ser - Serialized state of an IOMMU domain
+ * @hdr: Common object header
+ * @top_table_phys: Physical address of the top-level page table
+ * @top_level: Level of the top-level page table
+ * @max_vasz_lg2: Maximum number of bits the VA can contain
+ * @sign_extend: FEAT_SIGN_EXTEND is enabled for this domain
+ * @padding: Padding
+ * @restored_domain: Pointer to the restored domain (valid only after restore)
+ */
+struct iommu_domain_ser {
+	struct iommu_hdr_ser hdr;
+	u64 top_table_phys;
+	u64 top_level;
+	u32 max_vasz_lg2;
+	u8 sign_extend;
+	u8 padding[3];
+	struct iommu_domain *restored_domain;
+} __packed;
+
+/**
+ * struct iommu_attachment_ser - Serialized attachment between device and domain.
+ * @attachment_id: ID of the attachment between device and domain.
+ * @domain_phys: Physical address of the domain
+ * @pasid: PASID of the attachment
+ * @padding: Padding
+ */
+struct iommu_attachment_ser {
+	u64 attachment_id;
+	u64 domain_phys;
+	u32 pasid;
+	u32 padding;
+} __packed;
+
+/**
+ * struct iommu_device_ser - Serialized state of a device
+ * @hdr: Common object header
+ * @devid: Device ID
+ * @pci_domain_nr: PCI domain number
+ * @dma_owner_token: Token to identify the DMA owner of this device
+ * @iommu_phys: Physical address of the serialized IOMMU the device is behind
+ * @attachment: Attachment of the device to its domain
+ * @reserved: Reserved for future common fields.
+ */
+struct iommu_device_ser {
+	struct iommu_hdr_ser hdr;
+	u32 devid;
+	u32 pci_domain_nr;
+	u64 dma_owner_token;
+	u64 iommu_phys;
+	struct iommu_attachment_ser attachment;
+	u64 reserved[2];
+} __packed;
+
+/**
+ * struct iommu_hw_ser - Serialized state of an IOMMU instance
+ * @hdr: Common object header
+ * @token: Unique token to identify the IOMMU instance
+ * @type: IOMMU type serialized state belongs to
+ * @reserved: Reserved for future common fields.
+ */
+struct iommu_hw_ser {
+	struct iommu_hdr_ser hdr;
+	u64 token;
+	u64 type;
+	u64 reserved[2];
+} __packed;
+
+/**
+ * struct iommu_flb_ser - Top-level serialization structure
+ * @version: Version of the serialized data, IOMMU_LUO_FLB_VERSION
+ * @iommu_block_phys: Physical address of the first KHO block of IOMMU HWs, or
+ *                    0 if none
+ * @domain_block_phys: Physical address of the first KHO block of domains, or
+ *                     0 if none
+ * @device_block_phys: Physical address of the first KHO block of devices, or 0
+ *                     if none
+ */
+struct iommu_flb_ser {
+	u64 version;
+	u64 iommu_block_phys;
+	u64 domain_block_phys;
+	u64 device_block_phys;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMU_H */
-- 
2.56.1.809.ga0b61035b5-goog

