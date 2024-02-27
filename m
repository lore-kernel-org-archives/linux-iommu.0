Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A3F9CF
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000441; cv=none; b=GAkDmsj3alhmJ3yUTOQpQp4B5HrQl5LMWVcyOgbQFJVuQX4yxZ8C4X3hmHqEVrbdCzSoOpmhwo+CxsWW3oi2Ngvtc6nVnE8y4j3ZzodBJScP4WqbsFJlcIvYxNJTKTMwOeZsS41hYTvQfp4/pYE5af9a6kljrBesIE7/PJ3cypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000441; c=relaxed/simple;
	bh=G7j1AH+ahgRmCXuydMxeNo0vzEppNXG7fJWakgLIOWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KgN57EzIERN0/YQlhI6vkr8lL9YKqG2ntSBLsAwHE3SXPDgQDbdlxUzHPCLRjCs6+d5wmuXff2V15O3HX9z2jE7hpl3R7VwkvfONtLuetWJPlJt+LtOzZSG0pQyjjZngoCvH6xwnKrLv8KaYnkeSDI+4+uFQNHV96CkIaY5Wta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XX4VC1MW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XX4VC1MW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000439; x=1740536439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G7j1AH+ahgRmCXuydMxeNo0vzEppNXG7fJWakgLIOWc=;
  b=XX4VC1MWbqZ1b3wgGwPwXWJXDXe6zJ9zXBWZkSYvYg4ruA1wYFk9N+v9
   e/h3tYLzCSVwrUINeGvj+7By1rufuUlZ56TseCLPzBdgQ0RhtgpRdDibZ
   Y13NaNCoDXsLg/QTTbfrard9PzrL5MdOMIf0AilJV3psxKF12bH9pho+D
   5cbMxWONStG78htPMlesJKGe8XVDC2oJyQBaBxNvBFSiD5dHxR8vFmN1h
   9hUMFCHE2MHe1n6FxTNHQiPbLpahMoSd2Bo9NpUxpHwIq2BWpIIAHmHTm
   ui3g0ZfGR60GDSdDWQMfdmQUcqd0sIf12yQzn/SVz3BocE+QwEvxPh2GK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273086"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273086"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418277"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:36 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] [PULL REQUEST] Intel IOMMU updates for Linux v6.9
Date: Tue, 27 Feb 2024 10:14:33 +0800
Message-Id: <20240227021441.50434-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.9:

 - Add rbtree to track iommu probed devices
 - Add Intel IOMMU debugfs document
 - Cleanup and refactoring

All patches are based on v6.8-rc6. The series is also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.9

Unfortunately, there is a merge conflict with your next branch, in
drivers/iommu/intel/svm.c. I resolved this conflict as below.

diff --cc drivers/iommu/intel/svm.c
index b644d57da841,bdf3584ca0af..c1bed89b1026
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@@ -698,14 -693,20 +688,18 @@@ bad_req
                 * If prq is to be handled outside iommu driver via receiver of
                 * the fault notifiers, we skip the page response here.
                 */
-               if (!pdev)
+               mutex_lock(&iommu->iopf_lock);
+               dev = device_rbtree_find(iommu, req->rid);
+               if (!dev) {
+                       mutex_unlock(&iommu->iopf_lock);
                        goto bad_req;
+               }
  
-               intel_svm_prq_report(iommu, &pdev->dev, req);
-               trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 -              if (intel_svm_prq_report(iommu, dev, req))
 -                      handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 -              else
 -                      trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
 -                                       req->priv_data[0], req->priv_data[1],
 -                                       iommu->prq_seq_number++);
++              intel_svm_prq_report(iommu, dev, req);
++              trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
 +                               req->priv_data[0], req->priv_data[1],
 +                               iommu->prq_seq_number++);
-               pci_dev_put(pdev);
+               mutex_unlock(&iommu->iopf_lock);
  prq_advance:
                head = (head + sizeof(*req)) & PRQ_RING_MASK;
        }
@@@ -781,17 -794,10 +775,8 @@@ void intel_svm_page_response(struct dev
  
                qi_submit_sync(iommu, &desc, 1, 0);
        }
 -out:
 -      return ret;
  }
  
- static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-                                  struct device *dev, ioasid_t pasid)
- {
-       struct device_domain_info *info = dev_iommu_priv_get(dev);
-       struct intel_iommu *iommu = info->iommu;
- 
-       return intel_svm_bind_mm(iommu, dev, domain, pasid);
- }
- 
  static void intel_svm_domain_free(struct iommu_domain *domain)
  {
        kfree(to_dmar_domain(domain));

With above in mind, please consider them for v6.9.

Best regards,
Baolu

Erick Archer (1):
  iommu/vt-d: Use kcalloc() instead of kzalloc()

Jingqi Liu (1):
  iommu/vt-d: Add the document for Intel IOMMU debugfs

Lu Baolu (3):
  iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
  iommu/vt-d: Use rbtree to track iommu probed devices
  iommu/vt-d: Use device rbtree in iopf reporting path

Tina Zhang (3):
  iommu/vt-d: Remove treatment for revoking PASIDs with pending page
    faults
  iommu/vt-d: Remove initialization for dynamically heap-allocated
    rcu_head
  iommu/vt-d: Merge intel_svm_bind_mm() into its caller

 drivers/iommu/intel/iommu.h                   |  10 +
 drivers/iommu/intel/dmar.c                    |   4 +-
 drivers/iommu/intel/iommu.c                   |  95 +++++-
 drivers/iommu/intel/perf.c                    |   2 +-
 drivers/iommu/intel/svm.c                     |  39 +--
 Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
 drivers/iommu/intel/Kconfig                   |  11 -
 7 files changed, 391 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu

-- 
2.34.1

