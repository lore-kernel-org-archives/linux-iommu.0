From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 05/17] printk: Mark logbuf_lock & console_owner_lock as terminal locks
Date: Mon, 19 Nov 2018 13:55:14 -0500
Message-ID: <1542653726-5655-6-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

By marking logbuf_lock and console_owner_lock as terminal locks,
it reduces the performance overhead when those locks are used with
lockdep enabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..bdbbe31 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -367,7 +367,7 @@ __packed __aligned(4)
  * within the scheduler's rq lock. It must be released before calling
  * console_unlock() or anything else that might wake up a process.
  */
-DEFINE_RAW_SPINLOCK(logbuf_lock);
+DEFINE_RAW_TERMINAL_SPINLOCK(logbuf_lock);
 
 /*
  * Helper macros to lock/unlock logbuf_lock and switch between
@@ -1568,7 +1568,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 };
 #endif
 
-static DEFINE_RAW_SPINLOCK(console_owner_lock);
+static DEFINE_RAW_TERMINAL_SPINLOCK(console_owner_lock);
 static struct task_struct *console_owner;
 static bool console_waiter;
 
-- 
1.8.3.1
