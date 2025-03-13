Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFC1E4A4
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869350; cv=none; b=OHbi3Ro4Tu3XRc2WKKoX2Q7yxyD2nSEh8v9wPolaTMzH9ejyAXBSn3UTfdahuEO3GwNWPMzJcXDEyALA/AcjmwzrY0OD132c7I3i5AvWUsdwlN7bHVhviA48og5dvfoldkqKK6HnAQnYh3U7GbrmA4xFUn91341/qakut86YQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869350; c=relaxed/simple;
	bh=xtLk9HWdG7jgZDutSdkKdZxFmqV2jRXK/oJ1JuKa98Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfO/OvKN7SUv9L2Q9rAELw2pHPmWrh7xdEc8tOvfcXiuvlZWMWECJPPlB/zhO6+12Z8HUm9KjnB/YHcYrrAlqPvm6LMozim8IADeI3S/QmTt1wIjPXGrLxO/crGavc5vVC2IfQtt8I0i7EvhSo80/fSB9F57znNmBLYeTDPGG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwCyaX2r; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwCyaX2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869348; x=1773405348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtLk9HWdG7jgZDutSdkKdZxFmqV2jRXK/oJ1JuKa98Y=;
  b=NwCyaX2r0hUOStQ8cy870dtTNOZu2KTn0m+wfXXwRETNw9mr0ywCUzSe
   LyMFxoe0haTLg6bt6iK31FQz7CpyBgHYPgHSTScMroI5SC6mU/MNaTXBb
   gO8xUAGfk566xmW60Y5vaSiVF6WKVJ91JTcVYF8P1OgQ1h0RozrI+gLv2
   GPPTHo/aIxHT2a5Xawnw6qPJGu2EgH+Afj+5xzPxbfvmeG66hwXmarbbS
   n/9cHwGUkURfnu9rsEOGsOh3RCi5ux/HtLN0QvDZwY0kEEadX6Hq6d9SK
   +p5p6WrS/g4M109elHyQcjxg6uRKvq6oMb6fy0OjlR41AJBf8CieGN83E
   Q==;
X-CSE-ConnectionGUID: OVPeMSLzT6ahpjSgisRnGA==
X-CSE-MsgGUID: VSio7VuxTPi32+8IBVDaZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863936"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:34 -0700
X-CSE-ConnectionGUID: esaZBH8BT+yfB0LFeohifA==
X-CSE-MsgGUID: FrS9M2s7SPS2mZKU5j5bOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005486"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:35 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 02/21] iommu: Wrap pasid_array entry creation and setting
Date: Thu, 13 Mar 2025 05:35:13 -0700
Message-Id: <20250313123532.103522-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU core does not mandate that callers must always provide a new
handle, allowing for the possibility of handle reuse. In the replace
path, the existing handle can be reused. To facilitate this, the core
must ensure that the pasid_array entry is made or updated under xa_lock
to prevent race conditions with callers of iommu_attach_handle_get().
Additionally, this operation should be performed only after the underlying
IOMMU driver has successfully set the domain. This precaution is necessary
to prevent forwarding PRIs to the new domain before it is fully prepared.

To streamline this process, the creation of the pasid_array entry and the
__xa_store() operation are encapsulated into a helper, which is invoked at
the end of the replace operation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 332ecb20c385..6a314122a9da 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2168,6 +2168,22 @@ static void iommu_pasid_array_entry_clear_handle(void *entry)
 		 xa_untag_pointer(entry))->domain = NULL;
 }
 
+/* Caller should have reserved memory for __xa_store() */
+static void iommu_group_pasid_store(struct iommu_group *group, ioasid_t pasid,
+				    struct iommu_domain *domain,
+				    struct iommu_attach_handle *handle)
+{
+	void *entry;
+
+	lockdep_assert_held(&group->mutex);
+
+	xa_lock(&group->pasid_array);
+	entry = iommu_make_pasid_array_entry(domain, handle);
+	WARN_ON(xa_is_err(__xa_store(&group->pasid_array, pasid, entry,
+				     GFP_KERNEL)));
+	xa_unlock(&group->pasid_array);
+}
+
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
@@ -3369,7 +3385,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	const struct iommu_ops *ops;
-	void *entry;
 	int ret;
 
 	if (!group)
@@ -3393,8 +3408,6 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	entry = iommu_make_pasid_array_entry(domain, handle);
-
 	/*
 	 * Entry present is a failure case. Use xa_insert() instead of
 	 * xa_reserve().
@@ -3415,8 +3428,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
 	 * queued and then failing attach.
 	 */
-	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
-				   pasid, entry, GFP_KERNEL)));
+	iommu_group_pasid_store(group, pasid, domain, handle);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3527,14 +3539,12 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 			      struct iommu_group *group,
 			      struct iommu_attach_handle *handle)
 {
-	void *entry;
 	int ret;
 
 	if (!handle)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	entry = iommu_make_pasid_array_entry(domain, handle);
 	ret = xa_insert(&group->pasid_array,
 			IOMMU_NO_PASID, XA_ZERO_ENTRY, GFP_KERNEL);
 	if (ret)
@@ -3552,8 +3562,7 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
 	 * queued and then failing attach.
 	 */
-	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
-				   IOMMU_NO_PASID, entry, GFP_KERNEL)));
+	iommu_group_pasid_store(group, IOMMU_NO_PASID, domain, handle);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3600,14 +3609,12 @@ int iommu_replace_group_handle(struct iommu_group *group,
 			       struct iommu_domain *new_domain,
 			       struct iommu_attach_handle *handle)
 {
-	void *curr, *entry;
 	int ret;
 
 	if (!new_domain || !handle)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	entry = iommu_make_pasid_array_entry(new_domain, handle);
 	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
 	if (ret)
 		goto err_unlock;
@@ -3616,8 +3623,7 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	if (ret)
 		goto err_release;
 
-	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
-	WARN_ON(xa_is_err(curr));
+	iommu_group_pasid_store(group, IOMMU_NO_PASID, new_domain, handle);
 
 	mutex_unlock(&group->mutex);
 
-- 
2.34.1

