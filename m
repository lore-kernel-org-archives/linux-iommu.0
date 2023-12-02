Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AA11C87
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSM4KJD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510151; x=1733046151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nR/psJ1R705oxKAaTJeTprEYjfrf/NpWHn/y7k4WDWk=;
  b=KSM4KJD6++F0HXPHbW3mEG6SEuTHLL+fQE3WsIKF+ioIpiGwurrC+XBf
   eRJPl4J/YisvDrgijZC5D+7g/3I42ut5QednHle/f4/FwQl87is66K1DV
   rD/a0R/awzHfK9YHonuUFGeQwq7skrXY713YghzWG+dzffqkVT5LWt67w
   gnzwKIDSAoBnEjYVn3q4Q53Uo2T0ddsijDBnfoTKaMMtxJvy8nVQntpwb
   LsFj3FXYjU20Ju8kw36FxkxrQl7Zxxga7d1GRCYVCP6PhoPqhcnT8hozq
   g0UGLXt8780l/iXwpX1KYxKwG66qzHPlEhqBOeiWUDahY4rq0YRDp2YLe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="424755032"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="424755032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="836018614"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="836018614"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:42:26 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com,
	jgg@nvidia.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 01/42] KVM: Public header for KVM to export TDP
Date: Sat,  2 Dec 2023 17:13:24 +0800
Message-Id: <20231202091324.13436-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Introduce public header for data structures and interfaces for KVM to
export TDP page table (EPT/NPT in x86) to external components of KVM.

KVM exposes a TDP FD object which allows external components to get page
table meta data, request mapping, and register invalidation callbacks to
the TDP page table exported by KVM.

Two symbols kvm_tdp_fd_get() and kvm_tdp_fd_put() are exported by KVM to
external components to get/put the TDP FD object.

New header file kvm_tdp_fd.h is added because kvm_host.h is not expected to
be included from outside of KVM in future AFAIK.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/kvm_tdp_fd.h | 137 +++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 include/linux/kvm_tdp_fd.h

