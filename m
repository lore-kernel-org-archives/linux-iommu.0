From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue, 02 Sep 2014 15:11:23 +0200
Message-ID: <5405C1FB.6090009@samsung.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<3261702.HRSZJsEv5z@wuerfel> <5405B86C.9010704@samsung.com>
	<4561708.C5IqxBT0S9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <4561708.C5IqxBT0S9@wuerfel>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


On 2014-09-02 14:46, Arnd Bergmann wrote:
> On Tuesday 02 September 2014 14:30:36 Marek Szyprowski wrote:
>>>>>> However we also need to figure out how to let drivers to make their own
>>>>>> configuration, like it is required by Exynos DRM subsystem, which consist
>>>>>> of several devices, each having its own IOMMU controller, but for
>>>>>> convenience those drivers assume that they all have been bound to the same,
>>>>>> single domain.
>>>>> IIRC with the way we ended up putting the mask into the iommu descriptor of
>>>>> the ARM SMMU, you can put multiple devices into the same iommu group, and
>>>>> have them automatically share a domain.
>>>>>
>>>>> I don't know if the same would work for the Samsung implementation.
>>>> The question is how to transfer such information from the device
>>>> drivers, that
>>>> need/benefit from such configuration to iommu driver, which does all the
>>>> setup?
>>>> This is something completely internal to particular drivers and should
>>>> not be
>>>> exported to device tree or userspace. Thierry suggested to hardcode this
>>>> information in the iommu driver, but I'm looking for other approaches.
>>>> Maybe simply releasing device from the default dma-mapping domain before
>>>> attaching to custom one will be the easiest solution.
>>> For the ARM SMMU, the problem is that there is not necessarily a good way
>>> to partition the masters into IOMMU groups automatically, therefore we
>>> want to provide some hints in DT. On a machine that can have more domains
>>> than it has masters, this is not a problem and we can always use an
>>> all-ones mask, but for a machine on which this is not the case, the
>>> problem is simplified a lot of we hardcode the masks in a way that can
>>> always work, putting multiple devices into an iommu group if necessary.
>> Well, I was talking about the Exynos IOMMU case, where there are no hw
>> restrictions and grouping is done just to make things easier for the Exynos
>> DRM drivers (a buffer gets the same DMA address for all devices, which
>> are a part of virtual Exynos DRM device).
> Does that mean you don't actually need to use multiple contexts here and
> could actually just use the normal dma-mapping interface if there is
> a way to ensure the mappings are always shared across these masters?

Well, a default, shared single domain for dma-mapping interface will work
with Exynos DRM and its multiple masters, although I never thought about
such configuration.

> Or do you need this in addition to being able to use multiple masters
> so you can have multiple rendering contexts in user space?

Such advanced IO space management is not yet implemented.

However there are also devices (like multimedia codec - exynos mfc and 
camera
capture subsystem exynos isp), which have limited DMA/IO window (256MiB in
case of video codec), so they will still need to use their own separate 
domain.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
