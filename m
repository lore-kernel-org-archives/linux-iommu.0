From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 12/13] swiotlb: remove swiotlb_set_mem_attributes
Date: Mon,  5 Mar 2018 09:46:54 -0800
Message-ID: <20180305174655.9878-13-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180305174655.9878-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now that set_memory_decrypted is always available we can just call it
directly.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/mm/mem_encrypt.c          |  9 ---------
 lib/swiotlb.c                      | 12 ++++++------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 22c5f3e6f820..9da0b63c8fc7 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,8 +48,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size);
-
 bool sme_active(void);
 bool sev_active(void);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 8bfc735bbdd7..65f45e0ef496 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -379,15 +379,6 @@ void __init mem_encrypt_init(void)
 			     : "Secure Memory Encryption (SME)");
 }
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
-{
-	WARN(PAGE_ALIGN(size) != size,
-	     "size is not page-aligned (%#lx)\n", size);
-
-	/* Make the SWIOTLB buffer area decrypted */
-	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
-}
-
 struct sme_populate_pgd_data {
 	void	*pgtable_area;
 	pgd_t	*pgd;
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index ca8eeaead925..8b06b4485e65 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
+#include <linux/set_memory.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -156,8 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
-
 /* Note that this doesn't work with highmem page */
 static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 				      volatile void *address)
@@ -202,12 +201,12 @@ void __init swiotlb_update_mem_attributes(void)
 
 	vaddr = phys_to_virt(io_tlb_start);
 	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 
 	vaddr = phys_to_virt(io_tlb_overflow_buffer);
 	bytes = PAGE_ALIGN(io_tlb_overflow);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 }
 
@@ -348,7 +347,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	io_tlb_start = virt_to_phys(tlb);
 	io_tlb_end = io_tlb_start + bytes;
 
-	swiotlb_set_mem_attributes(tlb, bytes);
+	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
 
 	/*
@@ -359,7 +358,8 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!v_overflow_buffer)
 		goto cleanup2;
 
-	swiotlb_set_mem_attributes(v_overflow_buffer, io_tlb_overflow);
+	set_memory_decrypted((unsigned long)v_overflow_buffer,
+			io_tlb_overflow >> PAGE_SHIFT);
 	memset(v_overflow_buffer, 0, io_tlb_overflow);
 	io_tlb_overflow_buffer = virt_to_phys(v_overflow_buffer);
 
-- 
2.14.2
