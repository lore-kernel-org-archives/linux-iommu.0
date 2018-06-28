From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 5/5 V4] Help to dump the old memory encrypted into vmcore file
Date: Thu, 28 Jun 2018 16:58:06 +0800
Message-ID: <20180628085806.9280-6-lijiang@redhat.com>
References: <20180628085806.9280-1-lijiang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628085806.9280-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org, thomas.lendacky@amd.com, dyoung@redhat.com, kexec@lists.infradead.org, iommu@lists.linux-foundation.org, bhe@redhat.com
List-Id: iommu@lists.linux-foundation.org

In kdump mode, we need to dump the old memory into vmcore file,
if SME is enabled in the first kernel, we must remap the old
memory in encrypted manner, which will be automatically decrypted
when we read from DRAM. It helps to parse the vmcore for some tools.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Some changes:
1. add a new file and modify Makefile.
2. revert some code about previously using sev_active().
3. modify elfcorehdr_read().

 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++++++++++
 fs/proc/vmcore.c                     | 45 +++++++++++++++++++++++++-----
 include/linux/crash_dump.h           | 12 ++++++++
 4 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/crash_dump_encrypt.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5c..afb5bad 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
new file mode 100644
index 0000000..e1b1a57
--- /dev/null
+++ b/arch/x86/kernel/crash_dump_encrypt.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *	Memory preserving reboot related code.
+ *
+ *	Created by: Lianbo Jiang (lijiang@redhat.com)
+ *	Copyright (C) RedHat Corporation, 2018. All rights reserved
+ */
+
+#include <linux/errno.h>
+#include <linux/crash_dump.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+
+/**
+ * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem encrypted". For this page, there is no pte
+ * mapped in the current kernel. We stitch up a pte, similar to
+ * kmap_atomic.
+ */
+
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+		size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
+						  PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+			iounmap((void __iomem *)vaddr);
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, vaddr + offset, csize);
+
+	set_iounmap_nonlazy();
+	iounmap((void __iomem *)vaddr);
+	return csize;
+}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cfb6674..5fef489 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,6 +26,8 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 #include "internal.h"
+#include <linux/mem_encrypt.h>
+#include <asm/pgtable.h>
 
 /* List representing chunks of contiguous memory areas and their offsets in
  * vmcore file.
@@ -98,7 +100,8 @@ static int pfn_is_ram(unsigned long pfn)
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-				u64 *ppos, int userbuf)
+				u64 *ppos, int userbuf,
+				bool encrypted)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
@@ -120,8 +123,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 		if (pfn_is_ram(pfn) == 0)
 			memset(buf, 0, nr_bytes);
 		else {
-			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						offset, userbuf);
+			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
+					    buf, nr_bytes, offset, userbuf)
+					: copy_oldmem_page(pfn, buf, nr_bytes,
+							   offset, userbuf);
+
 			if (tmp < 0)
 				return tmp;
 		}
@@ -151,11 +157,34 @@ void __weak elfcorehdr_free(unsigned long long addr)
 {}
 
 /*
- * Architectures may override this function to read from ELF header
+ * Architectures may override this function to read from ELF header.
+ * The kexec-tools will allocated the memory and build the elf header
+ * in the first kernel, subsequently, we will copy the data in the
+ * memory to the reserved crash memory. In kdump mode, we will read the
+ * elf header from the reserved crash memory, from this point of view,
+ * which is not an old memory, the original function called may mislead
+ * and do unnecessary things.
+ * For SME, it copies the elf header from the memory encrypted(user space)
+ * to the memory unencrypted(kernel space) when SME is activated in the
+ * first kernel, this operation just leads to decryption.
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	char *kbuf;
+	resource_size_t offset;
+
+	if (!count)
+		return 0;
+
+	offset = (resource_size_t)*ppos;
+	kbuf = memremap(offset, count, MEMREMAP_WB);
+	if (!kbuf)
+		return 0;
+
+	memcpy(buf, kbuf, count);
+	memunmap(kbuf);
+
+	return count;
 }
 
 /*
@@ -163,7 +192,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0);
+	return read_from_oldmem(buf, count, ppos, 0, sme_active());
 }
 
 /*
@@ -173,6 +202,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot)
 {
+	prot = pgprot_encrypted(prot);
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
@@ -349,7 +379,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    m->offset + m->size - *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
+			tmp = read_from_oldmem(buffer, tsz, &start, userbuf,
+						sme_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3e4ba9d..a7e7be8 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,18 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					   size_t csize, unsigned long offset,
+					   int userbuf);
+#else
+static inline
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				    unsigned long offset, int userbuf)
+{
+	return 0;
+}
+#endif
 void vmcore_cleanup(void);
 
 /* Architecture code defines this if there are other possible ELF
-- 
2.9.5
