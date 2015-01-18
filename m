From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Sun, 18 Jan 2015 15:54:34 +0900
Message-ID: <54BB58AA.5070407@nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<20150115082843.GB30799@ulmo> <20150115111211.GF23475@arm.com>
	<2804479.ZFl06ysk3j@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2804479.ZFl06ysk3j@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
>> On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
>>> On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
>>>> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
>>> [...]
>>>
>>>>> 2) Say you want to use the IOMMU API in your driver, and have an iommu
>>>>> property in your device's DT node. If by chance your IOMMU is
>>>>> registered early, you will already have a mapping automatically
>>>>> created even before your probe function is called. Can this be
>>>>> avoided? Is it even safe?
>>>>
>>>> Currently, I think you have to either teardown the ops manually or
>>>> return an error from of_xlate. Thierry was also looking at this sort of
>>>> thing, so it might be worth talking to him.
>>>
>>> I already explained in earlier threads why I think this is a bad idea.
>>> It's completely unnatural for any driver to manually tear down something
>>> that it didn't want set up in the first place. It also means that you
>>> have to carefully audit any users of these IOMMU APIs to make sure that
>>> they do tear down. That doesn't sound like a good incremental approach,
>>> as evidenced by the breakage that Alex and Heiko have encountered.
>>
>> Well, perhaps we hide that behind a get_iommu API or something. We *do*
>> need this manual teardown step to support things like VFIO, so it makes
>> sense to reuse it for other users too imo.
>>
>>> The solution for me has been to completely side-step the issue and not
>>> register the IOMMU with the new mechanism at all. That is, there's no
>>> .of_xlate() implementation, which means that the ARM DMA API glue won't
>>> try to be smart and use the IOMMU in ways it's not meant to be used.
>
> That will break when someone will want to use the same IOMMU type for devices
> that use the DMA mapping API to hide the IOMMU. That might not be the case for
> your IOMMU today, but it's pretty fragile, we need to fix it.
>
>>> This has several advantages, such as that I can also use the regular
>>> driver model for suspend/resume of the IOMMU, and I get to enjoy the
>>> benefits of devres in the IOMMU driver. Probe ordering is still a tiny
>>> issue, but we can easily solve that using explicit initcall ordering
>>> (which really isn't any worse than IOMMU_OF_DECLARE()).
>>
>> That's a pity. I'd much rather extend what we currently have to satisfy
>> your use-case. Ho-hum.
>
> Assuming we want the IOMMU to be handled transparently for the majority of
> devices I only see two ways to fix this,
>
> The first way is to create a default DMA mapping unconditionally and let
> drivers that can't live with it tear it down. That's what is implemented
> today.

I strongly support Thierry's point that drivers should not have to tear 
down things they don't need. The issue we are facing today is a very 
good illustration of why one should not have to do this.

Everybody hates to receive unsollicited email with a link that says "to 
unsubscribe, click here". Let's not import that unpleasant culture into 
the kernel.

I am arriving late in this discussion, but what is wrong with asking 
drivers to explicitly state that they want the DMA API to be backed by 
the IOMMU instead of forcibly making it work that way?

>
> The second way is to implement a mechanism to let drivers signal that they
> want to handle DMA mappings themselves. As the mappings need in the general
> case to be created before the probe function  is called

Sorry for being ignorant here, but why is that?

 > we can't signal this by
> calling a function in probe(). A new flag field for struct device_driver is a
> possible solution. This would however require delaying the creation of DMA
> mappings until right before probe time. Attaching to the IOMMU could be pushed
> to right before probe() as well, which would have the added benefit of making
> IOMMU driver implementable as real platform drivers.

Keeping the ability to write IOMMU drivers as platform drivers would be 
nice indeed.

The problem with the opt-out flag though is that one will need to check 
every single driver out there to see whether it stills behave correctly 
if its hardware is suddently put behind a IOMMU. Doing it the other way 
(a flag that enables IOMMU if available) sounds safer to me.

What we have right now is a mechanism that basically makes it impossible 
to use the DMA API on many ARM platforms if ARM_DMA_USE_IOMMU is set 
(and I suspect it would also make the IOMMU unusable as well, without 
any way to fix things). This is quite concerning.

Even more concerning is that -rc5 is about to be released and we have 
in-tree drivers (Rockchip DRM) that are not working as they should 
because of this patch. Will, what is your plan to fix this? Do we have 
stuff that absolutely depends on this patch? If not, can we just revert 
it until all these issues are solved?
