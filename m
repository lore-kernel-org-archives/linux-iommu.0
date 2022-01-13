Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D15DC433EF
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 16:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE12B84CB6;
	Thu, 13 Jan 2022 16:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaM5Ewmh1o20; Thu, 13 Jan 2022 16:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E29CB84C9D;
	Thu, 13 Jan 2022 16:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CDFC002F;
	Thu, 13 Jan 2022 16:10:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2658DC001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 16:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D19341665
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 16:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yg0bKC0vfHaf for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 16:10:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EF5141661
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 16:10:21 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 25-20020a05600c231900b003497473a9c4so5711899wmo.5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=SPmaJub/jt94ihGwagtrfHtir8UBrBvypTKNKojeyrA=;
 b=BVBB+Qut1wf0yDLs2pgabC7QOG2Sq+20jm8ssrux8M/cL6yIEQ1cLoONRsJ3tAFOB7
 mAVtexOZomadjCBu5HS3//ck38nB8thHf4Vsb7B2Gu4SmYo1PXrWLt2A/RhTYRAs6chT
 A2yuc9kt7p1baJ7py4FCWgs7rw24L85tVk/4W8LVfElgZ03rT963kaaa4VkbN1DiwUXJ
 qnZsvby+F23F9gT8jaP+rJib0mnv6iej7oPfza94pno6s+bMVe/moC6XsPcGH0KE1brn
 /SZzMZYnKFEdbiVSWGxvCwwKgWv2AzgqwSWAiyOixbcDRB9AlAXLXpExApLKl7EkW3Oy
 FPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SPmaJub/jt94ihGwagtrfHtir8UBrBvypTKNKojeyrA=;
 b=4tP8+sirS5raSSlY1mSkB/TmXvE/t5LbfuMaHUl2g8c7iUrUEOuNQ1AWS41xXA8jz+
 XjYAmrfNwxb3KcQZMQfDk6+wwRChezgHAjG/B+E1XERbv1SLtaGRdjBZL8gij8K/QWjd
 WW5GdV+QhrZVWLUxWLC6vJjHqtgcnLo+8wqeRIUor31N/4mx+3fsPGSW0W2Swg0+XeMy
 Xjn9zQfGD52oyyhTN1hM5/avXdmNvDuc6C6DzNXqf124t6Ugr5sHJE+74uupNHnAc13w
 MtqpfFlo5S+ChNs0Han3UABbH+CZBcPqX/7s3l15Oh1FJLtff8uyQbS3EM2osfagl4YW
 3s4Q==
X-Gm-Message-State: AOAM5313itB9PXYvRaYa5nmnx03MgmH/czOww7TjDZbowplfH85+2ZrJ
 3GByfanH4pbDAxL4wamVXQc=
X-Google-Smtp-Source: ABdhPJz71D45GcRwagirhvSlyWM52OERaCgTDonsBE7CR9XIAMLCsE2GIYUK2N2X+W/NKuR3LQ9Flg==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr11718665wmb.5.1642090219767; 
 Thu, 13 Jan 2022 08:10:19 -0800 (PST)
Received: from [192.168.0.18] (81.172.62.207.dyn.user.ono.com. [81.172.62.207])
 by smtp.gmail.com with ESMTPSA id f8sm9488614wmg.3.2022.01.13.08.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 08:10:19 -0800 (PST)
Message-ID: <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
Date: Thu, 13 Jan 2022 17:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
 <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
 <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 libo.kang@mediatek.com, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
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

Hi Hans,

On 13/01/2022 11:15, Hans Verkuil wrote:
> On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
>> Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
>>> Il 12/11/21 11:55, Yong Wu ha scritto:
>>>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>>>> then remove that function, use pm_runtime_disable instead.
>>>>
>>>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>>>> rename it from the _pm to _clk.
>>>>
>>>> No functional change.
>>>>
>>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>>> CC: Irui Wang <irui.wang@mediatek.com>
>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>
>> Hello Yong,
>> the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
>> scheduled that for v5.18.
>>
>> Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
>> media: mtk-vcodec: *) from this series?
>>
>> For the records, I think that after sending v10 this series is ready to be merged,
>> as it was well reviewed and also tested on many MTK platforms.
> 
> Good to know. When I have the v10 I'll try to prioritize reviewing it and running
> my usual tests.
> 
> Yong, please make sure you run 'checkpatch.pl --strict' over the v10 patches and fix
> any issues (using common sense).
> 

Can you please take me in the look when you take the patches. I'll take the DTS 
related as soon as you queue up the others.

Thanks!
Matthias

> Regards,
> 
> 	Hans
> 
>>
>> Thank you,
>> - Angelo
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
