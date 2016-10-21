From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] iommu/iova: don't disable preempt around this_cpu_ptr()
Date: Fri, 21 Oct 2016 19:06:25 +0200
Message-ID: <20161021170626.31750-4-bigeasy@linutronix.de>
References: <20161021170626.31750-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021170626.31750-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: iommu@lists.linux-foundation.org

Commit 583248e6620a ("iommu/iova: Disable preemption around use of
this_cpu_ptr()") disables preemption while accessing a per-CPU variable.
This does keep lockdep quiet. However I don't see the point why it is
bad if we get migrated after its access to another CPU.
__iova_rcache_insert() and __iova_rcache_get() immediately locks the
variable after obtaining it - before accessing its members.
_If_ we get migrated away after retrieving the address of cpu_rcache
before taking the lock then the *other* task on the same CPU will
retrieve the same address of cpu_rcache and will spin on the lock.

alloc_iova_fast() disables preemption while invoking
free_cpu_cached_iovas() on each CPU. The function itself uses
per_cpu_ptr() which does not trigger a warning (like this_cpu_ptr()
does) because it assumes the caller knows what he does because he might
access the data structure from a different CPU (which means he needs
protection against concurrent access).

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/iova.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e23001bfcfee..359d5d169ec0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/bitops.h>
+#include <linux/cpu.h>
=20
 static bool iova_rcache_insert(struct iova_domain *iovad,
 			       unsigned long pfn,
@@ -420,10 +421,8 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned lo=
ng size,
=20
 		/* Try replenishing IOVAs by flushing rcache. */
 		flushed_rcache =3D true;
-		preempt_disable();
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
-		preempt_enable();
 		goto retry;
 	}
=20
@@ -751,7 +750,7 @@ static bool __iova_rcache_insert(struct iova_domain *io=
vad,
 	bool can_insert =3D false;
 	unsigned long flags;
=20
-	cpu_rcache =3D get_cpu_ptr(rcache->cpu_rcaches);
+	cpu_rcache =3D raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
=20
 	if (!iova_magazine_full(cpu_rcache->loaded)) {
@@ -781,7 +780,6 @@ static bool __iova_rcache_insert(struct iova_domain *io=
vad,
 		iova_magazine_push(cpu_rcache->loaded, iova_pfn);
=20
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
-	put_cpu_ptr(rcache->cpu_rcaches);
=20
 	if (mag_to_free) {
 		iova_magazine_free_pfns(mag_to_free, iovad);
@@ -815,7 +813,7 @@ static unsigned long __iova_rcache_get(struct iova_rcac=
he *rcache,
 	bool has_pfn =3D false;
 	unsigned long flags;
=20
-	cpu_rcache =3D get_cpu_ptr(rcache->cpu_rcaches);
+	cpu_rcache =3D raw_cpu_ptr(rcache->cpu_rcaches);
 	spin_lock_irqsave(&cpu_rcache->lock, flags);
=20
 	if (!iova_magazine_empty(cpu_rcache->loaded)) {
@@ -837,7 +835,6 @@ static unsigned long __iova_rcache_get(struct iova_rcac=
he *rcache,
 		iova_pfn =3D iova_magazine_pop(cpu_rcache->loaded, limit_pfn);
=20
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
-	put_cpu_ptr(rcache->cpu_rcaches);
=20
 	return iova_pfn;
 }
--=20
2.9.3
