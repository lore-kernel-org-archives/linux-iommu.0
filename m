From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Wed, 25 May 2016 18:49:18 +0530
Message-ID: <004c01d1b688$0f6379c0$2e2a6d40$@codeaurora.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org> <7555154.mU2oTAdECP@wuerfel> <000a01d1b672$93d54690$bb7fd3b0$@codeaurora.org> <14302911.qQPb4UMJ8d@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <14302911.qQPb4UMJ8d@wuerfel>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, robdclark@gmail.com, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

>> Ok, so i was doing this from the idea that, other iommu drivers
>>  where polling on a status bit in their sync call to ensure completion
>> of pending TLB invalidations. But in this case, there is no status bit.
>>  So added a barrier to have no ordering issues before the client
>> triggers the dma operation. But as you say above that it is implicit that
>> the device would have a barrier before starting the trigger, then the
>> barrier here becomes redundant.
>
>Ok. There are two more things to note here:
>
>* On other platforms, polling the register is likely required because
>  an MMIO write is "posted", meaning that a sync after writel() will
>  only ensure that it has left the CPU write queue, but it may still be
>  on the bus fabric and whatever side-effects are triggered by the
>  write are normally not guaranteed to be completed even after the
>  'sync'. You need to check the datasheet for your IOMMU to find out
>  whether the 'dsb' instruction actually has any effect on the IOMMU.
>  If not, then neither the barrier that you add here nor the barrier
>  in the following writel() is sufficient.
>
   Thanks for the detailed explanation.
i will check this. So with this, i think that if the iommu does not
 support polling for its status, then it should listen to 'dsb' otherwise
 there will no be no way of make it coherent ?

>* The one barrier that is normally required in an IOMMU is between
>  updating the in-memory page tables and the following MMIO store
>  that triggers the TLB flush for that entry. This barrier is
>  implied by writel() but not writel_relaxed(). If you don't have
>  a hardware page table walker in your IOMMU, you don't need to worry
>  about this.
>
  To get my understanding correct here, is the barrier required here because
   of speculative fetch ?

Regards,
 Sricharan
