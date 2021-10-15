Return-Path: <SRS0=4al/=PD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADFCC433F5
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 13:44:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382DC61090
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 382DC61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0F81401F4;
	Fri, 15 Oct 2021 13:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnf4k5S1FkI4; Fri, 15 Oct 2021 13:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75EF940348;
	Fri, 15 Oct 2021 13:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FBABC0011;
	Fri, 15 Oct 2021 13:44:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB61C000D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CE1883AB9
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whQYv8J515IS for <iommu@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 13:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51F0E83AB6
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:43:59 +0000 (UTC)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E81640064
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634305436;
 bh=eEc0Vi/iayffTVpVwLxFg1C5akct/CAQN7k1AuOgZVk=;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=mYxgOPN5Jb1TUhAxbERSP6oDQkg7DCQNK8eFutEd5A20s2mxFGybFNL+foQd1WRpG
 ZxaqsIrJ4T2/uNSLlE7x+VPfqv6PMJtFujJyThFfRwUKGLx46/KB1/lzKKKteR1Ban
 fSIrwVAkj09TyzqyOaOm5IbQ+1sEFc7IXLpaMFSys5AEJx0Tw43kTKAuM6jHgfox+K
 rhLBTjx1GycliuZg+ol0ifw31Ln3IapsrFgbLyyUZHq6P33QnExUczT8WadfsLB/ay
 VntUX7yQTQiN8P6+ASCPK2gpPgKnK6TSawYMOZduT0eNCfQb3/TooFbh4uMdFsbqa4
 6cHROuIcSZLcw==
Received: by mail-lf1-f72.google.com with SMTP id
 s8-20020ac25c48000000b003faf62e104eso6716012lfp.22
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eEc0Vi/iayffTVpVwLxFg1C5akct/CAQN7k1AuOgZVk=;
 b=DfVpJ1ISO2fwiBIWM8vYPCCqdp7EUcWwsrO+JzTcgkdv82gEZvmIZ7hQGtvipRMnTT
 2whe8EeYxCiPGJlRM4or/6KYIkkPJFX7qAp2r/R/d4eaFURqkSteJNWiJ7C4BtrjJS38
 95P4zVwNFo5TKSCM378UXogp1vAxifduz4b7p6dpi9vEatz5N3vCcmKoS62RbDXJPWWA
 Gu6UTaClRfJ5/miIUW1awDdXGuVUvTW6R3rk8LnY/1x180oL936DXWysMY7wjY88dHaW
 UOoAGvyas9aJEj3XL5EAu0W1Zb1r340Pru2/fYaO+Visqif0DsBnAXLYYrCSjHy2/lko
 PyIA==
X-Gm-Message-State: AOAM530kN2Tv68HDxSTHbDyxmO359Hg7BA6L5aTWs82wnAPX3XGoYini
 FFVEpxVyUL7NglULyOToZuqYCpRhE8fYaue/vLQjs93SIgTaMH2+6HILsmvFhSnSlbjomn+Tt74
 Nbn6qbRgJ4Xa83HzA7ebf7+vgRVXrPEdNfdn5xKfrrWEF9i0=
X-Received: by 2002:a05:6512:308b:: with SMTP id
 z11mr11244744lfd.330.1634305435631; 
 Fri, 15 Oct 2021 06:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ+/w4Io+W6PbEi76wSIW7Mdthem4+NCuHObjSgdwIOXIeUa8NDjlAeavafuyp7tD/WUbVmQ==
X-Received: by 2002:a05:6512:308b:: with SMTP id
 z11mr11244728lfd.330.1634305435410; 
 Fri, 15 Oct 2021 06:43:55 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id bd19sm557333ljb.28.2021.10.15.06.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 06:43:54 -0700 (PDT)
Subject: Re: [PATCH v4 03/13] memory: mtk-smi: Use clk_bulk clock ops
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-4-yong.wu@mediatek.com>
 <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ab5c6dd1-7eed-4515-8781-c79e5317d038@canonical.com>
Date: Fri, 15 Oct 2021 15:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
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

On 15/10/2021 15:38, AngeloGioacchino Del Regno wrote:
>> Use clk_bulk interface instead of the orginal one to simplify the code.
>>
>> For SMI larbs: Require apb/smi clocks while gals is optional.
>> For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
>>                  also only require apb/smi, No optional clk here.
>>
>> About the "has_gals" flag, for smi larbs, the gals clock also may be
>> optional even this platform support it. thus it always use
>> *_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
>> The smi_common's has_gals still keep it.
>>
>> Also remove clk fail logs since bulk interface already output fail log.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> Hello Yong,
> thanks for the patch! However, I have an improvement to point out:
> 
>> ---
>>   drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
>>   1 file changed, 55 insertions(+), 88 deletions(-)
>>
>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>> index c5fb51f73b34..f91eaf5c3ab0 100644
>> --- a/drivers/memory/mtk-smi.c
>> +++ b/drivers/memory/mtk-smi.c
>> @@ -60,6 +60,20 @@ enum mtk_smi_gen {
>>   	MTK_SMI_GEN2
>>   };
>>   
>> +#define MTK_SMI_CLK_NR_MAX			4
> 
> This refers to mtk_smi_common_clks[] and should be probably moved after that.
> In any case, I don't think that there's any need to manually define this as 4,
> as you can simply use the macro ARRAY_SIZE(mtk_smi_common_clks).
> Using that will make you able to not update this definition everytime an update
> occurs to the mtk_smi_common_clks array.
> 
>> +
>> +/* larbs: Require apb/smi clocks while gals is optional. */
>> +static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
>> +#define MTK_SMI_LARB_REQ_CLK_NR		2
>> +#define MTK_SMI_LARB_OPT_CLK_NR		1
>> +
>> +/*
>> + * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
>> + */
>> +static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
>> +#define MTK_SMI_COM_REQ_CLK_NR		2
>> +#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
>> +
> 
> Apart from that,
> Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

The patchset was merged around a month ago:
https://lore.kernel.org/lkml/163229303729.7874.4095337797772755570.b4-ty@canonical.com/


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
