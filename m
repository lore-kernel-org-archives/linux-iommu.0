Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08114A091
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333090; cv=none; b=oxjcLPTtO1Vs2Mvdm+n+OHL6XL+uPMiY+BxI92ABS9ZrZEYuovBjgeiaeQsQWqjbv9awkxocZoGj0agodyqe7J5Cry3MhLNPblLk0kA+66LrIMJJmBtikgeB8v9BdKdwGsZfk/2X3R90kVvmVuQez81nPKF9MGqGkOqwx9aRFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333090; c=relaxed/simple;
	bh=/yd76U2C/MzpuU1HznKVypbC7FLgM1XIezJ+dva0SCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFkVzz+axXb2VIpr2RoB9ytwiFA+TlGvZVe0tzcSxy0lfILT59GEbxVAXNi77/FVDyeDriiDoaRCk1XecJmT9WTmInK55KrzQ9nUfTIy4XtaK6KIYdh+NuxFdhUeQBBf/4dG8VJm9mkCq5v8kwhdGWwQfm5uX2ZH9u7i9vQUlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlnBtkIJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlnBtkIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333089; x=1742869089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yd76U2C/MzpuU1HznKVypbC7FLgM1XIezJ+dva0SCI=;
  b=RlnBtkIJZxgVzeCKXF+iMLVaHm2uoJSUXlu+dNBb92npcHuQn70bN9cN
   unuFOaOwQoCQSjfVFcKp4H0d+UEqRvDMuLVh6kxBhHI6kDRihqtZjAIdc
   AFT1UXHlCMUUFpmulwW4KSNzpaO51EiUQzKdZo3862xYUYla0ZLYVwD2U
   XfMZ5aeDovSl17xKVg1gCpiGtp9+wYBdXdKJxpJiNhUx3g47BvmjKaDvd
   6PVFeeePx6bDBVjkgL062I8RssN9JU2BqFdhrd+ViESwHCtAXmwXo2bwp
   wyIe/igzrt9gOW2IAfuMJ8yhr+IGjntvqc+StWBfWB1iDrohqPRHrv/QY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271339"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271339"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353931"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 03/12] iommu/vt-d: Add trace events for cache tag interface
Date: Mon, 25 Mar 2024 10:16:56 +0800
Message-Id: <20240325021705.249769-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events for cache tag assign/unassign/flush operations and trace
the events in the interfaces. These trace events will improve debugging
capabilities by providing detailed information about cache tag activity.
A sample of the traced messages looks like below [messages have been
stripped and wrapped to make the line short].

 cache_tag_assign: dmar9/0000:00:01.0 type iotlb did 1 pasid 9 ref 1
 cache_tag_assign: dmar9/0000:00:01.0 type devtlb did 1 pasid 9 ref 1
 cache_tag_flush_all: dmar6/0000:8a:00.0 type iotlb did 7 pasid 0 ref 1
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
	[0xeab00000-0xeab1afff] addr 0xeab00000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
	[0xeab20000-0xeab31fff] addr 0xeab20000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
	[0xeaa40000-0xeaa51fff] addr 0xeaa40000 pages 0x20 mask 0x5
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
	[0x98de0000-0x98de4fff] addr 0x98de0000 pages 0x8 mask 0x3
 cache_tag_flush_range: dmar1 0000:00:1b.0[0] type iotlb did 9
	[0xe9828000-0xe9828fff] addr 0xe9828000 pages 0x1 mask 0x0
 cache_tag_unassign: dmar9/0000:00:01.0 type iotlb did 1 pasid 9 ref 1
 cache_tag_unassign: dmar9/0000:00:01.0 type devtlb did 1 pasid 9 ref 1

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/trace.h | 97 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/cache.c |  8 +++
 2 files changed, 105 insertions(+)

diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 93d96f93a89b..b8c2ebace8af 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -89,6 +89,103 @@ TRACE_EVENT(prq_report,
 				      __entry->dw1, __entry->dw2, __entry->dw3)
 	)
 );
