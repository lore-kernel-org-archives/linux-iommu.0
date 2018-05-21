From: Huaisheng Ye <yehs2007@gmail.com>
Subject: [RFC PATCH v2 11/12] include/linux/highmem: update usage of movableflags
Date: Mon, 21 May 2018 23:20:32 +0800
Message-ID: <1526916033-4877-12-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net, kstewart@linuxfoundation.org, alexander.levin@verizon.com, gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com, hehy1@lenovo.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: iommu@lists.linux-foundation.org

From: Huaisheng Ye <yehs1@lenovo.com>

GFP_HIGHUSER_MOVABLE doesn't equal to GFP_HIGHUSER | __GFP_MOVABLE,
modify it to adapt patch of getting rid of GFP_ZONE_TABLE/BAD.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 776f90f..da34260 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -159,8 +159,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 			struct vm_area_struct *vma,
 			unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | movableflags,
-			vma, vaddr);
+	struct page *page = alloc_page_vma(movableflags ?
+		GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
-- 
1.8.3.1
