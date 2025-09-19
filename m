Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF526D4FB
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260594; cv=none; b=Wbw/OYAtW++G7V+AiyXmwo+Rb7hCpwu71hpKlLk5hYo9uABAVO9O2DpBDZe5vI433sKOdNxoYsQ5cY0XAUkmkWtun321dfjJoCeBw1SYUE4BAIYd0SCmjRtnNoJFaVxhhjQBiySCDObfUsv1EZfNt/MEnRmH8blPGwBw/bLFbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260594; c=relaxed/simple;
	bh=4R1MBHQq1JefAbwJJHoL+8VoAIMfKTm1QFbquO2mYLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxYpAKBhCfua6LjBoK5f0YSz3j3fWIg3xnWodwMgh9EQn6Z7pLGSU9r/Z4FQgkZ6ZMzbV5KsNhNQc9ke+dW7nMLERi+ufGT0ysSRxGWcWQogLu/ToCkxLX5Ku2/LwwCu9No6Adr2NlfKHlKYRC+4mZsjUTRFo8fHG8lUPc5tZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWO1xr5K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWO1xr5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260593; x=1789796593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4R1MBHQq1JefAbwJJHoL+8VoAIMfKTm1QFbquO2mYLA=;
  b=cWO1xr5KVFFwmeUH2uHtd9LmHAeKaemo2tfzzYgdh7944xrXl2C4Dk7X
   tLI+2UPj+kHmHBvip6l5lneMeX2oDgBQZy6d+IHXGMVy3yHWrKmfUST4M
   8/T0mB9mL3hT3+IR+SnpGY2PSZOq7Ijtn1pkimW8tN+TCXCo+7cCPVKHA
   Cc0Wh+C6hePvk+kVo+e1VFwQNoaeW3xCPg54wp8tqq+31Ac4eRAkpZarf
   fA047MeCW89xQYHU7RaGOWQa729yir4mOsDZJFwemJw+IDgnhfZk4fSCw
   BHAjm8rMIrykSxw1hAv5ESBtD0eZzXpdjYlKuLFPOZ54XRuTaRIlsqoSA
   Q==;
X-CSE-ConnectionGUID: Km2sK7kXTM+zb0XUUA6AOw==
X-CSE-MsgGUID: 3HSOQUapS+2ECy5Blf1dtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235856"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:43:13 -0700
X-CSE-ConnectionGUID: AnSarqLJRvCAo0XtC3fUqA==
X-CSE-MsgGUID: pmp2LUxXQ/WqgCkFl7wFLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858828"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:43:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 7/8] mm: Hook up Kconfig options for async page table freeing
Date: Fri, 19 Sep 2025 13:40:05 +0800
Message-ID: <20250919054007.472493-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919054007.472493-1-baolu.lu@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910ba2ef..247caac65e22 100644
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

