From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 2/4] soc: mediatek: Init MT8173 scpsys driver earlier
Date: Wed, 26 Oct 2016 16:54:53 +0200
Message-ID: <42e4a2ad-4349-6d64-b170-c31963d0416f@gmail.com>
References: <1463390894-32062-1-git-send-email-jamesjj.liao@mediatek.com>
 <1463390894-32062-3-git-send-email-jamesjj.liao@mediatek.com>
 <34025ec4-19d3-8b25-d669-50c6f19159cd@gmail.com>
 <1467782540.26485.11.camel@mtksdaap41> <577FA0D9.8070408@gmail.com>
 <1468314071.24705.4.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468314071.24705.4.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Yong,

On 07/12/2016 11:01 AM, Yong Wu wrote:
> Hi Matthias,
>
> On Fri, 2016-07-08 at 14:47 +0200, Matthias Brugger wrote:
>>
>> On 06/07/16 07:22, James Liao wrote:
>>> On Sat, 2016-07-02 at 18:35 +0200, Matthias Brugger wrote:
>>>>
>>>> On 05/16/2016 11:28 AM, James Liao wrote:
>>>>> Some power domain comsumers may init before module_init.
>>>>> So the power domain provider (scpsys) need to be initialized
>>>>> earlier too.
>>>>>
>>>>> Take an example for our IOMMU (M4U) and SMI. SMI is a bridge
>>>>> between IOMMU and multimedia HW. SMI is responsible to
>>>>> enable/disable iommu and help transfer data for each multimedia
>>>>> HW. Both of them have to wait until the power and clocks are
>>>>> enabled.
>>>>>
>>>>> So scpsys driver should be initialized before SMI, and SMI should
>>>>> be initialized before IOMMU, and then init IOMMU consumers
>>>>> (display/vdec/venc/camera etc.).
>>>>>
>>>>> IOMMU is subsys_init by default. So we need to init scpsys driver
>>>>> before subsys_init.
>>>>>
>>>>> Signed-off-by: James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>>>> Reviewed-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>>>   drivers/soc/mediatek/mtk-scpsys.c | 19 ++++++++++++++++++-
>>>>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>>>>> index 5870a24..00c0adb 100644
>>>>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>>>>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>>>>> @@ -617,4 +617,21 @@ static struct platform_driver scpsys_drv = {
>>>>>   		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
>>>>>   	},
>>>>>   };
>>>>> -builtin_platform_driver(scpsys_drv);
>>>>> +
>>>>> +static int __init scpsys_drv_init(void)
>>>>> +{
>>>>> +	return platform_driver_register(&scpsys_drv);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * There are some Mediatek drivers which depend on the power domain driver need
>>>>> + * to probe in earlier initcall levels. So scpsys driver also need to probe
>>>>> + * earlier.
>>>>> + *
>>>>> + * IOMMU(M4U) and SMI drivers for example. SMI is a bridge between IOMMU and
>>>>> + * multimedia HW. IOMMU depends on SMI, and SMI is a power domain consumer,
>>>>> + * so the proper probe sequence should be scpsys -> SMI -> IOMMU driver.
>>>>> + * IOMMU drivers are initialized during subsys_init by default, so we need to
>>>>> + * move SMI and scpsys drivers to subsys_init or earlier init levels.
>>>>> + */
>>>>> +subsys_initcall(scpsys_drv_init);
>>>>>
>>>>
>>>> Can't we achieve this with probe deferring? I'm not really keen on
>>>> coding the order of the different drivers like this.
>>>
>>> Hi Matthias,
>>>
>>> Some drivers such as IOMMU don't support probe deferring. So scpsys need
>>> to init before them by changing init level.
>>>
>>
>> SMI larbs return EPROBE_DEFER if it can't find the PM provider for it's
>> domain, so this part should not be the problem. The larbs get added as
>> components in the probe, when the PM provider is present.
>>
>> The iommu driver uses the larbs as components. As long as not all
>> components are present the iommu does not bind them. So from what I see
>> this should work without any problem.
>>
>> Can you please specify where the iommu dirver has a problem. Maybe we
>> need to fix the driver rather then scpsys.
>
> We got a problem while bootup, the hang backtrace is like below(Sorry, I
> can't find the full backtrace now):
>
> [    7.832359] Call trace:
> [    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
> [    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450
>
> The reason is that "larb->mmu" is NULL while DRM call mtk_smi_larb_get.
>
> DRM call iommu_present to wait for whether IOMMU is ready[1].
> But in the  MTK-IOMMU, It will call
> bus_set_iommu->mtk_iommu_add_device->mtk_iommu_attach_device, then it's
> able to transfer "struct mtk_smi_iommu" to SMI whose probe maybe delayed
> by power-domain, then SMI could finish its probe.
>
> So If DRM probe is called after the time of calling bus_set_iommu and
> before the time of SMI probe finish, this problem can be reproduced.
>
> The root cause is that iommu_present cann't indicate that MTK-IOMMU and
> SMI is ready actually. in other words, the DRM cann't detect
> whether the SMI has probed done.
>
> If we move scpsys_init from module_initcall to subsys_initcall, the
> IOMMU and SMI could be probe done during the subsys_initcall period.
> this issue can be avoid.
> And as we grep before, there are also some examples whose power-domain
> is also not module_init[2].
> core_initcall(exynos4_pm_init_power_domain);
> subsys_initcall(imx_pgc_init);
>
> If you think that this patch will hide the problem above, then I have to
> add a new function, like below:
> //==================
> bool mtk_smi_larb_ready(struct device *larbdev)
> {
> 	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
>
> 	return larb && !!larb->mmu;
> }
> //=================
>
> And in the probe of all the MTK-IOMMU consumer, we have to add this:
> //====================
> 	if (!mtk_smi_larb_ready(&larb_pdev->dev))
> 		return -EPROBE_DEFER;
> //====================
>
> The sequence is a little complex, If I don't explain clearly, please
> tell me.
> Any other suggestion about this? Thanks.

I'm still trying to find a different way to solve this. Unfortunately 
I'm not able to reproduce this on my mt8173-evb...

...but: iommu_present checkes if the bus->iommu_ops is set. If we set 
these option in the iommu after all components got initialized, we 
should be fine. Or did I miss something?

Would you mind trying the patch below (against v4.9-rc1)?
If you know of any way to reproduce this issue, I would be happy to know.

I'm adding Joerg, the iommu maintainer, maybe he has an idea.

Thanks a lot,
Matthias

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b12c12d..9249011 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -602,10 +602,12 @@ static int mtk_iommu_probe(struct platform_device 
*pdev)
         if (ret)
                 return ret;

-       if (!iommu_present(&platform_bus_type))
+       ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, 
match);
+
+       if (ret && !iommu_present(&platform_bus_type))
                 bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);

-       return component_master_add_with_match(dev, &mtk_iommu_com_ops, 
match);
+       return ret;
  }

  static int mtk_iommu_remove(struct platform_device *pdev)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
