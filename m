From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
Date: Fri, 1 Jul 2016 18:39:36 +0100
Message-ID: <5776AAD8.5030704@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
	<ac9b11493dfa3500889268488adfa8d4d5c34962.1467129314.git.robin.murphy@arm.com>
	<CALRxmdCuxLPogPTwpn2-B=PU=Ry0eNtgs2z+iZBPYtDc3NX-hQ@mail.gmail.com>
	<HE1PR04MB1641583BE6AFF39AF1BFCEFB8D250@HE1PR04MB1641.eurprd04.prod.outlook.com>
	<57769724.4040801@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <57769724.4040801-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/07/16 17:15, Robin Murphy wrote:
> On 01/07/16 17:03, Stuart Yoder wrote:
>>
>>
>>> -----Original Message-----
>>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> Date: Tue, Jun 28, 2016 at 11:18 AM
>>> Subject: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
>>> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>
>>>
>>> Certain peripherals may be bestowed with knowledge of the physical
>>> memory map of the system in which they live, and refuse to handle
>>> addresses that they do not think are memory, which causes issues when
>>> remapping to arbitrary IOVAs. Sidestep the issue by restricting IOVA
>>> domains to only allocate addresses within ranges which match the
>>> physical memory layout.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>
>>> Posting this as an RFC because it's something I've been having to use
>>> on Juno for all the PCI IOMMU development - it's pretty horrible, but I
>>> can't easily think of a nicer solution...
>>
>> Maybe I'm not getting the implications of this looking at the patch 
>> in isolation, but how will this impact systems that have devices
>> limited to 32-bit addressing?
>>
>> In our memory map we have physical memory regions at:
>> 0x00_8000_0000
>> 0x80_8000_0000
>>
>> Will devices with a 32-bit DMA mask still get 32-bit IOVAs?
> 
> Assuming there's some free IOVA space between 0x80000000 and 0xffffffff,
> yes, otherwise it gets nothing ;) This has no effect on the allocation
> behaviour in general, it just makes sure that within that behaviour, we
> avoid allocating any address that doesn't look "real". The primary issue
> is with 64-bit DMA masks - since it's a top-down allocator, you
> typically end up with the poor device issuing its first DMA transaction
> to 0xfffffffffffff000 which on Juno a) gets silently eaten by the root
> complex because it doesn't match any window in the PCI-AXI translation
> table, or b) goes wrong anyway because it's beyond the input address
> range of the SMMU (and there's something not quite right WRT
> truncation/sign-extension which I've not looked into closely and am
> semi-deliberately also sweeping under the rug thanks to the simpler
> hardware issue...)
> 
> As I say, it's hideous, but I can't see what else to do.

Urgh, thinking some more, this is OK on Juno and LS2085 only because
there *is* some RAM below 4GB to begin with. On something like Seattle
where it's all high up, 32-bit peripherals will be as screwed as if the
IOMMU wasn't there :(

How on Earth do we work out which devices can only DMA to arbitrary
portions of their addressable range, and which are unrestricted? I guess
the reasonable answer is to use "dma-ranges" on the PCI RC to describe
the valid regions, but then we have to propagate that to the domain
somehow, and only after we've taught Linux how to handle multiple
dma-ranges entries at all (currently we'll just ignore everything other
than the last one). As for ACPI...

In short; oh dear.

Robin.

>>
>> Thanks,
>> Stuart
>>
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
