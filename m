Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481769E04
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280479; cv=none; b=eEHJsRR0rz9E9Ru+/Fg638tL1IJD8LtOIRGh9Zw1hRTIQChiEiHxoZwmy9e3jRnyQR5zC6GW0C0NJv8tP7e/rl0HZla8LNa8Va8j7vf0dcAf6wuyHXLNPb2wIPT/mCaAGMKUt59ARlAmdcNmBC8BKFFL5Zxt2DCDEXri92RE7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280479; c=relaxed/simple;
	bh=/cVxTPK8YMoBH+k7owpPAvLO8OBKEisXNbpy2Gi5tXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoF1CLz9yG9TkX63uvWlG8awDNXXACKPpP8wSnbC62btpXFzyLdeKZCkL0VBKwzd7XZbRJ9ytvnVgqNUaEAbJHk738jUzAHvokFPVGkfXy4KGdgCaxyUMB36D/498Wqv5Vo+iudEgtFfefhd+T1/SXKrjM/Bj3iU2e4RRxA9940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG6jdsZJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG6jdsZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280479; x=1740816479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cVxTPK8YMoBH+k7owpPAvLO8OBKEisXNbpy2Gi5tXs=;
  b=QG6jdsZJpamAtqR/FjeutAA8uBqOYs1fdgFQfYN5fkgyszb3iBq77fH5
   T532gCL8I0nmSkqMrn6yIfchG0z8BgaJfESrnEKK2czv8f99Xv386v3Rf
   grZO5jElZjUMJzdIE3cnvPcqsBArjsksDLdFpDOoDsFZb3zrCZJoDXazg
   URFIxQ2Y9fGnWw/ExrR5nKqZElX6l5ruOo+YvJmRC2RU7I47KeKY740Dc
   Nshb6bi1kyI+iAcKgzFJXb18CrkThQ2i5gnQmxDleWUgITJsYQwaWxjSR
   ongFTf8KLjzCIIkuw7y1ulWYH0eIlFdoZmFFyKKgEy501hWF1TQJl3hiu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15240433"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15240433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8187527"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 00:07:52 -0800
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
Subject: [PATCH v14 3/3] iommu/vt-d: improve ITE fault handling if target device isn't present
Date: Fri,  1 Mar 2024 03:07:27 -0500
Message-Id: <20240301080727.3529832-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
References: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because surprise removal could happen anytime, e.g. user could request safe
removal to EP(endpoint device) via sysfs and brings its link down to do
surprise removal cocurrently. such aggressive cases would cause ATS
invalidation request issued to non-existence target device, then deadly
loop to retry that request after ITE fault triggered in interrupt context.
this patch aims to optimize the ITE handling by checking the target device
presence state to avoid retrying the timeout request blindly, thus avoid
hard lockup or system hang.

Devices TLB should only be invalidated when devices are in the 
iommu->device_rbtree (probed, not released) and present.

Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d14797aabb7a..fa1ac111a6e2 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1273,6 +1273,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	u64 iqe_err, ite_sid;
+	struct device *dev = NULL;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1317,6 +1319,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
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
 
@@ -1326,6 +1335,19 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If device was released or isn't present, no need to retry
+		 * the ATS invalidate request anymore.
+		 *
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		if (ite_sid) {
+			dev = device_rbtree_find(iommu, ite_sid);
+			if (!dev || !dev_is_pci(dev) ||
+				!pci_device_is_present(to_pci_dev(dev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.31.1

