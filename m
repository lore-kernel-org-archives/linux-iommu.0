Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6E2100
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnGK8gsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646070; x=1735182070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQnJp+eM13DOwyfJjWurrjBjS1JKHANOk6XIz1d/krs=;
  b=RnGK8gsFx/u2e+DnPODCtcyle+E2L/IlPaRloKYoy/20wa8wOIDIWxUn
   +HVo6j1LMSzlSd/Ri9khurP0eBUfIloyP1WqPTpHBHxh24dwkBtRm2XHa
   Dch+sLnfDMuYJSUFy3PWF0A56ngUfX0e0T1K4yNzk1GlWipyxQlU9TJcF
   uABLxSYfqiQFWOg4x1NeZI/u24vMniHTerOZVKSWimANEB7JIUOaF916Y
   G3boMUBkoFq+HeA6AgyrhZ/28RY70EfDJ63/N3e90JTW9FFOsLvq+HfnT
   AsQ8R86SmM4EkqZ2aXkYRjwOYm7jEVhVcG0dTgL6rDeHk8yNZqtfWOE/d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3705794"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="3705794"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 18:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="951386091"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="951386091"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2023 18:59:34 -0800
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
Subject: [RFC PATCH v8 3/5] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Tue, 26 Dec 2023 21:59:21 -0500
Message-Id: <20231227025923.536148-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
References: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pci_dev_is_disconnected() public so that it can be called from
Intel vt-d driver to quickly fix/workaround the surprise removal
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

