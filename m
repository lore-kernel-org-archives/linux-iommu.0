From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] iommu/dma: Respect IOMMU aperture when allocating
Date: Tue,  9 Aug 2016 16:23:18 +0100
Message-ID: <6d73ab5fb671089057b31beb73667c09147a0f0e.1470755555.git.robin.murphy@arm.com>
References: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Where a device driver has set a 64-bit DMA mask to indicate the absence
of addressing limitations, we still need to ensure that we don't
allocate IOVAs beyond the actual input size of the IOMMU. The reported
aperture is the most reliable way we have of inferring that input
address size, so use that to enforce a hard upper limit.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

This is the only other thing I currently have which could perhaps be
considered a fix; otherwise I'll pull it into the PCI/SMMU series.

 drivers/iommu/dma-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7d991c81c4fa..092d781f5f35 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -158,6 +158,8 @@ static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
 
+	if (domain->geometry.force_aperture)
+		dma_limit &= domain->geometry.aperture_end;
 	/*
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
-- 
2.8.1.dirty
