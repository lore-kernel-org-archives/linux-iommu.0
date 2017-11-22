From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/6] Intel IOMMU debugfs support
Date: Wed, 22 Nov 2017 10:47:33 -0800
Message-ID: <20171122184733.GA199214@otc-nc-03>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1511378746-109275-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex

you can add for the whole series

Reviewed By: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Wed, Nov 22, 2017 at 11:25:40AM -0800, Mehta, Sohil wrote:
> Hi all,
> 
> This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
> registers, internal context and dumps individual table entries to help debug
> Intel IOMMUs.
> 
> The first patch does the ground work for the following patches by creating a new
> Kconfig option - INTEL_IOMMU_DEBUG. It also reorganizes some Intel IOMMU data
> structures. The next five patches add debugfs support for IOMMU context
> internals, extended context, register contents, PASID internals, and Interrupt
> remapping in that order. The information can be accessed in sysfs at
> '/sys/kernel/debug/intel_iommu/'.
> 
> Regards,
> Sohil
> 
> Changes since v1:
>  - Fixed seq_printf formatting
>  - Handled the case when Interrupt remapping is not enabled
> 
> Gayatri Kammela (5):
>   iommu/vt-d: Add debugfs support for Intel IOMMU internals
>   iommu/vt-d: Add Intel IOMMU debugfs to show context internals
>   iommu/vt-d: Add Intel IOMMU debugfs to show extended context internals
>   iommu/vt-d: Add debugfs extension to show register contents
>   iommu/vt-d: Add debugfs extension to show Pasid table contents
> 
> Sohil Mehta (1):
>   iommu/vt-d: Add debugfs support for Intel IOMMU Interrupt remapping
> 
>  drivers/iommu/Kconfig             |  10 +
>  drivers/iommu/Makefile            |   1 +
>  drivers/iommu/intel-iommu-debug.c | 435 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-iommu.c       |  35 +--
>  drivers/iommu/intel-svm.c         |   8 -
>  include/linux/intel-iommu.h       |  32 +++
>  include/linux/intel-svm.h         |  10 +-
>  7 files changed, 494 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/iommu/intel-iommu-debug.c
> 
> -- 
> 2.7.4
> 
