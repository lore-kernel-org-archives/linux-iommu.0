From: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH] ARM: dma-mapping: Don't tear third-party mappings
Date: Wed, 17 May 2017 17:06:54 +0530
Message-ID: <d632aac259f4798d8eadb80480419bcc@codeaurora.org>
References: <6d9fa319-4401-c47a-7985-9a349838bcaf@arm.com>
	<20170516151434.18830-1-laurent.pinchart+renesas@ideasonboard.com>
	<2602abb1-e777-700c-bc95-14e576372537@arm.com>
	<4043121.T8QnJes2jP@avalon>
	<d27036e0-4be0-cfdd-f139-619c5adc05b0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d27036e0-4be0-cfdd-f139-619c5adc05b0-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2017-05-17 10:45, Sricharan R wrote:
> Hi Laurent/Robin,
> 
> On 5/16/2017 10:14 PM, Laurent Pinchart wrote:
>> Hi Robin,
>> 
>> On Tuesday 16 May 2017 16:47:36 Robin Murphy wrote:
>>> On 16/05/17 16:14, Laurent Pinchart wrote:
>>>> arch_setup_dma_ops() is used in device probe code paths to create an
>>>> IOMMU mapping and attach it to the device. The function assumes that 
>>>> the
>>>> device is attached to a device-specific IOMMU instance (or at least 
>>>> a
>>>> device-specific TLB in a shared IOMMU instance) and thus creates a
>>>> separate mapping for every device.
>>>> 
>>>> On several systems (Renesas R-Car Gen2 being one of them), that
>>>> assumption is not true, and IOMMU mappings must be shared between
>>>> multiple devices. In those cases the IOMMU driver knows better than 
>>>> the
>>>> generic ARM dma-mapping layer and attaches mapping to devices 
>>>> manually
>>>> with arm_iommu_attach_device(), which sets the DMA ops for the 
>>>> device.
>>>> 
>>>> The arch_setup_dma_ops() function takes this into account and bails 
>>>> out
>>>> immediately if the device already has DMA ops assigned. However, the
>>>> corresponding arch_teardown_dma_ops() function, called from driver
>>>> unbind code paths (including probe deferral), will tear the mapping 
>>>> down
>>>> regardless of who created it. When the device is reprobed
>>>> arch_setup_dma_ops() will be called again but won't perform any
>>>> operation as the DMA ops will still be set.
>>>> 
>>>> We need to reset the DMA ops in arch_teardown_dma_ops() to fix this.
>>>> However, we can't do so unconditionally, as then a new mapping would 
>>>> be
>>>> created by arch_setup_dma_ops() when the device is reprobed, 
>>>> regardless
>>>> of whether the device needs to share a mapping or not. We must thus 
>>>> keep
>>>> track of whether arch_setup_dma_ops() created the mapping, and only 
>>>> in
>>>> that case tear it down in arch_teardown_dma_ops().
>>>> 
>>>> Keep track of that information in the dev_archdata structure. As the
>>>> structure is embedded in all instances of struct device let's not 
>>>> grow
>>>> it, but turn the existing dma_coherent bool field into a bitfield 
>>>> that
>>>> can be used for other purposes.
>>>> 
>>>> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with 
>>>> deferred
>>>> probing or error") Signed-off-by: Laurent Pinchart
>>>> <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> ---
>>>> 
>>>>  arch/arm/include/asm/device.h | 3 ++-
>>>>  arch/arm/mm/dma-mapping.c     | 5 +++++
>>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/arch/arm/include/asm/device.h 
>>>> b/arch/arm/include/asm/device.h
>>>> index 36ec9c8f6e16..3234fe9bba6e 100644
>>>> --- a/arch/arm/include/asm/device.h
>>>> +++ b/arch/arm/include/asm/device.h
>>>> @@ -19,7 +19,8 @@ struct dev_archdata {
>>>>  #ifdef CONFIG_XEN
>>>>  	const struct dma_map_ops *dev_dma_ops;
>>>>  #endif
>>>> -	bool dma_coherent;
>>>> +	unsigned int dma_coherent:1;
>>> 
>>> This should only ever be accessed by the Xen DMA code via the
>>> is_device_dma_coherent() helper, so I can't see the change of storage
>>> type causing any problems.
>> 
>> Thank you for double-checking. I agree with your analysis.
>> 
>>>> +	unsigned int dma_ops_setup:1;
>>>>  };
>>>> 
>>>>  struct omap_device;
>>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>>> index c742dfd2967b..e0272f9140e2 100644
>>>> --- a/arch/arm/mm/dma-mapping.c
>>>> +++ b/arch/arm/mm/dma-mapping.c
>>>> @@ -2430,9 +2430,14 @@ void arch_setup_dma_ops(struct device *dev, 
>>>> u64
>>>> dma_base, u64 size,
>>>>  		dev->dma_ops = xen_dma_ops;
>>>>  	}
>>>>  #endif
>>>> +	dev->archdata.dma_ops_setup = true;
>>>>  }
>>>> 
>>>>  void arch_teardown_dma_ops(struct device *dev)
>>>>  {
>>>> +	if (!dev->archdata.dma_ops_setup)
>>>> +		return;
>>>> +
>>>>  	arm_teardown_iommu_dma_ops(dev);
>>>> +	set_dma_ops(dev, NULL);
>>> 
>>> Should we clear dma_ops_setup here for symmetry? I guess in practice
>>> it's down to the IOMMU driver so will never change after the first
>>> probe, but it still feels like a bit of a nagging loose end.
>> 
>> To make a difference, we would need an IOMMU driver that creates a 
>> mapping
>> after a first round of arch_setup_dma_ops() / arch_teardown_dma_ops() 
>> calls,
>> follow by a second round. I don't think this could happen, but if it 
>> did, I
>> believe we'd be screwed already, as there would be a time were an 
>> incorrect
>> mapping (created by arch_setup_dma_ops() while the IOMMU driver needs 
>> to take
>> care of mapping creation) exists.
>> 
> 
> Feels correct not to reset this, the iommu drivers in question, seems 
> to
> creating mapping/attaching in add_device path (which gets called before 
> the
> clients gets probed) and when the iommu client gets deferred/reprobed 
> that
> does not happen again even after the first round.

Please ignore the above comment. I said that because I was doing the
dma_ops_setup in arm_iommu_attach_device. I posted the three fixes now 
[1].
Accidentally removed you from CC, sorry for that.
Applied those patches on top of 8674/1 that Robin mentioned
below. So removed setting set_dma_ops(dev, NULL) from your patch.

Also please note that, I changed the Fixes: commit msg in your patch to
("of/acpi: Configure dma operations at probe time for platform/amba/pci 
bus devices")
because that was one which started to invoke the teardown on the driver
release path.

[1] https://lkml.org/lkml/2017/5/17/344

Regards,
  Sricharan


> 
>>> With that (or firm reassurance that it's OK not to),
>>> 
>>> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> 
>>> Apologies for being too arm64-focused in the earlier reviews and
>>> overlooking this. Should the patch supersede 8674/1 currently in
>>> Russell's incoming box?
>> 
>> Yes I think it should. Could you please take care of that ?
>> 
>> You can also add my
>> was
>> Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>> 
>> as I've tested that this paptch restores proper IOMMU operation on the 
>> Renesas
>> R-Car H2 Lager board. I believe the problem related to Sricharan's 
>> patch
>> reported by Geert still affects us and needs to be addressed 
>> separately.
> 
> Thanks for the above, i had the same thing to be posted, was just
> testing it once.
> There are three patches [1][2], already posted and third one for the
> issue that Geert
> pointed i did below (Geert had a patch little differently to ignore 
> -ENODEV).
> I had this question previously for not propagating errors apart from
> EPROBE_DEFER,
> did not have an issue reported at that time. Anyways if the below is 
> ok, i will
> just send the 3 patches in one set for easy picking up ?
> 
> [1] https://lkml.org/lkml/2017/5/16/25
> [2] The above one that you have.
> [3] The below one, if its fine ?
> 
> From 4b379d4b852c41d7b5904c9a9e53deda94039f0a Mon Sep 17 00:00:00 2001
> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Date: Wed, 3 May 2017 14:54:11 +0530
> Subject: [PATCH] of: iommu: Ignore all errors except EPROBE_DEFER
> 
> While deferring the probe of iommu masters,
> xlate and add_device callback can passback error values
> like -ENODEV, which means iommu cannot be connected
> with that master for real reasons. So rather than
> killing the master's probe for such errors, just
> ignore the errors and let the master work without
> an iommu.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e6e9bec..750ab07 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -237,6 +237,10 @@ const struct iommu_ops *of_iommu_configure(struct
> device *dev,
>                         ops = ERR_PTR(err);
>         }
> 
> +       /* Ignore all other errors apart from EPROBE_DEFER */
> +       if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER))
> +               ops = NULL;
> +
>         return ops;
>  }
> 
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 
> 
>> 
