From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 09/11] powerpc/svm: Use shared memory for LPPACA structures
Date: Thu, 23 Aug 2018 23:59:31 -0300
Message-ID: <20180824025933.24319-10-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

LPPACA structures need to be shared with the host. Hence they need to be on
shared memory. Instead of allocating individual chunks of memory for given
structure from memblock, a contiguous chunk of memory is allocated and then
converted into shared memory. Subsequent allocation requests will come from
the contiguous chunk which will be always shared memory for all structures.

While we were able to use a kmem_cache constructor for the Debug Trace Log,
LPPACAs are allocated very early in the boot process (before SLUB is
available) so we need to use a simpler scheme here.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 1edf8695019d..3e2aca150ad2 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
+#include <asm/svm.h>
 
 #include "setup.h"
 
@@ -25,6 +26,33 @@
 #endif
 
 #define LPPACA_SIZE 0x400
+#define SHARED_LPPACA_SIZE PAGE_ALIGN(LPPACA_SIZE * CONFIG_NR_CPUS)
+
+static phys_addr_t shared_lppaca_pa;
+static unsigned long shared_lppaca_size;
+
+static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
+				unsigned long limit, int cpu)
+{
+	unsigned long pa;
+
+	if (!shared_lppaca_pa) {
+		memblock_set_bottom_up(true);
+		shared_lppaca_pa = memblock_alloc_base_nid(SHARED_LPPACA_SIZE,
+					PAGE_SIZE, limit, -1, MEMBLOCK_NONE);
+		if (!shared_lppaca_pa)
+			panic("cannot allocate shared data");
+		memblock_set_bottom_up(false);
+		mem_convert_shared(PHYS_PFN(shared_lppaca_pa),
+				       SHARED_LPPACA_SIZE / PAGE_SIZE);
+	}
+
+	pa = shared_lppaca_pa + shared_lppaca_size;
+	shared_lppaca_size += size;
+
+	BUG_ON(shared_lppaca_size >= SHARED_LPPACA_SIZE);
+	return __va(pa);
+}
 
 static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 				unsigned long limit, int cpu)
@@ -88,7 +116,11 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
+	if (is_svm_platform())
+		lp = alloc_shared_lppaca(LPPACA_SIZE, 0x400, limit, cpu);
+	else
+		lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
+
 	init_lppaca(lp);
 
 	return lp;
