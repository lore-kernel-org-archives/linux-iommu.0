Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41F1D53C
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782881; cv=none; b=H4fzGcb0tUsEWx76b6v6r86GO0wbDD9iyuFCt7Z6Tp2y7sP0qpXNk7yNtyNax8I6+UUEVGx1lVEvQSOuN9reN/L6tUhC2nudGs5NHIP82Iy1OGhwvhwagArkzyGRmrhIc/8Z2523sV/82YirxWuo2PVZwFQb2ItnIaqwU62ScvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782881; c=relaxed/simple;
	bh=Q0ZGANXPztpM2O2KEUVb019jzb2ZSdMGP3pgfGlUZL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpBCsHytv/G836MFrHdMOGWRiRcgUfZkzSR/xXOtpIF8FcHodLw2b5XsIDvis/xMN9kRuFBqfmaYwS1WittCYxvx3CVfZUDqa83HC+k6BmuCJXNkLq2WIPv0z06jYxYxEctQDWeB9vJu3f2qWyEC6F3t5u1rFDT2aP/ViAT2m8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIZLHwID; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIZLHwID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782880; x=1748318880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0ZGANXPztpM2O2KEUVb019jzb2ZSdMGP3pgfGlUZL4=;
  b=YIZLHwIDE6VigWRzJdwsGwvzzHrvkXfN/0Z5+Y921UcEDKezEu2q7M5b
   YhWCn2kCPMJFj58Gr9v2msAj9vvyV4xb+TC0gaty1nWJ1gArftLYYwyly
   AqcMriQVvtW+BZAPLZQLm5NQBdKoSP8AivMk7Mwk+PFSup6FJizQM+wyV
   p2yXqjloZpw9iOOzzJUvS+Mjpu8suW57y2sxk9pct6PpYC0+umuG5JEzd
   hZtl7v5jYbFmG2NR1j4MInZxbPsC4feBBkI5B4AwokPue1aXAjrC4ZmPE
   1kTzYvAb7KgUu5vQ/3NYZ4X5469i8ZEtCbA7pV/MjLkQjow4Zj/YI+tva
   Q==;
X-CSE-ConnectionGUID: r+7/BZ4UT0ertRUKPvY3RA==
X-CSE-MsgGUID: mVDSuCHFRa2YP/B2jcZfNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022780"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022780"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:43 -0700
X-CSE-ConnectionGUID: a5koAXgESUaeXB9KlQkKaA==
X-CSE-MsgGUID: YKy9rx1YRw+f6cKbBCcvCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399959"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 05/10] iommufd: Add fault and response message definitions
Date: Mon, 27 May 2024 12:05:12 +0800
Message-Id: <20240527040517.38561-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_hwpt_pgfaults represent fault messages that the userspace can
retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
iommu_hwpt_pgfault.

An iommu_hwpt_page_response is a response message that the userspace
should send to the kernel after finishing handling a group of fault
messages. The @dev_id, @pasid, and @grpid fields in the message
identify an outstanding iopf group for a device. The @cookie field,
which matches the cookie field of the last fault in the group, will
be used by the kernel to look up the pending message.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..2f34d66436fb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -692,4 +692,100 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
+ *                                   valid.
+ * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
+ */
+enum iommu_hwpt_pgfault_flags {
+	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
+	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
+};
+
+/**
+ * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_PERM_READ: request for read permission
+ * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
+ * @IOMMU_PGFAULT_PERM_EXEC: (PCIE 10.4.1) request with a PASID that has the
+ *                           Execute Requested bit set in PASID TLP Prefix.
+ * @IOMMU_PGFAULT_PERM_PRIV: (PCIE 10.4.1) request with a PASID that has the
+ *                           Privileged Mode Requested bit set in PASID TLP
+ *                           Prefix.
+ */
+enum iommu_hwpt_pgfault_perm {
+	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
+	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
+	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
+	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
+};
+
+/**
+ * struct iommu_hwpt_pgfault - iommu page fault data
+ * @size: sizeof(struct iommu_hwpt_pgfault)
+ * @flags: Combination of enum iommu_hwpt_pgfault_flags
+ * @dev_id: id of the originated device
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @addr: Fault address
+ * @length: a hint of how much data the requestor is expecting to fetch. For
+ *          example, if the PRI initiator knows it is going to do a 10MB
+ *          transfer, it could fill in 10MB and the OS could pre-fault in
+ *          10MB of IOVA. It's default to 0 if there's no such hint.
+ * @cookie: kernel-managed cookie identifying a group of fault messages. The
+ *          cookie number encoded in the last page fault of the group should
+ *          be echoed back in the response message.
+ */
+struct iommu_hwpt_pgfault {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 perm;
+	__u64 addr;
+	__u32 length;
+	__u32 cookie;
+};
+
+/**
+ * enum iommufd_page_response_code - Return status of fault handlers
+ * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *                             populated, retry the access. This is the
+ *                             "Success" defined in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *                             access. This is the "Invalid Request" in PCI
+ *                             10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
+ *                             this device if possible. This is the "Response
+ *                             Failure" in PCI 10.4.2.1.
+ */
+enum iommufd_page_response_code {
+	IOMMUFD_PAGE_RESP_SUCCESS = 0,
+	IOMMUFD_PAGE_RESP_INVALID,
+	IOMMUFD_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @size: sizeof(struct iommu_hwpt_page_response)
+ * @flags: Must be set to 0
+ * @dev_id: device ID of target device for the response
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: One of response code in enum iommufd_page_response_code.
+ * @cookie: The kernel-managed cookie reported in the fault message.
+ */
+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+	__u32 cookie;
+	__u32 reserved;
+};
 #endif
-- 
2.34.1

