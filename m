From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 1/2] dma-direct: set_memory_{en,de}crypted() take number of pages
Date: Tue, 22 Jan 2019 19:17:57 -0200
Message-ID: <20190122211758.8317-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Ram Pai <linuxram@us.ibm.com>

set_memory_encrypted() and set_memory_decrypted() expect the number of
PAGE_SIZE pages to encrypt or decrypt. dma_direct_alloc() and
dma_direct_free() instead pass number of bytes. This encrypts/decrypts a
huge number of pages resulting in data corruption.

Fixed it.

[ bauermann: Slightly reworded commit message and added Fixes: tag. ]
Fixes: d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory encryption")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 kernel/dma/direct.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Notes:

1. This was tested on powerpc with patches adding support for running
   under the ultravisor, which are not yet upstream.

2. The lines changed in this patch were added by commit c10f07aa27da
   ("dma/direct: Handle force decryption for DMA coherent buffers in
   common code"), but it only moves the code from an x86-specific file.
   Therefore the Fixes tag references the commit that first introduced
   the code.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..bc78c37220ba 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -166,7 +166,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
-		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
+		set_memory_decrypted((unsigned long)ret, 1);
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 	} else {
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
@@ -186,10 +186,8 @@ void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	unsigned int page_order = get_order(size);
-
 	if (force_dma_unencrypted())
-		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
+		set_memory_encrypted((unsigned long)cpu_addr, 1);
 	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
 
