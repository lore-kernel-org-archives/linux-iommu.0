Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E4CCA47D
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB9C5841BE;
	Wed, 22 Jun 2022 14:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB9C5841BE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CQTnUj+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jky8n9hIh2zb; Wed, 22 Jun 2022 14:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A406A841D7;
	Wed, 22 Jun 2022 14:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A406A841D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB37C0039;
	Wed, 22 Jun 2022 14:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE49C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 386D260B16
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 386D260B16
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=CQTnUj+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZIrHBD1me6h for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:12:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D83660A93
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D83660A93
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id sb34so5494885ejc.11
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
 b=CQTnUj+3r1Tmk+T0IjuiHB1Hr4poYEqyzqY7e1KiKmdVMECfrXc4U5GEg0+HGYFtGK
 /63ZwSp/BIYc8pDjJQdAhJjVDxcvfs6MUrDxMOe3vyLpx3UjbS6NpkQTLniUIVmX4u9k
 la5+rQMbRD/KXjJML7sUQ573tQDMVpUt7frQWfL6v426debfnOw1gfnGXdzDh0wyC8QP
 bfGGXiL6G5Udv3dYc36Rgf7BiPgTaTD4g1UvxWwtPv+9vzPLSUSF4T8vIVvVTogpBJd6
 wOhbWPDWKTxaYUcyRxH8AXk1DGtjFpgk5+fcwKfl89uNIaiCFB7sR0oPLENO7/FMMx5C
 m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
 b=N7L57UAr1c35/smc8Ea/9lfSlktVJHTlIqp4X4kIiRgpG3Ci4AAJDWhjl7QHtCM+5x
 boNvkNNDktaRJQDRLUuFIFM2wqtGXXlzPc5351CenTRON4fp1cUuqSPyAFBHwE+0A/xa
 QZYr1BGQ33fcd+12N2rej1kL3ve4FaTBonSKWJh0R6lgGN+82P9nPzJwpDZYncHXscsP
 V7fXgggDn8mkwAas40Hful6wuziuKrZEfRS38Fo8kkSFJ9qq0BY1v1CFJQhH7Saej9U7
 Nx7eMKXfvqYOPg+vn2CAP8YvbplqkVzpgYwqQhJwPSebOLF2CzIXrxeJcUdJYn9PmF4G
 sBxg==
X-Gm-Message-State: AJIora8aPo9UF9ITWqPGExkbLa+XodxLOR7DN2qfGYM4QrI9ii9mGDj8
 sMIp8+Hxo96SCE4BkhLjzEM=
X-Google-Smtp-Source: AGRyM1tjj8BA36t5S7r9EYwBFt3Kn2rjeOb1UXCuXZaNTZE7evzeCkF4MwXZS/VBuSfPIwoVJ7nfIg==
X-Received: by 2002:a17:907:86aa:b0:722:d5b2:fca2 with SMTP id
 qa42-20020a17090786aa00b00722d5b2fca2mr3277139ejc.264.1655907171611; 
 Wed, 22 Jun 2022 07:12:51 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a17090632ca00b00722e7919835sm2332703ejk.111.2022.06.22.07.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jun 2022 07:12:49 -0700 (PDT)
Message-ID: <45a6ab4b-bc43-2c98-4f94-be6e4e9fc445@gmail.com>
Date: Wed, 22 Jun 2022 16:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and pericfg
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <YrMc2EUBDIxnoWiB@8bytes.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YrMc2EUBDIxnoWiB@8bytes.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 miles.chen@mediatek.com, will@kernel.org
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

Hi Joerg,

On 22/06/2022 15:44, Joerg Roedel wrote:
> On Thu, Jun 16, 2022 at 01:08:25PM +0200, AngeloGioacchino Del Regno wrote:
>> AngeloGioacchino Del Regno (5):
>>    dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
>>    iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
>>    arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
>>    arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
>>    iommu/mediatek: Cleanup pericfg lookup flow
>>
>>   .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
>>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
>>   drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
>>   4 files changed, 49 insertions(+), 21 deletions(-)
> 
> Applied, thanks.

I wanted to check if you took also 3 and 4, as these should go through my tree. 
Unfortunately you haven't pushed your tree (yet). In case you took the whole 
series, can you please drop the dts patches. I'll apply them now on my 
v5.19-next/dts64 branch.

Regards.
Matthias
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
