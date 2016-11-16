From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device gets
	context mapped
Date: Wed, 16 Nov 2016 17:02:30 +0800
Message-ID: <1479286950-21885-1-git-send-email-xlpang@redhat.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We met the DMAR fault both on hpsa P420i and P421 SmartArray controllers
under kdump, it can be steadily reproduced on several different machines,
the dmesg log is like:
HP HPSA Driver (v 3.4.16-0)
hpsa 0000:02:00.0: using doorbell to reset controller
hpsa 0000:02:00.0: board ready after hard reset.
hpsa 0000:02:00.0: Waiting for controller to respond to no-op
DMAR: Setting identity map for device 0000:02:00.0 [0xe8000 - 0xe8fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xf4000 - 0xf4fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6e000 - 0xbdf6efff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6f000 - 0xbdf7efff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf7f000 - 0xbdf82fff]
DMAR: Setting identity map for device 0000:02:00.0 [0xbdf83000 - 0xbdf84fff]
DMAR: DRHD: handling fault status reg 2
DMAR: [DMA Read] Request device [02:00.0] fault addr fffff000 [fault reason 06] PTE Read access is not set
hpsa 0000:02:00.0: controller message 03:00 timed out
hpsa 0000:02:00.0: no-op failed; re-trying

After some debugging, we found that the corresponding pte entry value
is correct, and the value of the iommu caching mode is 0, the fault is
probably due to the old iotlb cache of the in-flight DMA.

Thus need to flush the old iotlb after context mapping is setup for the
device, where the device is supposed to finish reset at its driver probe
stage and no in-flight DMA exists hereafter.

With this patch, all our problematic machines can survive the kdump tests.

CC: Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>
CC: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Tested-by: Joseph Szczypek <jszczype-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3965e73..eb79288 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2067,9 +2067,16 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 * It's a non-present to present mapping. If hardware doesn't cache
 	 * non-present entry we only need to flush the write-buffer. If the
 	 * _does_ cache non-present entries, then it does so in the special
-	 * domain #0, which we have to flush:
+	 * domain #0, which we have to flush.
+	 *
+	 * For kdump cases, present entries may be cached due to the in-flight
+	 * DMA and copied old pgtable, but there is no unmapping behaviour for
+	 * them, so we need an explicit iotlb flush for the newly-mapped device.
+	 * For kdump, at this point, the device is supposed to finish reset at
+	 * the driver probe stage, no in-flight DMA will exist, thus we do not
+	 * need to worry about that anymore hereafter.
 	 */
-	if (cap_caching_mode(iommu->cap)) {
+	if (is_kdump_kernel() || cap_caching_mode(iommu->cap)) {
 		iommu->flush.flush_context(iommu, 0,
 					   (((u16)bus) << 8) | devfn,
 					   DMA_CCMD_MASK_NOBIT,
-- 
1.8.3.1
