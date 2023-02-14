Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F157E
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676345179; x=1707881179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rCD/Qqygm00lrK0TTfCKSQlwDjaUN5UIdqMxbmLxq28=;
  b=PU89edqletgcq/+N7UpDbRg2lLRrEwQqW60BIqbXCAKxTc++PwSH8do9
   WvsR/pbofA8kO46JlVL1ftqxBUg0zu+EpJFxYyw6ukLQybgwBakRCVulO
   m1780kAXL2JzbuaDdxLHvNc3XuumSRO03HasKF5GrYiqrfcL+W5dvmuHe
   AfUpp/jd9rEKWeXGR1Athkh7NrUzSpBoHIV2JyUV2khG4vnpIkYTfk1fz
   kaxRAQLWWyBBTCPmRec7ICBtGuaEWsw7uMBYXe6jv3GR8P6Bcpn3Q5gwd
   kKqT/vRFb0UC4Nz6MVaYZwN03iuL7OFOY0bdDcrApnoNJaUlvQpBc8SYl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358476189"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358476189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 19:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732728776"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732728776"
Received: from test.bj.intel.com ([10.238.158.71])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 19:26:17 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: [PATCH] iommu/vt-d: Allow to use flush-queue when first level is default
Date: Mon, 13 Feb 2023 21:56:18 -0500
Message-Id: <20230214025618.2292889-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-mode
is on") forced default domains to be strict mode as long as IOMMU
caching-mode is flagged. The reason for doing this is that when vIOMMU
uses VT-d caching mode to synchronize shadowing page tables, the strict
mode shows better performance.

However, this optimization is orthogonal to the first-level page table
because the Intel VT-d architecture does not define the caching mode of
the first-level page table. Refer to VT-d spec, section 6.1, "When the
CM field is reported as Set, any software updates to remapping
structures other than first-stage mapping (including updates to not-
present entries or present entries whose programming resulted in
translation faults) requires explicit invalidation of the caches."
Exclude the first-level page table from this optimization.

Generally, vIOMMU can provide first-level translation support in the
following ways:

1. Generally using first-stage translation in vIOMMU implies nested
   translation enabled in the physical IOMMU. In this case the first-stage
   page table is wholly captured by the guest. The vIOMMU only needs to
   transfer the cache invalidations on vIOMMU to the physical IOMMU.
   Forcing the default domain to strict mode will cause more frequent
   cache invalidations, resulting in performance degradation. In a real
   performance benchmark test measured by iperf receive, the performance
   result on Sapphire Rapids 100Gb NIC shows:
   w/ this fix ~51 Gbits/s, w/o this fix ~39.3 Gbits/s.

2. Theoretically a first-stage IOMMU page table can still be shadowed
   in absence of the caching mode, e.g. with host write-protecting guest
   IOMMU page table to synchronize changed PTEs with the physical
   IOMMU page table. In this case the shadowing overhead is decoupled
   from emulating IOTLB invalidation then the overhead of the latter part
   is solely decided by the frequency of IOTLB invalidations. Hence
   allowing guest default dma domain to be lazy can also benefit the
   overall performance by reducing the total VM-exit numbers.

Fixes: 29b32839725f ("iommu/vt-d: Do not use flush-queue when caching-mode is on")
Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..9c41748a8292 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4005,7 +4005,8 @@ int __init intel_iommu_init(void)
 		 * is likely to be much lower than the overhead of synchronizing
 		 * the virtual and physical IOMMU page-tables.
 		 */
-		if (cap_caching_mode(iommu->cap)) {
+		if (cap_caching_mode(iommu->cap) &&
+			!first_level_by_default(IOMMU_DOMAIN_DMA)) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
-- 
2.25.1

