Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283720;
	b=0SaUnm8/mUZItrFnAF1/Mr7DynojoX7XqYHzqnvt850xE7Vj1tMVAlAqHTdlxjAf3J3A
	 Gt3zz+J8K4/6BLR0niiv8JXikoWrpuYlRasu27XpE7SXkwMu4KkF23lHfT9z9e+XnxHER
	 F/Uy6ytSWw7st34RNcHOnBRn1YmAuU4oT7/thltDV+mYjCRpT8A4M+Fdd654C7ZFIzPwL
	 KqREo2cyRQvI8hmFEbaEXb5/NgdR/oDUyP/kKwOSgfYhkRXPhduBV7P6BKZn3EcMLX//n
	 8DfPJAcYO7GMCHezhoR/Hjx/FyBYPgLz5o3PBrotsj8Q0wsdHUimOb9i3uQcFkcQqAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gWcpdZO/8NkcHce3xnRkp/Wp95PYKC+yG0pe4X1kX2w=;
	b=sKhU35r+nRZmJtw/m83pNmnVgY3yCCTvHouIMWJVQ97fT5KqDNRYSxjSjCmQDT/MNdPA
	 Zw3gKFf8aCKGPu5j15db8cdbNACSf9mMZvPYHY7l07EWqVMS4mqXBxpUZBDxdC/Edgk1L
	 S/YMtUpNIFMZz0MkRJBVx5s9zPBcq/G0cqlGHbD2cIpvvxb1A0/O+FyWvhmJap9Q+faGr
	 sBWcCag7cBFFJtRre6Ipx17TE/l8y6GesMGROX1vgE4FDOm6gGbYlNfWC27AkW/fpx44w
	 rj7kif1G47stHTMyRNTID3asrXCaG6dRDQgt3ac9RxTQCD4QPAMD43InsUS/hwwUP0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiB1GvMz;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECC60A3834
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25ECC60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiB1GvMz
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-851f720d7afso1218002a34.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283719; x=1794888519; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWcpdZO/8NkcHce3xnRkp/Wp95PYKC+yG0pe4X1kX2w=;
        b=WiB1GvMzUs2/TXTxuesaF5pHFw3tFZjyA0uovjq4qux7rKrpF5PzefNnljCMzzTjQ5
         Ynvl0rrNdEMG5p9S2aZQlr9W1OsIw8gUAJKA2UVhqCIZVtASHea+mnnX7PcJVkaF6Fr0
         JhH5huPsmuaPRTnpmrrdz88yWFoiwJQ26EfuxOHGtQ/BwroaxGBffRnkrYCbbj00IzBu
         LHuVDEoTwRDtgacIuGD2IkX08s8Ki1GoHe1rxj5H4lVG5K4/E0haJknEzttBjML6NWtq
         zdJ94K4wn121ELrgXg2LkLo3wR6XzCjcSIirRy81yiR4nvk1YoCR/7hc6OXFlkxFPBPM
         eePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283719; x=1794888519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWcpdZO/8NkcHce3xnRkp/Wp95PYKC+yG0pe4X1kX2w=;
        b=q8he+zL48rT4sm4uEiHB8UJgsIBO/uhpZ4L/iAX/FUfnDew2gn/z3HSAsa/wt9YmSO
         oVz/QJJ0Vkgg5xlLJpFzJToaB1uU41DqQbbXpgKhiVS6Bes4+Kx/DfNDZErDt01ctSbm
         boAw2h5HVbbSEdMPO8oGUJY3YHeEpG7YknRQ99zeUOoIm8d64yEzWCRLmlWMUeVe1ivf
         q5naA1ytaYw3jP2a0EPlReFepPFcft6fQ1Z4Gb9SAbPQc0agtT/6dV7ZSxo0dGLFi0pR
         gVlHLpePrBJDinkENs1LGkIq5Rl94h2L/5i9vyL8kHPuHET3aVmBheHq4C+Vd2woApEY
         Um4Q==
X-Forwarded-Encrypted: i=1; AL+hErEFjoUOGNBlQVqudVar3erJMhFnyn8xYfg9lLb4mUBHP30rq2P2/ez+PVzJA437o0HUo0HOTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z98XB4Utr5Mae/5wc5zYMMLxorThCysx4rGS1/+FriIwpKDVEJC
	12bUq93K83GWuSxw3TjIKwsqGNveDI+Uxu+N/fsYphu753epGUoueZUNIsCBiljSU1wRhCHSqaG
	MIRyQajcvI/TdLA==
