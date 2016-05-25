From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Wed, 25 May 2016 22:19:29 +0530
Message-ID: <000901d1b6a5$6dcd5f90$49681eb0$@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
	<14302911.qQPb4UMJ8d@wuerfel>
	<004c01d1b688$0f6379c0$2e2a6d40$@codeaurora.org>
	<7715835.BXgVNoY5UO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7715835.BXgVNoY5UO@wuerfel>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

>> >* On other platforms, polling the register is likely required because
>> >  an MMIO write is "posted", meaning that a sync after writel() will
>> >  only ensure that it has left the CPU write queue, but it may still be
>> >  on the bus fabric and whatever side-effects are triggered by the
>> >  write are normally not guaranteed to be completed even after the
>> >  'sync'. You need to check the datasheet for your IOMMU to find out
>> >  whether the 'dsb' instruction actually has any effect on the IOMMU.
>> >  If not, then neither the barrier that you add here nor the barrier
>> >  in the following writel() is sufficient.
>> >
>>    Thanks for the detailed explanation.
>> i will check this. So with this, i think that if the iommu does not
>>  support polling for its status, then it should listen to 'dsb' otherwise
>>  there will no be no way of make it coherent ?
>
>It's more likely that you have to do a readl() after the writel() to
>any address inside of the device in order to ensure the writel()
>has completed, but that is something that the hardware manual for
>the iommu should describe.
>
 ok, get it. So will do it as required for here.

>> >* The one barrier that is normally required in an IOMMU is between
>> >  updating the in-memory page tables and the following MMIO store
>> >  that triggers the TLB flush for that entry. This barrier is
>> >  implied by writel() but not writel_relaxed(). If you don't have
>> >  a hardware page table walker in your IOMMU, you don't need to worry
>> >  about this.
>> >
>>   To get my understanding correct here, is the barrier required here because
>>    of speculative fetch ?
>
>It doesn't have to be a speculative fetch, it could also be a normal
>fetch triggered by a DMA. The point is that the CPU is free to reorder
>the store to (io page table) memory relative to the store to the
>IOMMU flush register, and when you directly follow up with a store to
>the DMA master that triggers a transfer, this transfer can hit the
>IOMMU and cause the stale page table entry to be read.
>
>I guess in practice the barrier that comes before the MMIO write to the
>DMA master would ensure ordering of the DMA after both the IOPTE
>update and the MMIO flush (unless there was the speculative fetch you
>mentioned), but this is where I'm no longer confident enough in my
>pwn understanding of th ordering rules to rely on that. Having the
>barrier between the IOPTE update and the flush certainly leaves
>no room for ambiguity.
    Ok understand. Also i think speculative access if any, should 
     go away if unmap is done first and then remap by clients.

Regards,
 Sricharan
