From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] frv: cmpxchg: Implement cmpxchg64
Date: Mon,  3 Jul 2017 13:24:30 +0100
Message-ID: <1499084670-6996-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

FRV supports 64-bit cmpxchg, which is provided by the arch code as
__cmpxchg_64 and subsequently used to implement atomic64_cmpxchg.

This patch hooks up the generic cmpxchg64 API using the same function,
which also provides default definitions of the relaxed, acquire and
release variants. This fixes the build when COMPILE_TEST=y and
IOMMU_IO_PGTABLE_LPAE=y.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

FRV is orphaned, so not sure where to send this.

 arch/frv/include/asm/cmpxchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/frv/include/asm/cmpxchg.h b/arch/frv/include/asm/cmpxchg.h
index a899765102ea..ad1f11cfa92a 100644
--- a/arch/frv/include/asm/cmpxchg.h
+++ b/arch/frv/include/asm/cmpxchg.h
@@ -76,6 +76,7 @@ extern uint32_t __xchg_32(uint32_t i, volatile void *v);
  * - if (*ptr != test) then orig = *ptr;
  */
 extern uint64_t __cmpxchg_64(uint64_t test, uint64_t new, volatile uint64_t *v);
+#define cmpxchg64(p, o, n)	__cmpxchg_64((o), (n), (p))
 
 #ifndef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
 
-- 
2.1.4
