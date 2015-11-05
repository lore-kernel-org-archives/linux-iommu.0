From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about arm smmu
Date: Thu, 5 Nov 2015 10:41:59 +0800
Message-ID: <20151105024157.GA23661@linux-jyl1.ap.freescale.net>
References: <20151104134439.GA4022@linux-4gyl.site>
	<20151104144308.GQ5405@arm.com> <563A24EB.6090106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <563A24EB.6090106-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin, Will,

On Wed, Nov 04, 2015 at 03:31:55PM +0000, Robin Murphy wrote:
>On 04/11/15 14:43, Will Deacon wrote:
>>On Wed, Nov 04, 2015 at 09:44:40PM +0800, Peng Fan wrote:
>>>Hi Will,
>>
>>Hello,
>>
>>>I am trying to enable SMMU(mmu500) on an platform.
>>>My platform support only 32 SIDs, but it have more than 100 masters.
>
>Do you mean the MMU-500 configuration really only has 5 bits of
>stream ID wired up (which seems a bit unlikely, especially given that
>in such a configuration you should gain extra bits from the prepended
>TBU number), or that you have a sufficient number of stream ID bits
>but only have 32 stream matching groups?

There are 32 Stream matching registers, 32 Contexts. The stream id width
seems to be 10 bits.

>
>>>So I need to let different masters share one SID. I read current
>>>arm-smmu.c, but it needs each master has unique SID. Do you have
>>>some suggestions about how to let different masters sharing one
>>>SID?
>>
>>We can achieve that using iommu_groups, but then we need a way to
>>describe those groups in the device-tree, as opposed to putting
>>each device into its own group like we do at present. Robin (CC'd) had
>>some work-in-progress for this, iirc.
>
>I spent enough time on it that I reached the point of thinking
>there's no feasible DT binding that is sufficiently
>hardware-agnostic, and isn't just trying to paint a Linux
>implementation detail as hardware description - the master IDs are
>already there, so it might as well be up to the thing parsing them to
>work out what, if anything, it wants to do with duplicates.
>
>What I have now is a simple little lookup table solution inside the
>SMMUv2 driver to automatically track groups by stream ID for platform
>devices. I've not yet tried pulling in Joerg's generic group series,
>but I think it's going to slot together really neatly with that, so I
>might try breaking it out of the big stream ID probing rework I'm
>currently half-way through.

Would you mind share me you code? I'd like to try on my platform.

>
>>>On my platform, SID can be dynamically programmed. So I can program
>>>DMA0 and DMA1 using one SID, saying 0x5. But I do not have a good
>>>idea how to support this use case in arm-smmu.c driver.
>>
>>I think we've have the firmware allocating the SIDs, then describing
>>the grouping to Linux in the device-tree.
>
>Yeah, regardless of how we handle groups we need the SIDs to be in
>the DT and not change at runtime, so the programming is going to have
>to be done before the kernel even runs.

Yeah. I programmed the SID in bootloader. When kernel runs, the SID will
not change.


Thanks,
Peng.
>
>Robin.
>
>>
>>Will
>>
>
