From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/3] intel-iommu: fix mapping PSI missing for iommu_map()
Date: Wed, 18 Apr 2018 16:39:50 +0800
Message-ID: <20180418083953.21492-1-peterx@redhat.com>
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
To: Linux IOMMU Mailing List <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alexander Witte <alexander.witte-eh6l0D9wmvKB+jHODAdFcQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

v2:
- cc correct people and iommu list

(PSI stands for: Page Selective Invalidations)

Intel IOMMU has the caching mode to ease emulation of the device.
When that bit is set, we need to send PSIs even for newly mapped
pages.  However current driver is not fully obey the rule.  E.g.,
iommu_map() API will only do the mapping but it never sent the PSIs
before.  That can be problematic to emulated IOMMU devices since
they'll never be able to build up the shadow page tables if without
such information.  This patchset tries to fix the problem.

Patch 1 is a tracing enhancement that helped me to triage the problem.
It might even be useful in the future.

Patch 2 generalized a helper to notify the MAP PSIs.

Patch 3 fixes the real problem by making sure every domain mapping
will trigger the MAP PSI notifications.

Without the patchset, nested device assignment (assign one device
firstly to L1 guest, then to L2 guest) won't work for QEMU.  After
applying the patchset, it works.

Please review.  Thanks.

Peter Xu (3):
  intel-iommu: add some traces for PSIs
  intel-iommu: generalize __mapping_notify_one()
  intel-iommu: fix iotlb psi missing for mappings

 drivers/iommu/dmar.c        |  3 ++
 drivers/iommu/intel-iommu.c | 68 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.14.3
