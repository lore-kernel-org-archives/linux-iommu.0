From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 10 Jul 2014 15:32:16 -0700
Message-ID: <53BF1470.1000704@codeaurora.org>
References: <4545972.cM7IP1qTXQ@wuerfel> <53A4C0C9.2050908@codeaurora.org>
	<20140624091808.GC26013@arm.com> <53A9BC18.2090106@codeaurora.org>
	<20140624181150.GB4067@arm.com> <53A9EF3A.2070704@codeaurora.org>
	<20140625091858.GG6153@arm.com> <53ADEEDF.7060902@codeaurora.org>
	<20140630095220.GA25779@arm.com> <53BC95DA.1010500@codeaurora.org>
	<20140709105441.GE9485@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140709105441.GE9485-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 7/9/2014 3:54 AM, Will Deacon wrote:
> On Wed, Jul 09, 2014 at 02:07:38AM +0100, Olav Haugan wrote:
>> On 6/30/2014 2:52 AM, Will Deacon wrote:
>>> On Fri, Jun 27, 2014 at 11:23:27PM +0100, Olav Haugan wrote:
>>>> Lets say I have an IOMMU with 2 masters and 2 SMRn slots with the
>>>> following stream IDs coming from the masters:
>>>>
>>>> Master 1: 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28
>>>> Master 2: 0x30
>>>>
>>>> To make this work I would program SMR[0] with StreamID 0x20 and mask 0xF
>>>> to ignore lower 4 bits. SMR[1] would just be StreamID 0x30 with mask 0x0.
>>>>
>>>> However, I could also have an IOMMU with 2 masters and 9 SMRn slots with
>>>> the following stream IDs:
>>>>
>>>> Master 1: 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28
>>>> Master 2: 0x29
>>>>
>>>> Here I would program all SMRn and leave the mask to be 0 for all SMRn's.
>>>> So how do I detect when to apply a mask or not?
>>>
>>> You would aim to use the smallest number of SMRs per master possible.
>>> You could probably use:
>>>
>>>   Master 1: SMR[0].id == 0x20, SMR[0].mask = 0x07
>>>             SMR[1].id == 0x28, SMR[1].mask = 0x00
>>>
>>>   Master 2: SMR[2].id == 0x29, SMR[2].mask = 0x00
>>
>> So how does an algorithm figure this out in both my examples? The
>> algorithm would have to know about both (all) bus masters and their
>> stream IDs for a specific SMMU. If the algorithm operates on the set of
>> stream IDs for one bus master at a time the algorithm has no way of
>> knowing which bits can be ignored since it doesn't know the value of the
>> other stream IDs for the other bus masters and thus could potentially
>> create a mask that could cause a stream ID to match in two different
>> entries.
> 
> Complete knowledge of the system topology (i.e. all bus masters) is a
> requirement for being able to configure the SMMU correctly if you want to
> guarantee that you don't have SMR aliasing issues.

So you agree that an algorithm needs to know about all the bus
masters/stream IDs for a specific IOMMU before it can figure out the
StreamID masks and how many SMRs can be allocated to a specific bus
master? Andreas's algorithm does not know about the other bus
masters/stream IDs. It operates on one bus master at a time.

>>>> I am not familiar with Andreas's proposal. Do you have a link?
>>>
>>>   http://marc.info/?l=linux-arm-kernel&m=139110598005846&w=2
>>
>> Unless I am mistaken the algorithm works on one bus master at a time. I
>> don't think that will work.
> 
> IIRC, it works for densely packed SIDs on the master, so it tries to build
> up power-of-2 sized groups for that master then mops up the rest with
> individual entries.

I ran the algorithm through a few trivial cases:

1)
Stream IDs: 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28
Number of SMRs: 9

In this case the algorithm decided to set mask to 0 for all entries
using up 8 of the SMRs.

2) Same Stream IDs but only 2 SMRs.
The algorithm gave an error saying I did not have enough SMRs.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
