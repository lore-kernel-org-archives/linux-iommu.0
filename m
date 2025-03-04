Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C120299D
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090079; cv=none; b=nM7+sZThSFc3bmSBp+4j+f6gpMQ6+q8aXdzQARsACl0Z6gTfnl5BnntCfk0Fynfo3wkKrpGicbelqOrQ5/Pw7kEdHeGHPv6SKW8FuQmi9uO3j/SlV3IoX1SprwGeI7ZRJxMNjcvQVYRH0TINhlYLI0G5SrlctH5OW/HvEeDIE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090079; c=relaxed/simple;
	bh=uL7yoeNqWc6wnZL0QrwyAbrV/oRZxgpFmnqD8MjHmzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EixkdopifVwei9iREs5aK9HXpCYhgcn4YiBv7+XAKVPSOmtQWWjFhMjb7Fopk+FBIa1j9OFGtPPKkk8IOmiKu9fkLQXoeKcEu40+8etrmGuJFzrl0kMMQcRjsMID1wtJuFswAN4yVz1jT4NdEZyK/QBRKYfjF83nfDlI8Yz8ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2FJQ6i7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2FJQ6i7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741090078; x=1772626078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uL7yoeNqWc6wnZL0QrwyAbrV/oRZxgpFmnqD8MjHmzY=;
  b=Y2FJQ6i7NUf40AyFr30KowamcGvu9j4U4zl5UA5lXUWc7lfE8ID5AE52
   r1SL1QrOW/ULJlVszEaze+cznrOHnbB/hM/Ps/5H/bquIEoND08hESiGu
   r+lyQMqure4MR62mHqrmnM22ytxfh5VoFsJ/6BbHBk1My6TcJqZjXJZeJ
   p9cageUqsb1vMJl6OYxAI6xTr2lRYODW6eztDLlYDVEtwltlH3FvVCPs3
   To7ZuiBfk2Dbxkp9s1PQxbnQZK9icokBgBgEEzRPQL9uNlWzU/akOIHRZ
   Uk2vGFhaEzjRLQw1YIFeVtVT1ok6AYuNX4lQGvU/YK7uEgURFvbenKxAl
   w==;
X-CSE-ConnectionGUID: B1G6GrdmTtqd9FHtlqTh5Q==
X-CSE-MsgGUID: u6tHejVdTWqzYuLTJveC+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53407308"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53407308"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:07:56 -0800
X-CSE-ConnectionGUID: datQde5CQX67RrfBaf76kw==
X-CSE-MsgGUID: VBSlZVhiR4mBbIIeiBRu6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118514918"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 04 Mar 2025 04:07:55 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH] iommufd: Fail replace if device has not been attached
Date: Tue,  4 Mar 2025 04:07:54 -0800
Message-Id: <20250304120754.12450-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of iommufd_device_do_replace() implicitly
assumes that the input device has already been attached. However, there
is no explicit check to verify this assumption. If another device within
the same group has been attached, the replace operation might succeed,
but the input device itself may not have been attached yet.

As a result, the input device might not be tracked in the
igroup->device_list, and its reserved IOVA might not be added. Despite
this, the caller might incorrectly assume that the device has been
successfully replaced, which could lead to unexpected behavior or errors.

To address this issue, add a check to ensure that the input device has
been attached before proceeding with the replace operation. This check
will help maintain the integrity of the device tracking system and prevent
potential issues arising from incorrect assumptions about the device's
attachment status.

Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
Hi All,

Alternative may be just allow caller to replace device even if only its
alias has been attached. This can be done by a few line of codes. But it
seems more reasonable to fail it. So I chose to detect and fail it. However,
let me know if you have different thought.

Regards,
	Yi Liu
---
 drivers/iommu/iommufd/device.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4e107f69f951..c66bb9ef5465 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
+/* Check if idev is attached to igroup->hwpt */
+static bool iommufd_device_attached(struct iommufd_device *idev)
+{
+	struct iommufd_device *cur;
+
+	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
+		if (cur == idev)
+			return true;
+	return false;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev)
 {
@@ -705,6 +716,15 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	mutex_lock(&idev->igroup->lock);
 
+	/*
+	 * Device has not been attached yet, replace such a device is not
+	 * supported. Fail it to prompt caller to use the correct API.
+	 */
+	if (!iommufd_device_attached(idev)) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
 	if (igroup->hwpt == NULL) {
 		rc = -EINVAL;
 		goto err_unlock;
-- 
2.34.1

