Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6713DC433FE
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 08:46:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1941561027
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1941561027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF44B60705;
	Mon,  1 Nov 2021 08:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6GDh5PbSxdX; Mon,  1 Nov 2021 08:45:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 106EE6071C;
	Mon,  1 Nov 2021 08:45:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBAA6C0019;
	Mon,  1 Nov 2021 08:45:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D0DC000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D37B36071C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MsPW1I5eIknW for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24D1F60705
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:45:46 +0000 (UTC)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DC7F03F1A1
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1635756341;
 bh=gDEC7fcYyadG/CPtgrvRFpzQy+6XwYhZQ8QIsHdNyxU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Onw4qkC7H0HmewpFOPga08eWzocPT0NcXTCM/MT2461p3fhGQHLuNLIif02DKF+aJ
 uFuUC+hdDQQw0biRrAvKYFquVQFQ0BtUWFcLK3IJXui7zrY34Pll/Z9jrSzJfeAK+G
 onBkFrDUyu7JTk0tT1gwWyK6ve0+5CV7PAzVwSYt3OIVbD27tCIOH27KnNuqQeDeLh
 DevUD3BiLSxHSoArvVyaQJ4NtvGzeq0wO1BH3E2JAkl8SDrYfRRjDULcB9yuxkCoC0
 lmiYndLhPueGU63xmPeRM0P6U9Ss0a0fmimIufROo9C2nC7rtm0VjlOD3k4VhUkEou
 vWYoDvX3+JbdA==
Received: by mail-lj1-f200.google.com with SMTP id
 y18-20020a2e7d12000000b00212b22bc3a4so4769513ljc.2
 for <iommu@lists.linux-foundation.org>; Mon, 01 Nov 2021 01:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gDEC7fcYyadG/CPtgrvRFpzQy+6XwYhZQ8QIsHdNyxU=;
 b=RI/kdE0UawIsKNUuIhEPI9gmTxSFmGYIZK7uVaAuTcAcNJjkWSdVIrU6RFYyIrEKXg
 RWjsio+mFVG9cqrkQq2jyg8MPfpqkD10aZxrNqm38qRZk8z6QbqyVLU1OlyDkWtzpokN
 RoYy9/Liptu3kNPRJF6t+jLat4qL/+aenYCqYEP6msyJz6j+9O0J3leYgyxGKALgGTV4
 Zwct3Lwb8Mn2FwtBxM3TAbeoTGIVFLHh4l8nNapVLZ8Rw/+6tHSzgGuoaAF03AiEZ2YR
 1TMcRSGOV3ODCMqMZApF7tRNrLNL8CrI34gdou2t58D8oQwK+yDNlD0njBZisduAOuGe
 7MpQ==
X-Gm-Message-State: AOAM531DEL31clCMBN8d6TrdRSDDoGdIMewHMkYSNID+uv/heqUp2fDD
 Km/pe3h9jSfD4Bfom0itLjPm5/7S/GP+qBSev/zzivDu5P7vczVVdFTu8H5LMhqXF3XyptsKsQ1
 4THFXf4pm9KqADDQUBLumFn5PUZ3VfU+W0TmB8s0JchyeAl8=
X-Received: by 2002:a2e:7804:: with SMTP id t4mr31193461ljc.305.1635756340468; 
 Mon, 01 Nov 2021 01:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO4eUQalnMY+GmolbvNX6MLf2tjTZ/qaEH8Q6qIcLzLQsXmD8ENqNX0LUt9PZiHmN4NRJPcA==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr31193446ljc.305.1635756340279; 
 Mon, 01 Nov 2021 01:45:40 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 d9sm131527lfs.108.2021.11.01.01.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Nov 2021 01:45:39 -0700 (PDT)
Message-ID: <82835e3d-11a3-32e4-0782-d827a5e3d78e@canonical.com>
Date: Mon, 1 Nov 2021 09:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
 <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
 <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <9e4f327511fd85ba8613ec27644fbc29bc4ddb6b.camel@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 01/11/2021 07:09, Yong Wu wrote:
> On Fri, 2021-10-29 at 19:35 +0200, Krzysztof Kozlowski wrote:
>> On 28/10/2021 07:50, Yong Wu wrote:
>>> We add the ostd setting for mt8195. It introduces a abort for the
>>> previous SoC which doesn't have ostd setting. This is the log:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000000000000080
>>> ...
>>> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
>>> lr : mtk_smi_larb_resume+0x54/0x98
>>> ...
>>> Call trace:
>>>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>>>  pm_generic_runtime_resume+0x2c/0x48
>>>  __genpd_runtime_resume+0x30/0xa8
>>>  genpd_runtime_resume+0x94/0x2c8
>>>  __rpm_callback+0x44/0x150
>>>  rpm_callback+0x6c/0x78
>>>  rpm_resume+0x310/0x558
>>>  __pm_runtime_resume+0x3c/0x88
>>>
>>> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
>>> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it
>>> is
>>> also a valid value, thus, use the larb->larb_gen->ostd as the
>>> condition
>>> inside the "for" loop.
>>
>> You need to write more clearly, what you are fixing here.
>>
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>> Hi Krzysztof,
>>> Could you help review and conside this as a fix for the mt8195
>>> patchset?
>>> The mt8195 patchset are not in mainline, thus, I don't know its
>>> sha-id,
>>> and don't add Fixes tag.
>>> Thanks
>>> ---
>>>  drivers/memory/mtk-smi.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index b883dcc0bbfa..0262a59a2d6e 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -257,7 +257,7 @@ static void
>>> mtk_smi_larb_config_port_gen2_general(struct device *dev)
>>>  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>>>  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base +
>>> SMI_LARB_SW_FLAG);
>>>  
>>> -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd &&
>>> !!larbostd[i]; i++)
>>> +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd &&
>>> !!larbostd[i]; i++)
>>>  		writel_relaxed(larbostd[i], larb->base +
>>> SMI_LARB_OSTDL_PORTx(i));
>>
>> The code does not look good. You have already a dereference at line
>> 244:
>>
>> 	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> 
> if larb->larb_gen->ostd is null, larbostd is the offset, e.g. 0x80 in
> the log above. thus, we can not use "larbostd[i]" in the "for" loop.
> 
> sorry for the unreadable. In this case, is the change ok?

No, it's ok, I did not check the type of ostd and it's confusing a bit
that it is defined as a pointer to an array but you actually use it as
array of pointers to 32-elemenet arrays... Anyway I was mistaken and
there will be indeed no dereference at the assignment, but for code
clarity I would still prefer to do the check earlier, so:

> 
> or like this:
> 
> -const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> +const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen-ostd[larb-
>> larbid] : NULL;

Although I think now the proper type should be explicit.
mtk_smi_larb_mt8195_ostd is an 28-element array of
SMI_LARB_PORT_NR_MAX-element u8 arrays, therefore struct
mtk_smi_larb_gen should be:
	const u8 (*ostd)[][SMI_LARB_PORT_NR_MAX];

Right?


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