X-Received: from ilbek9-n2.prod.google.com ([2002:a05:6e02:4f09:20b0:523:3c29:df0d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2386:b0:4f5:41f:fdba with SMTP id 5614622812f47-5683c9bb9d6mr1183525b6e.20.1794283719003;
 Mon, 09 Nov 2026 20:08:39 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:12 +0000
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
Message-ID: <20261110040828.1774343-7-skhawaja@google.com>
Subject: [PATCH v7 06/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
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

Add implementation of the device and iommu preservation in a separate
file. Also set the device and iommu preserve/unpreserve ops in the
struct iommu_ops.

Preservation is refused for devices where ATS is supported. Carrying an
active ATS configuration across kexec would require adopting the ATS
state in the PCI core and in the context entries, and handling the
disable-to-enable, enable-to-disable and STU mismatch cases for a live
device.

Note that the preserved iommu root table, context table and device pasid
table will need cleanup as devices do not go through the release flow
during kexec. So the stale entries need to be removed during shutdown.
This is done in the next commit.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 MAINTAINERS                      |   8 +
 drivers/iommu/intel/Makefile     |   1 +
 drivers/iommu/intel/iommu.c      |   9 +-
 drivers/iommu/intel/iommu.h      |  13 ++
 drivers/iommu/intel/liveupdate.c | 246 +++++++++++++++++++++++++++++++
 include/linux/kho/abi/iommu.h    |  27 ++++
 6 files changed, 302 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d5289432908..66da0b0c248c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13511,6 +13511,14 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/intel/
 
+INTEL IOMMU LIVEUPDATE (VT-d)
+M:	Samiullah Khawaja <skhawaja@google.com>
+M:	Lu Baolu <baolu.lu@linux.intel.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
+F:	drivers/iommu/intel/liveupdate.c
+
 INTEL IPU BRIDGE
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 M:	Dan Scally <dan.scally@ideasonboard.com>
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..d38fc101bc35 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..14bd1ca4fbd5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -56,8 +57,6 @@ static int rwbf_quirk;
  */
 int intel_iommu_tboot_noforce;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
@@ -4070,6 +4069,12 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve_device	= intel_iommu_preserve_device,
+	.unpreserve_device	= intel_iommu_unpreserve_device,
+	.preserve		= intel_iommu_preserve,
+	.unpreserve		= intel_iommu_unpreserve,
+#endif
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5b3d234ae265..a6c0ed55db30 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -552,6 +552,8 @@ struct root_entry {
 	u64     hi;
 };
 
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
+
 /*
  * low 64 bits:
  * 0: present
@@ -1305,6 +1307,17 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser);
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser);
+int intel_iommu_preserve(struct iommu_device *iommu,
+			 struct iommu_hw_ser *iommu_ser);
+void intel_iommu_unpreserve(struct iommu_device *iommu,
+			    struct iommu_hw_ser *iommu_ser);
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..4f5fc0d227ba
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "DMAR: liveupdate: " fmt
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+
+/* 2 tables per bus in scalable mode with upper table at odd bit */
+#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) (((bus) << 1) + ((devfn) >> 7))
+static bool is_context_table_preserved(struct intel_iommu *iommu,
+				       struct iommu_hw_ser *ser,
+				       u8 bus, u8 devfn)
+{
+	return test_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+}
+
+static void unpreserve_context_table(struct intel_iommu *iommu,
+				     struct iommu_hw_ser *ser,
+				     u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	/*
+	 * In the Intel IOMMU driver, context tables are never freed once they
+	 * are allocated during runtime, as they can be shared across multiple
+	 * devices. So taking the iommu lock here to protect against concurrent
+	 * allocations inside iommu_context_addr() should be enough. Once the
+	 * address is read, it is safe to use it without holding the lock.
+	 */
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
+		iommu_unpreserve_pages(context);
+		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+}
+
+static int preserve_context_table(struct intel_iommu *iommu,
+				  struct iommu_hw_ser *ser,
+				  u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+	int ret;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+
+	/*
+	 * Intel IOMMU context tables are never freed by the driver once
+	 * allocated. It is safe to access the context pointer outside of the
+	 * iommu->lock.
+	 *
+	 * The check and set of the context_tables_bitmap below is not atomic.
+	 * This is fine as the IOMMU core serializes the preserve_device() and
+	 * unpreserve() callbacks using the lock of its liveupdate FLB object.
+	 * That lock is private to the IOMMU core, so it cannot be asserted here.
+	 */
+	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
+		ret = iommu_preserve_pages(context);
+		if (ret)
+			return ret;
+
+		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+
+	return 0;
+}
+
+static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
+					    struct iommu_hw_ser *ser)
+{
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		unpreserve_context_table(iommu, ser, i, 0);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		unpreserve_context_table(iommu, ser, i, 0x80);
+	}
+}
+
+static int preserve_iommu_context_tables(struct device_domain_info *info)
+{
+	struct iommu_hw_ser *iommu_ser;
+	struct intel_iommu *iommu;
+	int ret;
+	int i;
+
+	/* IOMMU for this device should already be preserved. */
+	iommu = info->iommu;
+	iommu_ser = iommu_preserved_state(&iommu->iommu);
+	if (!iommu_ser)
+		return -EINVAL;
+
+	/*
+	 * We could do preservation of context tables only for the bus of this
+	 * device, but these devices can have PCI aliases, so context tables for
+	 * those will also require preservation. Also unpreserve would require
+	 * some kind of refcounting where the context table will only be
+	 * unpreserved when the last device associated with it is unpreserved.
+	 *
+	 * This introduces unnecessary complication with minimum benefits as the
+	 * unpreserved context tables will probably be recreated by the next
+	 * kernel as these are all active devices. We follow simpler approach by
+	 * just preserving the currently active context tables.
+	 */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
+		if (ret)
+			return ret;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
+ * @dev: Target device
+ * @device_ser: Struct to populate with serialized device state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	if (!dev_is_pci(dev)) {
+		dev_err(dev, "Cannot preserve non-PCI device\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (!info || !info->domain)
+		return -EINVAL;
+
+	if (info->ats_supported)
+		return -EOPNOTSUPP;
+
+	/*
+	 * intel_iommu_preserve() is only called once per IOMMU, when the first
+	 * device behind it is preserved. The context tables are allocated on
+	 * demand as devices are probed, so new context tables might have been
+	 * allocated since then. Preserve all the currently allocated context
+	 * tables every time a device is preserved, so the context tables of the
+	 * device being preserved are always covered.
+	 */
+	ret = preserve_iommu_context_tables(info);
+	if (ret)
+		return ret;
+
+	device_ser->attachment.attachment_id = domain_id_iommu(info->domain,
+							       info->iommu);
+	return 0;
+}
+
+/**
+ * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
+ * @dev: Target device
+ * @device_ser: Struct containing serialized device state
+ */
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser)
+{
+	/*
+	 * The context tables preserved during device preservation, in the
+	 * preserve_device() callback, might be shared with other devices, so
+	 * those are unpreserved in the iommu unpreserve() callback. So this
+	 * callback is kept empty.
+	 *
+	 * Once device PASID tables are preserved, the unpreservation of PASID
+	 * tables will be added here.
+	 */
+}
+
+/**
+ * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
+ * @iommu_dev: Generic IOMMU device handle
+ * @ser: Struct to populate with serialized hardware state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_preserve(struct iommu_device *iommu_dev,
+			 struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+	int ret;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	ret = iommu_preserve_pages(iommu->root_entry);
+	if (ret)
+		return ret;
+
+	ser->intel.sm_enabled = sm_supported(iommu);
+	ser->intel.phys_addr = iommu->reg_phys;
+	ser->intel.root_table = __pa(iommu->root_entry);
+	ser->type = IOMMU_SER_TYPE_INTEL;
+	ser->token = ser->intel.phys_addr;
+
+	return 0;
+}
+
+/**
+ * intel_iommu_unpreserve() - Intel IOMMU callback to unpreserve hardware state
+ * @iommu_dev: Generic IOMMU device handle
+ * @ser: Struct containing serialized hardware state
+ */
+void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
+			    struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	unpreserve_iommu_context_tables(iommu, ser);
+	iommu_unpreserve_pages(iommu->root_entry);
+}
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 20e6c764aa2e..95354a12ba1d 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -77,12 +77,14 @@
 /**
  * enum iommu_type_ser - Type of the IOMMU being preserved
  * @IOMMU_SER_TYPE_INVALID: Invalid type of IOMMU
+ * @IOMMU_SER_TYPE_INTEL: Intel VT-d IOMMU
  *
  * IOMMU type is stored in the IOMMU HW state to differentiate between various
  * IOMMU HWs.
  */
 enum iommu_type_ser {
 	IOMMU_SER_TYPE_INVALID,
+	IOMMU_SER_TYPE_INTEL,
 };
 
 #define IOMMU_SER_FLAG_DELETED	BIT(0)
@@ -155,18 +157,43 @@ struct iommu_device_ser {
 	u64 reserved[2];
 } __packed;
 
+/* There are maximum 256 buses, so maximum 512 context tables */
+#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
+
+/**
+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
+ * @features: Bitmask of Intel IOMMU specific features
+ * @sm_enabled: Whether the IOMMU was used in scalable mode
+ * @phys_addr: Physical address of the IOMMU register base
+ * @root_table: Physical address of the root entry table
+ * @context_tables_bitmap: Bitmap representing the context tables that are
+ * preserved.
+ */
+struct iommu_intel_ser {
+	u32 features;
+	u8 sm_enabled;
+	u8 padding[3];
+	u64 phys_addr;
+	u64 root_table;
+	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
+} __packed;
+
 /**
  * struct iommu_hw_ser - Serialized state of an IOMMU instance
  * @hdr: Common object header
  * @token: Unique token to identify the IOMMU instance
  * @type: IOMMU type serialized state belongs to
  * @reserved: Reserved for future common fields.
+ * @intel: Intel specific serialization data
  */
 struct iommu_hw_ser {
 	struct iommu_hdr_ser hdr;
 	u64 token;
 	u64 type;
 	u64 reserved[2];
+	union {
+		struct iommu_intel_ser intel;
+	};
 } __packed;
 
 /**
-- 
2.56.0.506.g506a7eabc5-goog

