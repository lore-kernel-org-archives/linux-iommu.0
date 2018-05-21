From: Huaisheng Ye <yehs2007@gmail.com>
Subject: [RFC PATCH v2 12/12] arch/x86/include/asm/page.h: update usage of movableflags
Date: Mon, 21 May 2018 23:20:33 +0800
Message-ID: <1526916033-4877-13-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net, kstewart@linuxfoundation.org, alexander.levin@verizon.com, gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com, hehy1@lenovo.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: iommu@lists.linux-foundation.org

From: Huaisheng Ye <yehs1@lenovo.com>

GFP_HIGHUSER_MOVABLE doesn't equal to GFP_HIGHUSER | __GFP_MOVABLE,
modify it to adapt patch of getting rid of GFP_ZONE_TABLE/BAD.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org <x86@kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
---
 arch/x86/include/asm/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48..a47f42d 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -35,7 +35,8 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 }
 
 #define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
-	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
+	alloc_page_vma((movableflags ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER) \
+	| __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #ifndef __pa
-- 
1.8.3.1
