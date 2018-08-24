From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 04/11] powerpc/svm: Convert SWIOTLB buffers to shared memory
Date: Fri, 24 Aug 2018 13:25:28 -0300
Message-ID: <20180824162535.22798-5-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Hook the shared memory conversion functions into the ARCH_HAS_MEM_ENCRYPT
framework and call swiotlb_update_mem_attributes() to convert SWIOTLB's
buffers to shared memory.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig                   |  4 ++++
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/svm.c              | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90f73d15f58a..1466d1234723 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,12 +440,16 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 
 endchoice
 
+config ARCH_HAS_MEM_ENCRYPT
+	def_bool n
+
 config PPC_SVM
        bool "Secure virtual machine (SVM) support for POWERPC"
        default n
        depends on PPC_PSERIES
        select DMA_DIRECT_OPS
        select SWIOTLB
+       select ARCH_HAS_MEM_ENCRYPT
        help
          Support secure guests on POWERPC. There are certain POWER platforms
 	 which support secure guests with the help of an Ultravisor executing
diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..2b6e37ea446c
--- /dev/null
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SVM helper functions
+ *
+ * Copyright 2018 IBM Corporation
+ */
+
+#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
+#define _ASM_POWERPC_MEM_ENCRYPT_H
+
+#define sme_me_mask	0ULL
+
+static inline bool sme_active(void) { return false; }
+static inline bool sev_active(void) { return false; }
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */
diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index 37437cf92df5..eab2a64d8643 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -7,6 +7,20 @@
  */
 
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <asm/machdep.h>
+#include <asm/svm.h>
+
+static int __init init_svm(void)
+{
+	if (!is_svm_platform())
+		return 0;
+
+	swiotlb_update_mem_attributes();
+
+	return 0;
+}
+machine_early_initcall(pseries, init_svm);
 
 void mem_convert_shared(unsigned long pfn, unsigned long npages)
 {
@@ -31,3 +45,23 @@ void mem_convert_secure(unsigned long pfn, unsigned long npages)
 	 * ucall_convert_secure(paddr, size)
 	 */
 }
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_secure(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	mem_convert_shared(PHYS_PFN(__pa(addr)), numpages);
+
+	return 0;
+}
