Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B6EC433F5
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 11:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03867401BB;
	Mon, 22 Nov 2021 11:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBZEgb83QMDE; Mon, 22 Nov 2021 11:09:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9DF9A40010;
	Mon, 22 Nov 2021 11:09:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A73CC001E;
	Mon, 22 Nov 2021 11:09:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7862AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 11:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6572140162
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 11:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qh4geacn0pMN for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 11:09:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0A8E40010
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 11:09:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dafna) with ESMTPSA id 3733A1F44148
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637579340; bh=6R7asC355cFNye6uYubFW2XAoicTdUQaddnkr60Th1A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=EOTU3N8QBwwkYyW35oY3Di3R8mG0HV0HzKdn9Ts41UNH24Kgke3foLqvWEcwWzzmd
 J48fYH5waFC9ZxMLs1Uj6IEbLJ9qIU49oujVBZvkF7sH+ifARNhLX8ixB2jlTuC73g
 2/xT3qgDmhZF0gg+T4V13kiuMvCEuu/ImhCSz2hyKvR1fFmJDnoIDHzD2JKyxHQHpP
 rUvbGY1+cMc27JGmNznYA6DbXmGdRTArl1fEmIb9YJ2/UfFopFGi+nG+Rm8AsRo3oA
 7NJD6xw5MouUtInzMNPTGj4AKFPJ3T5RkRn/wu0sc36N27IY8+Y8UdnbzogS9SS0z5
 aVMb85CpAgo7w==
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
To: Yong Wu <yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-13-yong.wu@mediatek.com>
 <c4be1a14-c257-81b7-4a2b-f7e68c32de88@collabora.com>
 <5c4dd67ae7c81721d8cfd2c3b23b7c6df493cb5a.camel@mediatek.com>
 <4dd4cf8d-0f52-afae-f7d9-8e3cfdf3b729@collabora.com>
 <c69e03b4781dd9014393e0ff47767c58c846a722.camel@mediatek.com>
 <fd46a6647b7c3a184f32df9a25141a3213a04ee5.camel@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <40de67e6-e9c9-9c31-79fb-250ac8998513@collabora.com>
Date: Mon, 22 Nov 2021 13:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fd46a6647b7c3a184f32df9a25141a3213a04ee5.camel@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, sebastian.reichel@collabora.com,
 yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Fabien Parent <fparent@baylibre.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Collabora Kernel ML <kernel@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 22.11.21 09:05, Yong Wu wrote:
> Hi Dafna,
> 
> On Wed, 2021-11-10 at 15:50 +0800, Yong Wu wrote:
>> On Wed, 2021-11-10 at 07:29 +0200, Dafna Hirschfeld wrote:
>>>
>>> On 10.11.21 04:20, Yong Wu wrote:
>>>> On Tue, 2021-11-09 at 14:21 +0200, Dafna Hirschfeld wrote:
>>>>> Hi
>>>>> This patch is needed in order to update the tlb when a device
>>>>> is
>>>>> powered on.
>>>>> Could you send this patch alone without the whole series so it
>>>>> get
>>>>> accepted easier?
>>>>
>>>> Which SoC are you testing on? In previous SoC, the IOMMU HW don't
>>>> have
>>>> power-domain, and we have a "has_pm"[1] in the tlb function for
>>>> that
>>>> case. The "has_pm" should be always 0 for the previous SoC like
>>>> mt8173,
>>>> it should always tlb synchronize.
>>>>
>>>> thus, Could you help share more about your issue? In which case
>>>> it
>>>> lack
>>>> the necessary tlb operation. At least, We need confirm if it
>>>> needs
>>>> a
>>>> "Fixes" tags if sending this patch alone.
>>>
>>> Hi,
>>> I work with the mtk-vcodec driver on mt8173. As you wrote, the
>>> iommu
>>> doesn't
>>> have a power-domain and so when allocating buffers before the
>>> device
>>> is powered
>>> on, there is the warning
>>> "Partial TLB flush timed out, falling back to full flush"
>>> flooding the log buf.
>>
>> oh. Thanks very much for your information. Get it now.
>>
>> This issue should be introduced by the:
>>
>> b34ea31fe013 ("iommu/mediatek: Always enable the clk on resume")
>>
>> tlb failed due to the bclk is not enabled. Could you help try that
>> after reverting this?
>>
>>>
>>> Sebastian Reichel suggested to remove the 'if(has_pm)' check to
>>> avoid
>>> this warning,
>>> and avoid flushing the tlb if the device is off:
>>>
>>> [1] http://ix.io/3Eyr
>>>
>>> This fixes the warning, but then the tlb is not flushed in sync,
>>> Therefore the tlb should be flushed when the device is resumed.
>>>
>>> So the two patches (the one suggested in the link [1] and this
>>> patch)
>>> should be sent together as a 2-patch series.
>>
>> then this is reasonable. You could help this into a new patchset if
>> you
>> are free(add Fixes tag).
>>
>> Thanks.
>>
>>>
>>> Thanks,
>>> Dafna
>>>
>>>>
>>>> Thanks.
>>>>
>>>> [1]
>>>>
>>
>>
> https://elixir.bootlin.com/linux/v5.15/source/drivers/iommu/mtk_iommu.c#L236
>>>>
>>>>> I can resend the patch on your behalf if you want.
> 
> What's your plan here?
> 
> If you send the two as a independent patchset on v5.16, I will rebase
> yours.
> If you have no time for this, I could help this.

