From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/mediatek: Fix a build fail of m4u_type
Date: Sat, 26 Aug 2017 21:46:13 +0300
Message-ID: <c7e936c9-9d77-66cd-32d0-7a07ec45d68b@gmail.com>
References: <1503552249-22060-1-git-send-email-yong.wu@mediatek.com>
 <ecd9b73a-0c8f-175c-175f-27ae318352bf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ecd9b73a-0c8f-175c-175f-27ae318352bf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 08/26/2017 09:33 PM, Matthias Brugger wrote:
> 
> 
> On 08/24/2017 08:24 AM, Yong Wu wrote:
>> The commit ("iommu/mediatek: Enlarge the validate PA range
>> for 4GB mode") introduce the following build error:
>>
>>     drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_hw_init':
>>>> drivers/iommu/mtk_iommu.c:536:30: error: 'const struct mtk_iommu_data'
>>   has no member named 'm4u_type'; did you mean 'm4u_dom'?
>>       if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
>>
>> This patch fix it, use "m4u_plat" instead of "m4u_type".
>>
>> Reported-by: kernel test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> ---
>> 1) In the v2 of mt2712 iommu support patch-set, We changed a variant
>> name from "m4u_type" to "m4u_plat", But I'm sorry that I forgot to
>> change it in the later patch.
>> 2) This patch is based on [1].
>> [1]:https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023847.html
>> 3) I cann't find the commit id of the patch ("iommu/mediatek: Enlarge
>> the validate PA range for 4GB mode") in the [2].
>> So I don't write the commit id for that patch in the commit message.
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> 
> Because the kernel test robot took the patch from the mailinglist. Please fold 
> this fix into v3 of the series.
> 

Please ignore this message, I didn't realize that the driver was already queued 
by Joerg.

Regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
