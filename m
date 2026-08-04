Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BD4582F8
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887707; cv=none; b=uTGWqsKdE15OZDYghoXi+VJzVemg1HVajyqtlSYpLSdHSVEy8oosuWuCXxgb7EkuZdZFvzdabfQ4SzJcXKcUCiQI8TFrxrWNqjHuritL5sBDac5SzJNvklumnRhuxR07LtPUTpJzRjS5Adrn6EqNByGiZDaneyiqVhc5rYxCIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887707; c=relaxed/simple;
	bh=pnwJe36D1sL/gNEszmY3UecgU2zT9dRDC3/tQgH4P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFMe+7J0DspqUmvXiqo0DrwNOb1GZcGoQqC/lhNGmEyA0Fk6AdXMP8aI9hJzSK3OEBJ/ipJdSpUr5qUsKbDwQ5BsDLVWv0VpiypNVLOkYCJzP7ixUp2fKqjbUWyeBheO2nYrLSzQZFUlxcYx6cE2Se0Oly34AVTFqAKtF9wymS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkEht/3i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkEht/3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887706; x=1817423706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnwJe36D1sL/gNEszmY3UecgU2zT9dRDC3/tQgH4P6c=;
  b=GkEht/3iiFI+UuaJN7VZqr95VHvYo+zrRy7rswkNjAqhX6wq4NCJo/dJ
   e2TZm5oMPASEVrnTdJmZMpgyvlABmjAJ3/K987KamqYTb0eYqYqsk/w6s
   gniPEt5x55V1Giu8+gvFN0RlXfU2Nxam72Nv/geOC73cBDLdaSfIL4KYV
   sXrXdBpk+jCxb0GbM8AFGlLOCOtM4cYxmGvfF+rtIMuMaBskd33+sG3RQ
   kQ3puSHnaL6Rj6qSpKMjDVrYISBZ//g78RQ72I2+HndPfRN43A9VuLsX7
   3Mgrndws542oWYS0rRl1UB4OgPcTHwK5TysFSZPcxm+pLM4W7764+EJ9n
   g==;
X-CSE-ConnectionGUID: 6oaQ1qyfR3aHDBCyFqy+cw==
X-CSE-MsgGUID: 0MAThBckTHiwxhI1KqrQJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263378"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:55:06 -0700
X-CSE-ConnectionGUID: v8eD0TBqTIOK4IcULSR5xg==
X-CSE-MsgGUID: GL942qVfRXmEpTJ29YBrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324416"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:55:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/19] iommu/vt-d: Tear down scalable-mode context on probe failure
Date: Wed,  5 Aug 2026 07:43:12 +0800
Message-ID: <20260804234314.3087110-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intel_pasid_setup_sm_context() walks a PCI device’s DMA aliases via
pci_for_each_dma_alias() and programs a scalable-mode context entry for
each RID. For a device with a dma_alias_mask, the callback is invoked
once for the device’s own RID and once for each alias bit, all with the
same pci_dev, so device_pasid_table_setup() runs for multiple RIDs.

pci_for_each_dma_alias() stops at the first callback error. Therefore, a
failure partway through the walk can leave context entries for already
processed RIDs present and still pointing to the device’s PASID table.

On this error path, intel_iommu_probe_device() currently jumps directly
to intel_pasid_free_table(), which frees the PASID table without
first tearing down those context entries. The IOMMU may then walk a
present context entry whose PASID table pointer references freed
memory.

intel_iommu_release_device() already performs teardown before freeing the
table. Apply the same ordering on the probe failure path.

device_pasid_table_teardown() safely handles RIDs that were never
programmed: iommu_context_addr() returns NULL when no context table has
been allocated, and clearing the Present bit of an already non-present
entry is a no-op. So unwind is safe for both the alias that failed and
any aliases not yet reached.

Fixes: 301f1a80487fd ("iommu/vt-d: Setup scalable mode context entry in probe path")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9003783d02bc..489bab4999fb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3333,6 +3333,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	return &iommu->iommu;
 free_table:
+	intel_pasid_teardown_sm_context(dev);
 	intel_pasid_free_table(dev);
 clear_rbtree:
 	device_rbtree_remove(info);
-- 
2.43.0

