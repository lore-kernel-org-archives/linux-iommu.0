Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0C27A114
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051626; cv=none; b=HZONFETLTUWzxWHMhR5IQ//MqlKJzpcsbVvKHmGKyu/2TPLdnSvs1t/VgPhJlXjLwulwIyrT7g1ueKnKScDMGo3LXNzaa96OPd8yYvwaV7oHvzIeENmZUGz2mwmv1ULTFWZDU6o7ygjFeTktzm3IfU3TG2ysKHMcQsg5+57yO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051626; c=relaxed/simple;
	bh=NxN2V72HehM5qhaBkoFO6C59cQEs1svRv+tmXE2EZa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH8uU1vqVXoEFVR7EcClPezEq/KA9ZUF+K24NUWniBwxAW8WraoxmXkx8bi4RMl4a7In6JDvWbMBwGgQsmaJ22o3H6/PgZ4OdZ1xJPp3n6Ysg4Bke2OkY37XUMHiOaPr2Uv06KaViQoteWkMvLI6AFGhe34LBM1Jt5r4whRRIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuJwsmyT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuJwsmyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051625; x=1788587625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxN2V72HehM5qhaBkoFO6C59cQEs1svRv+tmXE2EZa8=;
  b=PuJwsmyTc2MrYTFJwo07aU7037zubBx530cgRGgP/uEcQvZI7y9LVNl1
   s5As6GsQsiF7A6D6DyCuGGljitBe+RGf4mc8jSKSUE8viC1E6hyglZeMG
   CskZcJ+BL6wbuc7wiw3DtYAwj8M2gvsWb5s6P+f7dKdk4xyGwR/tiouKU
   t6laH9wFqHwImIwXTImHx/QJIY6ivqI22l85D5tVqmAhZzGwzZya497sy
   fJeHfaduw/JJWdFIYfFg6a93BNewxO5torokwKtdL4UyJ42u0gCAxG/sV
   zpuvP6QomnYB3mJ27pV8iQvpVJBUTy0XrWVcV4TC7rww5UObM0nnvUGrf
   g==;
X-CSE-ConnectionGUID: eQuq7JzsQGOu/qZ+uXmZ4w==
X-CSE-MsgGUID: RdpWyR6WRui2KuOKU7L3ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015160"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015160"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:44 -0700
X-CSE-ConnectionGUID: hJzqPORMTi+h4ZkzimtwJg==
X-CSE-MsgGUID: YBwgRuk9RKi9ASvYjmG14g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257776"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 7/8] mm: Hook up Kconfig options for async page table freeing
Date: Fri,  5 Sep 2025 13:51:02 +0800
Message-ID: <20250905055103.3821518-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

The CONFIG_ASYNC_PGTABLE_FREE option controls whether an architecture
requires asynchronous page table freeing. On x86, this is selected if
IOMMU_SVA is enabled, because both Intel and AMD IOMMU architectures
could potentially cache kernel page table entries in their paging
structure cache, regardless of the permission.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..1b2326d81681 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -281,6 +281,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select ASYNC_PGTABLE_FREE		if IOMMU_SVA
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..1576409cec03 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -920,6 +920,9 @@ config PAGE_MAPCOUNT
 config PGTABLE_HAS_HUGE_LEAVES
 	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
 
+config ASYNC_PGTABLE_FREE
+	def_bool n
+
 # TODO: Allow to be enabled without THP
 config ARCH_SUPPORTS_HUGE_PFNMAP
 	def_bool n
-- 
2.43.0

