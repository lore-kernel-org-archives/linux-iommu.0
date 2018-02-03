From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Fri,  2 Feb 2018 16:49:56 -0800
Message-ID: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi All,

This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
registers, internal context and dumps individual table entries to help debug
Intel IOMMUs.

The first patch does the ground work for the following patches by reorganizing
some Intel IOMMU data structures. The following patches create a new Kconfig
option - INTEL_IOMMU_DEBUG and add debugfs support for IOMMU context internals,
register contents, PASID internals, and Interrupt remapping in that order. The
information can be accessed in sysfs at '/sys/kernel/debug/intel_iommu/'.


Regards,
Sohil
 
Changes since v6:
 - Split patch 1/5 and 2/5 differently
 - Simplify and improve code formatting
 - Use macro for register set definitions
 - Fix compiler warning for readq
 - Add Co-Developed-by tag to commit messages

Changes since v5:
 - Change the order of includes to an alphabetical order
 - Change seq_printf and seq_puts formatting

Changes since v4:
 - Change to a SPDX license tag
 - Fix seq_printf formatting and remove leading '\n's

Changes since v3:
 - Remove an unused function parameter from some of the functions
 - Fix checkpatch.pl warnings
 - Remove error reporting for debugfs_create_file functions
 - Fix unnecessary reprogramming of the context entries
 - Simplify and merge the show context and extended context patch into one
 - Remove redundant IOMMU null check under for_each_active_iommu
 - Update the commit title to be consistent

Changes since v2:
 - Added a macro for seq file operations based on recommendation by Andy 
   Shevchenko. The marco can be moved to seq_file.h at a future point
 - Changed the debugfs file names to more relevant ones
 - Added information for MTRR registers in the regset file

Changes since v1:
 - Fixed seq_printf formatting
 - Handled the case when Interrupt remapping is not enabled

Gayatri Kammela (4):
  iommu/vt-d: Relocate struct/function declarations to its header files
  iommu/vt-d: Enable debugfs support to show context internals
  iommu/vt-d: Add debugfs support to show register contents
  iommu/vt-d: Add debugfs support to show Pasid table contents

Sohil Mehta (1):
  iommu/vt-d: Add debugfs support for Interrupt remapping

 drivers/iommu/Kconfig             |   8 +
 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 338 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |  34 +---
 drivers/iommu/intel-svm.c         |   8 -
 include/linux/intel-iommu.h       |  39 +++++
 include/linux/intel-svm.h         |  10 +-
 7 files changed, 400 insertions(+), 38 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

-- 
2.7.4
