Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB73BED59
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979412; cv=none; b=unUKB4BomvnFijfzXUXI7Tx0ezo/woy81RrrZ3Y0T+0t396muDml9Wa43GXM2QKF/VMvy5X6gUXUPDKZWi/PqFGqVqj8zNxfZuJmPTeoRwBt0ieJolzncLXeC2ygh7uch0HEzHX8VToSmlhGcxDJ9Bl1TJy/Ft4XSPQ9bU21GZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979412; c=relaxed/simple;
	bh=70RKSMZjgbP0ktOPb9PAca2L/0fqqjCC+IMmxSG4xU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2OdA3plF8CzstcS6mNZxJPWAG+kqlxRYU6iw3ggwdSkFU96WognCunTuFYF0M2yglzzCbYIact2wrRopOkhvDHdEIDZ7ZtKMbkAHcEyuBFx1O781rLzebLCoVSks8r3bIViJwX2X/vZODf/eiXR3fp7sY3mpKRkZBvcd5S1VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjA7omBj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjA7omBj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f8bbb4045so4388347b3a.2
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979406; x=1777584206; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmpZCS6mKPYD/A8Ingq/lQA2gApCpbjA3a6IaVe9Pqc=;
        b=JjA7omBjxFkzYJXZ375bP7o3Z8/d6Um6wwWDWuxjERPDXXF0nzGajLW683Q/T7o1aW
         W033PXuLyEAEW7FPblj4mTroq00dsXS95z3yszmGdJf7YuX1g4IU6TvpoDDNR8DP0QA5
         ilE2J9saaKwQrwGrAz1VaXBDexWHwplGjzGug/56pCCFDPsO1pafSBbk1u9B7umlz8j/
         gB0kJSnCQXs0jUbPb5sz0fqrxtTjOfbM9CbYgEdf/hDujY3lOncsV2GR48jVG8wqkp6L
         RiMo00JGI1ccMpJ17qdZmvfPS+47FVBZMAiowSgxQkbzENDaeDYLgvPZKOOYvdaPcv0N
         XNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979406; x=1777584206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmpZCS6mKPYD/A8Ingq/lQA2gApCpbjA3a6IaVe9Pqc=;
        b=YXJFd8xBmFg33lMS+NrgxklYXle4YXBJpdWozXQT9MLNxcrG4nJRNuEfBHO26xdzwa
         PLQPA6hr30rBdTFW9MzoeWtW4d4EmhzZe9X9cnFrexZM9uGFyJ/DJHwA84MEhTOT3Zbf
         2MGgnA9EOELM0mSkpyFruzMP25BkC0MX6dAcstwQFrg45Qjfxk9AO2M58581vS5HKsOJ
         WfwKi34Fpc0n6lRJBP+QGjj1Ko6gAIDKc3AsnD2SvUHRUz1RMnbwHdL2HSM9oGrlq+os
         1lfbIV1YGA/eBrvbL82JKlB4KckMCnocJ+mr0My9mvVWajIi0yrAgFCY5jOZh0/yZsNu
         lQzA==
X-Gm-Message-State: AOJu0YzZdD6csne9Dd3+yvRnd5SiAj6XX8dJWmeS1nO8CAzLcqMIohmj
	I6egygGLyfxCJmEoObkzNWz0mk10Rk251/z1ulvfPL5i+F11iV3xil6kvp1OlpBwBbBuM4JFujd
	nOYeS73yFxQeMg1ib79k5EXgAhRnA7C/3CejeeVjJRpgtEabaYlnjqDrrCWD2RG6GwQj524Vgjz
	xyuIEh3qkmpHTvvbkPnORo/X/qReZrg/RcPQ1sWCEgRwbC5A==