+
+DECLARE_EVENT_CLASS(cache_tag_log,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag),
+	TP_STRUCT__entry(
+		__string(iommu, tag->iommu->name)
+		__string(dev, dev_name(tag->dev))
+		__field(u16, type)
+		__field(u16, domain_id)
+		__field(u32, pasid)
+		__field(u32, users)
+	),
+	TP_fast_assign(
+		__assign_str(iommu, tag->iommu->name);
+		__assign_str(dev, dev_name(tag->dev));
+		__entry->type = tag->type;
+		__entry->domain_id = tag->domain_id;
+		__entry->pasid = tag->pasid;
+		__entry->users = tag->users;
+	),
+	TP_printk("%s/%s type %s did %d pasid %d ref %d",
+		  __get_str(iommu), __get_str(dev),
+		  __print_symbolic(__entry->type,
+			{ CACHE_TAG_TYPE_IOTLB,		"iotlb" },
+			{ CACHE_TAG_TYPE_DEVTLB,	"devtlb" },
+			{ CACHE_TAG_TYPE_PARENT_IOTLB,	"parent_iotlb" },
+			{ CACHE_TAG_TYPE_PARENT_DEVTLB,	"parent_devtlb" }),
+		__entry->domain_id, __entry->pasid, __entry->users
+	)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_assign,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_unassign,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DEFINE_EVENT(cache_tag_log, cache_tag_flush_all,
+	TP_PROTO(struct cache_tag *tag),
+	TP_ARGS(tag)
+);
+
+DECLARE_EVENT_CLASS(cache_tag_flush,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask),
+	TP_STRUCT__entry(
+		__string(iommu, tag->iommu->name)
+		__string(dev, dev_name(tag->dev))
+		__field(u16, type)
+		__field(u16, domain_id)
+		__field(u32, pasid)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned long, addr)
+		__field(unsigned long, pages)
+		__field(unsigned long, mask)
+	),
+	TP_fast_assign(
+		__assign_str(iommu, tag->iommu->name);
+		__assign_str(dev, dev_name(tag->dev));
+		__entry->type = tag->type;
+		__entry->domain_id = tag->domain_id;
+		__entry->pasid = tag->pasid;
+		__entry->start = start;
+		__entry->end = end;
+		__entry->addr = addr;
+		__entry->pages = pages;
+		__entry->mask = mask;
+	),
+	TP_printk("%s %s[%d] type %s did %d [0x%lx-0x%lx] addr 0x%lx pages 0x%lx mask 0x%lx",
+		  __get_str(iommu), __get_str(dev), __entry->pasid,
+		  __print_symbolic(__entry->type,
+			{ CACHE_TAG_TYPE_IOTLB,		"iotlb" },
+			{ CACHE_TAG_TYPE_DEVTLB,	"devtlb" },
+			{ CACHE_TAG_TYPE_PARENT_IOTLB,	"parent_iotlb" },
+			{ CACHE_TAG_TYPE_PARENT_DEVTLB,	"parent_devtlb" }),
+		__entry->domain_id, __entry->start, __entry->end,
+		__entry->addr, __entry->pages, __entry->mask
+	)
+);
+
+DEFINE_EVENT(cache_tag_flush, cache_tag_flush_range,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask)
+);
+
+DEFINE_EVENT(cache_tag_flush, cache_tag_flush_cm_range,
+	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
+		 unsigned long addr, unsigned long pages, unsigned long mask),
+	TP_ARGS(tag, start, end, addr, pages, mask)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 4c245d39faf2..b35ef2ee2aca 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -17,6 +17,7 @@
 
 #include "iommu.h"
 #include "pasid.h"
+#include "trace.h"
 
 /* Checks if an existing cache tag can be reused for a new association. */
 static bool cache_tag_reusable(struct cache_tag *tag, u16 domain_id,
@@ -65,11 +66,13 @@ static int cache_tag_assign(struct dmar_domain *domain, u16 did,
 			temp->users++;
 			spin_unlock_irqrestore(&domain->cache_lock, flags);
 			kfree(tag);
+			trace_cache_tag_assign(temp);
 			return 0;
 		}
 	}
 	list_add_tail(&tag->node, &domain->cache_tags);
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
+	trace_cache_tag_assign(tag);
 
 	return 0;
 }
@@ -87,6 +90,7 @@ static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
 		if (cache_tag_reusable(tag, did, iommu, dev, pasid, type)) {
+			trace_cache_tag_unassign(tag);
 			if (--tag->users == 0) {
 				list_del(&tag->node);
 				kfree(tag);
@@ -293,6 +297,8 @@ void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
 						  IOMMU_NO_PASID, info->ats_qdep);
 			break;
 		}
+
+		trace_cache_tag_flush_range(tag, start, end, addr, pages, mask);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
@@ -330,6 +336,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 						  IOMMU_NO_PASID, info->ats_qdep);
 			break;
 		}
+		trace_cache_tag_flush_all(tag);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
@@ -376,6 +383,7 @@ void cache_tag_flush_cm_range(struct dmar_domain *domain, unsigned long start,
 							 addr, mask,
 							 DMA_TLB_PSI_FLUSH);
 		}
+		trace_cache_tag_flush_cm_range(tag, start, end, addr, pages, mask);
 	}
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
-- 
2.34.1

