From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
Date: Thu, 13 Sep 2018 10:02:11 +0800
Message-ID: <5B99C523.7060704@huawei.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
	<20180912165700.GC16071@arm.com>
	<d0775377-206f-ae3e-051d-3b829b499471@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d0775377-206f-ae3e-051d-3b829b499471-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: LinuxArm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2018/9/13 1:12, Robin Murphy wrote:
> On 12/09/18 17:57, Will Deacon wrote:
>> Hi all,
>>
>> On Wed, Aug 15, 2018 at 09:28:25AM +0800, Zhen Lei wrote:
>>> v4 -> v5:
>>> 1. change the type of global variable and struct member named "non_strict" from
>>>     "int" to "bool".
>>> 2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
>>>     in v4.
>>> 3. change boot option "arm_iommu" to "iommu.non_strict".
>>> 4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
>>>     non-leaf unmaps still need to be synchronous.
>>>
>>> Thanks for Robin's review comments.
>>
>> Since this is 90% of the way there now, I suggest Robin picks up what's here
>> and incorporates his remaining review comments directly (especially since it
>> sounded like Zhen Lei hasn't got much free time lately). With that, I can
>> queue this lot via my smmu branch, which already has some stuff queued
>> for SMMUv3 and io-pgtable.
>>
>> Please shout if you have any objections, but I'm keen for this not to
>> languish on the lists given how close it is!
> 
> Sure, having got this far I'd like to see it get done too. I'll make some time and give it a go.

Thank you very much.

I've been too busy lately, at least I still have no time this week, I also think it's been too long.

So sorry and thanks again.

> 
> Robin.
> 
> .
> 

-- 
Thanks!
BestRegards
