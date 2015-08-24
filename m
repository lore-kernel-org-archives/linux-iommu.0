From: "Xiao, Nan (Nan@HPS Performance, Beijing)" <nan.xiao@hp.com>
Subject: [PATCH] Fix bug in iommu_context_addr: Always get pointer to lower
 extended-context-table
Date: Mon, 24 Aug 2015 06:26:33 +0000
Message-ID: <F9D82F0D71C0024FA18FE771EDDAF149081FAC8F@G4W3303.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi David & joerg,

In iommu_context_addr() function, we always use lower extended-context-table
even though upper-half of the extended root-entry is present.

Signed-off-by: Nan Xiao <nan.xiao@hp.com>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94..4213598 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -759,10 +759,11 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
 			entry = &root->hi;
-		}
+		} else
+			entry = &root->lo;
 		devfn *= 2;
-	}
-	entry = &root->lo;
+	} else
+		entry = &root->lo;
 	if (*entry & 1)
 		context = phys_to_virt(*entry & VTD_PAGE_MASK);
 	else {
-- 
2.4.3

Best Regards
Nan Xiao