X-Received: from pfav10.prod.google.com ([2002:a05:6a00:ab0a:b0:82f:805:b62a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1993:b0:82c:2241:ab71 with SMTP id d2e1a72fcca58-82f8c9718c5mr31412431b3a.42.1776979405031;
 Thu, 23 Apr 2026 14:23:25 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:07 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-4-dmatlack@google.com>
Subject: [PATCH v4 03/11] PCI: liveupdate: Track incoming preserved PCI devices
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

During PCI enumeration, the previous kernel might have passed state about
devices that were preserved across kexec. The PCI core needs to fetch
this state to identify which devices are "incoming" and require special
handling.

Add pci_liveupdate_setup_device() which is called during device setup
to fetch the serialized state (struct pci_ser) from the Live Update
Orchestrator. The first time this happens, pci_flb_retrieve() will run
and convert the array of pci_dev_ser structs into an xarray so that it
can be looked up efficiently.

If a device is found in the xarray, the PCI core stores a pointer to its
state in dev->liveupdate_incoming and holds a reference to the incoming
FLB until pci_liveupdate_finish() is called by the driver.

This ensures proper lifecycle management for incoming preserved devices
and allows the PCI core and drivers to apply specific Live Update
logic to them in subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 189 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h        |  13 +++
 drivers/pci/probe.c      |   4 +
 include/linux/pci.h      |  16 ++++
 4 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 2dd8daa2f17c..e616cecc37c8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -56,6 +56,20 @@
  * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
  * with the list of **outgoing** preserved devices for the next kernel.
  *
+ * After kexec, whenever a device is enumerated, the PCI core will check if it
+ * is an **incoming** preserved device (i.e. preserved by the previous kernel)
+ * by checking the incoming FLB data (struct pci_ser).
+ *
+ * Drivers must notify the PCI core when an **incoming** device is done
+ * participating in the incoming Live Update with the following API:
+ *
+ *  * ``pci_liveupdate_finish(pci_dev)``
+ *
+ * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
+ * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
+ * (preserved for next kernel) and **incoming** (preserved by previous kernel)
+ * at the same time.
+ *
  * Restrictions
  * ============
  *
@@ -67,7 +81,6 @@
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
 
-#include <linux/bsearch.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
@@ -75,10 +88,24 @@
 #include <linux/mutex.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/sort.h>
+
+#include "pci.h"
 
 static DEFINE_MUTEX(pci_flb_outgoing_lock);
 
+struct pci_flb_incoming {
+	/* The pci_ser struct passed by the previous kernel. */
+	struct pci_ser *ser;
+
+	/* xarray used to quickly find a device in ser->devices[] */
+	struct xarray xa;
+};
+
+static unsigned long pci_ser_xa_key(unsigned long domain, unsigned long bdf)
+{
+	return domain << 16 | bdf;
+}
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_dev *dev = NULL;
@@ -124,13 +151,44 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
-	args->obj = phys_to_virt(args->data);
+	struct pci_flb_incoming *incoming;
+	int i, ret;
+
+	incoming = kmalloc(sizeof(*incoming), GFP_KERNEL);
+	if (!incoming)
+		return -ENOMEM;
+
+	incoming->ser = phys_to_virt(args->data);
+
+	xa_init(&incoming->xa);
+
+	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
+		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
+		unsigned long key;
+
+		if (!dev_ser->refcount)
+			continue;
+
+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
+		ret = xa_err(xa_store(&incoming->xa, key, dev_ser, GFP_KERNEL));
+		if (ret) {
+			xa_destroy(&incoming->xa);
+			kfree(incoming);
+			return ret;
+		}
+	}
+
+	args->obj = incoming;
 	return 0;
 }
 
 static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
-	kho_restore_free(args->obj);
+	struct pci_flb_incoming *incoming = args->obj;
+
+	xa_destroy(&incoming->xa);
+	kho_restore_free(incoming->ser);
+	kfree(incoming);
 }
 
 static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
