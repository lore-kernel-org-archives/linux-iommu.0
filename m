Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A286D6B
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171852; cv=none; b=QAKgRiq3mzUY84TMs70Z+E9sz00JD5WbNliXFnloBFln3DtCTnMK+OOAuamhZ0E6/gl+vNcqHmTdnVHwV4iXW1j/ruTgcuggIfRLKUc5PQtuk7FOoebnpE8PDoQ6Hw73B6hx53kFKYK9CzF0a272yLcC/Lohf/35j2qHTEHxQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171852; c=relaxed/simple;
	bh=Zu5AnuoxLCmHJOACwOEU2451ClLNd6bkHUbQEk2MCqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmODd1G05rM0KaG0PFSypzXSMuEdKAW8i0XebZfWYACPSu4c1zs4VtCZGkSWJlRC7SYS+3RVL13lnDyNHvx6E0xFjqOozzvT+bdpZ4BDAMMH8aumBxx2KzFRrtj3G3BNst4w5Dw7wgolOFH0tnopMz9RIihoBpE4Pp8PB4GtykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpVHigV/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpVHigV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171850; x=1789707850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zu5AnuoxLCmHJOACwOEU2451ClLNd6bkHUbQEk2MCqo=;
  b=fpVHigV/UptesdtMDWz7nS4XI8oDPshW3DBr56WZJpToes07CSV0Co+0
   UmhbPPsQx0Gvn5AW2zO1UzpS15BuDLPCyAvlQ+kCq90ofi+mmwYPHmEdv
   59xdGAVl4F2yEUvF8UZoxf8Zc/oXOHduP+JApayZgTkVdzZ/Vkxt+uuyo
   o0HWql9TQcrwaw20r+aqYD6W+GcN7BI7uj7iHb8LhYwW1Bs6jd+nYz2eP
   6bxYrXjPjGgbsSIwl4/nDLoTZ0ASWKcZmOItW/M8agh9mw1QUxUqLa3wh
   XggMQbS+OaxJrINsT2Qt3HlWVenkaDwgoPwh4GfEowlYeHdXXt6wK4thN
   g==;
X-CSE-ConnectionGUID: chVtkOHVS4iIJRoBW+wTDg==
X-CSE-MsgGUID: RGj+O0cMQcKdtpwA0Iie+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182277"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182277"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:10 -0700
X-CSE-ConnectionGUID: lVPoDScTSzio531Pl0nI4A==
X-CSE-MsgGUID: 97WaycxmQGycBcbYMS6prw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353411"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iommu/vt-d: debugfs: Avoid dumping context command register
Date: Thu, 18 Sep 2025 13:02:04 +0800
Message-ID: <20250918050204.359508-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The register-based cache invalidation interface is in the process of being
replaced by the queued invalidation interface. The VT-d architecture
allows hardware implementations with a queued invalidation interface to
not implement the registers used for cache invalidation. Currently, the
debugfs interface dumps the Context Command Register unconditionally,
which is not reasonable.

Remove it to avoid potential access to non-present registers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250917025051.143853-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 765edb3740e2..617fd81a80f0 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -62,7 +62,6 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(CAP),
 	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(RTADDR),
-	IOMMU_REGSET_ENTRY(CCMD),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
-- 
2.43.0

