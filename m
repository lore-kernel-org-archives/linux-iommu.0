Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E64C43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 08:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 486708404A;
	Thu, 16 Jun 2022 08:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDGUoGytkNBq; Thu, 16 Jun 2022 08:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2698182A29;
	Thu, 16 Jun 2022 08:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E93EEC0032;
	Thu, 16 Jun 2022 08:45:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87C9CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6313340119
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vOPoYZ-gMCFi for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 08:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16E3A400C6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 08:45:52 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 44EA16601745;
 Thu, 16 Jun 2022 09:45:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655369151;
 bh=3V8ML5nble416YqEnklIe2qV+U/q3IDZwUrctK/WtyU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jQrHrvQuytaaFWaSqxSHYM0vSS05al78apQ2LJHpDN0hf2dloTBuGpNpWqYBWmsy3
 tyRtoMdES5KqdD1iIQG+xYHTYbN0FGyVjvR4JqmU0olldQRi5BmIAn1CyH8fEFvDQH
 SWB7PyRiC7TiLacNPQhqQ5CIQMP5MO7WYVjfxdztcd3jdY9jmnf9TDAfELy2oE9K4t
 rVbzOokhsQRWjeSq9hl6KWTLDUofWN8quKmI0vWq3LWmVylaz9yAuMk6zxZCYM5rNJ
 fv6bBWLzZ9sAiIFo/uRoG6/qWLVSg1AWwo3rtwOKiPq8Ze0UlJ2cMR+IQtTeKplz1u
 BR2QhjXvcrSnA==
Message-ID: <5bc0a278-6a78-efec-f07b-a990830253f8@collabora.com>
Date: Thu, 16 Jun 2022 10:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
 <80c7fa61-e25a-fc45-bdcb-60ac3796b96e@collabora.com>
 <2d0f49294a8bac34dd5dd1ce4201f009a207b7a7.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2d0f49294a8bac34dd5dd1ce4201f009a207b7a7.camel@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, will@kernel.org,
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

Il 16/06/22 08:30, Yong Wu ha scritto:
> On Mon, 2022-06-13 at 10:13 +0200, AngeloGioacchino Del Regno wrote:
>> Il 13/06/22 07:32, Yong Wu ha scritto:
>>> On Thu, 2022-06-09 at 12:08 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> On some SoCs (of which only MT8195 is supported at the time of
>>>> writing),
>>>> the "R" and "W" (I/O) enable bits for the IOMMUs are in the
>>>> pericfg_ao
>>>> register space and not in the IOMMU space: as it happened already
>>>> with
>>>> infracfg, it is expected that this list will grow.
>>>
>>> Currently I don't see the list will grow. As commented before, In
>>> the
>>> lastest SoC, The IOMMU enable bits for IOMMU will be in ATF, rather
>>> than in this pericfg register region. In this case, Is this patch
>>> unnecessary? or we could add this patch when there are 2 SoCs use
>>> this
>>> setting at least?  what's your opinion?
>>>
>>
>> Perhaps I've misunderstood... besides, can you please check if
>> there's any
>> other SoC (not just chromebooks, also smartphone SoCs) that need this
>> logic?
> 
> As far as I know, SmartPhone SoCs don't enable the infra iommu until
> now. they don't have this logic. I don't object this patch, I think we
> could add it when at least 2 SoCs need this.
> 
> Thanks very much for help improving here.
> 

Many thanks for checking that! Now that everything is clear, I can safely
go on with pushing a v4 of this series.

Thanks again!
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
