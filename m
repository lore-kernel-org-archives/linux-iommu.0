Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A96F9E9
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFC5YSJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698136921; x=1729672921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyUeeVJUyOdoCnKoCMDJ4OfDnN41FQE7poIYURZrFJw=;
  b=WFC5YSJwto8Otm7vZrKlM56sKOwysx05aXa3uGiJxIfzRL0SxUoZoDt1
   PhAG8Q49mGuw7+00CP3JeSnG61iMRWfVRQB8Gey1x2bP5ctrKS3gk+OpI
   HFV1GSj01X48UKvGukayglbBvlzBQOX+lekhJU0SLwH8BYqSKPv4y9w9S
   6tL5RBzDxPmkRbAOY04o2S7fcUwwr8VhANLrrGcC+JP/4ghmUubkHw7Xs
   qX/xHQJa9AIcvPL/SLTOZv6WGjkQv+1UuquDVZCBqILreiXQZQLGS9gDC
   mxkRRUPS+A9Oqb8xQrE0NwH34gpt9ULRyVhq+usXFGe4qKFA+y8fFwOhe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389860365"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="389860365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 01:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="849062190"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="849062190"
Received: from b49691a74c3c.jf.intel.com ([10.165.59.100])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2023 01:41:56 -0700
From: Huang Jiaqing <jiaqing.huang@intel.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: jacob.jun.pan@linux.intel.com,
	kevin.tian@intel.com,
	yi.y.sun@intel.com,
	kvm@vger.kernel.org,
	jiaqing.huang@intel.com
Subject: [PATCH 2/2] iommu/vt-d: Adopt new helper for looking up pci device
Date: Tue, 24 Oct 2023 01:41:24 -0700
Message-Id: <20231024084124.11155-2-jiaqing.huang@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231024084124.11155-1-jiaqing.huang@intel.com>
References: <20231024084124.11155-1-jiaqing.huang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adopt the new iopf_queue_find_pdev func() to look up PCI device
for better efficiency and avoid the CPU stuck issue with parallel
heavy dsa_test.

Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
---
 drivers/iommu/intel/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 659de9c16024..0f1018b76557 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -672,7 +672,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		pdev = pci_get_domain_bus_and_slot(iommu->segment,
+		pdev = iopf_queue_find_pdev(iommu->iopf_queue,
 						   PCI_BUS_NUM(req->rid),
 						   req->rid & 0xff);
 		/*
@@ -688,7 +688,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 					 req->priv_data[0], req->priv_data[1],
 					 iommu->prq_seq_number++);
-		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.31.1

