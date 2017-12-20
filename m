From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] Add support for Intel IOMMU 5-level paging
Date: Wed, 20 Dec 2017 11:59:23 -0800
Message-ID: <1513799967-22454-1-git-send-email-sohil.mehta@intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kirill Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi All,

Upcoming hardware plans to introduce support for 5-level paging[1]. The support
for CPU 5-level paging has already been merged in kernel v4.14. The following
patches add support for Intel IOMMU 5-level paging. The patches are based on
the Intel Virtualization Technology for Directed I/O spec revision - 2.5 [2]

Intel IOMMU Extended-context entries support two levels of translation,
referred to as first-level translation and second-level translation. The first
level page table points to CPU page table when IOMMU is using Shared virtual
memory(SVM). The second level page tables are built by IOMMU driver for IOVA
translations when functions like dma_map/iommu_map are called.

Use of 5-level paging for first-level translation is controlled through
programming of the new paging mode field in the PASID entry for the IOMMU PASID
(Process Address space ID) table. Use of 5-level paging for second-level
translation is controlled through the programming of already existing Address
Width (AW) field in the context/extended-context entry.

The first patch adds 5-level paging support for second level translations by
increasing the supported domain address width. The following patches add the
necessary checks before enabling SVM. The last patch programs the 5-level
paging mode in the PASID entry.

Regards,
Sohil

[1] https://software.intel.com/sites/default/files/managed/2b/80/5-level_paging_white_paper.pdf
[2] https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf


Sohil Mehta (4):
  iommu/vt-d: Enable upto 57 bits of domain address width
  iommu/vt-d: Add a check for 1GB page support
  iommu/vt-d: Add a check for 5-level paging support
  iommu/vt-d: Enable 5-level paging mode in the PASID entry

 drivers/iommu/intel-iommu.c |  2 +-
 drivers/iommu/intel-svm.c   | 23 +++++++++++++++++++++--
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.7.4
