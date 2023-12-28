Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669EAD46
	for <iommu@lists.linux.dev>; Thu, 28 Dec 2023 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXxBSd3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703722693; x=1735258693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1qBt4D1WArrSV0MOzrBsQzAWBORFHOsqP7rl6KWn9uo=;
  b=NXxBSd3eEDG2LpTLfIcs5fxYXcLM/iWevOOGpf7LHme1YgKWtrMe4QUP
   OCa2nwP0owtkseLQi6DRw+cHocZYxxda3Rbo3fty1gzKcfbqTl1oHX+Dc
   Vsn+bEcAZMh+zw/xtVyva7cuLzNJElTtn6hQTTmjkPBJ+ARNiX8e4Pf5d
   eirntEETYlATsnIJn/IKV9BfOjTa2pqfy5MwrhJcr1NvXl7PZVri0M838
   5He7eIfWcFgQFJ+V9l+2DpgWcpLQdPtgfCMyzka8a8sbudlt/PlXY+mZz
   khh3VZ8vDdpDX2zCbhmDAG3aJEOzwkiX1F9zGgKbBnwwlR5Xyxt6g38Cy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3800492"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3800492"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 16:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="848812692"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="848812692"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2023 16:16:57 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v9 3/5] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Wed, 27 Dec 2023 19:16:44 -0500
Message-Id: <20231228001646.587653-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pci_dev_is_disconnected() public so that it can be called from
Intel VT-d driver to quickly fix/workaround the surprise removal
unplug hang issue for those ATS capable devices on PCIe switch downstream
hotplug capable ports.

Beside pci_device_is_present() function, this one has no config space
space access, so is light enough to optimize the normal pure surprise
removal and safe removal flow.

Tested-by: Haorong Ye <yehaorong@bytedance.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/pci/pci.h   | 5 -----
 include/linux/pci.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..75fa2084492f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,11 +366,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	return 0;
 }
 
-static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
-{
-	return dev->error_state == pci_channel_io_perm_failure;
-}
-
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DPC_RECOVERED 1
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..4779eec8b267 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2506,6 +2506,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
+{
+	return dev->error_state == pci_channel_io_perm_failure;
+}
+
 void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
-- 
2.31.1

