From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 08/11] powerpc: Add and use LPPACA_SIZE constant
Date: Thu, 23 Aug 2018 23:59:30 -0300
Message-ID: <20180824025933.24319-9-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

Helps document what the hard-coded number means.

Suggested-by: Alexey Kardashevskiy <aik@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0ee3e6d50f28..1edf8695019d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -24,6 +24,8 @@
 #define boot_cpuid 0
 #endif
 
+#define LPPACA_SIZE 0x400
+
 static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 				unsigned long limit, int cpu)
 {
@@ -70,7 +72,7 @@ static inline void init_lppaca(struct lppaca *lppaca)
 
 	*lppaca = (struct lppaca) {
 		.desc = cpu_to_be32(0xd397d781),	/* "LpPa" */
-		.size = cpu_to_be16(0x400),
+		.size = cpu_to_be16(LPPACA_SIZE),
 		.fpregs_in_use = 1,
 		.slb_count = cpu_to_be16(64),
 		.vmxregs_in_use = 0,
@@ -80,14 +82,13 @@ static inline void init_lppaca(struct lppaca *lppaca)
 static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 {
 	struct lppaca *lp;
-	size_t size = 0x400;
 
-	BUILD_BUG_ON(size < sizeof(struct lppaca));
+	BUILD_BUG_ON(LPPACA_SIZE < sizeof(struct lppaca));
 
 	if (early_cpu_has_feature(CPU_FTR_HVMODE))
 		return NULL;
 
-	lp = alloc_paca_data(size, 0x400, limit, cpu);
+	lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
 	init_lppaca(lp);
 
 	return lp;
