Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D9187F
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584826; x=1689120826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/6SSeJyFt4HtQDZKoE6TalrVcffk6vqEeNrwtMJkjI=;
  b=AnsT8QdFU+arUduJSTKz5chnGji3HyvUMymLVZ28VAh7ld+GJxR77MHZ
   i7hNJ+oZ7oqj/piJ8xZf3eCx3gFuLZ9grkg/EY39iNkfm826lUbhcIJh8
   ZFUJ/gkzNCGf23NOGzNfRdzFiieMbyHFyUohXUe6sjg8cx6t+G9v12Fvw
   BVvLAdvegjvr2tg6lylHgPfVSdyCtICx7xgdMIUynscNNzGaAQjJX8bv3
   4PR/AlNFZ2iMN84imvx8k5/iaY4COvCKWTSXHpie4EDrqykSj03pFkgeb
   wBG+Vm9aQDm4529l/FQqApJsOnXFGlhQdiB534SwAlMv+Lm3pZSBCM3IC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="264589886"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="264589886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445701"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] KVM: x86: Remove unnecessary include
Date: Tue, 12 Jul 2022 08:08:48 +0800
Message-Id: <20220712000908.3431936-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-iommu.h is not needed in kvm/x86 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-6-baolu.lu@linux.intel.com
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1910e1e78b15..f7ec1e39eec7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -41,7 +41,6 @@
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
-#include <linux/intel-iommu.h>
 #include <linux/cpufreq.h>
 #include <linux/user-return-notifier.h>
 #include <linux/srcu.h>
-- 
2.25.1

