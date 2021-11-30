Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20628C433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 11:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC85D608DD;
	Tue, 30 Nov 2021 11:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WgKqqpaRbj8H; Tue, 30 Nov 2021 11:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FEE5606D4;
	Tue, 30 Nov 2021 11:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB21C001C;
	Tue, 30 Nov 2021 11:33:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46414C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17D6F401AF
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aV3K0AGirFKq for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 11:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9D7E4019D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 11:33:11 +0000 (UTC)
Received: from [IPv6:2a00:c281:1409:4a00:f02c:94f7:9527:dda] (unknown
 [IPv6:2a00:c281:1409:4a00:f02c:94f7:9527:dda])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CAFDD1F410B9;
 Tue, 30 Nov 2021 11:33:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638271989; bh=kPPICgkzXFPBrIYmZPv1q+nwez55PhApUTcS0F/NeBo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Deq8PqlhTo0QneJhYsfmqFdvxX1pqWMpB6c+zvITaBH3pEHHh5JGO5Sy0evRJAMI9
 sXnuDdpZy+Lzle2eErvroT2n1r7myLSrKb7RX9bn/3wyfymXBt7gIo2qzAg+O+tDVl
 8g6XEBjqU88FYPMQuzdS3sfsmUhfCo4BqUZJGyKn++t/O7QRj2haWB0dvTk0zDvHR5
 dhM/+BpZGzAnzR4gHl12N8WgTJ8MYmgsjcO/NvwBrZ9o1AqMTauccppSbv4A+MOev3
 UI6LMYtsBuAdh8dQyjs0dD2AYCZliYOcfnfD4yqIaMlsUpP7BvgHZmZnKEc0Gzymkw
 zKy8tz0LHsrRA==
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
To: Yong Wu <yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-13-yong.wu@mediatek.com>
 <c4be1a14-c257-81b7-4a2b-f7e68c32de88@collabora.com>
 <5c4dd67ae7c81721d8cfd2c3b23b7c6df493cb5a.camel@mediatek.com>
 <4dd4cf8d-0f52-afae-f7d9-8e3cfdf3b729@collabora.com>
 <c69e03b4781dd9014393e0ff47767c58c846a722.camel@mediatek.com>
 <c5ded58b-a53a-3089-f8a5-c264f8ab9463@collabora.com>
 <128eb1874127b2b9b42a7419e26090d1d192666f.camel@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <58b13d3a-e89b-d2e3-278d-af8859d901b9@collabora.com>
Date: Tue, 30 Nov 2021 13:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <128eb1874127b2b9b42a7419e26090d1d192666f.camel@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, sebastian.reichel@collabora.com,
 yen-chang.chen@mediatek.com, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, yf.wang@mediatek.com,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Collabora Kernel ML <kernel@collabora.com>, Will Deacon <will@kernel.org>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org,
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



On 30.11.21 09:39, Yong Wu wrote:
> On Sat, 2021-11-27 at 12:11 +0200, Dafna Hirschfeld wrote:
>>
>> On 10.11.21 09:50, Yong Wu wrote:
>>> On Wed, 2021-11-10 at 07:29 +0200, Dafna Hirschfeld wrote:
>>>>
>>>> On 10.11.21 04:20, Yong Wu wrote:
>>>>> On Tue, 2021-11-09 at 14:21 +0200, Dafna Hirschfeld wrote:
>>>>>> Hi
>>>>>> This patch is needed in order to update the tlb when a device
>>>>>> is
>>>>>> powered on.
>>>>>> Could you send this patch alone without the whole series so
>>>>>> it
>>>>>> get
>>>>>> accepted easier?
>>>>>
>>>>> Which SoC are you testing on? In previous SoC, the IOMMU HW
>>>>> don't
>>>>> have
>>>>> power-domain, and we have a "has_pm"[1] in the tlb function for
>>>>> that
>>>>> case. The "has_pm" should be always 0 for the previous SoC like
>>>>> mt8173,
>>>>> it should always tlb synchronize.
>>>>>
>>>>> thus, Could you help share more about your issue? In which case
>>>>> it
>>>>> lack
>>>>> the necessary tlb operation. At least, We need confirm if it
>>>>> needs
>>>>> a
>>>>> "Fixes" tags if sending this patch alone.
>>>>
>>>> Hi,
>>>> I work with the mtk-vcodec driver on mt8173. As you wrote, the
>>>> iommu
>>>> doesn't
>>>> have a power-domain and so when allocating buffers before the
>>>> device
>>>> is powered
>>>> on, there is the warning
>>>> "Partial TLB flush timed out, falling back to full flush"
>>>> flooding the log buf.
>>>
>>> oh. Thanks very much for your information. Get it now.
>>>
>>> This issue should be introduced by the:
>>>
>>> b34ea31fe013 ("iommu/mediatek: Always enable the clk on resume")
>>
>> Hi, reverting this commit didn't solve those warnings,
>> I think this is because in the function mtk_iommu_attach_device
>> the first call to pm_runtime_resume_and_get does not turn the clks on
>> since m4u_dom is not yet initialize. And then mtk_iommu_attach_device
>> calls pm_runtime_put right after mtk_iommu_hw_init is called
>> (where the clks are turned on)
> 
> oh. Right. this is also related with the patch of "Add power-domain
> operation".
> 
> The current problem is that there is a redundant log of "Partial TLB
> flush timed out" in mt8173. We need fix this issue firstly. Are you
> going to prepare the patches again? If not, I could help this. You
> could help confirm them if you are free.

Hi,
I already sent a patch last week: https://lore.kernel.org/linux-iommu/afb46ad6ca9477a2bf71233858406caa6ccb1588.camel@mediatek.com/T/
could you please review it?

Thanks,
Dafna



> 
> Thanks.
> 
>>
>> thanks,
>> Dafna
>>
>>
>>>
>>> tlb failed due to the bclk is not enabled. Could you help try that
>>> after reverting this?
>>>
>>>>
>>>> Sebastian Reichel suggested to remove the 'if(has_pm)' check to
>>>> avoid
>>>> this warning,
>>>> and avoid flushing the tlb if the device is off:
>>>>
>>>> [1] http://ix.io/3Eyr
>>>>
>>>> This fixes the warning, but then the tlb is not flushed in sync,
>>>> Therefore the tlb should be flushed when the device is resumed.
>>>>
>>>> So the two patches (the one suggested in the link [1] and this
>>>> patch)
>>>> should be sent together as a 2-patch series.
>>>
>>> then this is reasonable. You could help this into a new patchset if
>>> you
>>> are free(add Fixes tag).
>>>
>>> Thanks.
>>>
>>>>
>>>> Thanks,
>>>> Dafna
>>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
