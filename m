From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 17:03:30 +0000
Message-ID: <611575f4-3e37-1f4d-ef29-94e6f65baf66@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
	<1483479056-15202-2-git-send-email-robdclark@gmail.com>
	<20170105115528.GG679@arm.com> <20170105120857.GB21952@leverpostej>
	<20170105140005.GJ679@arm.com> <20170105140720.GA25868@leverpostej>
	<20170105144742.GK679@arm.com>
	<d1a36cc5-265d-6971-f698-29b8d76e7884@arm.com>
	<20170105160755.GN679@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170105160755.GN679-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/01/17 16:07, Will Deacon wrote:
> On Thu, Jan 05, 2017 at 03:32:50PM +0000, Robin Murphy wrote:
>> On 05/01/17 14:47, Will Deacon wrote:
>>> On Thu, Jan 05, 2017 at 02:07:31PM +0000, Mark Rutland wrote:
>>>> Ok. It would be good to elaborate on what "stalling is useable" means in
>>>> the property description. i.e. what specificallty the implementation and
>>>> integration need to ensure.
>>>
>>> We can describe some of those guarantees in the property description, but
>>> it's difficult to enumerate them exhaustively. For example, you wouldn't
>>> want stalling to lead to data corruption, denial of service, or for the
>>> thing to catch fire, but having those as explicit requirements is a bit
>>> daft. It's also impossible to check that you thought of everything.
>>>
>>> Aside from renaming the option, I'm really after an opinion on whether
>>> it's better to have one property or combine it with the compatible
>>> string, because I can see benefits of both and don't much care either
>>> way.
>>
>> The SMMU implementation side of the decision (i.e. independence of IRQ
>> assertion vs. SS) seems like exactly the sort of stuff the compatible
>> string already has covered. The integration side I'm less confident can
>> be described this way at all - the "this device definitely won't go
>> wrong if stalled for an indefinite length of time" is inherently a
>> per-master thing, so a single property on the SMMU implying that for
>> every device connected to it seems a bit optimistic, and breaks down as
>> soon as you have one device in the system for which that isn't true (a
>> PCI root complex, say), even if that guy's traffic never crosses paths
>> with whichever few devices you actually care about using stalls with.
>>
>> I think this needs to be some kind of "arm,smmu-stall-safe" property
>> placed on individual master device nodes (mad idea: or even an extra
>> cell of flags in the IOMMU specifier) to encapsulate both that the given
>> device itself is OK with being stalled, and that it's integrated in such
>> a way that its stalled transactions cannot disrupt any *other* device
>> (e.g. it has a TBU all to itself). Then upon initialising a context bank
>> on a suitable SMMU implementation, we set CFCFG based on whatever device
>> is being attached to the corresponding domain, and refuse any subsequent
>> attempts to attach a non-stallable device to a stalling domain (and
>> possibly even vice-versa).
> 
> If we're going to add per-master properties, I'd *really* like them to be
> independent of the IOMMU in use. That is, we should be able to re-use this
> property as part of supporting SVM for platform devices in future.

I'd argue that they are still fairly separate things despite the
overlap: stalling is a specific ARM SMMU architecture thing (in both
architectures) which may be used for purposes unrelated to SVM;
conversely SVM implemented via PRI or similar mechanisms should be
pretty much oblivious to the transaction fault model.

> But I think we agree that we need:
> 
>   1. A compatible string for the SMMU that can be used to infer the SS
>      behaviour in the driver
> 
>   2. A property on the SMMU to say that it's been integrated in such a
>      way that stalling is safe (doesn't deadlock)

That's still got to be a per-master property, not a SMMU property, I
think. To illustrate:

  [A]         [B]   [C]
   |           |_____|
 __|______________|___
| TBU |        | TBU |
|_____|  SMMU  |_____|
|__|______________|__|
   |              |

Say A and B are instances of some device happy to be stalled, and C is a
PCIe RC, and each is attached to their own context bank - enabling
stalls for A is definitely fine. However even though B and C are using
different context banks, enabling stalls for B might deadlock C if it
results in more total outstanding transactions than the TBU's slave port
supports. Therefore A can happily claim to be stall-safe, but B cannot
due to its integration with respect to C.

And yes, I can point you at some existing hardware which really does
posess a topology like that.

>   3. A generic master property that says that the device can DMA to
>      unpinned memory

That sounds a bit *too* generic to me, given that there are multiple
incompatible ways that could be implemented. I'm not the biggest fan of
properties with heavily context-specific interpretations, especially
when there's more than a hint of software implementation details in the mix.

Robin.

> 
> Anything else?
> 
> Will
> 
