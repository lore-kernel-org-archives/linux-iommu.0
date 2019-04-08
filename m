Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2658AC10F14
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21102148E
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21102148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 72C1BD39;
	Mon,  8 Apr 2019 23:57:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AC79C7F
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C0715709
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 16:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="149169931"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 01/18] drivers core: Add I/O ASID allocator
Date: Mon,  8 Apr 2019 16:59:16 -0700
Message-Id: <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408235916.CBwO9l2StSCNf3QGmvkyhDhzBRa9MAJ8Mad_98Ulj-0@z>

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Some devices might support multiple DMA address spaces, in particular
those that have the PCI PASID feature. PASID (Process Address Space ID)
allows to share process address spaces with devices (SVA), partition a
device into VM-assignable entities (VFIO mdev) or simply provide
multiple DMA address space to kernel drivers. Add a global PASID
allocator usable by different drivers at the same time. Name it I/O ASID
to avoid confusion with ASIDs allocated by arch code, which are usually
a separate ID space.

The IOASID space is global. Each device can have its own PASID space,
but by convention the IOMMU ended up having a global PASID space, so
that with SVA, each mm_struct is associated to a single PASID.

The allocator doesn't really belong in drivers/iommu because some
drivers would like to allocate PASIDs for devices that aren't managed by
an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
drivers/pci either since platform device also support PASID. Add the
allocator in drivers/base.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/base/Kconfig   |   7 ++++
 drivers/base/Makefile  |   1 +
 drivers/base/ioasid.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  40 +++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 drivers/base/ioasid.c
 create mode 100644 include/linux/ioasid.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 059700e..e05288d 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -182,6 +182,13 @@ config DMA_SHARED_BUFFER
 	  APIs extension; the file's descriptor can then be passed on to other
 	  driver.
 
+config IOASID
+	bool
+	default n
+	help
+	  Enable the I/O Address Space ID allocator. A single ID space shared
+	  between different users.
+
 config DMA_FENCE_TRACE
 	bool "Enable verbose DMA_FENCE_TRACE messages"
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 1574520..aafa2ac 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
+obj-$(CONFIG_IOASID) += ioasid.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
new file mode 100644
index 0000000..cf122b2
--- /dev/null
+++ b/drivers/base/ioasid.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I/O Address Space ID allocator. There is one global IOASID space, split into
+ * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
+ * free IOASIDs with ioasid_alloc and ioasid_free.
+ */
+#include <linux/idr.h>
+#include <linux/ioasid.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+struct ioasid_data {
+	ioasid_t id;
+	struct ioasid_set *set;
+	void *private;
+	struct rcu_head rcu;
+};
+
+static DEFINE_IDR(ioasid_idr);
+
+/**
+ * ioasid_alloc - Allocate an IOASID
+ * @set: the IOASID set
+ * @min: the minimum ID (inclusive)
+ * @max: the maximum ID (exclusive)
+ * @private: data private to the caller
+ *
+ * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
+ * allocated ID on success, or INVALID_IOASID on failure. The @private pointer
+ * is stored internally and can be retrieved with ioasid_find().
+ */
+ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+		      void *private)
+{
+	int id = -1;
+	struct ioasid_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return INVALID_IOASID;
+
+	data->set = set;
+	data->private = private;
+
+	idr_preload(GFP_KERNEL);
+	idr_lock(&ioasid_idr);
+	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
+	idr_unlock(&ioasid_idr);
+	idr_preload_end();
+
+	if (id < 0) {
+		kfree(data);
+		return INVALID_IOASID;
+	}
+	return id;
+}
+EXPORT_SYMBOL_GPL(ioasid_alloc);
+
+/**
+ * ioasid_free - Free an IOASID
+ * @ioasid: the ID to remove
+ */
+void ioasid_free(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	idr_lock(&ioasid_idr);
+	ioasid_data = idr_remove(&ioasid_idr, ioasid);
+	idr_unlock(&ioasid_idr);
+
+	if (ioasid_data)
+		kfree_rcu(ioasid_data, rcu);
+}
+EXPORT_SYMBOL_GPL(ioasid_free);
+
+/**
+ * ioasid_find - Find IOASID data
+ * @set: the IOASID set
+ * @ioasid: the IOASID to find
+ * @getter: function to call on the found object
+ *
+ * The optional getter function allows to take a reference to the found object
+ * under the rcu lock. The function can also check if the object is still valid:
+ * if @getter returns false, then the object is invalid and NULL is returned.
+ *
+ * If the IOASID has been allocated for this set, return the private pointer
+ * passed to ioasid_alloc. Otherwise return NULL.
+ */
+void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+		  bool (*getter)(void *))
+{
+	void *priv = NULL;
+	struct ioasid_data *ioasid_data;
+
+	rcu_read_lock();
+	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	if (ioasid_data && ioasid_data->set == set) {
+		priv = ioasid_data->private;
+		if (getter && !getter(priv))
+			priv = NULL;
+	}
+	rcu_read_unlock();
+
+	return priv;
+}
+EXPORT_SYMBOL_GPL(ioasid_find);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
new file mode 100644
index 0000000..6f3655a
--- /dev/null
+++ b/include/linux/ioasid.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_IOASID_H
+#define __LINUX_IOASID_H
+
+#define INVALID_IOASID ((ioasid_t)-1)
+typedef unsigned int ioasid_t;
+typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
+
+struct ioasid_set {
+	int dummy;
+};
+
+#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
+
+#ifdef CONFIG_IOASID
+ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+		      void *private);
+void ioasid_free(ioasid_t ioasid);
+
+void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+		  bool (*getter)(void *));
+
+#else /* !CONFIG_IOASID */
+static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
+				    ioasid_t max, void *private)
+{
+	return INVALID_IOASID;
+}
+
+static inline void ioasid_free(ioasid_t ioasid)
+{
+}
+
+static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+				bool (*getter)(void *))
+{
+	return NULL;
+}
+#endif /* CONFIG_IOASID */
+#endif /* __LINUX_IOASID_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
