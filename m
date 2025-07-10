Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764526E711
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154964; cv=none; b=GwVstakLoE4izIso4xLyFPCBkp8V+nwlAS4uv+uBDQ5JWu5GBYNFfSflPxbOpQZcTTrkUoCWVVAKBF3oGX4D4CNaOUANTadAxTX0TPrH4N0kQbJl3xlyCDwP/iu9bZiMJHkJcFnMopq7JbX/NQmjFP/yp8qrRCDjNN6R3UjIoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154964; c=relaxed/simple;
	bh=ju+lG2yHIyUWAaknFfr55il4vTwXfJRx+LmJMBwM9b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7BxPce1PvaddJ+d5Siu98nidU7QAto2meisXYCUoM50AB+nET6sS6dJA+rBIzs7wLhd/Iu0PEzKPPShp/t6j5nWR1TUwbvfy0HoH3xBC8SOWRtwhzudC7lw5LNwmT6FZENZhK3AC0lwvHvd2NIiIWlTebi9+JiP+RNjll9PU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBc6a0qN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBc6a0qN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154963; x=1783690963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ju+lG2yHIyUWAaknFfr55il4vTwXfJRx+LmJMBwM9b8=;
  b=mBc6a0qNr/gIKyb7OlxDrAK12Fkxx3BQQd/GFr6/XESrCg5tqkiazDaL
   +/P5DKwF0RxeFrZFXVMSybt6FF9nLLKcjBeImBiumVzzyytrO9dlmmrEb
   vCDvkfqFy9fTiBTtPCKvQ/QHYdEuAHqb9VSRk6wL9n6nxsffHjpqDgk41
   T4E02Roe05DppRmgzHJ651/CNwZc16niMmiIB9yQAN96QYBzaqCep/Q0K
   gqezM04vd3KSlqXapkaPZuxV3DuaCEzvvyvkbWXXHYeLtb+kL7ku7HVNL
   1SCFWdBIpwq6a7D4kQwJjMzT43sj7KvqC5tfnZknq+HkMmtqzLegH0fgq
   Q==;
X-CSE-ConnectionGUID: HOS0FpyJR3WjOB3SEsyi5w==
X-CSE-MsgGUID: ObTQ+SQiTCGEp8BZxaQemA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787690"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787690"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:43 -0700
X-CSE-ConnectionGUID: If5Yq3MIRECWA74CBhBEHg==
X-CSE-MsgGUID: G/fku6UySuCqtPkG+U9VIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809441"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:40 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] iommu: Implement iommu_set_rid_fault_notifier()
Date: Thu, 10 Jul 2025 13:42:14 +0000
Message-ID: <20250710134215.97840-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the iommu_set_rid_fault_notifier() function which sets
an IOMMU fault notification callback for a specified endpoint device.
PCI endpoint device support is implemented in this patch, with possibility
of extension.

This change will provide endpoint device drivers with means of retrieving
details of IOMMU page faults occurring during operation and taking
device-specific actions.

Sample code using this facility:

static int sample_iommu_fault_notify(struct device *dev,
				     struct iommu_fault *fault,
                                     enum iommu_page_response_code,
				     void *data)
{
       printk("Fault data: rid: %#x, pasid: %u, ...  addr: %#llx\n",
              fault->prm.rid, fault->prm.pasid, ...
	      fault->prm.addr);
}

...

       ret = iommu_set_rid_fault_notifier(&pdev->dev,
					  sample_iommu_fault_notify,
					  data);
       if (ret)
               ...

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/io-pgfault.c | 53 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu-priv.h | 11 ++++++++
 drivers/iommu/iommu.c      | 12 +++++++++
 include/linux/iommu.h      | 17 ++++++++++--
 4 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 8b5926c1452e..8e50c5f03da2 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 ARM Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/sched/mm.h>
@@ -547,3 +548,55 @@ void iopf_queue_free(struct iopf_queue *queue)
 	kfree(queue);
 }
 EXPORT_SYMBOL_GPL(iopf_queue_free);
+
+/**
+ * iommu_set_rid_fault_notifier() - Set a Requester ID fault notifier
+ * @dev: the requester device
+ * @notifier: notifier function pointer (NULL unsets the notifier)
+ * @data: data to pass to the notifier function as a parameter
+ *
+ * Set or remove a device Requester ID based IOMMU fault failure
+ * notifier function.
+ *
+ * Return: 0 on success, or an error code.
+ */
+int iommu_set_rid_fault_notifier(struct device *dev,
+				 iommu_fault_rid_notifier_t notifier,
+				 void *data)
+{
+	struct iommu_rid_notifier *entry, *old;
+	struct dev_iommu *param = dev->iommu;
+	u32 rid;
+	int ret;
+
+	if (!param || !param->fault_param)
+		return -EINVAL;
+
+	rid = iommu_get_dev_rid(dev);
+
+	if (rid == IOMMU_INVALID_RID)
+		return -EINVAL;
+
+	guard(mutex)(&param->lock);
+
+	entry = kmalloc(sizeof(struct iommu_rid_notifier), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->notifier = notifier;
+	entry->data = data;
+	entry->dev = dev;
+
+	old = xa_store(&param->rid_notifiers, rid, entry, GFP_KERNEL);
+
+	ret = xa_err(old);
+	if (ret) {
+		kfree(entry);
+		return ret;
+	}
+
+	kfree(old);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_set_rid_fault_notifier);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index e236b932e766..71e187bc024b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -63,4 +63,15 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
 int iommu_replace_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid,
 			       struct iommu_attach_handle *handle);
+
+struct iommu_rid_notifier {
+	iommu_fault_rid_notifier_t notifier;
+	struct device *dev;
+	void *data;
+};
+
+#define IOMMU_INVALID_RID	U32_MAX
+
+u32 iommu_get_dev_rid(struct device *dev);
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3789c16806a1..c34c602dfb8a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3845,3 +3845,15 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	return ret;
 }
 #endif /* CONFIG_IRQ_MSI_IOMMU */
+
+u32 iommu_get_dev_rid(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return IOMMU_INVALID_RID;
+
+	pdev = to_pci_dev(dev);
+
+	return PCI_DEVID(pdev->bus->number, pdev->devfn);
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2062623fdf32..3a3f92222e27 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -161,6 +161,8 @@ struct iopf_queue {
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
+typedef void (*iommu_fault_rid_notifier_t)(struct device *, struct iommu_fault *,
+					   enum iommu_page_response_code, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -803,6 +805,7 @@ struct iommu_fault_param {
  */
 struct dev_iommu {
 	struct mutex lock;
+	struct xarray			rid_notifiers;
 	struct iommu_fault_param __rcu	*fault_param;
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
@@ -812,8 +815,6 @@ struct dev_iommu {
 	u32				pci_32bit_workaround:1;
 	u32				require_direct:1;
 	u32				shadow_on_flush:1;
-
-	struct xarray			rid_notifiers;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -931,6 +932,10 @@ void iommu_set_dma_strict(void);
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
+extern int iommu_set_rid_fault_notifier(struct device *dev,
+					iommu_fault_rid_notifier_t notifier,
+					void *data);
+
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	if (domain->ops->flush_iotlb_all)
@@ -1480,6 +1485,14 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
 {
 	return 0;
 }
+
+static inline int iommu_set_rid_fault_notifier(struct device *dev,
+					       iommu_fault_rid_notifier_t notifier,
+					       void *data)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IOMMU_API */
 #endif /* CONFIG_IRQ_MSI_IOMMU */
 
-- 
2.43.0

