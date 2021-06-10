Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F47EC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 07:53:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3166109E
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 07:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3166109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA683405AD;
	Thu, 10 Jun 2021 07:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VAzUIgxg4Fm0; Thu, 10 Jun 2021 07:53:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B56F404CD;
	Thu, 10 Jun 2021 07:53:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26131C000E;
	Thu, 10 Jun 2021 07:53:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8753CC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A5A3400C9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EjbpOzYOBjz1 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:53:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8170440025
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:53:37 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id e11so1119408wrg.3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xJS0U9ByX0NxIuJpqaNPHe7gI5LppZzf1YoFLwdpgpQ=;
 b=AtutUx5F3FjGQHEtvWof9HOeTHWeBqvhVw+QiN+Sh6cWWewDfrjuaZjOgIU8GrvZla
 6PSpE270aJ7Btt2qATsv9ZhQy58/0GoWWD5CnAISW5h2u03IY721oe03cmG/VhveVGw/
 fIvFr3ZW60yd5JvkbVc401CsPLw/sMlHMPcEsS7+8fpbgaPGboXiVI4p2aQC0iupWWUA
 yvllp02g0KpE38Gh0/adERukIXbEQPWpkg5Hwp0/YamaLVTu8RR0KbFJ4rBVKtlUE2CD
 YXQcYwiWadJ1e0HyfnyVp6gQIJJRAngE/XVLL6ga9zNZL97Pp6Vg5oRaiPOGaMV825g7
 /9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xJS0U9ByX0NxIuJpqaNPHe7gI5LppZzf1YoFLwdpgpQ=;
 b=Q8ReF1kNV1ncXI0xe8yWLbvMcSNgrUjzFqa+F1etxqUAi2mGOWcxiuBVNVLUQcIJ+J
 QhEW26yQqK9uPP3wMkQSxn/Wb7jkWby9AylbeKjole9qHww+4i1Ns1grXowm/ALvUacw
 GwdGv+shhh+vLLvmuSwEESqKtZwC5pN8BqHgu7KWzlVbA4Pc9YJMRGFLDvZj7OgINQbc
 1bXEGeg3F7eRoKqjJsVW2hV2Ry4PqLY4oh5YIVvgMu3CAWTZDbEfvVj9MXY3Gsf8Y750
 2DOEM8yx0CLoPLbmcjbAUJTO+SwEOnYXI6sju88qzCz83Q15KjRk3R47DWf5VI69F0uQ
 9U6Q==
X-Gm-Message-State: AOAM533YhanNtIfmZDH9iMGwLCFO3wyB381ifba/WaCAikpC4MBzwxSR
 yyc5vRN7uSGIl2pF794ndfs=
X-Google-Smtp-Source: ABdhPJyWIa0BThW8wleRBOOtD6X+dU2YcMMb96LCJzvn3Y7r3nvLUwAHQC9a6Zki2vUnentp0rRZoQ==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr3851640wrt.209.1623311615564; 
 Thu, 10 Jun 2021 00:53:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
 by smtp.gmail.com with ESMTPSA id o6sm2696870wre.73.2021.06.10.00.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 00:53:34 -0700 (PDT)
To: Yong Wu <yong.wu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
 <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
 <1620822547.2983.8.camel@mhfsdcap03>
From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
Message-ID: <c1422242-8d8c-9592-c22d-288c503cd8b1@gmail.com>
Date: Thu, 10 Jun 2021 09:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1620822547.2983.8.camel@mhfsdcap03>
Content-Language: en-US
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 Devicetree List <devicetree@vger.kernel.org>, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 ming-fan.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, Alexandre Courbot <acourbot@chromium.org>,
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

Hi Yong,

On 12/05/2021 14:29, Yong Wu wrote:
> On Wed, 2021-05-12 at 17:20 +0800, Hsin-Yi Wang wrote:
>> On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>
>>> MediaTek IOMMU has already added the device_link between the consumer
>>> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
>>> the smi-larb's pm_runtime_get_sync also be called automatically.
>>>
>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>> CC: Irui Wang <irui.wang@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> Reviewed-by: Evan Green <evgreen@chromium.org>
>>> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
>>> ---
>>>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
>>>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>>>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>>>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
>>>  4 files changed, 10 insertions(+), 77 deletions(-)
> 
> [...]
> 
>>> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>>>                 }
>>>         }
>>>
>>> -       ret = mtk_smi_larb_get(pm->larbvenc);
>>> -       if (ret) {
>>> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
>>> -               goto clkerr;
>>> -       }
>>> -       return;
>>
>> You can't delete the return; here, otherwise vcodec_clk will be turned
>> off immediately after they are turned on.
> 
> Thanks very much for your review.
> 
> Sorry for this. You are quite right.
> 
> I checked this, it was introduced in v4 when I rebase the code. I will
> fix it in next time.
> 

Please also make sure that you add all maintainers. I realized that at least for
the media/platform drivers we miss the maintainer and the corresponding mailing
list.
This is especially important in this series, as it spans several subsystems.

Thanks a lot,
Matthias

>>
>>> -
>>>  clkerr:
>>>         for (i -= 1; i >= 0; i--)
>>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>>> @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
>>>         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
>>>         int i = 0;
>>>
>>> -       mtk_smi_larb_put(pm->larbvenc);
>>>         for (i = enc_clk->clk_num - 1; i >= 0; i--)
>>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>>>  }
>>> --
>>> 2.18.0
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
