Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F941686A
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811743; cv=none; b=rWOG71G0Lq3BqOG7jx6ifRfOZoBFbpniQdufe8+nZ8QnBP8zKazdOz5OmAnRtfJ1otSxRBb75NjjrVXGrvzgWFKZ7XD7HvLE8LyBFkTnzTdCIQdOSlMDwd65IePBZ5F82Kc+PEksvO2TQZB/3pcqTrvNZhAzYEXDUcbefOgEBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811743; c=relaxed/simple;
	bh=kGVbd9pnieA+4WkKdGphqkjUnjw6m66qlFoy3/Q6/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9HdMCKGqNfEUzrtsgDi/Kl5nJpoS8a/QpFHQKy4sQM15f/YvpHUarPty6hnwQjMPs9nxnoPpvjUe8QnkVoSIAV+deuDMUYnnCfArO0/auTJtYSynV5aZqLWnZ02IU8EDbw4za5XTujn18/bP+lt6T1056A7rchAeeqM38wLWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abFsZllM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abFsZllM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811742; x=1817347742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGVbd9pnieA+4WkKdGphqkjUnjw6m66qlFoy3/Q6/+8=;
  b=abFsZllMEbBFz+E+CQuxSTE2D9HMPMroMfzzEnZPXXsZ8DE/ig1NkyId
   KxD2uGr2ioHMoVHgbLFvpPHzt+RVXSgKEExrX6HwpvuPbEAI5Yat8eyTI
   UB1NjbSLVe+FTBS/z8cUHXSGPs9V+fSVqG8c2oU+Jy6IwkTaK1YnDS/FL
   k+6qOTNmZNMaAh4R0HYBfkswKmufsOxnf6qmSJHEGGXAcng5UZkdS2t9T
   qeD7CL4KVin4IexL5TkUGNcr0sIEBZ5ooknbv/md3bKBJZpzdgBvBa87a
   r1PDpucs34/MHQnk+4v0x2HphENl8KqwPtJwF6943ZJxQgAd9A3BZyA7g
   A==;
X-CSE-ConnectionGUID: MghESFD4TsC6TPhASczACg==
X-CSE-MsgGUID: 3YqieOSgQDabu+rQnsmsbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231370"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:49:01 -0700
X-CSE-ConnectionGUID: MzVLTTsOTo6mh0p81YQpVQ==
X-CSE-MsgGUID: B0P+Oxq5R+KLRMdq+9qeBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587615"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:49:00 -0700
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
Subject: [PATCH 17/20] iommu/vt-d: Clear Present bit before tearing down copied context entry
Date: Tue,  4 Aug 2026 10:37:11 +0800
Message-ID: <20260804023714.3080506-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copied_context_tear_down() zeroes the 128-bit context entry with
context_clear_entry() while the Present bit is still set, and only then
issues the context-cache and IOTLB invalidations.  This leaves a window
in which hardware can fetch a torn entry, with some fields already zeroed
while Present is still set, leading to unpredictable behaviour or
spurious faults.  While x86 provides strong write ordering, the compiler
may reorder the writes to the two 64-bit halves of the entry, and the
hardware fetch is not guaranteed to be atomic with respect to multiple
CPU writes.

There is no cacheline flush before the invalidation either, so on an
IOMMU without coherent access to the context table the zeroed entry may
not be visible to hardware at the point the invalidation is submitted.

Apply the same ownership handshake described in the VT-d spec, Section
6.5.3.3 ("Guidance to Software for Invalidations"): clear only the Present
bit, flush it out to the IOMMU, perform the invalidations, and only then
zero the remainder of the entry.

Fixes: c7191984e5aad ("iommu/vt-d: Factor out helpers from domain_context_mapping_one()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7098a6bf6a40..000b81cf4a7a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1109,7 +1109,8 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 	assert_spin_locked(&iommu->lock);
 
 	did_old = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 
 	if (did_old < iommu->max_domain_id) {
 		iommu->flush.flush_context(iommu, did_old,
@@ -1120,6 +1121,9 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 					 DMA_TLB_DSI_FLUSH);
 	}
 
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+
 	clear_context_copied(iommu, bus, devfn);
 }
 
-- 
2.43.0

