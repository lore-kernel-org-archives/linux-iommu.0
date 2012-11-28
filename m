From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU devices(was:
 How to specify IOMMU'able devices in DT)
Date: Wed, 28 Nov 2012 11:07:46 -0700
Message-ID: <50B652F2.5050407@wwwdotorg.org>
References: <20120924124452.41070ed2ee9944d930cffffc@nvidia.com><054901cd9a45$db1a7ea0$914f7be0$%szyprowski@samsung.com><20120924.145014.1452596970914043018.hdoyu@nvidia.com> <20121128.154832.539666140149950229.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128.154832.539666140149950229.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org" <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/28/2012 06:48 AM, Hiroshi Doyu wrote:
> Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Mon, 24 Sep 2012 14:50:14 +0300 (EEST):
> ...
>>>>> On Mon, 2012-09-24 at 12:04 +0300, Hiroshi Doyu wrote:
>>>>>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>>>>>> index a1a7225..9eae3be 100644
>>>>>> --- a/drivers/base/platform.c
>>>>>> +++ b/drivers/base/platform.c
>>>>>> @@ -21,6 +21,8 @@
>>>>>>  #include <linux/slab.h>
>>>>>>  #include <linux/pm_runtime.h>
>>>>>>
>>>>>> +#include <asm/dma-iommu.h>
>>>>>> +
>>>>>>  #include "base.h"
>>>>>>
>>>>>>  #define to_platform_driver(drv)        (container_of((drv), struct
>>>>>> platform_driver, \
>>>>>> @@ -305,8 +307,19 @@ int platform_device_add(struct platform_device
>>>>>> *pdev)
>>>>>>                  dev_name(&pdev->dev), dev_name(pdev->dev.parent));
>>>>>>
>>>>>>         ret = device_add(&pdev->dev);
>>>>>> -       if (ret == 0)
>>>>>> -               return ret;
>>>>>> +       if (ret)
>>>>>> +               goto failed;
>>>>>> +
>>>>>> +#ifdef CONFIG_PLATFORM_ENABLE_IOMMU
>>>>>> +       if (platform_bus_type.map && !pdev->dev.archdata.mapping) {
>>>>>> +               ret = arm_iommu_attach_device(&pdev->dev,
>>>>>> +                                             platform_bus_type.map);
>>>>>> +               if (ret)
>>>>>> +                       goto failed;
>>>>>
>>>>> This is horrible ... you're adding an architecture specific callback
>>>>> into our generic code; that's really a no-no.  If the concept of
>>>>> CONFIG_PLATFORM_ENABE_IOMMU is useful to more than just arm, then this
>>>>> could become a generic callback.
>>>>
>>>> As mentioned in the original, this is a heck to explain what is
>>>> needed. I am looking for some generic solution for how to specify
>>>> IOMMU info for each platform devices. I'm guessing that some other SoC
>>>> may have the similar requirements on the above. As you mentioned, this
>>>> solution should be a generic, not arch specific.
>>>
>>> Please read more about bus notifiers. IMHO a good example is provided in 
>>> the following thread:
>>> http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg12238.html
>>
>> This bus notifier seems enough flexible to afford the variation of
>> IOMMU map info, like Tegra ASID, which could be platform-specific, and
>> the other could be common too. There's already iommu_bus_notifier
>> too. I'll try to implement something base on this.
> 
> Experimentally implemented as below. With the followig patch, each
> device could specify its own map in DT, and automatically the device
> would be attached to the map.
> 
> There is a case that some devices share a map. This patch doesn't
> suppor such case yet.
> 
> From 8cb75bb6f3a8535a077e0e85265f87c1f1289bfd Mon Sep 17 00:00:00 2001
> From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Wed, 28 Nov 2012 14:47:04 +0200
> Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU devices
> 
> platform_bus notifier registers IOMMU devices if dma-window is
> specified.
> 
> Its format is:
>   dma-window = <"start" "size">;
> ex)
>   dma-window = <0x12345000 0x8000>;
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/board-dt-tegra30.c |   40 ++++++++++++++++++++++++++++++++

Shouldn't this patch be to the IOMMU driver itself, not the core Tegra code?
