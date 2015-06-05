From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/17] Fixes and Cleanups for the Intel VT-d driver
Date: Fri,  5 Jun 2015 16:10:46 +0200
Message-ID: <1433513463-19128-1-git-send-email-joro@8bytes.org>
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
Cc: rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey,

here are a couple of patches to fix the fall-out from the
patch set fixing the kdump faults with VT-d enabled. A few
important issues have been fixed:

	* Moved sleeping functions out of atomic sections,
	  mainly iremap_cache/iounmap.

	* Mark domain ids used in the old kernel as reserved
	  in the kdump kernel, so that any new domains don't
	  interfere with domains from the old kernel

	* Mark all IRT entries from the old kernel as
	  reservered in the new kernel, so that we don't
	  overwrite an entry which might still be in use by
	  a device

	* Only try to load anything from the old kernel when
	  we are in a kdump kernel. If we find the iommu
	  hardware enabled and we are not in a kdump kernel,
	  just disable the iommu and proceed with
	  initialization.

	* Fix a compile error

Besides that I also cleaned up the code to simplify it:

	* Move necessary initialization steps before the
	  root entry table and the irq remapping table is
	  programmed into hardware. This makes sure QI is
	  initialized so that we can flush the iommu caches
	  when hardware got the new tables.

	* Make the new root entry table and irq remapping
	  table visible to hardware immediatly after they
	  are created and loaded with the data from the old
	  kernel. This allows to remove the code to update
	  both, the old and the new version of the table at
	  the same time.

	* Clean up log messages from the VT-d driver to have
	  a common prefix that can be grepped for.

	* Remove unused code

The changes have been tested by me an Baoquan He. I'll plan
to put them into the x86/vt-d branch for v4.2.

Regards,

	Joerg

Joerg Roedel (17):
  iommu/vt-d: Fix compile error when CONFIG_INTEL_IOMMU=n
  iommu/vt-d: Remove __iommu_save_to_oldmem() function
  iommu/vt-d: Make two functions static
  iommu/vt-d: Load old data structures only in kdump kernel
  iommu/vt-d: Mark root-entry present in set_root_entry
  iommu/vt-d: Rework loading of old root-entry table
  iommu/vt-d: Copy context-tables outside of spin_lock
  iommu/vt-d: Don't reuse domain-ids from old kernel
  iommu/vt-d: Clean up log messages in intel-iommu.c
  iommu/vt-d: Allocate irq remapping table bitmap with GFP_KERNEL
  iommu/vt-d: Move QI initialization to intel_setup_irq_remapping
  iommu/vt-d: Move EIM detection to intel_prepare_irq_remapping
  iommu/vt-d: Split up iommu_set_irq_remapping
  iommu/vt-d: Move kdump pointer intialization to __iommu_load_old_irte
  iommu/vt-d: Mark irt entries from old kernel as allocated
  iommu/vt-d: Copy old irte in intel_setup_irq_remapping
  iommu/vt-d: Remove update code for old ir-table

 drivers/iommu/dmar.c                |  26 +-
 drivers/iommu/intel-iommu.c         | 463 ++++++++++++++----------------------
 drivers/iommu/intel_irq_remapping.c | 263 +++++++++-----------
 include/linux/intel-iommu.h         |  17 +-
 4 files changed, 299 insertions(+), 470 deletions(-)

-- 
1.9.1
