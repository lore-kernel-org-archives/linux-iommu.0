From: Pan Bian <bianpan2016@163.com>
Subject: iommu/vt-d: drop mm use count if address is not canonical
Date: Wed, 17 Apr 2019 17:12:57 +0800
Message-ID: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: iommu@lists.linux-foundation.org

The use count of svm->mm is incremented by mmget_not_zero. However, it
is not dropped when the address is not canonical. This patch fixes the
bug.

Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check if
address is canonical.")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..2630d2e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
+		if (!is_canonical_address(address)) {
+			mmput(svm->mm);
 			goto bad_req;
+		}
 
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
-- 
2.7.4
