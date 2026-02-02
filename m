Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85D25D208
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026110; cv=none; b=n6u098MoMfK569TgOct9iT/DcC6AY2Pt4xf8n7SFBs6i8qxJhXDGOMnNV/+XRC9UvIfo8MPHxUK8ClAQe6pnn3XGQSxfzrYEz9bxUiEvOZ/4khkYXVfqYuaRa7lsqUQ4novPlfHzotlTDOch5/1WUDdIcYyslP7kH1j37R4Gc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026110; c=relaxed/simple;
	bh=B7lMQpJnB6va2eav6dldFz446NvMiLfT+sc99Bhaph0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnTHZx4UOQdLiWPErtcPaKxYWTAVZE8ounpUL1KD0+SJH4Yz2GJtb3dsDj+kv8OJAnGDKFQEjWuE6CJB7jY/4OKHbBlsSFbKHkcfpSbCG6ps7n3JB0Lnrcjwugxvn2HuD/JXHWspr4eTKVjiaenHvsW3qFbOuPWMSf6chfUCH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F1stMk+V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F1stMk+V"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2CB220B7167;
	Mon,  2 Feb 2026 01:55:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2CB220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770026102;
	bh=0NfH5EemjyrMH+bkivy0W380J1NOprlHf/cerQTGe+A=;
	h=From:To:Cc:Subject:Date:From;
	b=F1stMk+VsGHgmst03vJmFF8tJIQMJKw09oIN/t0d/kgXli4rOnpjwZp9rr6apGDHO
	 Z8+L4uHvwhiGfJRYOjwKy4yGOkoGLqA++nYHd1gcf5TkfWEUqcCR2I0W40+GIygQBp
	 NFeSc7OtFKX6XesOrKE9Xlp4e6CsfP8AavJ7zoVA=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommupt: Always add IOVA range to iotlb_gather in gather_range_pages()
Date: Mon,  2 Feb 2026 17:54:58 +0800
Message-ID: <20260202095458.882560-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add current (iova, len) to the ioltb gather, regardless of the setting
of PT_FEAT_FLUSH_RANGE or PT_FEAT_FLUSH_RANGE_NO_GAPS.

In gather_range_pages(), the current unmap IOVA range is only added to
iotlb_gather when PT_FEAT_FLUSH_RANGE is set. Yet a virtual IOMMU with
NpCache use only PT_FEAT_FLUSH_RANGE_NO_GAPS. In that case, iotlb_gather
will stays empty (start=ULONG_MAX, end=0) after initialization, and the
currest (iova, len) will not be added to the iotlb_gather, causeing
subsequent iommu_iotlb_sync() to perform IOTLB invalidation with wrong
parameters (e.g. amd_iommu_iotlb_sync() computes size from
gather->end - gather->start + 1, leading to an invalid range).

The disjoint check and sync for PT_FEAT_FLUSH_RANGE_NO_GAPS remain
unchanged: when the new range is disjoint from the existing gather,
we still sync first and then add the new range, so semantics for
NO_GAPS are preserved.

Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
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

