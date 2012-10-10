From: Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for v3.7-rc1
Date: Wed, 10 Oct 2012 20:11:31 +0100
Message-ID: <20121010201131.091d5a1f@ado-amd-gentoo.moore.slainvet.net>
References: <20121005152312.GA4649@8bytes.org>
	<20121009224532.1e515664@ado-amd-gentoo.moore.slainvet.net>
	<20121010073022.GB16151@8bytes.org>
	<20121010095823.140fdd98@ado-amd-gentoo.moore.slainvet.net>
	<20121010133249.GC16151@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121010133249.GC16151-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 10 Oct 2012 15:32:49 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Oct 10, 2012 at 09:58:23AM +0100, Andrew Oakley wrote:
> > On Wed, 10 Oct 2012 09:30:22 +0200
> > Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> 
> > AMD-Vi:   DEV_SPECIAL(IOAPIC[2])		devid: 00:00.1
> 
> Okay, got it. This is the problem. The device id seems to be wrong.
> The BIOS should configure your IOAPIC as device id 00:14.0 and not
> 00:00.1. The current checking code does not check for this particular
> situation. But the attached diff should change that. Can you please
> test it and reports if the machine boots for you? Interrupt remapping
> will be disabled automatically, though.

Yes, that detects the problem and disables the interrupt remapping (the
kernel boots).

If I modify the devid for the IOAPIC in init_iommu_from_acpi then it
also seems to work.  I haven't managed to get vfio/qemu working yet but
it seems to be unrelated ("Invalid ROM contents", same thing happens
when I try to dump the rom with stable kernels).

Thanks

-- 
Andrew Oakley
