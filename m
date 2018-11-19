From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 09/17] debugobjects: Make object hash locks nestable terminal locks
Date: Mon, 19 Nov 2018 13:55:18 -0500
Message-ID: <1542653726-5655-10-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

By making the object hash locks nestable terminal locks, we can avoid
a bunch of unnecessary lockdep validations as well as saving space
in the lockdep tables.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4216d3d..c6f3967 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1129,8 +1129,13 @@ void __init debug_objects_early_init(void)
 {
 	int i;
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
+	/*
+	 * Make the obj_hash locks nestable terminal locks.
+	 */
+	for (i = 0; i < ODEBUG_HASH_SIZE; i++) {
 		raw_spin_lock_init(&obj_hash[i].lock);
+		lockdep_set_terminal_nestable_class(&obj_hash[i].lock);
+	}
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
 		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
-- 
1.8.3.1
