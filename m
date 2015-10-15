From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] iommu/vt-d: shift wrapping bug in prq_event_thread()
Date: Thu, 15 Oct 2015 21:25:15 +0300
Message-ID: <20151015182515.GE3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <David.Woodhouse@intel.com>
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The "req->addr" variable is a bit field declared as "u64 addr:52;".
The "address" variable is a u64.  We need to cast "req->addr" to a u64
before the shift or the result is truncated to 52 bits.

Fixes: 0b9252a34858 ('iommu/vt-d: Implement page request handling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Also does this code work if PAGE_SHIFT is more than 12?  (I am a newbie
so this is not rhetorical, I don't know the answer).

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index ba88889..19aa67b 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -395,7 +395,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 
 		result = QI_RESP_INVALID;
-		address = req->addr << PAGE_SHIFT;
+		address = (u64)req->addr << PAGE_SHIFT;
 		if (!req->pasid_present) {
 			pr_err("%s: Page request without PASID: %08llx %08llx\n",
 			       iommu->name, ((unsigned long long *)req)[0],
