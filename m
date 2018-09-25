From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/6] Add Intel IOMMU debugfs support
Date: Tue, 25 Sep 2018 14:34:06 +0200
Message-ID: <20180925123406.xbqxg4t5gdtmtpp7@8bytes.org>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180912001141.64025-1-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 11, 2018 at 05:11:35PM -0700, Sohil Mehta wrote:
> Sohil Mehta (5):
>   iommu/vt-d: Relocate struct/function declarations to its header files
>   iommu/vt-d: Update register definitions to VT-d 3.0 specification
>   iommu/vt-d: Enable base Intel IOMMU debugfs support
>   iommu/vt-d: Add debugfs support for Interrupt remapping
>   iommu/vt-d: Add debugfs support to show context internals
> 
>  arch/x86/include/asm/irq_remapping.h |   2 +
>  drivers/iommu/Kconfig                |  13 ++
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/intel-iommu-debugfs.c  | 314 +++++++++++++++++++++++++++
>  drivers/iommu/intel-iommu.c          |  32 +--
>  drivers/iommu/intel_irq_remapping.c  |   2 +-
>  include/linux/intel-iommu.h          |  72 ++++++
>  7 files changed, 407 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/iommu/intel-iommu-debugfs.c

Applied, thanks.
