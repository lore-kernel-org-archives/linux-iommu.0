Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6E241E7
	for <iommu@lists.linux.dev>; Sun,  7 Apr 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501025; cv=none; b=PRDnac+7vKac200MsD5j6y3XaTJcQT97IgRPWWoSI3NxPvkOWxtMxiPjJCeiPXW1ivcr4iI1GiOmVCBDpPQJsdKvTAh9y9msRhUvjS463uIe2Iv2ZsZ8oUU09qpE67qw1qAQRJ4U0nhwm9QG5ogpH9wkuCBqfWgvGGCW2TFow3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501025; c=relaxed/simple;
	bh=KJetIovQXyKAbyZx80iCQSW216fIOI8VU98/mw3+bss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9QaxFvT1GHEzRvurab/R2K3910hidXFX2QSVjk+i7NE9zbVP3z1+EgkVSpMjP3NeZ1+9zOxxOf5mkq387dNQvG5LzBhIlZhj4vrYYHyUPESOLzeXOb0dLpQPHh4YSeF7m2EMgIzXo0O4W7w0gYBjTecXbwHMTM4dtonPwcSKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gebutQPA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gebutQPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712501024; x=1744037024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJetIovQXyKAbyZx80iCQSW216fIOI8VU98/mw3+bss=;
  b=gebutQPAY3Cb4ljPXkCPHrBmCtDpKo/2JmqcKbcJDNIcjyiCYW5SlIBz
   0pQsMOyHYnhssB7ZGQI++rZnaJrrkBDkvOT6zyuNuRwOVOeNmbwC1VjLQ
   QG2SVH0St0QYtzSnhovSgrq449ACm0nOOCzN85prKWmPGmRFJkXwhQyJs
   FJURdSYj4TGE/lByiIERjQz3Tq3dSip4btCl/ezPGOhAkZT4gzlS4AdXF
   S/yEq5zePZe2QXRo85nP58YTNGntPE5w+jEo/POQ/2uwtN7ev0CC4THwp
   mfXEnWqRAv4ceK4jZcf5uDwSkrdgyq1pG7Epx+bJ6upnmzLDa8T9xJrn+
   w==;
X-CSE-ConnectionGUID: 8o+8k+1VQ0WwJv7qsl3EVQ==
X-CSE-MsgGUID: 5oZyN5JWS+W4xeuuknDtug==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11607284"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11607284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 07:43:44 -0700
X-CSE-ConnectionGUID: n0GDiMU4SumL818Ey6kJqg==
X-CSE-MsgGUID: DShMURWGSJidnhaNxRQJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="57102682"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 07 Apr 2024 07:43:42 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb flush
Date: Sun,  7 Apr 2024 22:42:32 +0800
Message-Id: <20240407144232.190355-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407144232.190355-1-baolu.lu@linux.intel.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
implementation caches not-present or erroneous translation-structure
entries except the first-stage translation. The caching mode is
unrelated to the device TLB , therefore there is no need to check
it before a device TLB invalidation operation.

Before the scalable mode is introduced, caching mode is treated as
an indication that the driver is running in a VM guest. This is just
a software contract as shadow page table is the only way to implement
a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
the scalable mode is introduced, this doesn't stand for anymore, as
caching mode is not relevant for the first-stage translation. A virtual
IOMMU implementation is free to support first-stage translation only
with caching mode cleared.

Remove the caching mode check before device TLB invalidation to ensure
compatibility with the scalable mode use cases.

Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 493b6a600394..681789b1258d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	else
 		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
-	if (!cap_caching_mode(iommu->cap) && !map)
+	if (!map)
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
@@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
 
-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
+		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 
 	if (dmar_domain->nested_parent)
-- 
2.34.1