Hi, just sent it in the patchset ` iommu/mediatek: fix tlb flush logic`

Thanks,
Dafna

> 
> Thanks.
> 
>>>>>
>>>>> Thanks,
>>>>> Dafna
>>>>>
>>>>> On 23.09.21 14:58, Yong Wu wrote:
>>>>>> Prepare for 2 HWs that sharing pgtable in different power-
>>>>>> domains.
>>>>>>
>>>>>> When there are 2 M4U HWs, it may has problem in the
>>>>>> flush_range
>>>>>> in
>>>>>> which
>>>>>> we get the pm_status via the m4u dev, BUT that function don't
>>>>>> reflect the
>>>>>> real power-domain status of the HW since there may be other
>>>>>> HW
>>>>>> also
>>>>>> use
>>>>>> that power-domain.
>>>>>>
>>>>>> The function dma_alloc_attrs help allocate the iommu buffer
>>>>>> which
>>>>>> need the corresponding power domain since tlb flush is needed
>>>>>> when
>>>>>> preparing iova. BUT this function only is for allocating
>>>>>> buffer,
>>>>>> we have no good reason to request the user always call
>>>>>> pm_runtime_get
>>>>>> before calling dma_alloc_xxx. Therefore, we add a
>>>>>> tlb_flush_all
>>>>>> in the pm_runtime_resume to make sure the tlb always is
>>>>>> clean.
>>>>>>
>>>>>> Another solution is always call pm_runtime_get in the
>>>>>> tlb_flush_range.
>>>>>> This will trigger pm runtime resume/backup so often when the
>>>>>> iommu
>>>>>> power is not active at some time(means user don't call
>>>>>> pm_runtime_get
>>>>>> before calling dma_alloc_xxx), This may cause the performance
>>>>>> drop.
>>>>>> thus we don't use this.
>>>>>>
>>>>>> In other case, the iommu's power should always be active via
>>>>>> device
>>>>>> link with smi.
>>>>>>
>>>>>> The previous SoC don't have PM except mt8192. the mt8192
>>>>>> IOMMU
>>>>>> is
>>>>>> display's
>>>>>> power-domain which nearly always is enabled. thus no need fix
>>>>>> tags
>>>>>> here.
>>>>>> Prepare for mt8195.
>>>>>>
>>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>>> ---
>>>>>>     drivers/iommu/mtk_iommu.c | 11 +++++++++++
>>>>>>     1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/mtk_iommu.c
>>>>>> b/drivers/iommu/mtk_iommu.c
>>>>>> index 44cf5547d084..e9e94944ed91 100644
>>>>>> --- a/drivers/iommu/mtk_iommu.c
>>>>>> +++ b/drivers/iommu/mtk_iommu.c
>>>>>> @@ -984,6 +984,17 @@ static int __maybe_unused
>>>>>> mtk_iommu_runtime_resume(struct device *dev)
>>>>>>     		return ret;
>>>>>>     	}
>>>>>>     
>>>>>> +	/*
>>>>>> +	 * Users may allocate dma buffer before they call
>>>>>> pm_runtime_get, then
>>>>>> +	 * it will lack the necessary tlb flush.
>>>>>> +	 *
>>>>>> +	 * We have no good reason to request the users always
>>>>>> call
>>>>>> dma_alloc_xx
>>>>>> +	 * after pm_runtime_get_sync.
>>>>>> +	 *
>>>>>> +	 * Thus, Make sure the tlb always is clean after each
>>>>>> PM
>>>>>> resume.
>>>>>> +	 */
>>>>>> +	mtk_iommu_tlb_do_flush_all(data);
>>>>>> +
>>>>>>     	/*
>>>>>>     	 * Uppon first resume, only enable the clk and return,
>>>>>> since
>>>>>> the values of the
>>>>>>     	 * registers are not yet set.
>>>>>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
