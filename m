Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C20C43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 10:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C59206102C;
	Wed,  8 Jun 2022 10:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hZ0HgfjP41d; Wed,  8 Jun 2022 10:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE33E61006;
	Wed,  8 Jun 2022 10:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96083C0039;
	Wed,  8 Jun 2022 10:25:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05405C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7C8F4013D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JYbwVQmx6OFr for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 10:25:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E543740126
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 10:25:49 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 246C0660181B;
 Wed,  8 Jun 2022 11:25:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1654683948;
 bh=CbCEHZf0MESeLkAV+KaRIb58SJLwsWDBEd1XfSKloiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JL6CAQRzPNxS11sdv1lqG3+jYQQBX0szDXfzGlqNeAmSTxcSN4hrnxHXiJK4TI/5o
 4lG3gsRwQhONwG+w5NxnfRzA+cI5lF3VjstoVw0s3HPCKYvYr7kER2ucKauN9+qgMT
 mTsntlQDlE0JrPQUTJURaOqHDSkyIi90kFHMkUae1FEGncdiXfftKujwqhZzPtMcGC
 hldbDeeSFn1Hvs5EIWixyoS9jStUbJyl1AVxxnbAxcZhEJiSgkRbwBUWK0306fSYfO
 mWuaO/tU/mF4L7Eqymam34ABQMq66ZhWoW9r442GAmDfk2QCk2U4rXjVa10NTpdz0t
 8aV3MpGHtXuKQ==
Message-ID: <4f6f1ec4-2c68-5446-e0e0-85e1631a84cf@collabora.com>
Date: Wed, 8 Jun 2022 12:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
 <20220531161910.GE25502@willie-the-truck>
 <CAF6AEGvF+5mf6jE9Xac1qR9P+-=ELLu_LzoJhUV-Dx2RYH20Ag@mail.gmail.com>
 <6efeafbc-d366-bddd-faa4-4359f3a56f4a@somainline.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6efeafbc-d366-bddd-faa4-4359f3a56f4a@somainline.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Martin Botka <martin.botka@somainline.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Il 03/06/22 20:03, Konrad Dybcio ha scritto:
> 
> 
> On 31.05.2022 22:57, Rob Clark wrote:
>> On Tue, May 31, 2022 at 9:19 AM Will Deacon <will@kernel.org> wrote:
>>>
>>> On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
>>>> On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
>>>>>
>>>>> On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
>>>>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>>>
>>>>>> As specified in this driver, the context banks are 0x1000 apart.
>>>>>> Problem is that sometimes the context number (our asid) does not
>>>>>> match this logic and we end up using the wrong one: this starts
>>>>>> being a problem in the case that we need to send TZ commands
>>>>>> to do anything on a specific context.
>>>>>
>>>>> I don't understand this. The ASID is a software construct, so it shouldn't
>>>>> matter what we use. If it does matter, then please can you explain why? The
>>>>> fact that the context banks are 0x1000 apart seems unrelated.
>>>>
>>>> I think the connection is that mapping from ctx bank to ASID is 1:1
>>>
>>> But in what sense? How is the ASID used beyond a tag in the TLB? The commit
>>> message hints at "TZ commands" being a problem.
>>>
>>> I'm not doubting that this is needed to make the thing work, I just don't
>>> understand why.
>>
>> (disclaimer, it has been quite a while since I've looked at the smmu
>> setup with earlier tz, ie. things that use qcom_iommu, but from
>> memory...)
>>
>> We cannot actually assign the context banks ourselves, so in the dt
>> bindings the "ASID" is actually the context bank index.
> I think so.
> 
>    I don't
>> remember exactly if this was a limitation of the tz interface, or
>> result of not being able to program the smmu's global registers
>> ourselves.
> 
> As far as I understand, it's the latter, as changing the defaults is not allowed by the security policy on consumer devices.
> 
> Qualcomm arbitrarily chose some numbers that may or may have not aligned with their usual index-is-offset-divided-by-0x1000 and hardcoded them in the BSP, and now the secure side (if required, and well, it is..) expects precisely that configuration.
> 
> 
> Konrad
> 

I can confirm that it's the latter, as described by Konrad.
The inability of programming the global registers from Linux is due to the
hypervisor disallowing that (in different ways depending on the SoC's firmware
but with the same outcome: AP reset by HYP).

Cheers,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
