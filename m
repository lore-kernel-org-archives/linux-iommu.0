From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/7] iommu/amd: Optimize iova queue flushing
Date: Wed,  7 Jun 2017 16:58:13 +0200
Message-ID: <1496847500-6781-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to optimize the queue flushing in the
AMD IOMMU driver. It removes the global per-cpu flush queues
and implements queue-rings which are per-domain and per-cpu.

This allows some good optimizations to lower the flush-rate
of a domain and also lowers the contention on the queue
locks.

Regards,

	Joerg

Joerg Roedel (7):
  iommu/amd: Rip out old queue flushing code
  iommu/amd: Add per-domain flush-queue data structures
  iommu/amd: Make use of the per-domain flush queue
  iommu/amd: Add locking to per-domain flush-queue
  iommu/amd: Add flush counters to struct dma_ops_domain
  iommu/amd: Add per-domain timer to flush per-cpu queues
  iommu/amd: Remove queue_release() function

 drivers/iommu/amd_iommu.c | 363 +++++++++++++++++++++++++++++-----------------
 1 file changed, 227 insertions(+), 136 deletions(-)

-- 
2.7.4
