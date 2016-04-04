From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Mon, 4 Apr 2016 12:51:46 +0200
Message-ID: <20160404105146.GD24141@suse.de>
References: <5700BF69.2080102@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5700BF69.2080102-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Clemens,

On Sun, Apr 03, 2016 at 08:59:53AM +0200, Clemens Ladisch wrote:
> there are several reports of Xonar PCIe sound cards failing to work in
> kernel 4.4 (including 4.4.5):
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1313790
> https://bugzilla.kernel.org/show_bug.cgi?id=111711
> https://bbs.archlinux.org/viewtopic.php?pid=1601338#p1601338
> 
> They show error messages like this:
> 
>   AMD-Vi: Event logged [IO_PAGE_FAULT device=03:00.0 domain=0x0000 address=0x000000000020cf00 flags=0x0070]
> 
> All these cards use a PCI chip, with different PCIe bridges (ASM1083,
> PEX8112, PEX8111).a
> 
> It probably matters that "03" is the PCI bus, but that device "00" does
> not exist.

I have seen that before, can you please boot with 'amd_iommu_dump' on
the kernel command line and send me dmesg after boot?


Thanks a lot,


       Joerg
