From: Sunil Kovvuri <sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU
	is bypassed
Date: Wed, 26 Apr 2017 17:33:15 +0530
Message-ID: <CA+sq2CdXdVG09Oish_F3QMyCFCv8SO-OCtr6A6W9rFb7baCMug@mail.gmail.com>
References: <1493114272-30093-1-git-send-email-sunil.kovvuri@gmail.com>
	<20170426100150.GE21744@arm.com>
	<CA+sq2Ce2UVi04VtD4KLDsNk2baN1kq_vN2KOrEt9a_cB0gJ0vw@mail.gmail.com>
	<20170426113651.GI21744@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170426113651.GI21744-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 26, 2017 at 5:06 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Apr 26, 2017 at 04:13:29PM +0530, Sunil Kovvuri wrote:
>> On Wed, Apr 26, 2017 at 3:31 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Hi Sunil,
>> >
>> > On Tue, Apr 25, 2017 at 03:27:52PM +0530, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> >> From: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> >>
>> >> For software initiated address translation, when domain type is
>> >> IOMMU_DOMAIN_IDENTITY i.e SMMU is bypassed, mimic HW behavior
>> >> i.e return the same IOVA as translated address.
>> >>
>> >> This patch is an extension to Will Deacon's patchset
>> >> "Implement SMMU passthrough using the default domain".
>> >>
>> >> Signed-off-by: Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> >> ---
>> >>
>> >> V2
>> >> - As per Will's suggestion applied fix to SMMUv3 driver as well.
>> >
>> > This follows what the AMD driver does, so:
>> >
>> > Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>>
>> Thanks,
>>
>> >
>> > but I still think that having drivers/net/ethernet/cavium/thunder/nicvf_queues.c
>> > poke around with the physical address to get at the struct pages underlying
>> > a DMA buffer is really dodgy.
>>
>> Driver is not dealing with page structures to be precise, just like
>> for any other NIC device, driver needs to know the virtual address
>> of the packet to where it's DMA'ed, so that SKB if framed and
>> handed over to network stack. Due to reasons mentioned below,
>> in this driver it's not possible to maintain a list of DMA addresses to
>> Virtual address mappings. Hence using IOMMU API, DMA address
>> is translated to physical address and finally to virtual address. I don't
>> see anything dodgy here.
>
> It's dodgy because you're the only NIC driver using iommu_iova_to_phys
> directly and, afaict, the driver could just stash either the struct page
> or the virtual address at the point of allocation.

Well the driver needs to be written based on how HW functions even if
it results in making use of an API which isn't used earlier by others.

>
>> > Is there no way this can be avoided, perhaps by tracking the pages some other way
>>
>> I have explained that in the commit message
>> --
>>     Also VNIC doesn't have a seperate receive buffer ring per receive
>>     queue, so there is no 1:1 descriptor index matching between CQE_RX
>>     and the index in buffer ring from where a buffer has been used for
>>     DMA'ing. Unlike other NICs, here it's not possible to maintain dma
>>     address to virt address mappings within the driver. This leaves us
>>     no other choice but to use IOMMU's IOVA address conversion API to
>>     get buffer's virtual address which can be given to network stack
>>     for processing.
>> --
>>
>> >(although I don't understand why you're having to mess with the page reference
>> >counts to start with)?
>> Not sure why you say it's a mess, adjusting page reference counts is quite
>> common if you check other NIC drivers. On ARM64 especially when using
>> 64KB pages, if we have only one packet buffer for each page then we
>> will have to set aside a whole lot of memory which sometimes is not possible
>> on embedded platforms. Hence multiple pkt buffers per page, and page reference
>> is set accordingly.
>
> I wasn't saying that was a mess, I was just saying that I didn't understand
> why you mess (verb) with the page reference counts (my ignorance of the
> network layer). The code that I think is a mess is:
>
>                 phys_addr = nicvf_iova_to_phys(nic, buf_addr);
>                 [...]
>                 put_page(virt_to_page(phys_to_virt(phys_addr)));

Even if it's possible to record info info in this driver, still page reference
count needs to be released to free it otherwise the page is gone.

>
> because:
>
>   (a) You have the information you need at allocation time, but you've
>       failed to record that and are trying to use the IOMMU API to
>       reconstruct the CPU virtual address

That's exactly what I have explained in the commit message, i.e why
I cannot record info at the time of allocation. Also, HW gives address of
the buffer (IOVA or physcial) where it has DMA'ed the packet and not an
index into buffer ring. There is one single buffer ring for 8 receive queues,
so there is no way to do a mapping btw DMA address at receive queue to
recorded info in buffer ring.

All you said is possible and that is exactly what I would have done if HW
gives me an index into buffer ring instead of DMA'ed address and I wouldn't
have been hit so hard with all the bottlenecks in ARM IOMMU infrastructure.

Thanks,
Sunil.

>
>   (b) When there isn't an IOMMU present, you assume that bus addresses ==
>       physical addresses
>
>   (c) You assume that the DMA buffer is mapped in the linear mapping
>
> that's probably all true for ThunderX/arm64, but it's generally not portable
> or reliable code. If you could get a handle to the struct page that you
> allocated in the first place, then you could use page_address to get its
> virtual address instead of having to go via the physical address.
>
> Will
