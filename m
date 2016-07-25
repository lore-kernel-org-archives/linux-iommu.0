From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 5/6] dmaengine: pl330: Make sure microcode is privileged
Date: Mon, 25 Jul 2016 12:16:48 -0700
Message-ID: <20160725191649.13414-6-mitchelh@codeaurora.org>
References: <20160725191649.13414-1-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160725191649.13414-1-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Patrick Daly <pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thomas Zeng <tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The PL330 performs privileged instruction fetches.  This can result in
SMMU permission faults on SMMUs that implement the ARMv8 VMSA, which
specifies that mappings that are writeable at one execution level shall
not be executable at any higher-privileged level.  Fix this by using the
DMA_ATTR_PRIVILEGED attribute, which will ensure that the microcode
IOMMU mapping is only accessible to the privileged level.

Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

Notes:
    v3..v4
    
      - Reworked against the new dma attrs format.

 drivers/dma/pl330.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4fc3ffbd5ca0..8cd624fc3760 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1854,14 +1854,16 @@ static int dmac_alloc_resources(struct pl330_dmac *pl330)
 {
 	int chans = pl330->pcfg.num_chan;
 	int ret;
+	unsigned long dma_attrs = DMA_ATTR_PRIVILEGED;
 
 	/*
 	 * Alloc MicroCode buffer for 'chans' Channel threads.
 	 * A channel's buffer offset is (Channel_Id * MCODE_BUFF_PERCHAN)
 	 */
-	pl330->mcode_cpu = dma_alloc_coherent(pl330->ddma.dev,
+	pl330->mcode_cpu = dma_alloc_attrs(pl330->ddma.dev,
 				chans * pl330->mcbufsz,
-				&pl330->mcode_bus, GFP_KERNEL);
+				&pl330->mcode_bus, GFP_KERNEL,
+				dma_attrs);
 	if (!pl330->mcode_cpu) {
 		dev_err(pl330->ddma.dev, "%s:%d Can't allocate memory!\n",
 			__func__, __LINE__);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
