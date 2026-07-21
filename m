Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C685A3E8C55
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626476; cv=none; b=GhVOpcs3txCAGV9QzwBjTz50QEp5DaWhb9FBVnPk4LW1vMxv/bTpHigWFOtzIHCzONRe9iXC8QygjyPTN3nZWKcSmnWtTyY1bVy6Xcgmhw2+37wrxmZM/AYulfH9mAs4VT9okINm19Cyu2bDROy9sRI/3nkl7g3WJ8tkiaznFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626476; c=relaxed/simple;
	bh=3ocY3LuxVGOzuZ5oLTc06Yv6aTa8QcQV0dt7Jn9m7qE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOE5fX8T4ZAob1+jrSoRSL94O3kK3T6aUVwS3Cl8ut4LV9T8GEy393mLl1104fFFUuba9oDKrQNsKteifzLwf2mZw39LPWJTuvPdJ2QFdqjTYLxAD74/vqByClWp/Au9ZOhvN8ZxOAu3yIWK62j7Wm+EJYApNSMBvu3c42Oq99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=TYqqRocx; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="TYqqRocx"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/intel: fix out-of-bounds memset in dmar_latency_disable()
Date: Tue, 21 Jul 2026 17:34:10 +0800
Message-ID: <20260721093410.2465-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc10.internal.baidu.com (172.31.50.20) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1784626462;
	bh=GaD1oGhEMrfBVdwD5WLzMvPeXBXtgS8uA/yLsA4ODlU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=TYqqRocxA89iitEktZUNpPTgvOy8DxRPIbQPdp73WoJgP4ehoX5rzFoEkSGXw2H3i
	 C9R9ZnJVwrV3l3BbqAkzjHtRYncBu15MBgKL/VUnHW9nUmmAUIceYCSXHl093uGPYH
	 Ecltr5+kJoA9s8iwXgZJFneLaGeoXkgLnTO9SkdlnP2n7GQlY3N3oqguSkPsR7/j7x
	 IkkNHg+9UVsvu0OUc+ofEkT3CMtl04dCA0dAF5cJobF8amhR5is0te6cCH70MSQdbA
	 yWj3xq3O9aFVc49OCAHVsNx/pzygmSoyk5d7IDAm7gnmuJbgTJHjNsKQ6/hEsdAdqe
	 NUPm8Ok+Dxf6A==

From: Li RongQing <lirongqing@baidu.com>

dmar_latency_disable() intends to zero out only the single
latency_statistic entry for the given type, but the memset size was
computed as sizeof(*lstat) * DMAR_LATENCY_NUM, which clears the entire
array starting from &lstat[type].

When type > 0, this writes beyond the end of the allocated array,
corrupting adjacent memory.

Fix by using sizeof(*lstat) to clear only the target entry.

Fixes: 55ee5e67a59a ("iommu/vt-d: Add common code for dmar latency performance monitors")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/intel/perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 02168f2..bec98dc 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -63,7 +63,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type)
 		return;
 
 	spin_lock_irqsave(&latency_lock, flags);
-	memset(&lstat[type], 0, sizeof(*lstat) * DMAR_LATENCY_NUM);
+	memset(&lstat[type], 0, sizeof(*lstat));
 	spin_unlock_irqrestore(&latency_lock, flags);
 }
 
-- 
2.9.4

