Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A65473D
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333096; cv=none; b=mOFuaDTysMOFu8miem6vlthF3HiZWnxF/iN/GrAU8L/YU2QqLALg2orHjB/nA4JkpGYutJB6SMHaoYvAlYOwIYJzFtDZNj25atiYM0GjLuORYbwDhIhEurc47F8n9ZdTE2BmwUmyH2jZeu9CEx+Mu0b1q0KHxo3dONOyiQVZ9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333096; c=relaxed/simple;
	bh=X91sn3qLI1hNjQ+x53CENgbWg0CtCQsOM/1KIO/sS8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JulfaMHu3BSU8T/1Qv1Z/0cTqYFvPrKzn2c0LDxFyE01wZUDyzOyTClkLyyZHWbKEymrbRUBpb394eV1K9DutoWZeCPeB0bZDVgLrjfpZyk2loPyHP9kSAAB08TXW6opeaVhkbQAkm1vr/qi3ekoqbW/2nWdQ164O78GXC9/FzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw3N5a07; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw3N5a07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333094; x=1742869094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X91sn3qLI1hNjQ+x53CENgbWg0CtCQsOM/1KIO/sS8s=;
  b=Mw3N5a075x9UvfF8MyteAk9FMQFKz9+q5uclUEJ0my2pWFShyjXvouEo
   VPwe9EqDmebO2F8/jhD1siWYjgQy/L8FtQW2vcjPglcBJVoV6dWs4zdfC
   hdNn3u0W31sPr/3iEgviRN+qYV1wSYcHyRMf0ml8nks0A1+rHOIuXLbgo
   jBxt8ugFM5x3N7EfoMZNFrJKBBc3uag8/uQw4y7PVKt4uZWoleLCFn5ex
   OfD5WI10eUJCQc0ZDB0+P/movB7XdmBvlzHFMduFlLS21nnBztIOrfIkZ
   3Zo2HjUi26KsJH7CxgiS6zAp5S/W3lxfwMntpny327hIiL0zJFZuLhumt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271351"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271351"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353941"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:09 -0700
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
Subject: [PATCH 04/12] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Mon, 25 Mar 2024 10:16:57 +0800
Message-Id: <20240325021705.249769-5-baolu.lu@linux.intel.com>
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

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 93e4422c9b10..4ce98f23917c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1560,26 +1560,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1

