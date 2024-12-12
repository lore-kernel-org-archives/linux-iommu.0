Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611B3F9D2
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969831; cv=none; b=tSmCSggN62+srcAg8s1wpFQlmexaoMmnfOeiTLpJvw44/j6GVDD7AQZMKkZQFvvpkooYc50A5iRdFgyVXuI0Igr/f5L+ShRdBptIKLfAZMUuXfSfMD5JFxeP3WgocsCcjTPgL8MOMg7Pl1cwu6IscWgKrTUH/jenHyg2LOk9JiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969831; c=relaxed/simple;
	bh=Kq6/fEnAxpqAtJaALn2RzgIOhJL5MZj63K/gz0fiX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjyIRCzc3t3V2FrSN8gZ6aVzKPnTXB2UL6/pXP60Yp2IQmodu7bFMCpNqjQ5L/ccsWT0fd9AyYM4wAxPke7Dj8FWHUkVHnKeGnykrUme9d0UyS0AXtLe8h5JjwPIGCYr00jeY+KdtUHaQ7ISNa4KL8TFMUEsWthp5ZxRgDcR1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzlHaoH6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzlHaoH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733969830; x=1765505830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kq6/fEnAxpqAtJaALn2RzgIOhJL5MZj63K/gz0fiX7Y=;
  b=PzlHaoH6uSUEDDhuhd3+O+HVBVWgl5bRjNp+iAYOX5lCBN8t2uOYwWA5
   r/Rq9Mxh85zIM+WfjBdxfJ3/Oqv2toO2buqDB6tBCwK7dSGFIjAgX1isF
   WfKfzzi78L8dflA/ydXM3M+fKsXuW/LE/7joXlF7YVLrnvQqOij0ttdEo
   omMUr2UymE44oooef2igIk292aEdCmNJgAGKLdnFi2AKrzftyVXaHS4+R
   g6xmYNyri37sGZu6fnRGvow5BGEBBqiERJDleS04BCAn9OxLy5nBWc0vI
   if7cjQrNsctbUFP2dt54oLW84zTbnl3v+cDZ7TofkfpyOag0PU5Ex0E5K
   A==;
X-CSE-ConnectionGUID: Vs0V0T3rTdqwNdnzk1TVhw==
X-CSE-MsgGUID: Bx06PBA5RsW439bLqIAJtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33687011"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="33687011"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 18:17:09 -0800
X-CSE-ConnectionGUID: VCQut5AORZm3f/yeSAbYTw==
X-CSE-MsgGUID: Wr68SmgLQyeGPSxrSiJ34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96866320"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa008.jf.intel.com with ESMTP; 11 Dec 2024 18:17:07 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release path
Date: Thu, 12 Dec 2024 10:15:29 +0800
Message-ID: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PASID is used for SVA by a device, it's possible that the PASID
entry is cleared before the device flushes all ongoing DMA requests and
removes the SVA domain. This can occur when an exception happens and the
process terminates before the device driver stops DMA and calls the
iommu driver to unbind the PASID.

There's no need to drain the PRQ in the mm release path. Instead, the PRQ
will be drained in the SVA unbind path.

Unfortunately, commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain
removed from RID") changed this behavior by unconditionally draining the
PRQ in intel_pasid_tear_down_entry(). This can lead to a potential
sleeping-in-atomic-context issue.

Smatch static checker warning:

	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
	warn: sleeping in atomic context

To avoid this issue, prevent draining the PRQ in the SVA mm release path
and restore the previous behavior.

Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from RID")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-iommu/c5187676-2fa2-4e29-94e0-4a279dc88b49@stanley.mountain/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0f2a926d3bd5..5b7d85f1e143 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -265,7 +265,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
-	intel_iommu_drain_pasid_prq(dev, pasid);
+	if (!fault_ignore)
+		intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 /*
-- 
2.43.0

