Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6987C
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 04:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669867730; x=1701403730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8ZxO0P+bgikDq55sQqKBRK6c8+nVfCJ+RSELC/xG0I=;
  b=WKyKpUE/lFiwXXxNsQ5684QBAeJEWRGEw6ryWs2Q0VWlyZSchtjk79U3
   UpKxNhLWaFmi6H2369z9nrbcNb9Sf25hbPQcV+b97cqkYDKfvcrKoi2SU
   eln7+uUwFC1Py8W/5d6yvYsB3hVf38GsTQBXvXFBi6KMt42j8vY3ZoTbV
   EbEf4XMxKyogJn4+y+DhqiiWNlGdWvuGLucyxOWSeVizNVnuN4r0amTW3
   WImnbm7S3wmdgK6zRX8NdXg62XZpEC1xLV4+ylHKBYThN73+RF4yY265K
   V7jDpinDEiAw0sF8JIoT86OqdNgeLCb3/5OcAV8gz7t1ix2m7VkJUTvIu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377745742"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="377745742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707911656"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707911656"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 20:08:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Fix PCI device refcount leak in prq_event_thread()
Date: Thu,  1 Dec 2022 12:01:25 +0800
Message-Id: <20221201040127.1962750-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

As comment of pci_get_domain_bus_and_slot() says, it returns a pci device
with refcount increment, when finish using it, the caller must decrease
the reference count by calling pci_dev_put(). So call pci_dev_put() after
using the 'pdev' to avoid refcount leak.

Besides, if the 'pdev' is null or intel_svm_prq_report() returns error,
there is no need to trace this fault.

Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data accesses in page fault path")
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221119144028.2452731-1-yangyingliang@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fe615c53479c..03b25358946c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -748,12 +748,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		if (!pdev)
+			goto bad_req;
 
-		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
-				 req->priv_data[0], req->priv_data[1],
-				 iommu->prq_seq_number++);
+		if (intel_svm_prq_report(iommu, &pdev->dev, req))
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+		else
+			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+					 req->priv_data[0], req->priv_data[1],
+					 iommu->prq_seq_number++);
+		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.34.1

