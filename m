Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5D18DB03
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898866; cv=none; b=u/bKDmt70JoQF6gT6D2RGRKXWnjktNiSLvi40+Am/dgafwKVammLd6WpMtyu9We3+ScjE9olT1F9a21+IdazBa0zMOfP7/UgjNhGHY0bPir3N81CHUTQjpcpWid6VLNXqqH17muaUpUKqQ2O/jFFA6UEV4+kmwsVspp2ZDAIqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898866; c=relaxed/simple;
	bh=LQqzAjspviM0/DEAi1RUbDf3DG1eq5bmeUcZl9itj0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFRwiEGxdmPbA93aIFp6iH8J/UeMTZP+1KlDOx4+OHmA3eRsYBlU5HDl6q+XJnicBZpL72ubBUSMIESBD3i/HB6BQ/7XlyngN7ic+7YpC0gf9rOUJd78m8FnABNfN4lXpsWVmBlkRl4CC2ClRIRcYNUG4LYfsPvdwRa3ULWLv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AtdL5iXE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AtdL5iXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751898862;
	bh=LQqzAjspviM0/DEAi1RUbDf3DG1eq5bmeUcZl9itj0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AtdL5iXEbqhxgy7ej+d1sDhw08eL3Z+NohmrWrHh3t992W2a0EyLbHpgr0oTym4yN
	 kKwglzAKQysYONjhcURZsffcW21q0BpSges9kFdH9WKYn40lnXgO97pZX6jrRebdav
	 Udn87tPfR0BgYF/xxru0+Y4uIr4B0lExq6NVXXdVsc4+sku3+RDIXvDtEdoLV61LYH
	 jWVuJU1iD6RcsXViKrmnEQ/1gaKRIeu0HVr1PS1+maQT2J7wLFooTcYLmFy3KEL0V0
	 eBhLGLrFiTXSAvcgdFeyXQEhrM1GQkSR0TeUr5IQ3/X+z64/LonHoq6WFpvQmqB06t
	 dc2HCjbiCchXw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C1E317E0A28;
	Mon,  7 Jul 2025 16:34:22 +0200 (CEST)
Message-ID: <f665ccf7-dff2-4c42-9a3e-efa6cdf40ee4@collabora.com>
Date: Mon, 7 Jul 2025 16:34:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
To: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
Cc: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>
 <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
 <1dbebbf290413eae9af13312028c2d19d3441a09.camel@mediatek.com>
 <d818cad4-9eff-4fd6-b46c-d1fc24f7130b@collabora.com>
 <c2fhyerjrb5qgtgyo7jojcyolsryvdp6injgbbzdkbzoaubdnk@37aw7p2f6rbj>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c2fhyerjrb5qgtgyo7jojcyolsryvdp6injgbbzdkbzoaubdnk@37aw7p2f6rbj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/07/25 15:41, u.kleine-koenig@baylibre.com ha scritto:
