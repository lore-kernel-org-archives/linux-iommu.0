From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Sat, 25 Jan 2014 10:44:18 +0800
Message-ID: <20140125024418.GA1549@dhcp-17-102.nay.redhat.com>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389391652-52422-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Tested this patchset on my local HP Z420 workstation, and it works very
well.

Hi Bill,

Thanks for your effort.

There are several concerns from me.

Firstly, I think the patch log need be rearanged. Patchset cover letter
can contain information to express why, how briefly. If you think this
is very useful, it can be split and put into patch log.

Then for each patch, patch log should be accurate and summary to
describe why and how this patch really does. If you feel several patches
have the corelation, they may need to be merged.

Secondly, each patch could get a seperate subject which tells what this
patch really does. Even they are merged to kernel git tree, each of them
is a independent commit. People can take to use or depend only one of
them. Actually, I don't like current patch subject.

Thirdly, this patchset will be part of intel-iommu, though they only
works for kdump kernel. As a subsystem, the style need be consistent. I
like the debug method which introduces a struct pr_debug, however
maintainers may not like it. Because a debug utility may bloat code and
affect people's review. Personally I like refined code, the less the
easier to review. Or put it as a independent patch at the end of the
patchset, let maintainer decide whether it's OK to pull in.

Sorry to say so much, I think this solution is truly the right way. As
you know, it's a big problem for kdump when intel-iommu is active in 1st
kernel. Because of this bug, many machines with intel-iommu have to be
set intel-iommu=off, the performance is affected very much.

Baoquan
Thanks

On 01/10/14 at 03:07pm, Bill Sumner wrote:
> v2->v3:
> 1. Commented-out "#define DEBUG 1" to eliminate debug messages
> 2. Updated the comments about changes in each version in all patches in the set.
> 3. Fixed: one-line added to Copy-Translations" patch to initialize the iovad
>           struct as recommended by Baoquan He [bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
>           init_iova_domain(&domain->iovad, DMA_32BIT_PFN);
> 
> v1->v2:
> The following series implements a fix for:
> A kdump problem about DMA that has been discussed for a long time. That is,
> when a kernel panics and boots into the kdump kernel, DMA started by the 
> panicked kernel is not stopped before the kdump kernel is booted and the 
> kdump kernel disables the IOMMU while this DMA continues.  This causes the
> IOMMU to stop translating the DMA addresses as IOVAs and begin to treat them 
> as physical memory addresses -- which causes the DMA to either:
> (1) generate DMAR errors or (2) generate PCI SERR errors or (3) transfer  
> data to or from incorrect areas of memory. Often this causes the dump to fail.
> 
 
