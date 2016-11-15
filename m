From: Nikola Pajkovsky <npajkovsky@suse.cz>
Subject: [PATCH] iommu: fix iommu_free() comparison of unsigned expression >= 0
Date: Tue, 15 Nov 2016 09:47:49 +0100
Message-ID: <7612c0f9dd7c1290407dbf8e809def922006920b.1479161177.git.npajkovsky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

commit 8fd524b355da ("x86: Kill bad_dma_address variable") has killed
bad_dma_address variable and used instead of macro DMA_ERROR_CODE
which is always zero. Since dma_addr is unsigned, statement

   dma_addr >= DMA_ERROR_CODE

is always true, and not needed.

arch/x86/kernel/pci-calgary_64.c: In function ‘iommu_free’:
arch/x86/kernel/pci-calgary_64.c:299:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  if (unlikely((dma_addr >= DMA_ERROR_CODE) && (dma_addr < badend))) {

Fixes: 8fd524b355da ("x86: Kill bad_dma_address variable")
Signed-off-by: Nikola Pajkovsky <npajkovsky@suse.cz>
---
 arch/x86/kernel/pci-calgary_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 5d400ba1349d..d47517941bbc 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -296,7 +296,7 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 
 	/* were we called with bad_dma_address? */
 	badend = DMA_ERROR_CODE + (EMERGENCY_PAGES * PAGE_SIZE);
-	if (unlikely((dma_addr >= DMA_ERROR_CODE) && (dma_addr < badend))) {
+	if (unlikely(dma_addr < badend)) {
 		WARN(1, KERN_ERR "Calgary: driver tried unmapping bad DMA "
 		       "address 0x%Lx\n", dma_addr);
 		return;
-- 
2.10.0
