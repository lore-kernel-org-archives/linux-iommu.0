From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Wed, 25 May 2016 16:15:31 +0530
Message-ID: <000a01d1b672$93d54690$bb7fd3b0$@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org> <3164695.VzCnHHyi7r@wuerfel> <000601d1b4b9$119c2410$34d46c30$@codeaurora.org> <7555154.mU2oTAdECP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <7555154.mU2oTAdECP@wuerfel>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, robdclark@gmail.com, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

<snip..>

>> I had measured the numbers only for the full usecase path, not for the
>> reset path alone. I saw improvement of about 5% on full numbers.
>> As you said, the reset path would be called only less often
>> and might not bring a measurable change. I did not see a difference in behavior
>> when changing the sync to happen after the writes.
>
>Ok, then better not change it.
>

Ok.

>> But my understanding was that
>> the sync after the writes was required to ensure write completion.
>
>Can you cite the relevant documentation on this? Is this specific
>to the Qualcomm CPU implementation or the IOMMU? I don't think
>the ARM architecture requires anything like this in general.
>

My explanation was not correct. So the whole reason for doing the
sync here was to make sure that client is going to observe the effect
the of tlb invalidation before starting any dma operation.
But as you have explained below, if it is implicit that any operation
 from a device that could trigger a dma should have an barrier preceding
that, then the a sync here may not be needed.

>
>> >> @@ -181,7 +187,8 @@ fail:
>> >>
>> >>  static void __flush_iotlb_sync(void *cookie)
>> >>  {
>> >> -	/* To avoid a null function pointer */
>> >> +	/* To ensure completion of the TLBIVA in __flush_iotlb_range */
>> >> +	mb();
>> >>  }
>> >
>> >I don't understand the specific race from the comment.
>> >
>> >What operation comes after this that relies on __flush_iotlb_range
>> >having completed, and how does an mb() guarantee this?
>> >
>>
>> The flush_iotlb_range operation invalidates the tlb for writes to
>> pagetable and the finally calls the sync operation to ensure completion
>> of the flush and this is required before returning back to the client
>> of the iommu. In the case of this iommu, only a barrier is required to
>> ensure completion of the invalidate operation.
>
>This doesn't answer my question: What operation would a client do
>that requires the flush to be completed here? A barrier is always
>defined in terms of things that come before it in combination with
>things that come after it.
>
>Any operation that could trigger a DMA from a device is required
>to have a barrier preceding it (usually wmb() one implied by writel()),
>so this is clearly not about a driver that installs a DMA mapping
>before starting a DMA, but I don't see what else it would be.
>

Ok, so i was doing this from the idea that, other iommu drivers
 where polling on a status bit in their sync call to ensure completion
of pending TLB invalidations. But in this case, there is no status bit.
 So added a barrier to have no ordering issues before the client
triggers the dma operation. But as you say above that it is implicit that
the device would have a barrier before starting the trigger, then the
barrier here becomes redundant.

<snip..>

>> >In this case, I'd say it's better to rewrite the function to avoid the
>> >read: iova_to_phys() should be fast, and not require hardware access.
>> >Getting rid of the hardware access by using an in-memory cache for
>> >this should gain more than just removing the barriers, as an MMIO read
>> >is always slow
>>
>> Ok, you mean using the software walk through ? I will check on this to measure
>>  the latency difference. If thats true, then the iopgtable ops itself provides a
>> function for iova_to_phys conversion, so that can be used.
>
>I hadn't realized that this is a lookup in the hardware, rather than
>reading a static register. It's probably a good idea to check this
>anyway.

Ok, will measure the difference and have the better one.

Regards,
 Sricharan
