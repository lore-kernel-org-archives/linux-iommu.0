Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22128C2B3
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878084; cv=none; b=RzANUUXkIVCfvbCGRcCJ4Tze63mrI6QGqm72HAPUEyqsQYewpSZGMMXe8dCC3wqsCVrHGSR9Vibala5m5HWzE5+/zuh9+yV6SrFotlcA11eLqUto5GYAT5smOrYznG7wd/3i2HQrWEQHAmLSdWn+8LURdTKJrBxDat8rJc+lXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878084; c=relaxed/simple;
	bh=wuHu5L8stqYfI+1TQxbJC5m2b/XKqI3Lh3s9ovq7pYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCNOrC3O/RPPlI4S1+LQ5SMZHeU50d3vA9bdtAr7DBpdRA7AY0eN08+65/uXsBJjyAARvdCVB6ZtzO6LX1VR6FMNB0UzLgyIxPwrCBkUac4glsi1+U5dg+Gj7D56Avye4lu9QqzvtQ+huvPA57Fq8WMb6EUzuLeZzwbrQd2Va6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U1GjuxXj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U1GjuxXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751878075;
	bh=wuHu5L8stqYfI+1TQxbJC5m2b/XKqI3Lh3s9ovq7pYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1GjuxXjoxQtoqcWavS3RVxNki9j+uqYA9N0VVt9UjazobtZOpf+Tq2H3LUBbnuQR
	 tnSBz+HUP9MR68AhdhdzxcmxlQkHKaj0L5Pry+ihY7KKUJn1efKpbOIl+ZRJuyh659
	 3jlEFGU8DOB18eKYPu2YSe7TWhChhd1goor2vWebJ2dTALhQX7nekmAs62ugKx0iHx
	 V4VLza1mKFIK2ETB9EUwvTBXxevEEB454vJ+lEl6YupoPsHNrnp/i2bmbom7ZkkXN4
	 w1FkkwJqvh2HOl9ktbCIx5Ef8q7/TYTfkSg9VQbmqvMXkTAVc8NOg776lwLpd2Huf7
	 USgY1oY/3hXmA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95EF717E07C9;
	Mon,  7 Jul 2025 10:47:54 +0200 (CEST)
Message-ID: <d818cad4-9eff-4fd6-b46c-d1fc24f7130b@collabora.com>
Date: Mon, 7 Jul 2025 10:47:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>
 <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
 <1dbebbf290413eae9af13312028c2d19d3441a09.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1dbebbf290413eae9af13312028c2d19d3441a09.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/07/25 09:24, Yong Wu (吴勇) ha scritto:
> On Thu, 2025-07-03 at 18:41 +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> [expanding the audience a bit according to the drivers that are
>> involved
>> now that the problem is better understood]
>>
>> On Tue, Jun 17, 2025 at 05:18:30PM +0200, Uwe Kleine-König wrote:
>>> on a 6.16-rc2 kernel running on an mt8365-evk I occasionally hit
>>> the
>>> following during boot:
>>
>> I invested some time now to understand the issue. So here comes what
>> I
>> understood, maybe that helps someone to spot the fix to the described
>> problem.
>>
>> With a configuration that has all drivers built-in but
>>
>> 	CONFIG_DRM_MEDIATEK=m
>> 	CONFIG_MTK_IOMMU=m
>>
>> and
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index cb95fecf6016..d4320db7cd2d 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -1387,14 +1387,15 @@ static int mtk_iommu_probe(struct
>> platform_device *pdev)
>>   		goto out_list_del;
>>   
>>   	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
>>   	if (ret)
>>   		goto out_sysfs_remove;
>>   
>>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>> +		msleep(10000);
>>   		ret = component_master_add_with_match(dev,
>> &mtk_iommu_com_ops, match);
>>   		if (ret)
>>   			goto out_device_unregister;
>>   	}
>>   	return ret;
>>   
>>   out_device_unregister:
>>
>> I can reliably trigger the race.
>>
>> With that sleep in place iommu_device_register() completes quickly
>> which
>> enables probing of the devices with drivers contained in the
>> drm_mediatek module (because the modules are loaded in parallel on
>> a different CPU).
>>
>> Then generic driver code calls resume on all suppliers for devices to
>> bind, among them the four larb devices. However due to
>> component_master_add_with_match() not being called yet, the larb
>> devices
>> are not yet bound to the iommu device and so larb->mmu is still NULL.
>> The latter is a problem in mtk_smi_larb_config_port_gen2_general()
>> which
>> is called from mtk_smi_larb_resume().
> 
> Hi Uwe,
> 
> Thanks for your help. In this case, it looks like the disp probe occurs
> before the smi_larb_bind operation, we need to let disp wait for the
> bind to complete.
> 
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -666,6 +666,10 @@ static int __maybe_unused
> mtk_smi_larb_resume(struct device *dev)
>          if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
> MTK_SMI_FLAG_SLEEP_CTL))
>                  mtk_smi_larb_sleep_ctrl_disable(larb);
> 
> +     /* The larb_bind operation may be later than the master probe. */
> +       if (!larb->mmu)
> +               return -EPROBE_DEFER;
> +
>          /* Configure the basic setting for this larb */
> 
> 
> Hi Angelo,
>   Do you have any suggestion?
> 

I don't have the necessary bandwidth to really broadly research about this, but
there's two ideas:

1. What if we disable PM OPS until MMU is bound? That would avoid calls to
    larb_resume().....
2. Instead of component, we could register a device - which carries its own suspend
    and resume ops; the device would be registered only after all local arbiters
    are bound, so there would be no suspend/resume ops until everything is in place.
    That's more or less how it's done in drivers/usb/core/port.c

Probably N.1 would work best - we could...

probe:
pm_runtime_set_active(larb->smi.dev);
pm_runtime_forbid(larb->smi.dev);

bind:
larb->mmu = ...
larb->bank = ...

pm_runtime_set_suspended(larb->smi.dev);
pm_runtime_allow(larb->smi.dev);


...the next usage/wakeup should then call resume() but at that point we're sure
that larb->mmu is actually initialized, because we allowed PM resume only after
binding.

I want to repeat - I didn't make any extensive research, just a fast read and
threw some ideas on the table without any testing or anything else :-)

Cheers,
Angelo

> 
> Thanks.
> 
>>
>> I don't know what the right fix here is, but maybe someone else does?
>>
>> Best regards
>> Uwe

