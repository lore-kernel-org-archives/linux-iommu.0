Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21388353A92
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566768; cv=none; b=UV4EP0kHeOQK6PPzIMtYrt8zD8juJBciV10QLTs59adhEUFnXtDYypeq8lcgg2I+H0ud06EDdenbyVDdVH7xkaPArDm32EAfiKJARgtQuJKvyPE+Odf0qzLzJsG3qs+s63ZX2y13jqeHDzKIMbzsyNaAQrXXI+XTZ1RiPPtczDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566768; c=relaxed/simple;
	bh=RB4JJzRllkWjqZy9fXCi29s/pxpLcwx/ySDi/mBNaz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQvV8VRVPoQ4aWmG+Go87MfC4Tl9zhuMPzJg1X9Cg7qMFGflF9X6QqTGkATEoDk/0pHFbgC57veI6dtf7m7El9n2uhF/WThuQZhJNXX7+a1Z/+jt4Puh5yFYRt0cwvE4zRFPo2TUZQVWUjruPKnRLi+hcRm5vxODfangna8WtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3AL8+Zj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3AL8+Zj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566767; x=1822102767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RB4JJzRllkWjqZy9fXCi29s/pxpLcwx/ySDi/mBNaz0=;
  b=Y3AL8+ZjXVUL0g1R5hhLMuSf/T0nyDoGVdYcjDRfsBxQuDrTMOs64nWl
   Kar9AkQS6mHC4etthlbANx5lrJYQDZcgpzuP/K60ZP4tECAl5UUZzkm8s
   c3HWEsALUHKh24+veuGDr3LiuOcBU5rhyuZvGm6LpoH8GZPWRyNUI1wAo
   8GlZ35nRWu8dYSbTt77JMT6g2rmrUND2LllrolO6NGP6Hst6P0lCg9kjV
   J7zduUjAtM5Bbm7cCcKBOa9Nd9CoKb5kpHMR4TSuRJyru2hgoCEcI9QeF
   9dGPrNpXA6a0KTxJA06kxB/zt0gQhkKkSPDdEIJL1Vhgnpdf8uvZEZH7t
   Q==;
X-CSE-ConnectionGUID: q16CLhh5S8CGItFINQ5meg==
X-CSE-MsgGUID: GP0ts5NaR0Gz8jHKqpAJlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917222"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917222"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:27 -0700
X-CSE-ConnectionGUID: QQxYfvW9RWW9IB4qb5S03Q==
X-CSE-MsgGUID: 3CK5fP+8RAOJONflRQlJsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004107"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] iommu/vt-d: Fix iopf refcount leak in nested attach
Date: Mon, 28 Sep 2026 11:27:20 +0800
Message-ID: <20260928032722.2868623-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_nested_attach_dev() takes an iopf reference for the new domain but
does not drop the possible reference from the old domain. This leaks
info->iopf_refcount, can keep the device permanently on the iopf queue,
and later triggers WARN_ON(info->iopf_refcount) when PRI is disabled.

Fix this by dropping the possible reference from the old domain after
the nested translation setup completes.

Fixes: 17fce9d2336d9 ("iommu/vt-d: Put iopf enablement in domain attach path")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..f84fc8b41fde 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -59,6 +59,8 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	if (ret)
 		goto disable_iopf;
 
+	iopf_for_domain_remove(old, dev);
+
 	info->domain = dmar_domain;
 	info->domain_attached = true;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-- 
2.43.0

