From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 06/17] debugobjects: Mark pool_lock as a terminal lock
Date: Mon, 19 Nov 2018 13:55:15 -0500
Message-ID: <1542653726-5655-7-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

By marking the internal pool_lock as a terminal lock, lockdep will be
able to skip full validation to improve locking performance.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed..403dd95 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -39,7 +39,7 @@ struct debug_bucket {
 
 static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 
-static DEFINE_RAW_SPINLOCK(pool_lock);
+static DEFINE_RAW_TERMINAL_SPINLOCK(pool_lock);
 
 static HLIST_HEAD(obj_pool);
 static HLIST_HEAD(obj_to_free);
-- 
1.8.3.1
