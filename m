Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AC3D561
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052775; cv=none; b=LzB12o5Vkqd6QOtH7ECChiyzXaDyZpAmIzyFdcwAbG7RmVsfqYnijI5n/mfns78ZdcCcYibVXfAWX2XQLQCQmqaLitUZ1oCRivwQBSp+ZtweVeZdR07pqwqylVzdkU0dCJ/K1fBszwbZZ1YaZWND9yMunTekS6UiHLLNd4qjD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052775; c=relaxed/simple;
	bh=LI4TUKQcvu8NMrFjCnSkKO5OlCTfkkPU/tftsaNGm9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEMlaAysFfb3stJNUE8HromJ32PJQBiGl8Q1iMFnhNGK+EQpe95Z3iv+kB3U1g7R2vQNd/8U17PuGYTsbOUnBluErCtEAG8iEy57QUb6zNcRznM6P2rud6HZpc7KuePpi5wN6zX6oJcV3vmxs6EVOcHzZPSfAPPfqFO6fcmHwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8yQ9iSS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8yQ9iSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734052774; x=1765588774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LI4TUKQcvu8NMrFjCnSkKO5OlCTfkkPU/tftsaNGm9Y=;
  b=G8yQ9iSSSoIk0ghk7D+Q6AoyUMrqepnFy/XWGP0xu3DqA4uBSsWK4tBC
   1TDt7PZPjV/Dmy1beMuUtH5YGAvipkV/KSFdE6KP+C+N6+ZATzF3+eQgO
   WhZud7mQgySN0asFHGwVmccazDY4kTU1wx7YCOEv+zBYFroni4J9mM7TI
   I7FBJQ7p0mWDEy4/sLthpUmoL0MV6DEyPJtfv9uCnBMIBHLc4UtBxX/8K
   tpf78vEYUFNNMDZGPRig/AAzwEHKs/tlM0GEOpkAv/46iDTRhhg0nV6N8
   4HvnoPwb88wfVMa0zVr2FmI9hZCXZ1THCprAjKHnlHbfqpkZ7lfI5Qv2D
   A==;
X-CSE-ConnectionGUID: CgTvErejT16BIvjhXBNjYQ==
X-CSE-MsgGUID: 0cNGgLLlSwOWJCyaXqb6YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45510024"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45510024"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:19:33 -0800
X-CSE-ConnectionGUID: cZLgcs2cTW6maeyaHdtyjQ==
X-CSE-MsgGUID: d3uU5sVFSpSfPRYoNviNZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96835641"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 17:19:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu/vt-d: Avoid draining PRQ in sva mm release path
Date: Fri, 13 Dec 2024 09:17:52 +0800
Message-ID: <20241213011752.1177061-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
References: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241212021529.1104745-1-baolu.lu@linux.intel.com
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

