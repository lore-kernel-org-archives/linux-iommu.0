Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722FDC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57AFF403D8;
	Tue,  7 Dec 2021 12:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbNmdZb81kCz; Tue,  7 Dec 2021 12:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 138EE402E0;
	Tue,  7 Dec 2021 12:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBC53C002F;
	Tue,  7 Dec 2021 12:17:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C229C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5265E403D8
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7eMMc20Y6Ap7 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:16:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16E3A402E0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:16:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 0EE141F44F90
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638879415; bh=B15G7ImDZFtF6Fgqc3mnNZ9T/WxEYBMsfOlqdDJeg0c=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=KWVGlMzOSZiio+hBSkRv9KhAv9P4xPky5Uc+b9k/wK39xpfar9SRJh0Jise/8TGGC
 v+qCsrKl07At6FFXeORmjpT6xgdsvmQOWpJNdJI7KO1zrwJx3bWEDydOUBZmzQKDMs
 mZVd3VYdxvtxX4gABlx8VDEhalOoX423StYbXQzPzymB63IzDzuaLsfqmEPARqXbXn
 V6XFPSiZWbsYVoEWyH2PqlkAQ8Uu5ohcXvkgFrKUIoYS2LHkfFck0PY/ogUCsg4LNS
 6j4J43iWjbDXUUXOcNpr1kmKDM6Vfknuu9x5i6wsswxHe1NesnPyCATisJ1W4SGznJ
 p6vextvshl4GQ==
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
 <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
 <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
 <47c30f6f-ce9d-9ea7-283c-9026ae9ed1c0@collabora.com>
 <e1d72db69f424b9ee8987b7bafa7423c672ceef1.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <85ef182a-8ebe-7dbb-aa95-35e77cbb072c@collabora.com>
Date: Tue, 7 Dec 2021 13:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e1d72db69f424b9ee8987b7bafa7423c672ceef1.camel@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Il 07/12/21 13:10, Yong Wu ha scritto:
> On Tue, 2021-12-07 at 09:56 +0100, AngeloGioacchino Del Regno wrote:
>> Il 07/12/21 07:24, Yong Wu ha scritto:
>>> Hi AngeloGioacchino,
>>>
>>> Thanks for your review.
>>>
>>> On Mon, 2021-12-06 at 16:08 +0100, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 03/12/21 07:40, Yong Wu ha scritto:
>>>>> sleep control means that when the larb go to sleep, we should
>>>>> wait
>>>>> a bit
>>>>> until all the current commands are finished. thus, when the
>>>>> larb
>>>>> runtime
>>>>> suspend, we need enable this function to wait until all the
>>>>> existed
>>>>> command are finished. when the larb resume, just disable this
>>>>> function.
>>>>> This function only improve the safe of bus. Add a new flag for
>>>>> this
>>>>> function. Prepare for mt8186.
>>>>>
>>>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>     drivers/memory/mtk-smi.c | 39
>>>>> +++++++++++++++++++++++++++++++++++----
>>>>>     1 file changed, 35 insertions(+), 4 deletions(-)
>>>
>>> [snip]
>>>
>>>>>     static int __maybe_unused mtk_smi_larb_suspend(struct device
>>>>> *dev)
>>>>>     {
>>>>>     	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
>>>>> MTK_SMI_FLAG_SLEEP_CTL))
>>>>> +		ret = mtk_smi_larb_sleep_ctrl(dev, true);
>>>>
>>>> Sorry but what happens if SLP_PROT_RDY is not getting set
>>>> properly?
>>>>    From what I can understand in the commit description that you
>>>> wrote,
>>>> if we reach
>>>> the timeout, then the LARB transactions are not over....
>>>>
>>>> I see that you are indeed returning a failure here, but you are
>>>> also
>>>> turning off
>>>> the clocks regardless of whether we get a failure or a success;
>>>> I'm
>>>> not sure that
>>>> this is right, as this may leave the hardware in an unpredictable
>>>> state (since
>>>> there were some more LARB transactions that didn't go through),
>>>> leading to crashes
>>>> at system resume (or when retyring to suspend).
>>>
>>> Thanks for this question. In theory you are right. In this case,
>>> the
>>> bus already hang.
>>>
>>> We only printed a fail log in this patch. If this fail happens, we
>>> should request the master to check which case cause the larb hang.
>>>
>>> If the master has a good reason or limitation, the hang is
>>> expected, I
>>> think we have to add larb reset in this fail case: Reset the larb
>>> when
>>> the larb runtime resume.
>>>
>>
>> Think about the case in which the system gets resumed only partially
>> due to a
>>
>> failure during resume of some driver, or due to a RTC or arch timer
>> resume and
>> suspend right after... or perhaps during runtime suspend/resume of
>> some devices.
>> In that case, we definitely want to avoid any kind of failure point
>> that would
>> lead to a system crash, or any kind of user noticeable (or UX
>> disrupting) "strange
>> behavior".
>>
>> I think that we should make sure that the system suspends cleanly,
>> instead of
>> patching up any possible leftover issue at resume time: if this is
>> doable with
>> a LARB reset in suspend error case, that looks like being a good
>> option indeed.
>>
>> As a side note, thinking about UX, losing a little more time during
>> suspend is
>> nothing really noticeable for the user... on the other hand, spending
>> more time
>> during resume may be something noticeable to the user.
>> For this reason, I think that guaranteeing that the system resumes as
>> fast as
>> possible is very important, which adds up to the need of suspending
>> cleanly.
> 
> Thanks for this comment. I will put it in the suspend when adding the
> reset. But I have no plan to add it in this version since I don't see
> the need for this right now. Maybe I should add a comment in the code
> for this.
> 

What I understand from your reply is that the reset is not trivial work
and needs quite some time to be done properly; in that case: yes, please
add a TODO comment that explains the situation and the discussed solution.

Also, since this SLP_PROT_RDY flag seems to be very nice, just a simple
question: is this a new feature in the SMI IP of MT8186, or is there anything
similar that we may use on other SoCs, like 8183, 8192, 8195, as a follow-up
of this series?

>>
>>> Fortunately, we have never got this issue. We could add this reset
>>> when
>>> necessary. Is this OK for you?
>>>
>>> Thanks.
>>>
>>>>
>>>>>     
>>>>>     	clk_bulk_disable_unprepare(larb->smi.clk_num, larb-
>>>>>> smi.clks);
>>>>> -	return 0;
>>>>> +	return ret;
>>>>>     }
>>>>>     
>>>>>     static const struct dev_pm_ops smi_larb_pm_ops = {
>>>>>
>>>>
>>>>
>>
>>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
