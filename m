From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/19] Fix Intel IOMMU breakage in kdump kernel
Date: Sat, 13 Jun 2015 08:47:08 +0200
Message-ID: <1434178047-17809-1-git-send-email-joro@8bytes.org>
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
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

as David Woodhouse pointed out, my fixes and cleanups for
the original patch-set turned out to be a complete rewrite.
So to have a cleaner history of the feature and to make
backporting easier, here is a rewrite of my changes based on
v4.1-rc7.

Some additional issues have been fixed by this rewrite, like
a kdump-kernel boot panic with 'iommu=pt' and support for
copying the extended root-entry and context table formats
has been added.

I plan to rebuild the x86/vt-d branch of the iommu tree with
these patches.

Regards,

	Joerg

Joerg Roedel (19):
  iommu/vt-d: Cleanup log messages
  iommu/vt-d: Init QI before root entry is allocated
  iommu/vt-d: Make root entry visible for hardware right after
    allocation
  iommu/vt-d: Detect pre enabled translation
  iommu/vt-d: Copy translation tables from old kernel
  iommu/vt-d: Do not re-use domain-ids from the old kernel
  iommu/vt-d: Mark copied context entries
  iommu/vt-d: Allocate si_domain in init_dmars()
  iommu/vt-d: Don't do early domain assignment if kdump kernel
  iommu/vt-d: Don't copy translation tables if RTT bit needs to be
    changed
  iommu/vt-d: Don't disable translation prior to OS handover
  iommu/vt-d: Enable Translation only if it was previously disabled
  iommu/vt-d: Move EIM detection to intel_prepare_irq_remapping
  iommu/vt-d: Move QI initializationt to intel_setup_irq_remapping
  iommu/vt-d: Disable IRQ remapping in intel_prepare_irq_remapping
  iommu/vt-d: Set IRTA in intel_setup_irq_remapping
  iommu/vt-d: Copy IR table from old kernel when in kdump mode
  iommu/vt-d: Make sure copied over IR entries are not reused
  iommu/vt-d: Don't disable IR when it was previously enabled

 drivers/iommu/dmar.c                |  28 +-
 drivers/iommu/intel-iommu.c         | 495 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel_irq_remapping.c | 255 ++++++++++++-------
 include/linux/intel-iommu.h         |   5 +
 4 files changed, 573 insertions(+), 210 deletions(-)

-- 
1.9.1
