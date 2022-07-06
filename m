Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A08EC43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 14:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E3E5813C7;
	Wed,  6 Jul 2022 14:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E3E5813C7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lmT7TvAX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDwuSm5PPAvv; Wed,  6 Jul 2022 14:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA950813BD;
	Wed,  6 Jul 2022 14:39:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA950813BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C478C0033;
	Wed,  6 Jul 2022 14:39:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 607B4C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A343608D8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:39:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A343608D8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=lmT7TvAX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YvHcYYolIjvb for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 14:39:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 441EA60750
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 441EA60750
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:39:01 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id f14so3560774lfl.11
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zZOCnL2sk3pByrLKpJXQRiEZ7lTe3lvaSXFyozjR1Sk=;
 b=lmT7TvAXdlwO8MoznJL41ScqnCxhsPkyj3eO8uJVObJgBwMjkbz/dZ39ZBM2Q6uKVU
 OYmvbwv02NdsHcN62nEMsrORHyzmxAYZmIPxYaTFaaaS18SQGiG0Vbpy5rd8u60KuOm7
 BZZCXPyYtByZ51BH/XuE3XmjOHA+E+ksnsjvnO4Vv5MRk6ia//DlfQXbATqtc/M32+0W
 Vkyn6341a4yx3S6P9qKA/V1h+VyuGk/bMIBNVaiOI9euzs7WrBD5hJ//1OG1vpriTMQP
 FvgjjPgQIC4C0Bs6jZFH0oQ3q2vOxEvDkO7uPZLvwfSJqE2C/qslvt4ZbHZUZi/wFXmx
 eOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zZOCnL2sk3pByrLKpJXQRiEZ7lTe3lvaSXFyozjR1Sk=;
 b=6uuGjxDOiGTLLz/6adYFyJp9irI73PEf3cxE6rm/u7RR8dUJF3pxrLeIRlPLxuvxKR
 Ddk0xw0zFiAR+uD0+SGE/mmWDTmF16jcfEod9tNM5De5BLReCzoxR3ql1L4YS3RbPEAb
 B83OzGCkAS3xwWd2NEQzDh0HReEq4yA07wVL+DcJKSyuRQ0imUJzIpEXDSATVWgl19Wk
 qv5wBVx+VNXX5Scmh2JGNxRHB2r7cOVYgXBShN6ome/u+2E8a6HrOqvAt9gEL+GN/I7w
 6aHApl1WH93eOVVtlzg4bJ1K0jrP4doG0xq17VvC8VdT4Lt9kQyKabLxSWGCH36nCSBT
 Dcjg==
X-Gm-Message-State: AJIora8d08yyz2ONSqFvPD/D2aDpNsEBttHUuArUWyvpuCJjOwMJNwZj
 1zeJyNA1PceL52xeOZZyncPhsw==
X-Google-Smtp-Source: AGRyM1tvr1UuDnYcmSJc30YkpAaFP4aCC6wjkMinKdciZeRPBO4Q4W7IOip5cYIkpaF2vYVKHyb7wA==
X-Received: by 2002:a05:6512:2204:b0:484:e8eb:4169 with SMTP id
 h4-20020a056512220400b00484e8eb4169mr4366900lfu.472.1657118339097; 
 Wed, 06 Jul 2022 07:38:59 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 b29-20020ac25e9d000000b00486bf193d23sm267876lfq.299.2022.07.06.07.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 07:38:58 -0700 (PDT)
Message-ID: <4c3443f4-a65d-331b-851a-01f5275bbf4b@linaro.org>
Date: Wed, 6 Jul 2022 16:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
 <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
 <9757b32c-c196-f7e0-3c61-1d4edae854dc@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9757b32c-c196-f7e0-3c61-1d4edae854dc@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On 06/07/2022 15:48, Matthias Brugger wrote:
> 
> 
> On 04/07/2022 14:36, Krzysztof Kozlowski wrote:
>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>> The max clock items for the dts node with compatible
>>> 'mediatek,mt8195-smi-sub-common' should be 3.
>>>
>>> However, the dtbs_check of such node will get following message,
>>> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>>>           From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>>>
>>> Remove the last 'else' checking to fix this error.
>>
>> Missing fixes tag.
>>
> 
>  From my understanding, fixes tags are for patches that fix bugs (hw is not 
> working etc) and not a warning message from dtbs_check. So my point of view 
> would be to not add a fixes tag here.

Not conforming to bindings is also a bug. Missing properties or wrong
properties, even if hardware is working, is still a bug. If such bug is
not visible now in Linux, might be visible later in the future or
visible in different OS (DTS are used by other systems and pieces of
software like bootloaders). Limiting this only to Linux and to current
version (hardware still works) is OK for Linux drivers, but not for DTS.

Therefore Fixes tag in general is applicable. Of course maybe to this
one not really, maybe this is too trivial, or whatever, so I do not
insist. But I insist on the principle - reasonable dtbs_check warnings
are like compiler warnings - bugs which have to be fixed.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
