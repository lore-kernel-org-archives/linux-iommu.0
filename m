Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8276048
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244297; cv=none; b=DJWd42zLGiGxHDONpRdI66sV4f8OikHrPd34o/+2R7n3WSqnCvVCrpmX9GzqTxkY11jNE2lBGo5TDv9RjTHTHNzeCAkPxOeoejTeibnEVWM3sX9T188M3CXx5kr6KKtJEVIV1Xkk2YYi6T85qzXZcTpGrcyjfaWK3jTaaGV+WCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244297; c=relaxed/simple;
	bh=JAHOTQH4PiZazv2tg8j+ODrfqTu/cLl55/IpDQrDQD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+CggYsnf4+n585DjeP82jhv2CF+lrUHMYZiBIAi1wjnGqERVwip2gaHt/Jd+pZLwNDuFMxIpMJZj2G5D7HwRMHCzC+biSOzpuNBHkZjvu0qEwjbTv39z6+C1uPafFde1fCLLYyeunEeodBVDS2pDXK2QXM/jTPRYCNfO3BDN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJN0Ld36; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJN0Ld36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244295; x=1756780295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JAHOTQH4PiZazv2tg8j+ODrfqTu/cLl55/IpDQrDQD8=;
  b=gJN0Ld36r95yvNfiVQ/0NXCF/ANt5+xQyKQoIWa6T4ulqYJXbyM7wKR6
   +q58gcmz7UI9kf600Zl4dSTf/mFZEjLiJyOF4ZuAfGlnBixGqIiw+4uIH
   3p79aMQszm947pi9KXIgwuHf5r08TwbjRODpamG9KNaWcAs2ptK1/Chtp
   FjWywP10S7HshpqpVvF+sVdztpHYGFwQF8Mmvrmw6BBS7kWWhEiiulNdN
   jt3tOAKFu7k/o0uRBLWrIzBld/wdFy9ZYM1atV4dv+lfuU2nvFp1J4HYA
   VWALLEB+ZCcJ5dTuSW4qt5gFwmN/QV4MsXogl+CG+kvNnVx1YOv7iJxWK
   w==;
X-CSE-ConnectionGUID: 4G8RXIRRTJq41CSR/5tTkw==
X-CSE-MsgGUID: mYvyXA1ySFyIIBvUOTCtAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994322"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994322"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:35 -0700
X-CSE-ConnectionGUID: LIYITmiyQ4Krj157cBc4kA==
X-CSE-MsgGUID: CNIssNR0TlqE6y8Dt7EolA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359334"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count
Date: Mon,  2 Sep 2024 10:27:18 +0800
Message-Id: <20240902022724.67059-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay K Kumar <sanjay.k.kumar@intel.com>

If qi_submit_sync() is invoked with 0 invalidation descriptors (for
instance, for DMA draining purposes), we can run into a bug where a
submitting thread fails to detect the completion of invalidation_wait.
Subsequently, this led to a soft lockup. Currently, there is no impact
by this bug on the existing users because no callers are submitting
invalidations with 0 descriptors. This fix will enable future users
(such as DMA drain) calling qi_submit_sync() with 0 count.

Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors, while
concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Both
threads then enter a while loop, waiting for their respective descriptors
to complete. T1 detects its completion (i.e., T1's invalidation_wait status
changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
reclaim all descriptors, potentially including adjacent ones of other
threads that are also marked as QI_DONE.

During this time, while T2 is waiting to acquire the qi->q_lock, the IOMMU
hardware may complete the invalidation for T2, setting its status to
QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
invalidation_wait descriptor and changes its status to QI_FREE, T2 will
not observe the QI_DONE status for its invalidation_wait and will
indefinitely remain stuck.

This soft lockup does not occur when only non-zero descriptors are
submitted.In such cases, invalidation descriptors are interspersed among
wait descriptors with the status QI_IN_USE, acting as barriers. These
barriers prevent the reclaim code from mistakenly freeing descriptors
belonging to other submitters.

Considered the following example timeline:
	T1			T2
========================================
	ID1
	WD1
	while(WD1!=QI_DONE)
	unlock
				lock
	WD1=QI_DONE*		WD2
				while(WD2!=QI_DONE)
				unlock
	lock
	WD1==QI_DONE?
	ID1=QI_DONE		WD2=DONE*
	reclaim()
	ID1=FREE
	WD1=FREE
	WD2=FREE
	unlock
				soft lockup! T2 never sees QI_DONE in WD2

Where:
ID = invalidation descriptor
WD = wait descriptor
* Written by hardware

The root of the problem is that the descriptor status QI_DONE flag is used
for two conflicting purposes:
1. signal a descriptor is ready for reclaim (to be freed)
2. signal by the hardware that a wait descriptor is complete

The solution (in this patch) is state separation by using QI_FREE flag
for #1.

Once a thread's invalidation descriptors are complete, their status would
be set to QI_FREE. The reclaim_free_desc() function would then only
free descriptors marked as QI_FREE instead of those marked as
QI_DONE. This change ensures that T2 (from the previous example) will
correctly observe the completion of its invalidation_wait (marked as
QI_DONE).

Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240728210059.1964602-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1c8d3141cb55..01e157d89a16 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,9 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-	while (qi->desc_status[qi->free_tail] == QI_DONE ||
-	       qi->desc_status[qi->free_tail] == QI_ABORT) {
-		qi->desc_status[qi->free_tail] = QI_FREE;
+	while (qi->desc_status[qi->free_tail] == QI_FREE && qi->free_tail != qi->free_head) {
 		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
 		qi->free_cnt++;
 	}
@@ -1463,8 +1461,16 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	for (i = 0; i < count; i++)
-		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
+	/*
+	 * The reclaim code can free descriptors from multiple submissions
+	 * starting from the tail of the queue. When count == 0, the
+	 * status of the standalone wait descriptor at the tail of the queue
+	 * must be set to QI_FREE to allow the reclaim code to proceed.
+	 * It is also possible that descriptors from one of the previous
+	 * submissions has to be reclaimed by a subsequent submission.
+	 */
+	for (i = 0; i <= count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
-- 
2.34.1

