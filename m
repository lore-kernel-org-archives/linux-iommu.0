From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Quirk to support Marvell 88SE91xx SATA controllers with
	Intel IOMMU.
Date: Sat, 2 Mar 2013 06:19:07 +0800
Message-ID: <CAJtEV7Zs2BiwJ9jdDeoceh9hiVXvVaSvj=9H+4+vEzhY72AS9g@mail.gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
	<1355914703-28576-1-git-send-email-acooks@gmail.com>
	<1362126373-32318-1-git-send-email-acooks@gmail.com>
	<CAO9zADxjoP+R9ccz7vMPmcFvdYwNjErSjaWc_RFkW_FY3+SK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAO9zADxjoP+R9ccz7vMPmcFvdYwNjErSjaWc_RFkW_FY3+SK=w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>
Cc: Chu Ying <gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, YingChu <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Mar 2, 2013 at 1:51 AM, Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org> wrote:
>
>
> On Fri, Mar 1, 2013 at 3:26 AM, Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> This is my third submitted patch to make Marvell 88SE91xx SATA controllers
>> work when IOMMU is enabled.[1][2]
>>
>
> Hi,
>
> Against 3.7.10:
>
> # patch -p1 <
> ../RFC-Fix-Intel-IOMMU-support-for-Marvell-88SE91xx-SATA-controllers..patch
> patching file drivers/iommu/intel-iommu.c
> patching file drivers/pci/quirks.c
> Hunk #1 succeeded at 3230 (offset 3 lines).
> patching file include/linux/pci.h
> #

Thanks for testing!

Patching 3.7.10 looks somewhat different here. I'm using the
linux-3.7.y branch from
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
at commit 356d8c6fb2a7cf49e836742738a8b9a47e77cfea. The output I get
is:

$ patch -p1 < ~/devel/lk_patches_dma_source_maps-20130301/marvell_ghost_funcs.patch
patching file drivers/iommu/intel-iommu.c
Hunk #1 succeeded at 1672 (offset -2 lines).
Hunk #2 succeeded at 1729 (offset -2 lines).
Hunk #3 succeeded at 3833 (offset -2 lines).
patching file drivers/pci/quirks.c
Hunk #1 succeeded at 3210 (offset -39 lines).
Hunk #2 succeeded at 3240 (offset -39 lines).
Hunk #3 succeeded at 3258 (offset -39 lines).
patching file include/linux/pci.h
Hunk #1 succeeded at 1546 (offset -32 lines).
Hunk #2 succeeded at 1555 (offset -32 lines).
patching file include/linux/pci_ids.h

>
> Recompile kernel, reboot..
>
> Shutdown host, re-attach to Marvell Controller w/IOMMU.
>
> The host still failed to boot, dmesg/panic here:
> http://home.comcast.net/~jpiszcz/20130301/boot_failure.JPG
>
> (The root disk is /dev/sdc)

Sorry it doesn't work for you, but I can't really tell what's failing
from the photo you posted. I'm running 3.7.10 with this patch right
now.

According to the dmesg output you posted at
https://home.comcast.net/~jpiszcz/20121128/dmesg.txt and the lspci
output in http://www.kernelhub.org/?p=2&msg=171877, you've run into
two separate DMAR issues:

Problem A - nvidia graphics:
[    2.968248] dmar: DRHD: handling fault status reg 202
[    2.968253] dmar: DMAR:[DMA Read] Request device [04:00.0] fault addr 0
[    2.968253] DMAR:[fault reason 06] PTE Read access is not set

Problem B - Marvell 88SE9123:
[    2.974534] ata9: SATA link down (SStatus 0 SControl 300)
[    2.976297] ata7: SATA link down (SStatus 0 SControl 300)
[    2.977939] ata13: SATA link down (SStatus 0 SControl 300)
[    2.979689] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.981419] dmar: DRHD: handling fault status reg 2
[    2.981431] ata8: SATA link down (SStatus 0 SControl 300)
[    2.981449] ata11: SATA link down (SStatus 0 SControl 300)
[    2.988479] dmar: DMAR:[DMA Read] Request device [84:00.1] fault
addr fff00000
[    2.988479] DMAR:[fault reason 02] Present bit in context entry is clear

Can you capture a full dmesg with this patch applied?

--
a.
