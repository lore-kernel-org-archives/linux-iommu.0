From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Thu, 15 Mar 2018 13:11:03 +0000
Message-ID: <dfc5505e-9ab9-2d81-2fc5-623730a68ba9@arm.com>
References: <20180302180704.GA3846@localhost.localdomain>
	<20180302213711.GA30356@lst.de>
	<20180303082234.GB24991@localhost.localdomain>
	<20180303161249.GA9516@lst.de>
	<20180303181904.GA19076@localhost.localdomain>
	<20180305151010.GA15965@lst.de>
	<20180311180124.GA27731@localhost.localdomain>
	<5696e17e-e0f4-4e6c-7783-4eeea0ff7a5e@arm.com>
	<20180313131745.GC6260@lst.de>
	<d0659e5e-4be7-9a1e-fb8e-b418962d74de@arm.com>
	<20180315075831.GB12136@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315075831.GB12136-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 15/03/18 07:58, Christoph Hellwig wrote:
> On Wed, Mar 14, 2018 at 05:43:46PM +0000, Robin Murphy wrote:
>>> Looking back I don't really understand why we even indirect the "classic"
>>> per-device dma_declare_coherent_memory use case through the DMA API.
>>
>> It certainly makes sense for devices which can exist in both shared-memory
>> and device-local-memory configurations, so the driver doesn't have to care
>> about the details (particularly on mobile SoCs where the 'local' memory
>> might just be a chunk of system RAM reserved by the bootloader, and it's
>> just a matter of different use-cases on identical hardware).
> 
> Well, the "classic" case for me is memory buffers in the device.  Setting
> some memory aside, either in a global pool as now done for arm-nommu
> or even per-device as on some ARM SOCs is different indeed.
> 
> As far as I can tell the few devices that use 'local' memory always
> use that.

I was thinking mostly of GPUs, where the same IP core might be available 
in a discrete PCIe chip with its own GDDR controller and on-board local 
RAM, and also in an APU/SoC-type configuration reliant on the CPU memory 
bus. But I guess in practice those drivers are already well beyond the 
generic DMA API and into complicated explicitly-managed stuff like TTM.

>>> It seems like a pretty different use case to me.  In the USB case we
>>> also have the following additional twist in that it doesn't even need
>>> the mapping to be coherent.
>>
>> I'm pretty sure it does (in the sense that it needs to ensure the arch code
>> makes the mapping non-cacheable), otherwise I can't see how the bouncing
>> could work properly. I think the last bit of the comment above
>> hcd_alloc_coherent() is a bit misleading.
> 
> Well, if it isn't marked non-cacheable we'd have to do dma_cache_sync
> operations for it.  Which would probably still be faster than non-cacheable
> mappings.

Ah, I see, we crossed wires there - the *current* implementation 
definitely requires a coherent mapping, but in general you're right that 
there are other ways to solve this particular problem which wouldn't. 
This case really wants to be able to overload the streaming map/unmap 
calls to automatically bounce through device-local memory, but I'm sure 
that's not worth the complexity or effort in general :)

>>> So maybe for now the quick fix is to move the sleep check as suggested
>>> earlier in this thread, but in the long run we probably need to do some
>>> major rework of how dma_declare_coherent_memory and friends work.
>>
>> Maybe; I do think the specific hcd_alloc_coherent() case could still be
>> fixed within the scope of the existing code, but it's not quite as clean
>> and straightforward as I first thought, and the practical impact of
>> tweaking the WARN should be effectively zero despite the theoretical edge
>> cases it opens up. Do you want me to write it up as a proper patch?
> 
> Yes.  Including a proper comment on why the might_sleep is placed there.

OK, will do.

> My mid-term plan was to actually remove the gfp flags argument from
> the dma alloc routines as is creates more confusion than it helps.
> I guess this means we'll at least need to introduce a DMA_ATTR_NON_BLOCK
> or similar flag instead then unfortunately.

At least we already have DMA_ATTR_NO_WARN, which could be implemented 
consistently to clean up the existing __GFP_NOWARN users.

Robin.
