From: "David Woodhouse" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH] x86: Allow IOMMU drivers to Hook arch_setup_dma_ops()
Date: Mon, 31 Oct 2016 18:06:26 -0000
Message-ID: <e7649392eaae9867fbd0b5d80efb6e07.squirrel@twosheds.infradead.org>
References: <1477854889.14501.6.camel@woodhou.se>
	<a95e5fb2-3f5d-5334-c62d-e4b99a52adcb@arm.com>
	<1477924491.14501.16.camel@infradead.org>
	<d2b36234-df39-da1c-08cb-d85a953d703b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d2b36234-df39-da1c-08cb-d85a953d703b-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


>> So dma_ops can go back to being a platform-wide thing; it's only the
>> IOMMU ops which are different per device.
>
> Well, in our case we'll probably never escape the kind of nutty SoC
> topologies where only some devices are behind IOMMUs (which might
> themselves be heterogeneous), only some are coherent, etc., but if you
> don't have to deal with that then dma_ops indeed become nice and easy.


But that is all handled through the per-device IOMMU ops, surely? You can
still have a generic dma_ops implementation that just uses the IOMMU ops
and falls back to 1:1 or swiotlb if there is no IOMMU for that device.

>>>> And IOMMU ops should be per-device of course, not per-bus. But this is
>>>> a start...
>>> As it happens, that was one of the additional motivations for
>>> introducing the new iommu_fwspec - see [3] for my take on the matter.
>>
>> Right... in my case I don't actually need iommu_ops to change. We have
>> multiple IOMMUs of the same type, and we don't have a *separate* ops
>> structure for each of them.
>>
>> What we *do* need to change is the iommu-private data pointer, which
>> indicates specifically which DMAR unit is being used.
>>
>> That's currently kept in dev->archdata but with assumptions that the
>> device->IOMMU mapping is only done when the domain is first set up, so
>> it needs to be redone either with a new field in dev->archdata or some
>> additional complexity.
>>
>> Rather than a new field in archdata.... should we make this a generic
>> iommu_priv pointer living next to iommu_ops in the device structure?
>>
>> Could you use that?
>
> As far as I can tell from looking through the x86 drivers, you should
> already be good to go to convert the likes of device_to_iommu() and the
> equivalent AMD lookup tables over to a one-off initialisation of
> dev->iommu_fwspec and stashing stuff in iommu_fwspec::iommu_priv and
> iommu_fwspec::ids as appropriate. I just didn't dare try writing the
> patches myself...

Yeah, I was looking at that. Can probably work if we fix it so we can pass
a NULL fwnode to iommu_fwspec_init(), and/or not assume that fwnode is OF.


-- 
dwmw2
