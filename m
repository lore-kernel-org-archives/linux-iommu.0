From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ARM: dma-mapping: Implement
	arm_dma_iommu_detach_device()
Date: Wed, 30 May 2018 14:42:50 +0100
Message-ID: <d3121aeb-1d75-2ba6-681a-f1e0681e290a@arm.com>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
	<20180530080345.2353-2-thierry.reding@gmail.com>
	<eee02391-aa25-da84-f98a-b5fed6c69599@arm.com>
	<20180530125446.GA1595@ulmo> <20180530131239.GA5400@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180530131239.GA5400@ulmo>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 30/05/18 14:12, Thierry Reding wrote:
> On Wed, May 30, 2018 at 02:54:46PM +0200, Thierry Reding wrote:
>> On Wed, May 30, 2018 at 10:59:30AM +0100, Robin Murphy wrote:
>>> On 30/05/18 09:03, Thierry Reding wrote:
>>>> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> Implement this function to enable drivers from detaching from any IOMMU
>>>> domains that architecture code might have attached them to so that they
>>>> can take exclusive control of the IOMMU via the IOMMU API.
>>>>
>>>> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>> Changes in v3:
>>>> - make API 32-bit ARM specific
>>>> - avoid extra local variable
>>>>
>>>> Changes in v2:
>>>> - fix compilation
>>>>
>>>>    arch/arm/include/asm/dma-mapping.h |  3 +++
>>>>    arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
>>>>    arch/arm/mm/dma-mapping.c          | 16 ++++++++++++++++
>>>>    3 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>>>> index 8436f6ade57d..5960e9f3a9d0 100644
>>>> --- a/arch/arm/include/asm/dma-mapping.h
>>>> +++ b/arch/arm/include/asm/dma-mapping.h
>>>> @@ -103,6 +103,9 @@ extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>>>    #define arch_teardown_dma_ops arch_teardown_dma_ops
>>>>    extern void arch_teardown_dma_ops(struct device *dev);
>>>> +#define arm_dma_iommu_detach_device arm_dma_iommu_detach_device
>>>> +extern void arm_dma_iommu_detach_device(struct device *dev);
>>>> +
>>>>    /* do not use this function in a driver */
>>>>    static inline bool is_device_dma_coherent(struct device *dev)
>>>>    {
>>>> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
>>>> index f448a0663b10..eb781369377b 100644
>>>> --- a/arch/arm/mm/dma-mapping-nommu.c
>>>> +++ b/arch/arm/mm/dma-mapping-nommu.c
>>>> @@ -241,3 +241,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>>>    void arch_teardown_dma_ops(struct device *dev)
>>>>    {
>>>>    }
>>>> +
>>>> +void arm_dma_iommu_detach_device(struct device *dev)
>>>> +{
>>>> +}
>>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>>> index af27f1c22d93..6d8af08b3e7d 100644
>>>> --- a/arch/arm/mm/dma-mapping.c
>>>> +++ b/arch/arm/mm/dma-mapping.c
>>>> @@ -2400,3 +2400,19 @@ void arch_teardown_dma_ops(struct device *dev)
>>>>    	arm_teardown_iommu_dma_ops(dev);
>>>>    }
>>>> +
>>>> +void arm_dma_iommu_detach_device(struct device *dev)
>>>> +{
>>>> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
>>>> +	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
>>>> +
>>>> +	if (!mapping)
>>>> +		return;
>>>> +
>>>> +	arm_iommu_release_mapping(mapping);
>>>
>>> Potentially freeing the mapping before you try to operate on it is never the
>>> best idea. Plus arm_iommu_detach_device() already releases a reference
>>> appropriately anyway, so it's a double-free.
>>
>> But the reference released by arm_iommu_detach_device() is to balance
>> out the reference acquired by arm_iommu_attach_device(), isn't it? In
>> the above, the arm_iommu_release_mapping() is supposed to drop the
>> final reference which was obtained by arm_iommu_create_mapping(). The
>> mapping shouldn't go away irrespective of the order in which these
>> will be called.
> 
> Going over the DMA/IOMMU code I just remembered that I drew inspiration
> from arm_teardown_iommu_dma_ops() for the initial proposal which also
> calls both arm_iommu_detach_device() and arm_iommu_release_mapping().
> That said, one other possibility to implement this would be to export
> the 32-bit and 64-bit ARM implementations of arch_teardown_dma_ops()
> and use that instead. linux/dma-mapping.h implements a stub for
> architectures that don't provide one, so it should work without any
> #ifdef guards.
> 
> That combined with the set_dma_ops() fix in arm_iommu_detach_device()
> should fix this pretty nicely.

OK, having a second look at the ARM code I see I had indeed overlooked 
that extra reference held until arm_teardown_iommu_dma_ops() - mea culpa 
- but frankly that looks wrong anyway, as it basically defeats the point 
of refcounting the mapping at all. AFAICS arm_setup_iommu_dma_ops() 
should just be made to behave 'normally' by unconditionally dropping the 
initial reference after calling __arm_iommu_attach_device(), then we 
don't need all these odd and confusing release calls dotted around at all.

Robin.
