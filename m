From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] dma-debug: implement dynamic entry allocation
Date: Mon,  3 Dec 2018 17:28:05 +0000
Message-ID: <cover.1543856576.git.robin.murphy@arm.com>
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
To: hch-jcswGhMUV9g@public.gmane.org
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The HNS_ENET discussion got me thinking, why not just make DMA debug
cleverer so that (in terms of basic functionality at least) we don't
need to worry about driver- or arch-specific configuration at all?

Patches #2 and #3 are the real meat here - #1 is just some preparatory
cleanup motivated by moving printks around, and could be split out if
desired; I kept #4 separate as a possible nice-to-have depending on
what people think.

Robin.


Robin Murphy (4):
  dma-debug: Use pr_fmt()
  dma-debug: Refactor dma_debug_entry allocation
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent

 kernel/dma/debug.c | 198 ++++++++++++++++++++++++---------------------
 1 file changed, 105 insertions(+), 93 deletions(-)

-- 
2.19.1.dirty
