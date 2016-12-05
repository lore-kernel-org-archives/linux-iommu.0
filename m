From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3] iommu/vt-d: Flush old iommu caches for kdump when the
	device gets context mapped
Date: Mon,  5 Dec 2016 20:09:07 +0800
Message-ID: <1480939747-31916-1-git-send-email-xlpang@redhat.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>, Joseph Szczypek <jszczype-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

After some debugging, we found that the fault addr is from DMA initiated at
the driver probe stage after reset(not in-flight DMA), and the corresponding
pte entry value is correct, the fault is likely due to the old iommu caches
of the in-flight DMA before it.

Thus we need to flush the old cache after context mapping is setup for the
device, where the device is supposed to finish reset at its driver probe
stage and no in-flight DMA exists hereafter.

I'm not sure if the hardware is responsible for invalidating all the related
caches allocated in the iommu hardware before, but seems not the case for hpsa,
actually many device drivers have problems in properly resetting the hardware.
Anyway flushing (again) by software in kdump kernel when the device gets context
mapped which is a quite infrequent operation does little harm.

With this patch, the problematic machine can survive the kdump tests.

CC: Myron Stowe <myron.stowe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Joseph Szczypek <jszczype-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>
CC: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CC: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
Fixes: dbcd861f252d ("iommu/vt-d: Do not re-use domain-ids from the old kernel")
Fixes: cf484d0e6939 ("iommu/vt-d: Mark copied context entries")
Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
v2->v3:
Flush context cache only and add Fixes-tag, according to Joerg's comments.

 drivers/iommu/intel-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3965e73..624eac9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2024,6 +2024,25 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_present(context))
 		goto out_unlock;
 
+	/*
+	 * For kdump cases, old valid entries may be cached due to the
+	 * in-flight DMA and copied pgtable, but there is no unmapping
+	 * behaviour for them, thus we need an explicit cache flush for
+	 * the newly-mapped device. For kdump, at this point, the device
+	 * is supposed to finish reset at its driver probe stage, so no
+	 * in-flight DMA will exist, and we don't need to worry anymore
+	 * hereafter.
+	 */
+	if (context_copied(context)) {
+		u16 did_old = context_domain_id(context);
+
+		if (did_old >= 0 && did_old < cap_ndoms(iommu->cap))
+			iommu->flush.flush_context(iommu, did_old,
+						   (((u16)bus) << 8) | devfn,
+						   DMA_CCMD_MASK_NOBIT,
+						   DMA_CCMD_DEVICE_INVL);
+	}
+
 	pgd = domain->pgd;
 
 	context_clear_entry(context);
-- 
1.8.3.1
