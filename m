From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 0/5] Add Intel IOMMU debugfs support
Date: Wed, 10 Jan 2018 15:46:51 +0200
Message-ID: <1515592011.7000.873.camel@linux.intel.com>
References: <1515556102-34150-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515556102-34150-1-git-send-email-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sohil Mehta <sohil.mehta@intel.com>, Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-01-09 at 19:48 -0800, Sohil Mehta wrote:
> Hi All,
> 
> This series aims to add debugfs support for Intel IOMMU. It exposes
> IOMMU
> registers, internal context and dumps individual table entries to help
> debug
> Intel IOMMUs.
> 
> The first patch does the ground work for the following patches by
> creating a
> new Kconfig option - INTEL_IOMMU_DEBUG. It also reorganizes some Intel
> IOMMU
> data structures. The next four patches add debugfs support for IOMMU
> context
> internals, register contents, PASID internals, and Interrupt remapping
> in 
> that order. The information can be accessed in sysfs at
> '/sys/kernel/debug/intel_iommu/'.
> 

Thanks for an update.
I found small issues, otherwise looks pretty much good.

P.S. During re-indendation take care of the lines that can be combined
to one line.

> Regards,
> Sohil
> 
> Changes since v5:
>  - Change the order of includes to an alphabetical order
>  - Change seq_printf and seq_puts formatting
> 
> Changes since v4:
>  - Change to a SPDX license tag
>  - Fix seq_printf formatting and remove leading '\n's
> 
> Changes since v3:
>  - Remove an unused function parameter from some of the functions
>  - Fix checkpatch.pl warnings
>  - Remove error reporting for debugfs_create_file functions
>  - Fix unnecessary reprogramming of the context entries
>  - Simplify and merge the show context and extended context patch into
> one
>  - Remove redundant IOMMU null check under for_each_active_iommu
>  - Update the commit title to be consistent
> 
> Changes since v2:
>  - Added a macro for seq file operations based on recommendation by
> Andy 
>    Shevchenko. The marco can be moved to seq_file.h at a future point
>  - Changed the debugfs file names to more relevant ones
>  - Added information for MTRR registers in the regset file
> 
> Changes since v1:
>  - Fixed seq_printf formatting
>  - Handled the case when Interrupt remapping is not enabled
> 
> Gayatri Kammela (4):
>   iommu/vt-d: Add debugfs support for Intel IOMMU internals
>   iommu/vt-d: Add debugfs support to show context internals
>   iommu/vt-d: Add debugfs support to show register contents
>   iommu/vt-d: Add debugfs support to show Pasid table contents
> 
> Sohil Mehta (1):
>   iommu/vt-d: Add debugfs support for Interrupt remapping
> 
>  drivers/iommu/Kconfig             |  10 ++
>  drivers/iommu/Makefile            |   1 +
>  drivers/iommu/intel-iommu-debug.c | 346
> ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-iommu.c       |  35 +---
>  drivers/iommu/intel-svm.c         |   8 -
>  include/linux/intel-iommu.h       |  34 ++++
>  include/linux/intel-svm.h         |  10 +-
>  7 files changed, 407 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/iommu/intel-iommu-debug.c
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
