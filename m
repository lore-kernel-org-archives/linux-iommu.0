Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6135CC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D659B405B6;
	Wed, 22 Jun 2022 14:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D659B405B6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DeOw2wN9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0AadbBTUyv0S; Wed, 22 Jun 2022 14:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9915840012;
	Wed, 22 Jun 2022 14:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9915840012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 596E2C0039;
	Wed, 22 Jun 2022 14:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A81FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30FAB60B16
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30FAB60B16
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=DeOw2wN9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NAvYQFl-jqLC for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:12:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6436460A93
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6436460A93
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:12:52 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id ge10so3019842ejb.7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
 b=DeOw2wN9IdijMC2unWkJBkn+F0tt1mYIyrxsmxR8zGIsx8/cjJnRnFkZjEYZR5v9Jn
 xz5LX66Z3YY5K4Zz3g8/bTlx4BWJohVZrld5+reQtujgrYk74t0a8x+Q11wcVAt+C3tx
 cPZO1WbrXhdHJI/4y6hmqzkZZDkM9BftULJwtglLO5v3H2TNVmFKjzegwg4PT/m03Dmi
 QXifV5FRRtVHRu5BFg6Ex0yCvBeViPdV3ntO12SIXDgEDa7+MghdN4/m9+20iyyIubTq
 +2YVHcgzLL0A3ljn87Q3x3JTVG8xnYWswRkIg6KCbStGL2xY4cS4jYioPHz8LNfR1EVN
 DKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ren2+uJhEOKFuly4Y7r0RVT/r2/Z143SWwTToasxhOA=;
 b=TQCaEtwN3F38xaoR5M7yeLDP4R347SSi4g37QwvzFXNZ/jYrldppbRKizrv7mVqMnY
 rnakmy8b8pb/5bJPtrsTZpIc4kchdbh0MkLJepF4UbNrzWgoJKAlQNOLk50S55xPQKXW
 UPGXGJ+Qr+e313gF8FN2pkBt0q/HjRbKopaY5Drwo3l2tYl/s4d7IjRS4W2cMs/cYIiq
 e8yjGWlywg9dm1A2ugAPpML2/RHtguP6uRgVgkEb1W1rD2WzFjm5JvlowrTzK8GcrIUj
 kU6uot44wteReGJV+gY741zx2iVCi6tCjUp/dh/0Y6kUPbhnH+V6c9aqCv/EsFXUm1a9
 SuOA==
X-Gm-Message-State: AJIora+iTBD50vqMeYa2v3BZoZW/5RZ/TSuXCxUyjNTShII2spb1hY6z
 S4N5AYpoX14oIevUgNQp29E=
X-Google-Smtp-Source: AGRyM1t0OvYHeXsCleYG7c+Bdl+xwzqiXlEMNOW8mbHHHkBOXkEEbMYHepKrU1rP9EliZy/8YVZE+Q==
X-Received: by 2002:a17:907:7b8a:b0:707:59d4:14a3 with SMTP id
 ne10-20020a1709077b8a00b0070759d414a3mr3351002ejc.51.1655907170343; 
 Wed, 22 Jun 2022 07:12:50 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a17090634c500b007041e969a8asm9257889ejb.97.2022.06.22.07.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jun 2022 07:12:49 -0700 (PDT)
Message-ID: <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
Date: Wed, 22 Jun 2022 16:12:47 +0200
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
