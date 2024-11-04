Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9F1B394E;
	Mon,  4 Nov 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719189; cv=none; b=LTw8FF0c6eDB340xjygTPtnOSaVDgkBxa3ocEXaYx3wrhtCvg9aew7pwxqDnH0ipvz6SGkrXF+YhkWLoXvbr3JEx1znXrGmrt3eJOYN8+egtchk18OWWOQigM1/C+nJII8Zou6on23495nEMvIN/OOwMgMO3eLq+RAWk9KPSBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719189; c=relaxed/simple;
	bh=w4DhfcqhD35OLZhCD/yjFqQsPzQFGG5lrGkMuG3Ix1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DlaWkAshJNQPZc0+aAHJ18kzzp649qN62+ki7aWWWUOimlhHAXwkSfMEMfQjszkuaSQLpeeYn/XeypJ524hyYvPNH+Ugfm7T2CgNhbbISCUTvJehjINCg66h6yvJ9Pz7taWDFjYaIJpV7FOeTbGODacvo8K4y+eOOLqzhaWbocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966C9C4CECE;
	Mon,  4 Nov 2024 11:19:47 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: iommu@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Ido Schimmel <idosch@idosch.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] kmemleak: iommu/iova: Fix transient kmemleak false positive
Date: Mon,  4 Nov 2024 11:19:44 +0000
Message-Id: <20241104111944.2207155-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of iova_depot_pop() in 911aa1245da8 ("iommu/iova: Make
the rcache depot scale better") confused kmemleak by moving a struct
iova_magazine object from a singly linked list to rcache->depot and
resetting the 'next' pointer referencing it. Unlike doubly linked lists,
the content of the object being referred is never changed on removal
from a singly linked list and the kmemleak checksum heuristics do not
detect such scenario. This leads to false positives like:

unreferenced object 0xffff8881a5301000 (size 1024):
  comm "softirq", pid 0, jiffies 4306297099 (age 462.991s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00  .........}......
    0f b4 05 00 00 00 00 00 b4 96 05 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5

Introduce kmemleak_transient_leak() which resets the object checksum
requiring another scan pass before it is reported (if still
unreferenced). Call this new API in iova_depot_pop().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Ido Schimmel <idosch@idosch.org>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/ZY1osaGLyT-sdKE8@shredder/
---

This could be two patches but I thought the rationale for a new kmemleak
API goes better with its use in the iova code. Happy to move the 6 lines
iova change to a separate patch but they should still go in together.
Given that there are more line under mm/, I'd say it better goes in via
the mm tree with the relevant acks from the iommu folk.

Thanks.

 Documentation/dev-tools/kmemleak.rst |  1 +
 drivers/iommu/iova.c                 |  6 +++++
 include/linux/kmemleak.h             |  4 +++
 mm/kmemleak.c                        | 39 ++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 2cb00b53339f..7d784e03f3f9 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -161,6 +161,7 @@ See the include/linux/kmemleak.h header for the functions prototype.
 - ``kmemleak_free_percpu``	 - notify of a percpu memory block freeing
 - ``kmemleak_update_trace``	 - update object allocation stack trace
 - ``kmemleak_not_leak``	 - mark an object as not a leak
+- ``kmemleak_transient_leak``	 - mark an object as a transient leak
 - ``kmemleak_ignore``		 - do not scan or report an object as leak
 - ``kmemleak_scan_area``	 - add scan areas inside a memory block
 - ``kmemleak_no_scan``	 - do not scan a memory block
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 16c6adff3eb7..5b5400efb657 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -673,6 +674,11 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
 {
 	struct iova_magazine *mag = rcache->depot;
 
+	/*
+	 * As the mag->next pointer is moved to rcache->depot and reset via
+	 * the mag->size assignment, mark it as a transient false positive.
+	 */
+	kmemleak_transient_leak(mag->next);
 	rcache->depot = mag->next;
 	mag->size = IOVA_MAG_SIZE;
 	rcache->depot_size--;
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 6a3cd1bf4680..93a73c076d16 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -26,6 +26,7 @@ extern void kmemleak_free_part(const void *ptr, size_t size) __ref;
 extern void kmemleak_free_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_update_trace(const void *ptr) __ref;
 extern void kmemleak_not_leak(const void *ptr) __ref;
+extern void kmemleak_transient_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
@@ -93,6 +94,9 @@ static inline void kmemleak_update_trace(const void *ptr)
 static inline void kmemleak_not_leak(const void *ptr)
 {
 }
+static inline void kmemleak_transient_leak(const void *ptr)
+{
+}
 static inline void kmemleak_ignore(const void *ptr)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 0400f5e8ac60..72e09ac9140b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -934,6 +934,28 @@ static void make_black_object(unsigned long ptr, unsigned int objflags)
 	paint_ptr(ptr, KMEMLEAK_BLACK, objflags);
 }
 
+/*
+ * Reset the checksum of an object. The immediate effect is that it will not
+ * be reported as a leak during the next scan until its checksum is updated.
+ */
+static void reset_checksum(unsigned long ptr)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	object = find_and_get_object(ptr, 0);
+	if (!object) {
+		kmemleak_warn("Not resetting the checksum of an unknown object at 0x%08lx\n",
+			      ptr);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&object->lock, flags);
+	object->checksum = 0;
+	raw_spin_unlock_irqrestore(&object->lock, flags);
+	put_object(object);
+}
+
 /*
  * Add a scanning area to the object. If at least one such area is added,
  * kmemleak will only scan these ranges rather than the whole memory block.
@@ -1202,6 +1224,23 @@ void __ref kmemleak_not_leak(const void *ptr)
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
 
+/**
+ * kmemleak_transient_leak - mark an allocated object as transient false positive
+ * @ptr:	pointer to beginning of the object
+ *
+ * Calling this function on an object will cause the memory block to not be
+ * reported as a leak temporarily. This may happen, for example, if the object
+ * is part of a singly linked list and the ->next reference to it is changed.
+ */
+void __ref kmemleak_transient_leak(const void *ptr)
+{
+	pr_debug("%s(0x%px)\n", __func__, ptr);
+
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+		reset_checksum((unsigned long)ptr);
+}
+EXPORT_SYMBOL(kmemleak_transient_leak);
+
 /**
  * kmemleak_ignore - ignore an allocated object
  * @ptr:	pointer to beginning of the object