> On Mon, Jul 07, 2025 at 10:47:53AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 07/07/25 09:24, Yong Wu (吴勇) ha scritto:
>>> On Thu, 2025-07-03 at 18:41 +0200, Uwe Kleine-König wrote:
>>>> Hello,
>>>>
>>>> [expanding the audience a bit according to the drivers that are
>>>> involved
>>>> now that the problem is better understood]
>>>>
>>>> On Tue, Jun 17, 2025 at 05:18:30PM +0200, Uwe Kleine-König wrote:
>>>>> on a 6.16-rc2 kernel running on an mt8365-evk I occasionally hit
>>>>> the
>>>>> following during boot:
>>>>
>>>> I invested some time now to understand the issue. So here comes what
>>>> I
>>>> understood, maybe that helps someone to spot the fix to the described
>>>> problem.
>>>>
>>>> With a configuration that has all drivers built-in but
>>>>
>>>> 	CONFIG_DRM_MEDIATEK=m
>>>> 	CONFIG_MTK_IOMMU=m
>>>>
>>>> and
>>>>
>>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>>> index cb95fecf6016..d4320db7cd2d 100644
>>>> --- a/drivers/iommu/mtk_iommu.c
>>>> +++ b/drivers/iommu/mtk_iommu.c
>>>> @@ -1387,14 +1387,15 @@ static int mtk_iommu_probe(struct
>>>> platform_device *pdev)
>>>>    		goto out_list_del;
>>>>    	ret = iommu_device_register(&data->iommu, &mtk_iommu_ops, dev);
>>>>    	if (ret)
>>>>    		goto out_sysfs_remove;
>>>>    	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>>>> +		msleep(10000);
>>>>    		ret = component_master_add_with_match(dev,
>>>> &mtk_iommu_com_ops, match);
>>>>    		if (ret)
>>>>    			goto out_device_unregister;
>>>>    	}
>>>>    	return ret;
>>>>    out_device_unregister:
>>>>
>>>> I can reliably trigger the race.
>>>>
>>>> With that sleep in place iommu_device_register() completes quickly
>>>> which
>>>> enables probing of the devices with drivers contained in the
>>>> drm_mediatek module (because the modules are loaded in parallel on
>>>> a different CPU).
>>>>
>>>> Then generic driver code calls resume on all suppliers for devices to
>>>> bind, among them the four larb devices. However due to
>>>> component_master_add_with_match() not being called yet, the larb
>>>> devices
>>>> are not yet bound to the iommu device and so larb->mmu is still NULL.
>>>> The latter is a problem in mtk_smi_larb_config_port_gen2_general()
>>>> which
>>>> is called from mtk_smi_larb_resume().
>>>
>>> Hi Uwe,
>>>
>>> Thanks for your help. In this case, it looks like the disp probe occurs
>>> before the smi_larb_bind operation, we need to let disp wait for the
>>> bind to complete.
>>>
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -666,6 +666,10 @@ static int __maybe_unused
>>> mtk_smi_larb_resume(struct device *dev)
>>>           if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
>>> MTK_SMI_FLAG_SLEEP_CTL))
>>>                   mtk_smi_larb_sleep_ctrl_disable(larb);
>>>
>>> +     /* The larb_bind operation may be later than the master probe. */
>>> +       if (!larb->mmu)
>>> +               return -EPROBE_DEFER;
>>> +
> 
> A .resume callback isn't supposed to return -EPROBE_DEFER.
> 

Obviously :-)

>>>           /* Configure the basic setting for this larb */
>>>
>>>
>>> Hi Angelo,
>>>    Do you have any suggestion?
>>>
>>
>> I don't have the necessary bandwidth to really broadly research about this, but
>> there's two ideas:
>>
>> 1. What if we disable PM OPS until MMU is bound? That would avoid calls to
>>     larb_resume().....
> 
> I think the key question here is: Is the iommu functional without the
> larbs bound? If not I'd claim that iommu_device_register() should only
> happen if all larbs are present and ready.
> 

Not all IOMMUs need Local Arbiters... some of them are very specific and do not
need to be arbitered, mostly because they're not shared.

Some.. like the infra contexts for the PCI-Express controller... because then
generally all of the multimedia related contexts should need the arbitering
because they should be all shared between the multimedia IPs (but it may also
be possible to use some without arbitering, depending on the application, though
upstream I think there's no multimedia context with no arbiter - I didn't really
carefully check in devicetrees anyway).

>> 2. Instead of component, we could register a device - which carries its own suspend
>>     and resume ops; the device would be registered only after all local arbiters
>>     are bound, so there would be no suspend/resume ops until everything is in place.
>>     That's more or less how it's done in drivers/usb/core/port.c
>>
>> Probably N.1 would work best - we could...
>>
>> probe:
>> pm_runtime_set_active(larb->smi.dev);
>> pm_runtime_forbid(larb->smi.dev);
>>
>> bind:
>> larb->mmu = ...
>> larb->bank = ...
>>
>> pm_runtime_set_suspended(larb->smi.dev);
>> pm_runtime_allow(larb->smi.dev);
>>
>>
>> ...the next usage/wakeup should then call resume() but at that point we're sure
>> that larb->mmu is actually initialized, because we allowed PM resume only after
>> binding.
> 
> Not knowing the details of the hardware that feels wrong. IMHO a device
> that is operational should be able to do PM ops.
> 

That's true and I completely agree with you, in general - though, this is a "Local
Arbiter" and... if there's nothing to arbiter, it's not functional.

This is arbitering iommu-bus/memory(dma)-bus access to provide some kind of basic
bus QoS: of course, if there's no iommu, there can't be any access, so again there
would be nothing to perform bandwidth arbitration with.

Count that we will (hopefully...) (and hopefully soon...) see some interconnect
driver that takes the defaults in SMI (in a way or another) and changes them to
provide a finer grain QoS (because right now it's static, there's no usage analysis
in place), so the amount of users of mtk-smi should also get higher.. maybe.

Cheers,
Angelo

