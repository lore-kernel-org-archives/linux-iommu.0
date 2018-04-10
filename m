From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
Date: Tue, 10 Apr 2018 19:05:13 +0200
Message-ID: <20180410170513.22834-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The code refactoring by commit 0176adb00406 ("swiotlb: refactor
coherent buffer allocation") made swiotlb_alloc_buffer() almost always
failing due to a thinko: namely, the function evaluates the
dma_coherent_ok() call incorrectly and dealing as if it's invalid.
This ends up with weird errors like iwlwifi probe failure or amdgpu
screen flickering.

This patch corrects the logic error.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088658
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088902
Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v4.16+
Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..de7cc540450f 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -719,7 +719,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		goto out_warn;
 
 	*dma_handle = __phys_to_dma(dev, phys_addr);
-	if (dma_coherent_ok(dev, *dma_handle, size))
+	if (!dma_coherent_ok(dev, *dma_handle, size))
 		goto out_unmap;
 
 	memset(phys_to_virt(phys_addr), 0, size);
-- 
2.16.3
