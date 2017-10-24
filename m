From: Jim Quinlan <jim2101024-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
Date: Tue, 24 Oct 2017 14:08:12 -0400
Message-ID: <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de> <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009F05A-VkEWCZq2GCInGFn1LkZF6NBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Laight <David.Laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 23, 2017 at 5:06 AM, David Laight <David.Laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org> wrote:
> From: Jim Quinlan
>> Sent: 20 October 2017 16:28
>> On Fri, Oct 20, 2017 at 10:57 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>> > On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
>> >> I am not sure I understand your comment -- the size of the request
>> >> shouldn't be a factor.  Let's look at your example of the DMA request
>> >> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
>> >> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
>> >> what is available, there is no 15 page span that can happen across the
>> >> 0x40000000 boundary.  For SG, there can be no merge that connects a
>> >> page from one region to another region.  Can you give an example of
>> >> the scenario you are thinking of?
>> >
>> > What prevents a merge from say the regions of
>> > 0....3fffffff and 40000000....7fffffff?
>>
>> Huh? [0x3ffff000...x3ffffff] is not available to be used. Drawing from
>> the original example, we now have to tell Linux that these are now our
>> effective memory regions:
>>
>>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>>
>> This leaves a one-page gap between phsyical memory regions which would
>> normally be contiguous. One cannot have a dma alloc that spans any two
>> regions.  This is a drastic step, but I don't see an alternative.
>> Perhaps  I may be missing what you are saying...
>
> Isn't this all unnecessary?
> Both kmalloc() and dma_alloc() are constrained to allocate memory
> that doesn't cross an address boundary that is larger than the size.
> So if you allocate 16k it won't cross a 16k physical address boundary.
>
>         David
>
Hi David,  Christoph was also concerned about this:

"For the block world take a look at __blk_segment_map_sg which does the merging
of contiguous pages into a single SG segment.  You'd have to override
BIOVEC_PHYS_MERGEABLE to prevent this from happening in your supported
architectures for the block layer."

Do you consider this a non-issue as well or can this happen and span
memory regions?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
