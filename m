From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 01/17] locking/lockdep: Remove version from lock_class structure
Date: Mon, 19 Nov 2018 13:55:10 -0500
Message-ID: <1542653726-5655-2-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Waiman Long <longman@redhat.com>
List-Id: iommu@lists.linux-foundation.org

It turns out the version field in the lock_class structure isn't used
anywhere. Just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1fd82ff..c5335df 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -97,8 +97,6 @@ struct lock_class {
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
 	 */
-	unsigned int			version;
-
 	int				name_version;
 	const char			*name;
 
-- 
1.8.3.1
