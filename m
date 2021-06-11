Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0ACC48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:07:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071E9613E7
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E9613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA70D41576;
	Fri, 11 Jun 2021 10:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XU3fqYDmqJuW; Fri, 11 Jun 2021 10:07:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B5B7414C8;
	Fri, 11 Jun 2021 10:07:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE04C000D;
	Fri, 11 Jun 2021 10:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A45BEC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 857898331B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPChHzuT-Zrd for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 10:07:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8A978329A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:07:29 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id l2so5437127wrw.6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gFhqPqOGSTJJX3dT27efQ5zQlrIM3h1f2aA9XZu0Vc8=;
 b=Fb53nvxjK0BcaL7BNdeGiZtFhAi6nR4cLzDs/h/OmS32FIVcPer0MefjbMscy6hQXG
 WMiJm90n3CUAcReVU4u3av59Vc6dEzxTd5D9bEFg8lJZiE210pmWEqeBDMBs1DQSL6dF
 MAF21gvl2Xq08HRmFab1/k4A/kSdoqnLrq33ukkcjDTHatq70Lv4U25FLv0FcqxhfNGO
 U7kVBzy5cS5yKtji5+YZARfpqSNYRHSw9oXO8shNn3E318Ag1KiTRFhxtfzd1EAkPoBy
 TJet10s2y8zWQ5CY/FGR9VQUKRpBUjE6b9Fwdn4A48fsQpWlWMUN14UbhJda6vp5o1s4
 TeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gFhqPqOGSTJJX3dT27efQ5zQlrIM3h1f2aA9XZu0Vc8=;
 b=Ns8YvaUeLYIR0xNdHbjfXqiYKu+GH9DH85r3XC5k9/0+IZkS2MSnir+hOPwtR3MDGm
 rrvp+qQc2gaWHyutRcWGgYLs0hZHh1LVcmBGcNToroGzQvRZ5L/NtmA562179LEi+KnN
 RnP0Bf0U9n9pG9Cd91WcPFd0nf6uNNmG6lELmo32jgNynw+DrejCBkMPl2xkI7vUBxXs
 7GPwXiQd62LetQaGo1qYTtiaxMTCPcAilTqtMR7VXsRGmFvHYAxbFKZi+Z565bt1o9VR
 Nzcxg+8BH09Rv4vU/RJQdBkRe6yrMivRZLeCsbFsEbxl2W/Onk5EK5PbW1TBqjUCSKG0
 +sFw==
X-Gm-Message-State: AOAM5308e24Wb/9llEgvsqAmw0+1TAws5yMU+mli2P+Gi0cRJr1G7+M4
 WjyJX8gi6wC2Ab01AjYgeP4=
X-Google-Smtp-Source: ABdhPJyXEm705FvtfJsTKJDMlqkddRVeBGjayOW/x5R9yipKm4VX2Cwnxm40M9p06MvhSKM1KAZsQg==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr3166775wrn.64.1623406047349; 
 Fri, 11 Jun 2021 03:07:27 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
 by smtp.gmail.com with ESMTPSA id r6sm6437738wrz.91.2021.06.11.03.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 03:07:26 -0700 (PDT)
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
 <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
 <1620822547.2983.8.camel@mhfsdcap03>
 <c1422242-8d8c-9592-c22d-288c503cd8b1@gmail.com>
 <1623326528.23717.20.camel@mhfsdcap03>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e7269c80-5437-6ab9-c1db-df0b94eb97d8@gmail.com>
Date: Fri, 11 Jun 2021 12:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1623326528.23717.20.camel@mhfsdcap03>
Content-Language: en-US
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, Devicetree List <devicetree@vger.kernel.org>,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>, ming-fan.chen@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 Alexandre Courbot <acourbot@chromium.org>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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



On 10/06/2021 14:02, Yong Wu wrote:
> On Thu, 2021-06-10 at 09:53 +0200, Matthias Brugger wrote:
>> Hi Yong,
>>
>> On 12/05/2021 14:29, Yong Wu wrote:
>>> On Wed, 2021-05-12 at 17:20 +0800, Hsin-Yi Wang wrote:
>>>> On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>>>
>>>>> MediaTek IOMMU has already added the device_link between the consumer
>>>>> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
>>>>> the smi-larb's pm_runtime_get_sync also be called automatically.
>>>>>
>>>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>>>> CC: Irui Wang <irui.wang@mediatek.com>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> Reviewed-by: Evan Green <evgreen@chromium.org>
>>>>> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
>>>>> ---
>>>>>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
>>>>>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>>>>>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>>>>>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
>>>>>  4 files changed, 10 insertions(+), 77 deletions(-)
>>>
>>> [...]
>>>
>>>>> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>>>>>                 }
>>>>>         }
>>>>>
>>>>> -       ret = mtk_smi_larb_get(pm->larbvenc);
>>>>> -       if (ret) {
>>>>> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
>>>>> -               goto clkerr;
>>>>> -       }
>>>>> -       return;
>>>>
>>>> You can't delete the return; here, otherwise vcodec_clk will be turned
>>>> off immediately after they are turned on.
>>>
>>> Thanks very much for your review.
>>>
>>> Sorry for this. You are quite right.
>>>
>>> I checked this, it was introduced in v4 when I rebase the code. I will
>>> fix it in next time.
>>>
>>
>> Please also make sure that you add all maintainers. I realized that at least for
>> the media/platform drivers we miss the maintainer and the corresponding mailing
>> list.
>> This is especially important in this series, as it spans several subsystems.
> 
> Thanks for hint. I only added the file maintainer here. I will add
> linux-media in next version.
> 
> By the way, this patchset cross several trees, then which tree should it
> go through. Do you have some suggestion?
> 

That's a good question. I think the media tree would be a good candidate, as it
has the biggest bunch of patches. But that would mean that Joerg is fine that.
The DTS part could still go through my tree.

Regards,
Matthias
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
