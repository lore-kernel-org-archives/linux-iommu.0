From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] mm: Add kernel MMU notifier to manage IOTLB/DEVTLB
Date: Thu, 14 Dec 2017 19:08:54 -0800
Message-ID: <20171215030854.GA69597@otc-nc-03>
References: <1513213366-22594-1-git-send-email-baolu.lu@linux.intel.com>
	<1513213366-22594-2-git-send-email-baolu.lu@linux.intel.com>
	<a98903c2-e67c-a0cc-3ad1-60b9aa4e4c93@huawei.com>
	<5A31F232.90901@linux.intel.com>
	<e7462b54-9d3a-abfd-8df2-2db3780de78d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e7462b54-9d3a-abfd-8df2-2db3780de78d-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Paul E . McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Kirill A . Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bob

On Thu, Dec 14, 2017 at 02:07:38PM +0800, Bob Liu wrote:
> On 2017/12/14 11:38, Lu Baolu wrote:

> >>>> We already have an existing MMU notifiers for userspace updates,
> >>>> however we lack the same thing for kernel page table updates. To
> >> Sorry, I didn't get which situation need this notification.
> >> Could you please describe the full scenario?
> > 
> > Okay.
> > 
> > 1. When an SVM capable driver calls intel_svm_bind_mm() with
> >     SVM_FLAG_SUPERVISOR_MODE set in the @flags, the kernel
> >     memory page mappings will be shared between CPUs and
> >     the DMA remapping agent (a.k.a. IOMMU). The page table
> >     entries will also be cached in both IOTLB (located in IOMMU)
> >     and the DEVTLB (located in device).
> > 
> 
> But who/what kind of real device has the requirement to access a kernel VA?
> Looks like SVM_FLAG_SUPERVISOR_MODE is used by nobody?

That's right, there is no inkernel user at the moment, but we certainly see
them coming.

Maybe not the best example :-), but I'm told Lustre and some of the 
modern NIC's also can benefit from SVM in kernel use.

Not a hypothetical use case certainly!


Cheers,
Ashok
