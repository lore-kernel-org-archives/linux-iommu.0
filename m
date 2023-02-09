Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09628A94B
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675977908; x=1707513908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N6Ck+USojABOxT9CFzTEfdxuALT4Xbd+KeJGB455nkw=;
  b=VyBf6oHCOwr2EJ60KP31jU/SUOfFP9Xgrzw40RP3+RCQ76zvf/8bNGdP
   iQZbd+ekyW2g09Y7/AMuc5QJAbYiSQURIzuIYa7WgkyNexMdZ2ePVZKUa
   UHCYSZRaHkJPjAt/vnkN5RXTb+b/0ZLimmgszWzXMlwEkZLx7+MeIEWpE
   QkDhILuSYLap9Z0leZR4tO/RO9+/tzugksgP71QlIDtwjvwqL79CK07Qy
   WF8CSgqzgqEnD1CyFumKpEp96Avb7PuDSB0df4G+RV4x9NWKY2EhGulWr
   Wd6jjTVbVwwG0NaE6jKBwiuH5cMr1qRzbIVcEEyavkI3xhPVYobsVmT4u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="327943072"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="327943072"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 13:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="617678462"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="617678462"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2023 13:25:06 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	stable@vger.kernel.org,
	Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [PATCH v4] iommu/vt-d: Fix PASID directory pointer coherency
Date: Thu,  9 Feb 2023 13:28:43 -0800
Message-Id: <20230209212843.1788125-1-jacob.jun.pan@linux.intel.com>
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

This patch adds clflush calls whenever allocating and updating
a PASID table directory to ensure cache coherency.

On the reverse direction, there's no need to clflush the PASID directory
pointer when we deactivate a context entry in that IOMMU hardware will
not see the old PASID directory pointer after we clear the context entry.
PASID directory entries are also never freed once allocated.

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
Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
Reported-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4: Remove clflush PASID dir pointer when programming context entry
v3: Add clflush after PASID directory allocation to prevent malicious
device attack with unauthorized PASIDs. Also flush all the PASID entries
after directory updates. (Baolu)
v2: Add clflush to PASID directory update case (Baolu, Kevin review)
---
 drivers/iommu/intel/pasid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb3c7020028d..979f796175b1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -128,6 +128,9 @@ int intel_pasid_alloc_table(struct device *dev)
 	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
 	info->pasid_table = pasid_table;
 
+	if (!ecap_coherent(info->iommu->ecap))
+		clflush_cache_range(pasid_table->table, size);
+
 	return 0;
 }
 
@@ -215,6 +218,10 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 			free_pgtable_page(entries);
 			goto retry;
 		}
+		if (!ecap_coherent(info->iommu->ecap)) {
+			clflush_cache_range(entries, VTD_PAGE_SIZE);
+			clflush_cache_range(&dir[dir_index].val, sizeof(*dir));
+		}
 	}
 
 	return &entries[index];
-- 
2.25.1

