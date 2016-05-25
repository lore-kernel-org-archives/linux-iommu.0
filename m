From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v4 0/9] *** Fix kdump failure in system with amd iommu***
Date: Wed, 25 May 2016 14:28:46 +0800
Message-ID: <1464157735-8865-1-git-send-email-bhe@redhat.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vincent.wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Recently I have time to continue the work of fixing AMD IOMMU faults in
kdump kernel. The situation is I tried to make change at the time point
as Intel iommu has done, but still Ethernet NIC will trigger the printing
of IO_PAGE_FAULT. I got 2 machines with AMD IOMMU v1 and v2 separately,
the test result is similar, always there are IO_PAGE_FAULT message for
Ethernet network card. I have no idea why it happened though I did it
just like Intel IOMMU did.

In this v4 change, I just made changes as follows:

1) Several clean up patches when I reviewed AMD IOMMU code.
2) Detect if it's pre-enabled in kdump kernel.
3) Copy dev tables in kdump kernel. Since dev table is per device we just
   need to copy the content in dev table, the io page table pointer and
   irq table pointer are contained in each dev table entry.
4) Reserved the domain id which has been allocated in 1st kernel
5) Do not re-enable or re-init the dev table entry bits or control bit
   of AMD IOMMU.

Post this to mailing list, hope it can be figured out which need be further
changed.

v3->v4:
    1)Define several PTE/DTE bits MACRO definition according to Zongshun's
      comments.
    2)Learned the implementation of vt-d fix done by Joerg and did the AMD
      IOMMU change similiarly.

Baoquan HE (4):
  iommu/amd: add early_enable_iommu() helper function
  iommu/amd: copy old trans table from old kernel
  iommu/amd: Do not initialize dev tables again in kdump
  iommu/amd: Check the validation of irq table and domain id

Baoquan He (5):
  iommu/amd: clean up the cmpxchg64 invocation
  iommu/amd: Use standard bitmap operation to set bitmap
  iommu/amd: Detect pre enabled translation
  iommu/amd: Define bit fields for DTE particularly
  iommu/amd: Add function copy_dev_tables

 drivers/iommu/amd_iommu.c       |  21 +++----
 drivers/iommu/amd_iommu_init.c  | 136 +++++++++++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h |  29 +++++++--
 3 files changed, 156 insertions(+), 30 deletions(-)

-- 
2.5.5
