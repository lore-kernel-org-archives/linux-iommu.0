Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8312395DB6
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107385; cv=none; b=ItOIGpXJc5ra9l72FFOLRpWQE2nvOSWwzkvEq9e9A7F93b7jhLE4G4zPXDXSoXO9FV2UAR94FXoQMroOncwIoFQxgPp3th+suC4Y4vDY146SSaXWi6C34bckxuA0HqMtvCbLxgC8hahvk8PKoLWD1W1SCYvnc3Kb4wCH3zz+poQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107385; c=relaxed/simple;
	bh=tFri8tzFfnfumGHSUEKrXwT2UIb21ehl0seMEFfao58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzv5LbpLfkEIqNgJ7KVP1oq1zikWE4qYCiQZWeRyVIY5NRMhh278JAZR9hPnqYXHBDWpBkUlYpLYXBqP3oHZSfX7qgz4kFBYyu6D2RAjblAftvy27jRMSCzDSXVnM9ZVxiQNNlbJg1bT5FRoUdVcuIaw0TdDx84afE16fprXkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YWu5W+mX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YWu5W+mX"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6952520B716A;
	Tue,  3 Feb 2026 00:29:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6952520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770107378;
	bh=kjs15QNnVwCtbzOyb92L+we3z4+EWVEXCzG0P6wN5NA=;
	h=From:To:Cc:Subject:Date:From;
	b=YWu5W+mXV2Ggm0PoMzR3p7Lu1sHmihNfwaNcy3TdHfUsesiwOE5Nz1/rgVdsgf9UE
	 cNkIghlRv4oWbgvc+VUhS/Xa1j4sg9JTJ6N+j+alHCn9zrEykl7BJdSbrf0zaU1Su7
	 vuPouk4egPfbhMBEEH933svCo8xIawX4qm/T7OIc=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommupt: Always add IOVA range to iotlb_gather in gather_range_pages()
Date: Tue,  3 Feb 2026 16:29:34 +0800
Message-ID: <20260203082934.1270789-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add current (iova, len) to the iotlb gather, regardless of the setting
of PT_FEAT_FLUSH_RANGE or PT_FEAT_FLUSH_RANGE_NO_GAPS.

In gather_range_pages(), the current IOVA range is only added to
iotlb_gather when PT_FEAT_FLUSH_RANGE is set. Yet a virtual IOMMU with
NpCache uses only PT_FEAT_FLUSH_RANGE_NO_GAPS. In that case, iotlb_gather
will stay empty (start=ULONG_MAX, end=0) after initialization, and the
current (iova, len) will not be added to the iotlb_gather, causing
subsequent iommu_iotlb_sync() to perform IOTLB invalidation with wrong
parameters (e.g., amd_iommu_iotlb_sync() computes size from
gather->end - gather->start + 1, leading to an invalid range).

The disjoint check and sync for PT_FEAT_FLUSH_RANGE_NO_GAPS remain
unchanged: when the new range is disjoint from the existing gather,
we still sync first and then add the new range, so semantics for
NO_GAPS are preserved.

Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
v2:
- Fix grammar and spelling errors in commit message
- Add "Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>" and
  "Cc: stable@vger.kernel.org"

 drivers/iommu/generic_pt/iommu_pt.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index d575f3ba9d34..3e33fe64feab 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -58,10 +58,9 @@ static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
 		 * Note that the sync frees the gather's free list, so we must
 		 * not have any pages on that list that are covered by iova/len
 		 */
-	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
-		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
 	}
 
+	iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
 	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
 }
 
-- 
2.52.0

