From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 14/17] dma-debug: Mark free_entries_lock as terminal
Date: Mon, 19 Nov 2018 13:55:23 -0500
Message-ID: <1542653726-5655-15-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

By making free_entries_lock a terminal spinlock, it reduces the lockdep
overhead when this lock is used.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca46..f891688 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -106,7 +106,7 @@ struct hash_bucket {
 /* List of pre-allocated dma_debug_entry's */
 static LIST_HEAD(free_entries);
 /* Lock for the list above */
-static DEFINE_SPINLOCK(free_entries_lock);
+static DEFINE_TERMINAL_SPINLOCK(free_entries_lock);
 
 /* Global disable flag - will be set in case of an error */
 static bool global_disable __read_mostly;
-- 
1.8.3.1
