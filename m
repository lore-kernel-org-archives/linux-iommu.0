Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F48BF9
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="artdBOv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697512871; x=1729048871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsdAUA8p1gbd434H5E9bJERERFBzsxCgS1ZKXsNQj30=;
  b=artdBOv5V1vsnvytgpJOdYu1b//88t1Du6e2GHqbNAjo0a2eE87uBkhu
   m0gaj+1TZRX5pUhCXxkr5CokalCPAyumJkGIJ1g+yUUTKqzqSaqBluMBm
   tbrmNzJV+WQra0dbyJ7CbWB9bAtjyAXHtNA3cVQWPtfxVf/yiwWg4E5AY
   ioRO2D8APwJLdmXawT4Kz9sL3BPdVCqRVEbr9c3KOvm2DKHS+7M+4/46L
   ftbX1GGwFVZmUzH+54TmU9EUAukhYwfvQn/4IDGVt93EnEeg2nBSicwnO
   hB3KU0NnhA5QGF50fiq/nlc8Rl3xpKKVaKg/YWyoBdJGqhB2kwY0i9xGC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389560778"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389560778"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826269905"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826269905"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 20:21:08 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 01/12] iommu/vt-d: Retire the treatment for revoking PASIDs with pending pgfaults
Date: Tue, 17 Oct 2023 11:20:33 +0800
Message-Id: <20231017032045.114868-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017032045.114868-1-tina.zhang@intel.com>
References: <20231017032045.114868-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revoking PASIDs with pending page faults has been achieved by clearing the
pasid entry and draining the pending page faults in both hardware and
software. The temporary treatment can be retired now.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3c531af58658..9bf79cf88aec 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -387,13 +387,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 			if (svm->notifier.ops)
 				mmu_notifier_unregister(&svm->notifier, mm);
 			pasid_private_remove(svm->pasid);
-			/*
-			 * We mandate that no page faults may be outstanding
-			 * for the PASID when intel_svm_unbind_mm() is called.
-			 * If that is not obeyed, subtle errors will happen.
-			 * Let's make them less subtle...
-			 */
-			memset(svm, 0x6b, sizeof(*svm));
 			kfree(svm);
 		}
 	}
-- 
2.39.3

