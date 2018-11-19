From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 10/17] lib/stackdepot: Make depot_lock a terminal spinlock
Date: Mon, 19 Nov 2018 13:55:19 -0500
Message-ID: <1542653726-5655-11-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

By defining depot_lock as a terminal spinlock, it reduces the
lockdep overhead when this lock is being used.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e513459..fb17888 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -78,7 +78,7 @@ struct stack_record {
 static int depot_index;
 static int next_slab_inited;
 static size_t depot_offset;
-static DEFINE_SPINLOCK(depot_lock);
+static DEFINE_TERMINAL_SPINLOCK(depot_lock);
 
 static bool init_stack_slab(void **prealloc)
 {
-- 
1.8.3.1