@@ -225,6 +283,129 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
+static struct xarray *pci_liveupdate_flb_get_incoming(void)
+{
+	struct pci_flb_incoming *incoming;
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
+
+	/* Live Update is not enabled. */
+	if (ret == -EOPNOTSUPP)
+		return NULL;
+
+	/* Live Update is enabled, but there is no incoming FLB data. */
+	if (ret == -ENODATA)
+		return NULL;
+
+	/*
+	 * Live Update is enabled and there is incoming FLB data, but none of it
+	 * matches pci_liveupdate_flb.compatible.
+	 *
+	 * This could mean that no PCI FLB data was passed by the previous
+	 * kernel, but it could also mean the previous kernel used a different
+	 * compatibility string (i.e. a different ABI).
+	 */
+	if (ret == -ENOENT) {
+		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
+		return NULL;
+	}
+
+	/*
+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
+	 * but it cannot be retrieved.
+	 */
+	if (ret) {
+		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
+		return NULL;
+	}
+
+	return &incoming->xa;
+}
+
+static void pci_liveupdate_flb_put_incoming(void)
+{
+	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
+}
+
+void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+	struct xarray *xa;
+	unsigned long key;
+
+	xa = pci_liveupdate_flb_get_incoming();
+	if (!xa)
+		return;
+
+	key = pci_ser_xa_key(pci_domain_nr(dev->bus), pci_dev_id(dev));
+	dev_ser = xa_load(xa, key);
+
+	/* This device was not preserved across Live Update */
+	if (!dev_ser) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+	/*
+	 * This device was preserved, but has already been probed and gone
+	 * through pci_liveupdate_finish(). This can happen if PCI core probes
+	 * the same device multiple times, e.g. due to hotplug.
+	 */
+	if (!dev_ser->refcount) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
+
+	/*
+	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
+	 * that dev_ser does not get freed while it is in use.
+	 */
+	dev->liveupdate_incoming = dev_ser;
+}
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * Drop the FLB reference acquired in pci_liveupdate_setup_device() if
+	 * the device is being cleaned up before pci_liveupdate_finish(), e.g.
+	 * due to allocation failure during setup.
+	 *
+	 * Do not drop dev->liveupdate_incoming->refcount since this device has
+	 * not gone through pci_liveupdate_finish() and thus is still an
+	 * incoming preserved device.
+	 *
+	 * Note: This cannot race with pci_liveupdate_finish() since it is only
+	 * called in cleanup paths when there are no users of the pci_dev.
+	 */
+	if (dev->liveupdate_incoming)
+		pci_liveupdate_flb_put_incoming();
+}
+
+void pci_liveupdate_finish(struct pci_dev *dev)
+{
+	if (!dev->liveupdate_incoming) {
+		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
+		return;
+	}
+
+	pci_info(dev, "Device is finished participating in Live Update\n");
+
+	/*
+	 * Drop the refcount so this device does not get treated as an incoming
+	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
+	 * again becase the device is hot-plugged.
+	 */
+	dev->liveupdate_incoming->refcount = 0;
+	dev->liveupdate_incoming = NULL;
+
+	/* Drop this device's reference on the incoming FLB. */
+	pci_liveupdate_flb_put_incoming();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
+
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
 	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..09bab39738d7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1439,4 +1439,17 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
 	 PCI_CONF1_EXT_REG(reg))
 
+#ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_setup_device(struct pci_dev *dev);
+void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+}
+
+static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..938a28e4a7a0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2069,6 +2069,8 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
+	pci_liveupdate_setup_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
@@ -2192,6 +2194,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_liveupdate_cleanup_device(dev);
 		pci_release_of_node(dev);
 		return -EIO;
 
@@ -2490,6 +2493,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb94cbd8ab9d..dd6b26ca9462 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -597,6 +597,7 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_LIVEUPDATE
 	struct pci_dev_ser *liveupdate_outgoing; /* State preserved for next kernel */
+	struct pci_dev_ser *liveupdate_incoming; /* State preserved by previous kernel */
 #endif
 };
 
@@ -2887,11 +2888,17 @@ void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
 
 int pci_liveupdate_preserve(struct pci_dev *dev);
 void pci_liveupdate_unpreserve(struct pci_dev *dev);
+void pci_liveupdate_finish(struct pci_dev *dev);
 
 static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
 {
 	return dev->liveupdate_outgoing;
 }
+
+static inline struct pci_dev_ser *pci_liveupdate_incoming(struct pci_dev *dev)
+{
+	return dev->liveupdate_incoming;
+}
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -2911,10 +2918,19 @@ static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
 }
 
+static inline void pci_liveupdate_finish(struct pci_dev *dev)
+{
+}
+
 static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
 {
 	return NULL;
 }
+
+static inline struct pci_dev_ser *pci_liveupdate_incoming(struct pci_dev *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* LINUX_PCI_H */
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

