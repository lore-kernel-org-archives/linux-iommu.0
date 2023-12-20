Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0331BE4C
	for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5wl9xth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703033551; x=1734569551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bq2s9gwLh3Oh742hJuC8CK1tg4+GUxCgWKtcAn88usw=;
  b=O5wl9xthLW70OT7NFYKQjmhNvFrMaMPGqI4Th9xnaMYw0aLz26hT+2Sr
   bArV8Y30F4RcLQ3zjxtzJDik5mtRciUsUgaj7uA/COipP9fO6qBbFOVQx
   nnoYt9ajxqxrBdDewWEjTgY38zNcuZ5Qv7B/8A2KEnE08qTq5gpj92djg
   Ng3DsFlsX/EhbEfUS1pk8L1I38SqQAvs6MtPOLZbJFD/EX/nrRK12vWoN
   kK4phOeU5PxS0v68d7hCog4IPozrz03Ob3dx4P5Sr4mR4O9Xl1rNfq/Pu
   EXzWIIdVaNb1U8KTHqDqxk3OfAUjJ4Pd1/2/WJ7UVdV264g5TprDgQ1Hv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2566073"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="2566073"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107551574"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1107551574"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2023 16:51:59 -0800
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
Subject: [PATCH v4 1/2] PCI: make pci_dev_is_disconnected() helper public for other drivers
Date: Tue, 19 Dec 2023 19:51:52 -0500
Message-Id: <20231220005153.3984502-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make pci_dev_is_disconnected() public so that it can be called from
Intel vt-d driver to quickly fix/workaround the SURPPRISE_REMOVAL unplug
hang issue for those ATS capable devices on PCIe switch downstream 
ports.

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
index 60ca768bc867..869f2ec97a84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2503,6 +2503,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
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

