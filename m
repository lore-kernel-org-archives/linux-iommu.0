Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A947613D
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706284; x=1719242284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mN/2WK8J7n2rewlZ5IincQ/OigkXaXVK51epQ2blgdQ=;
  b=D3+CBVL2sN4tbII1OPTpTkCxlNCn3QKJCNfnOvGqP4OIV0dnIhrDbvN5
   4QIFqD0ngueOufnAJsCviozQPfI4LVb6MkHWNJpd0LaZUH5fCEx7WV8Wm
   DMCD87/fR8i8kQfAGFYjmpL0siCcUA8i8N0QE7lj8n2Gl+LoEDqrmgsw4
   yt4UGj511GqhUBkYQwCzh8A5tqwAQWR1G/dKK8Z9o8b1gfkF8G7nPnDDV
   dtIeqmVfJC+CQsBbGiSq570QZawH3tglRTIswufITLHtTxP2ZVP4LmhAc
   ygEydAesgTkwbTBEbw61R5hvw8mwjrI+UYUFc3U8Vn88UB10QssS1zcB6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255058"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004517"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004517"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:01 -0700
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 1/5] iommu/vt-d: debugfs: Define domain_translation_struct file ops
Date: Sun, 25 Jun 2023 23:04:38 +0800
Message-Id: <20230625150442.42197-2-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230625150442.42197-1-Jingqi.liu@intel.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define domain_translation_struct file_operations instead of using
DEFINE_SHOW_ATTRIBUTE() in order to specify source identifier and pasid
to dump the specified page table.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..072cfef19175 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -391,7 +391,25 @@ static int domain_translation_struct_show(struct seq_file *m, void *unused)
 	return bus_for_each_dev(&pci_bus_type, NULL, m,
 				show_device_domain_translation);
 }
-DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
+
+static int domain_translation_struct_open(struct inode *inode,
+					  struct file *filp)
+{
+	/*
+	 * Allocate one 1Mbyte buffer to save sequential file output,
+	 * since the default size of input buffer is 1Mbyte when the
+	 * user reads.
+	 */
+	return single_open_size(filp, domain_translation_struct_show,
+				inode->i_private, SZ_1M);
+}
+
+static const struct file_operations domain_translation_struct_fops = {
+	.open		= domain_translation_struct_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 static void invalidation_queue_entry_show(struct seq_file *m,
 					  struct intel_iommu *iommu)
-- 
2.21.3

