From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
	mapping
Date: Wed, 30 May 2018 14:30:51 +0100
Message-ID: <856db04f-592c-1618-36a8-100808693813@arm.com>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
	<20180530080345.2353-3-thierry.reding@gmail.com>
	<7960e4fc-f680-f8d1-0c5a-3ff1e13b3154@arm.com>
	<20180530130045.GB1595@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180530130045.GB1595@ulmo>
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

On 30/05/18 14:00, Thierry Reding wrote:
> On Wed, May 30, 2018 at 11:30:25AM +0100, Robin Murphy wrote:
>> On 30/05/18 09:03, Thierry Reding wrote:
>>> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> Depending on the kernel configuration, early ARM architecture setup code
>>> may have attached the GPU to a DMA/IOMMU mapping that transparently uses
>>> the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
>>> backed buffers (a special bit in the GPU's MMU page tables indicates the
>>> memory path to take: via the SMMU or directly to the memory controller).
>>> Transparently backing DMA memory with an IOMMU prevents Nouveau from
>>> properly handling such memory accesses and causes memory access faults.
>>>
>>> As a side-note: buffers other than those allocated in instance memory
>>> don't need to be physically contiguous from the GPU's perspective since
>>> the GPU can map them into contiguous buffers using its own MMU. Mapping
>>> these buffers through the IOMMU is unnecessary and will even lead to
>>> performance degradation because of the additional translation. One
>>> exception to this are compressible buffers which need large pages. In
>>> order to enable these large pages, multiple small pages will have to be
>>> combined into one large (I/O virtually contiguous) mapping via the
>>> IOMMU. However, that is a topic outside the scope of this fix and isn't
>>> currently supported. An implementation will want to explicitly create
>>> these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
>>> mapping would still be required.
>>
>> I wonder if it might make sense to have a hook in iommu_attach_device() to
>> notify the arch DMA API code when moving devices between unmanaged and DMA
>> ops domains? That seems like it might be the most low-impact way to address
>> the overall problem long-term.
>>
>>> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>> Changes in v3:
>>> - clarify the use of IOMMU mapping for compressible buffers
>>> - squash multiple patches into this
>>>
>>>    drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
>>> index 78597da6313a..d0538af1b967 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
>>> @@ -105,6 +105,11 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
>>>    	unsigned long pgsize_bitmap;
>>>    	int ret;
>>> +#if IS_ENABLED(CONFIG_ARM)
>>
>> Wouldn't CONFIG_ARM_DMA_USE_IOMMU be even more appropriate?
> 
> Not necessarily. arm_dma_iommu_detach_device() is always defined on ARM,
> only with CONFIG_ARM_DMA_USE_IOMMU=n it will be empty. So this check is
> a guard to make sure we don't call the function when it isn't available,
> but it may still not do anything.

Calling a function under condition A, which only does anything under 
condition B, when B depends on A, is identical in behaviour to only 
calling the function under condition B, except needlessly harder to follow.

>>> +	/* make sure we can use the IOMMU exclusively */
>>> +	arm_dma_iommu_detach_device(dev);
>>
>> As before, I would just use the existing infrastructure the same way the
>> Exynos DRM driver currently does in __exynos_iommu_attach() (albeit without
>> then reattaching to another DMA ops mapping).
> 
> That's pretty much what I initially did and which was shot down by
> Christoph. As I said earlier, at this point I don't really care what
> color the shed will be. Can you and Christoph come to an agreement
> on what it should be?

What I was getting at is that arm_iommu_detach_device() already *is* the 
exact function Christoph was asking for, it just needs a minor fix 
instead of adding explicit set_dma_ops() fiddling at its callsites which 
only obfuscates the fact that it's supposed to be responsible for 
resetting the device's DMA ops already.

Robin.
