From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V3 7/8] arm/arm64: dma-mapping: Call iommu's remove_device callback during device detach
Date: Thu, 27 Oct 2016 10:46:45 +0530
Message-ID: <005301d23011$53e74b50$fbb5e1f0$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org> <1475600632-21289-8-git-send-email-sricharan@codeaurora.org> <2873304f-8b2e-b519-b3e6-d2b452b1df60@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2873304f-8b2e-b519-b3e6-d2b452b1df60@arm.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Robin Murphy' <robin.murphy@arm.com>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>> dma_deconfigure calls arch_teardown_dma_ops in the device_detach path,
>> which is called when the device gets detached from the driver.
>> When the device was added, iommu's add_device callback was used to
>> add the device in to its iommu_group and setup the device to be ready
>> to use its iommu. Similarly, call remove_device callback to remove the
>> device from the group and reset any other device's iommu configurations.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/mm/dma-mapping.c   | 8 ++++++++
>>  arch/arm64/mm/dma-mapping.c | 7 +++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index b9191f0..cbe22de 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -2289,11 +2289,19 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>  static void arm_teardown_iommu_dma_ops(struct device *dev)
>>  {
>>  	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
>> +	const struct iommu_ops *ops;
>>
>>  	if (!mapping)
>>  		return;
>>
>>  	__arm_iommu_detach_device(dev);
>> +
>> +	if (dev->iommu_fwspec) {
>> +		ops = dev->iommu_fwspec->ops;
>> +		if (ops->remove_device)
>> +			ops->remove_device(dev);
>> +	}
>> +
>
>Yuck. It's a little unfortunate that we have to do this at all, but I
>see why. Still, it should be done in common code, not duplicated across
>arch code, not least for symmetry with where the matching add_device
>happened (although I think of_dma_deconfigure() would suffice, I'm not
>sure we really need to add an of_iommu_deconfigure() just for this).
>

 So one way is its already called via a the BUS_NOTIFY_REMOVED_DEVICE
 notifier in iommu_bus_notifier. I put it here, one for symmetry and
 another thinking that the remove_device callback should be done
 before the dma_ops is set to NULL. If thats not required then the existing
 iommu_bus_notifier itself can do the cleanup. The corresponding
 add_device in that notifier is dummy now, i will add a patch to remove
 that. If not the whole thing, we can add of_iommu_deconfigure as well.

>It's also broken for IOMMU drivers which rely on the
>of_iommu_configure() mechanism but have not yet been converted to use
>iommu_fwspec (Exynos, MSM, etc.)
>

 I did this, because fwspec was the right way to get ops in the future,
 but yes its getting broken for those which are not converted,
 will have to use dev->bus->iommu_ops in those cases. Will address this
 while changing the above.

Regards,
 Sricharan

 
