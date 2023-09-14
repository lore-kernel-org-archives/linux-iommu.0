Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C715E92
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694682007; x=1726218007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3swk2kXJoM2a1PqfcTU8QJMMZhHalASP/3K35w+Kct8=;
  b=VVG5qkWgYsg/2nfRzA4hPmzta2j5v/1T11W1Us48xH0S8rEO8CCaFY8N
   b3Qnx+sWQUUBUaH+AD4n08fFdcxYFajrAi2hjoynaHg8KdmeOBENVMq0/
   BRuASjp+VYTbwBZae5xt0I8vDLwLa7ySxNCsw13Kv12xHbZV2tNl9wrH8
   G87X+vZtZhfEafxqwAbQeJz19qmCwiOnlCLt3ZzXbXFkS6ce7resnb57A
   dUBzH3ZmBFLGWKHoX7FwIStHwe+9zUqEzjXz41nkikrwYfHh224uq2xpF
   gF8pyJkGjc1Ni7ceI4ViT3hm8O2z8RSmKU+xA+zmIJPXrk9fWcqiakRM/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465266335"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="465266335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859612834"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="859612834"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2023 01:59:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 04/12] iommu: Cleanup iopf data structure definitions
Date: Thu, 14 Sep 2023 16:56:30 +0800
Message-Id: <20230914085638.17307-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914085638.17307-1-baolu.lu@linux.intel.com>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct iommu_fault_page_request and struct iommu_page_response are not
part of uAPI anymore. Convert them to data structures for kAPI.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h      | 27 +++++++++++----------------
 drivers/iommu/io-pgfault.c |  1 -
 drivers/iommu/iommu.c      |  4 ----
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1040047982aa..db13ebaabcf7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -69,12 +69,12 @@ struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
 #define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
 #define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 3)
-	__u32	flags;
-	__u32	pasid;
-	__u32	grpid;
-	__u32	perm;
-	__u64	addr;
-	__u64	private_data[2];
+	u32	flags;
+	u32	pasid;
+	u32	grpid;
+	u32	perm;
+	u64	addr;
+	u64	private_data[2];
 };
 
 /**
@@ -83,7 +83,7 @@ struct iommu_fault_page_request {
  * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
  */
 struct iommu_fault {
-	__u32	type;
+	u32 type;
 	struct iommu_fault_page_request prm;
 };
 
@@ -104,8 +104,6 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
- * @argsz: User filled size of this data
- * @version: API version of this structure
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
  * @pasid: Process Address Space ID
@@ -113,14 +111,11 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
-	__u32	argsz;
-#define IOMMU_PAGE_RESP_VERSION_1	1
-	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
-	__u32	flags;
-	__u32	pasid;
-	__u32	grpid;
-	__u32	code;
+	u32	flags;
+	u32	pasid;
+	u32	grpid;
+	u32	code;
 };
 
 
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index e5b8b9110c13..24b5545352ae 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -56,7 +56,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
 			       enum iommu_page_response_code status)
 {
 	struct iommu_page_response resp = {
-		.version		= IOMMU_PAGE_RESP_VERSION_1,
 		.pasid			= iopf->fault.prm.pasid,
 		.grpid			= iopf->fault.prm.grpid,
 		.code			= status,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..ccad2131f49d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1458,10 +1458,6 @@ int iommu_page_response(struct device *dev,
 	if (!param || !param->fault_param)
 		return -EINVAL;
 
-	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
-	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
-		return -EINVAL;
-
 	/* Only send response if there is a fault report pending */
 	mutex_lock(&param->fault_param->lock);
 	if (list_empty(&param->fault_param->faults)) {
-- 
2.34.1

