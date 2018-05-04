From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/2] iommu/vt-d: Fix mapping PSI missing for iommu_map()
Date: Fri,  4 May 2018 10:34:51 +0800
Message-ID: <20180504023453.25682-1-peterx@redhat.com>
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
To: Linux IOMMU Mailing List <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexander Witte <alexander.witte-eh6l0D9wmvKB+jHODAdFcQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

v3:
- drop the pr_debug patch [Joerg]
- rename all the subjects as suggested [Joerg]
- rebase

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

Patch 1 introduces a helper to notify the MAP PSIs.

Patch 2 fixes the real problem by making sure every domain mapping
will trigger the MAP PSI notifications.

Without the patchset, nested device assignment (assign one device
firstly to L1 guest, then to L2 guest) won't work for QEMU.  After
applying the patchset, it works.

Please review.  Thanks.

Peter Xu (2):
  iommu/vt-d: Introduce __mapping_notify_one()
  iommu/vt-d: Fix iotlb psi missing for mappings

 drivers/iommu/intel-iommu.c | 65 ++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 19 deletions(-)

-- 
2.17.0
