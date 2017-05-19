From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
Date: Fri, 19 May 2017 08:28:06 +0530
Message-ID: <CAMSpPPeh66YX4DXXX7eBKT9ZL00Uh+7DnPAnnOBN9bdVVmNk3g@mail.gmail.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
	<1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
	<CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ@mail.gmail.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 18, 2017 at 12:43 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tue, May 16, 2017 at 7:22 AM, Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> current device framework and OF framework integration assumes
>> dma-ranges in a way where memory-mapped devices define their
>> dma-ranges. (child-bus-address, parent-bus-address, length).
>>
>> of_dma_configure is specifically written to take care of memory
>> mapped devices. but no implementation exists for pci to take
>> care of pcie based memory ranges.
>
> Hi Oza,
>
> I'm trying to make sense of this, but am still rather puzzled. I have
> no idea what the distinction between memory-mapped devices and
> pcie based devices is in your description, as PCIe is usually memory
> mapped, and Linux doesn't actually support other kinds of PCIe
> devices on most architectures.
>
there are 2 problems which I am trying to address here.

problem-1:
let me explain our PCI RC's limitations first.

IOVA allocaiton honours device's coherent_dma_mask/dma_mask.
in PCI case, current code honours DMA mask set by EP,
there is no concept of PCI host bridge dma-mask, which should be there
and could truely reflect the limitaiton of PCI host bridge.

having said that we have
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
which means we can only address 512GB.

now because of broken of_dma_get_range we end up getting 64bit dma_mask.
please check the code:of_dma_configure()
if (ret < 0) {
dma_addr = offset = 0;
size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);

now in this process I figred out problems in of_dma_get_range: hence the fix
1) return of wrong size as 0 becasue of whole parsing problem.
2) not handling absence of dma-ranges which is valid for PCI master.
3) not handling multipe inbound windows.
4) in order to get largest possible dma_mask. this patch also returns
the largest possible size based on dma-ranges,

please have a look at
[PATCH v6 3/3] PCI/of fix of_dma_get_range; get PCI specific dma-ranges
I just made is bus specific leaving origional of_dma_get_range unmodified
and defining new PCI handling of_bus_pci_get_dma_ranges

also when I say memory-mapped and PCI device, I only mean to say with respect
to the dma-ranges format. (of coure PCI is memory mapped as well).
probbaly my commit description is misleading, sorry about that.

so Problem1: is just bug fix, Nothing else


Problem2: [PATCH v6 2/3] iommu/pci: reserve IOVA for PCI masters

we have memory banks

<0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
<0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
<0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
<0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */

when I run SPDK (User sapce) which internally uses vfio to access PCI
endpoint directly.
vfio uses huge-pages which could coming from 640G/0x000000a0.
and the way vfio maps the hugepage to user space and generates IOVA is different
from the way kernel allocate IOVA.

vfio just maps one to one IOVA to Physical address.
it just calls directly remap_pfn_range.

so the way kernel allocates IOVA (where it honours device dma_mask)
and the way userspace gets IOVA is totally different.

so dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
will not work.
instead we have to go for scatterred dma-ranges leaving holes.

having said that we have to reserve IOVA allocations for inbound memory.
I am in a process of addressing Robin Murphy's comment on that and rebasing
my patch on rc12.

this problem statement is more important to us.
because it makes both kernel and use space IOVA allocations work when
IOMMU is enabled.

probably thing might be confusing because I am clubbing my patches to
address both
the problems. going forward I should just try to first send out patch
for problem2 alone (not sure)
because my next patch-set would bring some changes in pci/probe.c as well.

>> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
>> world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> this patch serves following:
>>
>> 1) exposes interface to the pci host driver for their
>> inbound memory ranges
>>
>> 2) provide an interface to callers such as of_dma_get_ranges.
>> so then the returned size get best possible (largest) dma_mask.
>> because PCI RC drivers do not call APIs such as
>> dma_set_coherent_mask() and hence rather it shows its addressing
>> capabilities based on dma-ranges.
>>
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>
> do you mean the coherent_dma_mask of the PCI host bridge
> or an attached device here?
>
> If you require PCI devices to come up with an initial
> coherent_dma_mask other than 0xffffffffff, there are other
> problems involved. In particular, you will need to use
> swiotlb, which is not supported on arm32 at the moment,
> and the dma_set_mask()/dma_set_coherent_mask()
> functions need to be modified.

even without this patch also it comes up with coherent_dma_mask of 64bits.
since it considers dma_mask set by Endpoint.

please check [RFC PATCH 2/3] iommu/dma: account pci host bridge
dma_mask for IOVA allocation
this patch was in-fact inspired by Robin Murphy's earlier discussions.

>
>> +       while (1) {
>> +               dma_ranges = of_get_property(node, "dma-ranges", &rlen);
>> +
>> +               /* Ignore empty ranges, they imply no translation required. */
>> +               if (dma_ranges && rlen > 0)
>> +                       break;
>> +
>> +               /* no dma-ranges, they imply no translation required. */
>> +               if (!dma_ranges)
>> +                       break;
>
> A missing parent dma-ranges property here should really indicate that there
> is no valid translation. If we have existing cases where this happens
> in DT files, we may treat it as allowing only 32-bit DMA (as we already
> do for having no dma-ranges at all), but treating it the same way
> as an empty dma-ranges property sounds wrong.

not sure if I understood you:
but we have dma-ranges property optional for one of our SOC, in the sense...
PCI RC will allow all the incoming transactions because RC does not
translate anything.
what mask should it generate if dma-ranges property is not present ?
how do you suggest to handle ?

>
>      Arnd