diff --git a/include/linux/kvm_tdp_fd.h b/include/linux/kvm_tdp_fd.h
new file mode 100644
index 0000000000000..3661779dd8cf5
--- /dev/null
+++ b/include/linux/kvm_tdp_fd.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_TDP_FD_H
+#define __KVM_TDP_FD_H
+
+#include <linux/types.h>
+#include <linux/mm.h>
+
+struct kvm_exported_tdp;
+struct kvm_exported_tdp_ops;
+struct kvm_tdp_importer_ops;
+
+/**
+ * struct kvm_tdp_fd - KVM TDP FD object
+ *
+ * Interface of exporting KVM TDP page table to external components of KVM.
+ *
+ * This KVM TDP FD object is created by KVM VM ioctl KVM_CREATE_TDP_FD.
+ * On object creation, KVM will find or create a TDP page table, mark it as
+ * exported and increase reference count of this exported TDP page table.
+ *
+ * On object destroy, the exported TDP page table is unmarked as exported with
+ * its reference count decreased.
+ *
+ * During the life cycle of KVM TDP FD object, ref count of KVM VM is hold.
+ *
+ * Components outside of KVM can get meta data (e.g. page table type, levels,
+ * root HPA,...), request page fault on the exported TDP page table and register
+ * themselves as importers to receive notification through kvm_exported_tdp_ops
+ * @ops.
+ *
+ * @file:  struct file object associated with the KVM TDP FD object.
+ * @ops:   kvm_exported_tdp_ops associated with the exported TDP page table.
+ * @priv:  internal data structures used by KVM to manage TDP page table
+ *         exported by KVM.
+ *
+ */
+struct kvm_tdp_fd {
+	/* Public */
+	struct file *file;
+	const struct kvm_exported_tdp_ops *ops;
+
+	/* private to KVM */
+	struct kvm_exported_tdp *priv;
+};
+
+/**
+ * kvm_tdp_fd_get - Public interface to get KVM TDP FD object.
+ *
+ * @fd:       fd of the KVM TDP FD object.
+ * @return:   KVM TDP FD object if @fd corresponds to a valid KVM TDP FD file.
+ *            -EBADF if @fd does not correspond a struct file.
+ *            -EINVAL if @fd does not correspond to a KVM TDP FD file.
+ *
+ * Callers of this interface will get a KVM TDP FD object with ref count
+ * increased.
+ */
+struct kvm_tdp_fd *kvm_tdp_fd_get(int fd);
+
+/**
+ * kvm_tdp_fd_put - Public interface to put ref count of a KVM TDP FD object.
+ *
+ * @tdp:  KVM TDP FD object.
+ *
+ * Put reference count of the KVM TDP FD object.
+ * After the last reference count of the TDP FD object goes away,
+ * kvm_tdp_fd_release() will be called to decrease KVM VM ref count and destroy
+ * the KVM TDP FD object.
+ */
+void kvm_tdp_fd_put(struct kvm_tdp_fd *tdp);
+
+struct kvm_tdp_fault_type {
+	u32 read:1;
+	u32 write:1;
+	u32 exec:1;
+};
+
+/**
+ * struct kvm_exported_tdp_ops - operations possible on KVM TDP FD object.
+ * @register_importer:  This is called from components outside of KVM to register
+ *                      importer callback ops and the importer data.
+ *                      This callback is a must.
+ *                      Returns: 0 on success, negative error code on failure.
+ *                              -EBUSY if the importer ops is already registered.
+ * @unregister_importer:This is called from components outside of KVM if it does
+ *                      not want to receive importer callbacks any more.
+ *                      This callback is a must.
+ * @fault:              This is called from components outside of KVM to trigger
+ *                      page fault on a GPA and to map physical page into the
+ *                      TDP page tables exported by KVM.
+ *                      This callback is optional.
+ *                      If this callback is absent, components outside KVM will
+ *                      not be able to trigger page fault and map physical pages
+ *                      into the TDP page tables exported by KVM.
+ * @get_metadata:       This is called from components outside of KVM to retrieve
+ *                      meta data of the TDP page tables exported by KVM, e.g.
+ *                      page table type,root HPA, levels, reserved zero bits...
+ *                      Returns: pointer to a vendor meta data on success.
+ *                               Error PTR on error.
+ *                      This callback is a must.
+ */
+struct kvm_exported_tdp_ops {
+	int (*register_importer)(struct kvm_tdp_fd *tdp_fd,
+				 struct kvm_tdp_importer_ops *ops,
+				 void *importer_data);
+
+	void (*unregister_importer)(struct kvm_tdp_fd *tdp_fd,
+				    struct kvm_tdp_importer_ops *ops);
+
+	int (*fault)(struct kvm_tdp_fd *tdp_fd, struct mm_struct *mm,
+		     unsigned long gfn, struct kvm_tdp_fault_type type);
+
+	void *(*get_metadata)(struct kvm_tdp_fd *tdp_fd);
+};
+
+/**
+ * struct kvm_tdp_importer_ops - importer callbacks
+ *
+ * Components outside of KVM can be registered as importers of KVM's exported
+ * TDP page tables via register_importer op in kvm_exported_tdp_ops of a KVM TDP
+ * FD object.
+ *
+ * Each importer must define its own importer callbacks and KVM will notify
+ * importers of changes of the exported TDP page tables.
+ */
+struct kvm_tdp_importer_ops {
+	/**
+	 * This is called by KVM to notify the importer that a range of KVM
+	 * TDP has been invalidated.
+	 * When @start is 0 and @size is -1, a whole of KVM TDP is invalidated.
+	 *
+	 * @data:    the importer private data.
+	 * @start:   start GPA of the invalidated range.
+	 * @size:    length of in the invalidated range.
+	 */
+	void (*invalidate)(void *data, unsigned long start, unsigned long size);
+};
+#endif /* __KVM_TDP_FD_H */
-- 
2.17.1

