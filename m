From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Tue, 13 Feb 2018 14:53:32 -0800
Message-ID: <20180213145332.35c73eda@jacob-builder>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
	<20180213140303.42mbzfxpypljy37l@8bytes.org>
	<20180213214002.GA27066@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180213214002.GA27066@otc-nc-03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 13 Feb 2018 13:40:02 -0800
"Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi Joerg,
> 
> On Tue, Feb 13, 2018 at 03:03:03PM +0100, Joerg Roedel wrote:
> > On Fri, Feb 02, 2018 at 04:49:56PM -0800, Sohil Mehta wrote:  
> > > This series aims to add debugfs support for Intel IOMMU. It
> > > exposes IOMMU registers, internal context and dumps individual
> > > table entries to help debug Intel IOMMUs.
> > > 
> > > The first patch does the ground work for the following patches by
> > > reorganizing some Intel IOMMU data structures. The following
> > > patches create a new Kconfig option - INTEL_IOMMU_DEBUG and add
> > > debugfs support for IOMMU context internals, register contents,
> > > PASID internals, and Interrupt remapping in that order. The
> > > information can be accessed in sysfs at
> > > '/sys/kernel/debug/intel_iommu/'.  
> > 
> > This looks like it only presents data from the iommu-hardware
> > (register state) or from in-memory data structures used by the
> > hardware. Can't all this be read out from user-space with libpci
> > and /dev/mem access?  
> 
> True, we can do the tools and keep it strictly user space, but find
> it very convenient to keep the kernel code and debugfs together. When
> there are bug-reports its rather easy for the user to collect some
> data and report it, and all the data-structures we need are readily
> available instead of finding a round-about way to capture the same
> data from user-space.
> 
> This version has only hw dumps for now, but we plan to add some other
> things like walking 2nd level page-tables, or get some SVM specific
> data from the driver in the future. 
> 
We did start out with /dev/mem but run into CONFIG_STRICT_DEVMEM
requirement which is turned on by default.
libpci is only limited to PCI config space access, right?

> > 
> > Things are different for kernel-defined data structures, as they
> > might change between releases and can be presented to user-space
> > via debugfs is needed, but the data structures used by the hardware
> > should be pretty stable.  
> 
> Cheers,
> Ashok

[Jacob Pan]
