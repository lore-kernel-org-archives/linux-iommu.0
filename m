Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C998274FEF
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171846; cv=none; b=GhzFnrBSjeEuhLlWaZEmPFtCf+sDziZIdjzCow7H4mnO6kw0ngMAryoU16lopvtBJ7E0feoEqXRg1VD8BfrNIpe1EPWvWgOsHYEIWVSf2jMw4/LvSxyKrVWJ+GCs3BwgjcjNAqEf7SrIzvxneVkFmiBY1gOsyalUPXv/Y9eQVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171846; c=relaxed/simple;
	bh=rGLx+MboJvSWlJwrlf2DVv8MGDDP4w8MrS8i1yDyxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncsxWvE1oBDrXbrhP16DsM4x3DGePV4qADidfGpp/gsj9iRqanZq7E4Qik0bt41YJV8IrLge8dq1Nhc+jIpA72QwjpQUUvGRYzndFsdTw4V8QP2Sy8Ecq2ezNMB3l84hDPKfwEsJWb1s73ePrMomn4yEekkrRS+rlvTnXMu1sMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSV6zKRP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSV6zKRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171844; x=1789707844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGLx+MboJvSWlJwrlf2DVv8MGDDP4w8MrS8i1yDyxEk=;
  b=kSV6zKRPby3bN+R1YgzwaTyN1F8crb6mG64MmeVZfq8gmdbRy01Y7WT3
   cehp283bIdMbHfI4bWcRa915Z3oyoCqHMr/Mxzc8uUnWUNwG7kYNKRHeW
   lpqzcJztDbPtNUMbrEymYFP1kyOcTXpHf3qnGwALmh0tF7qGwa4fn2CQQ
   knIRAEnHiABJ7TcrljK2EoKWLDaIF89PSSCGYY3R5PRkU4nHCKtvzSATK
   XYbNT4eNrLGY9KYvRRpsbUIIjQtLs4txLrutQTgXIc+SvOzx/trq/6/Es
   lcyyFZCzadOr411/o9MsemmWuyuiitMDxUuPIEopRpRoqwega3Kp9RRl/
   w==;
X-CSE-ConnectionGUID: M+9xnkU7TH6RfszSqi/G2A==
X-CSE-MsgGUID: grHk1HT+TDmmAVwYQJ9+/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182253"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:03 -0700
X-CSE-ConnectionGUID: Hf+PBDC1TqO/HkMI+A72SA==
X-CSE-MsgGUID: fQmkKDexSS2pIUfRmY6LJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353400"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Thu, 18 Sep 2025 13:01:58 +0800
Message-ID: <20250918050204.359508-2-baolu.lu@linux.intel.com>
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

From: Seyediman Seyedarab <ImanDevel@gmail.com>

snprintf() returns the number of bytes that would have been written, not
the number actually written. Using this for offset tracking can cause
buffer overruns if truncation occurs.

Replace snprintf() with scnprintf() to ensure the offset stays within
bounds.

Since scnprintf() never returns a negative value, and zero is not possible
in this context because 'bytes' starts at 0 and 'size - bytes' is
DEBUG_BUFFER_SIZE in the first call, which is large enough to hold the
string literals used, the return value is always positive. An integer
overflow is also completely out of reach here due to the small and fixed
buffer size. The error check in latency_show_one() is therefore
unnecessary. Remove it and make dmar_latency_snapshot() return void.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Link: https://lore.kernel.org/r/20250731225048.131364-1-ImanDevel@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 10 ++--------
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..65d2f792f0f7 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -648,17 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
 static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
 			     struct dmar_drhd_unit *drhd)
 {
-	int ret;
-
 	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
 		   iommu->name, drhd->reg_base_addr);
 
-	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
-	if (ret < 0)
-		seq_puts(m, "Failed to get latency snapshot");
-	else
-		seq_puts(m, debug_buf);
-	seq_puts(m, "\n");
+	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
+	seq_printf(m, "%s\n", debug_buf);
 }
 
 static int latency_show(struct seq_file *m, void *v)
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index adc4de6bbd88..dceeadc3ee7c 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -113,7 +113,7 @@ static char *latency_type_names[] = {
 	"     svm_prq"
 };
 
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
 	struct latency_statistic *lstat = iommu->perf_statistic;
 	unsigned long flags;
@@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 	memset(str, 0, size);
 
 	for (i = 0; i < COUNTS_NUM; i++)
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "%s", latency_counter_names[i]);
 
 	spin_lock_irqsave(&latency_lock, flags);
@@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 		if (!dmar_latency_enabled(iommu, i))
 			continue;
 
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "\n%s", latency_type_names[i]);
 
 		for (j = 0; j < COUNTS_NUM; j++) {
@@ -156,11 +156,9 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
 	spin_unlock_irqrestore(&latency_lock, flags);
-
-	return bytes;
 }
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index df9a36942d64..1d4baad7e852 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -40,7 +40,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
 bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
 void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
 			 u64 latency);
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
 #else
 static inline int
 dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
@@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
 {
 }
 
-static inline int
+static inline void
 dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
-	return 0;
 }
 #endif /* CONFIG_DMAR_PERF */
-- 
2.43.0

