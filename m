Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C86BA3F
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675461822; x=1706997822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cskhf8vcDlJ5KLsoC6Xpt8pWGcbFmVNKlwLnbgeY8uI=;
  b=V4bIHfVAugkLqMVD+HNa1mRbMBSxBwPLAGkQImFFInsLPzi+m0H3mZAu
   tB2NAbrFeiHHY8hkpLI71M5YOirbci9s1zSJZpFNOiuvFCTAmtLZ8WS+f
   uf4WBGKvZR1Mxh8Si2mHHql3Abxc8WHb185e/taGgxH6VS2dACs6skE2s
   gDK1HMrVttFiGdwIYePMct/ejAbd2d25De6RSDJ9WKgCChUgBWSSyDEnC
   fq5t9yEl5zKk/yzT3ugVgmXie9L/qAPs8EyW1c6i9/xoI+xNNkg69jHSw
   ORcbUQy4ByUmIk/mH262nbcHvrPszN1bnXtPZIm9FTh1HtXEu+ouGFe1v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="309202204"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="309202204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839742743"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="839742743"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2023 14:03:41 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	stable@vger.kernel.org,
	Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [PATCH] iommu/vt-d: Fix PASID directory pointer coherency
Date: Fri,  3 Feb 2023 14:07:14 -0800
Message-Id: <20230203220714.1283383-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms that do not support IOMMU Extended capability bit 0
Page-walk Coherency, CPU caches are not snooped when IOMMU is accessing
any translation structures. IOMMU access goes only directly to
memory. Intel IOMMU code was missing a flush for the PASID table
directory that resulted in the unrecoverable fault as shown below.

This patch adds a clflush when activating a PASID table directory.
There's no need to do clflush of the PASID directory pointer when we
deactivate a context entry in that IOMMU hardware will not see the old
PASID directory pointer after we clear the context entry.

[    0.555386] DMAR: DRHD: handling fault status reg 3
[    0.555805] DMAR: [DMA Read NO_PASID] Request device [00:0d.2] fault addr 0x1026a4000 [fault reason 0x51] SM: Present bit in Directory Entry is clear
[    0.556348] DMAR: Dump dmar1 table entries for IOVA 0x1026a4000
[    0.556348] DMAR: scalable mode root entry: hi 0x0000000102448001, low 0x0000000101b3e001
[    0.556348] DMAR: context entry: hi 0x0000000000000000, low 0x0000000101b4d401
[    0.556348] DMAR: pasid dir entry: 0x0000000101b4e001
[    0.556348] DMAR: pasid table entry[0]: 0x0000000000000109
[    0.556348] DMAR: pasid table entry[1]: 0x0000000000000001
[    0.556348] DMAR: pasid table entry[2]: 0x0000000000000000
[    0.556348] DMAR: pasid table entry[3]: 0x0000000000000000
[    0.556348] DMAR: pasid table entry[4]: 0x0000000000000000
[    0.556348] DMAR: pasid table entry[5]: 0x0000000000000000
[    0.556348] DMAR: pasid table entry[6]: 0x0000000000000000
[    0.556348] DMAR: pasid table entry[7]: 0x0000000000000000
[    0.556348] DMAR: PTE not present at level 4

Cc: <stable@vger.kernel.org>
Reported-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..b4878c7ac008 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1976,6 +1976,12 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		pds = context_get_sm_pds(table);
 		context->lo = (u64)virt_to_phys(table->table) |
 				context_pdts(pds);
+		/*
+		 * Scalable-mode PASID directory pointer is not snooped if the
+		 * coherent bit is not set.
+		 */
+		if (!ecap_coherent(iommu->ecap))
+			clflush_cache_range(table->table, sizeof(void *));
 
 		/* Setup the RID_PASID field: */
 		context_set_sm_rid2pasid(context, PASID_RID2PASID);
-- 
2.25.1

