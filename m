Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CB364D8
	for <iommu@lists.linux.dev>; Thu, 29 Feb 2024 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179656; cv=none; b=N5UK0hYPgWHU/TdyglORBBDRgQXv1FbaMpH1HM/049efefEMZjIjxzprO1akknyTcUEsSL4qfPvQ5JaB3UlXrI7Br6HNdoYV7le+Z3Ki5mSdVbj9xTlezkxX3o30LCuqcoQD6fb38e/uUP3n67tf3dv28H/KNtxIB+OkIJZpvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179656; c=relaxed/simple;
	bh=9z91bbeMOkdKLCnrdb24mYicdPZxZvNcK5RJ9UnvaZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SrSR/b5NaUBd1IvoFdaZq3BnZ47XqTb+niXmDeqHQuuBTbvIhOkTbM8yeCT2hnPln6diXQWpQAjfNe4nLoryiWGUNty3YtXM/kiGRT4uIl63S+TPuq3SOcq+TlCTEWxnURlAj/el65jRA8Dg2a9YIBBvk2SSI4GGHEgh5Pj5lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIsGiyNK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIsGiyNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709179654; x=1740715654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9z91bbeMOkdKLCnrdb24mYicdPZxZvNcK5RJ9UnvaZ4=;
  b=BIsGiyNKbZhWT4UEv08aE+AsZ7dF2kx4KF/h42Dl1T0QpmRsxj/4a59V
   nIF+g0JLcHUZk1PLN/H6Dn8W7PYDdhonXDa6LZm6ReEAJnElWBDoRkNoG
   dYsKT8DDZ6l6CRQPdqB4gKOjFWQleO/i5YoSV6f/5SzXCaWpInfwRJ9Bo
   tNms/uaUfhBTUmuVTw5c13pYvJWDaLP0k8Xj58xLF63ejE6hzlu+SmhFg
   hqVnmk9rPTP72IT9iYGcuWm1xEHKsMEYUFuij08HbrQB61bkrNM9J/iZZ
   MeXLqvjKztnXMfiY0vtGkovvdafxLQQaRTJP6G9R7yp3wve11df45e/RA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3791556"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3791556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 20:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="38521709"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa002.jf.intel.com with ESMTP; 28 Feb 2024 20:07:29 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH] iommu/vt-d: improve ITE fault handling if device was released
Date: Wed, 28 Feb 2024 23:07:24 -0500
Message-Id: <20240229040724.3393042-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Break the loop to blindly retry the timeout ATS invalidation request
after ITE fault hit if device was released or isn't present anymore.

This is part of the followup of prior proposed patchset

https://do-db2.lkml.org/lkml/2024/2/22/350

Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d14797aabb7a..d01d68205557 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1273,6 +1273,9 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	u64 iqe_err, ite_sid;
+	struct device *dev = NULL;
+	struct pci_dev *pdev = NULL;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1317,6 +1320,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
+		/*
+		 * SID field is valid only when the ITE field is Set in FSTS_REG
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
@@ -1326,6 +1336,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If got ITE, we need to check if the sid of ITE is one of the
+		 * current valid ATS invalidation target devices, if no, or the
+		 * target device isn't presnet, don't try this request anymore.
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 */
+		if (ite_sid) {
+			dev = device_rbtree_find(iommu, ite_sid);
+			if (!dev || !dev_is_pci(dev))
+				return -ETIMEDOUT;
+			pdev = to_pci_dev(dev);
+			if (!pci_device_is_present(pdev) &&
+				ite_sid == pci_dev_id(pci_physfn(pdev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.31.1

