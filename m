From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: bus_notifier registers platform IOMMU
 devices
Date: Mon, 10 Dec 2012 10:43:17 -0700
Message-ID: <50C61F35.9050702@wwwdotorg.org>
References: <1354646264-12126-1-git-send-email-hdoyu@nvidia.com><50BFB88C.8080901@wwwdotorg.org> <20121207.121205.1712068640752315024.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121207.121205.1712068640752315024.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 12/07/2012 03:12 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 5 Dec 2012 22:11:40 +0100:
> 
>> On 12/04/2012 11:37 AM, Hiroshi Doyu wrote:
>>> Most of platform devices are IOMMU'able in Tegra30 SoC. Registering
>>> all IOMMU'able devices manually isn't nice. This patch allows
>>> platform bus_notifier to register IOMMU devices. Map info can be
>>> passed from DT. Info format is:
>>>
>>>   dma-window = <0 0x40000000>;
>>>
>>> TODO:
>>> A map can be shared with mutiple devices. This info also could be
>>> passed from DT or default map can be set in advance.
>>
>>> +static int tegra_smmu_device_notifier(struct notifier_block *nb,
>>> +				      unsigned long event, void *_dev)
>>
>>> +	switch (event) {
>>> +	case BUS_NOTIFY_ADD_DEVICE:
>>> +		err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base,
>>> +					&size);
>>> +		if (!err)
>>> +			map = arm_iommu_create_mapping(&platform_bus_type,
>>> +						       base, size, 0);
>>
>> So, this ends up attempting to hook up the Tegra SMMU for /any/ node on
>> a platform bus that has a dma-window property. That seems a little
>> dangerous. I guess it's not true for Tegra30, but what if there are
>> multiple buses on the SoC, each with a separate IOMMU - using this
>> approach would mean the two IOMMU drivers end up fighting to register
>> mappings for devices on each-others buses.
>>
>> I think the solution here is one of:
>>
>> a) Explicitly represent the bus structure in DT (something we don't do
>> on Tegra at present), and have the bus itself indicate which IOMMU
>> device is the IOMMU for that bus.
> 
> AHB/APB/PPSB bus don't do much currently. New bus drivers for them
> would be used just for device registration. I'm not so sure if this
> direction is right or not. Could they live with the existing
> platfrom_driver? Any example would be appreciated if any.

I wasn't really thinking of creating a whole new driver for the bus; the
existing simple-bus will automatically enumerate/instantiate all its
children, and hence allow describing (at least part of) the SoC bus
structure without writing any additional code. This appears to be used
quite a bit already in arch/arm/boot/dts/*.

...
>> Probably, devices should not be registered until the IOMMU that serves
>> them is available. Otherwise, can't a device probe, start making IO
>> accesses using a physical/bus memory map, and then later have that
>> yanked out and replaced by the IOMMU'd memory map. How is that
>> co-ordinated? That somewhat argues for each device explicitly setting up
>> the IOMMU registration, or the driver core handling the
>> dependencies.
> 
> I think that enabling/disabling IOMMU _tranparently_ to drivers may be
> beneficial basically because we don't want to deal with drivers with
> IOMMU enabled separately from the normal case.
> 
> For dynamic enabling/disabling of IOMMU, *dma_ops in struct
> dev_archdata will be overwritten, and there may be inconsistency for
> the type of dma allocated buffers. Has there been other arch/platfrom
> to handle dynamic enabling/disalbing IOMMU this already, even for each
> drivers?

I don't know.
