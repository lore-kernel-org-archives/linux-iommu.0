Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C5CC6377A
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 02:51:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B7761362
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 02:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B7761362
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00F396084A;
	Thu, 22 Jul 2021 02:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xV3cMWaBuFN; Thu, 22 Jul 2021 02:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CEAF607A4;
	Thu, 22 Jul 2021 02:51:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D70FAC0010;
	Thu, 22 Jul 2021 02:51:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0781C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B95FA82A8F
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3o6-8INeer3t for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:51:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 385FF825C6
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:51:53 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id m20so4096955ili.9
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 19:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lsMmdb3RACH1JkoBJG5sGumKb94IlRY0tNHad0u0PRI=;
 b=BWu3IsnBWNJ6SYHYPjGcHrwLbUd22FJ5Wm4hinoPNxo/JOzCVI350dmdA/efKbXHRV
 0oy6E72/8JZbXKnutWyLA2jkPwn+yGjOtDPA6woHwvqkz4nnlvZLpn0ie9bw82Vjksrs
 kGcsTuCesY3Y2zoptUcI3VVPQSvCZTep0NNR0DP2pNNYHUUU+VC6RBhZYgJCw2e0M+XP
 NJ6I/9p0it+qwM1SoWEwXkQ3Eu99hPaanC7koigtUrDHweQwKApNiBU3Xd7J87vSmK1c
 w2SXjfMrpl4RCwFlM17khiBzmwc/SYUOpVbzy3hfVJjIm6H9ABoM+stMR3OZI6+AdOh1
 vT7A==
X-Gm-Message-State: AOAM533mA7TtJv8qcOxpUp9ViewNvnNFTk06OC6qw3qXzj5OOhos2iFa
 DcIkWh9sKUxZyPy3kBEkEg==
X-Google-Smtp-Source: ABdhPJzmZE18IFaBDdOlrhlpnBJ9AsAYn8ZvXINaR6JGQ41ByUku4NHP3Ts8jbSgGijUtBKOGvhjJQ==
X-Received: by 2002:a05:6e02:1a8b:: with SMTP id
 k11mr26794183ilv.136.1626922312055; 
 Wed, 21 Jul 2021 19:51:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id l9sm6060802iln.12.2021.07.21.19.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 19:51:51 -0700 (PDT)
Received: (nullmailer pid 3204306 invoked by uid 1000);
 Thu, 22 Jul 2021 02:51:48 -0000
Date: Wed, 21 Jul 2021 20:51:48 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: memory: mediatek: Add mt8195 smi
 binding
Message-ID: <20210722025148.GA3204276@robh.at.kernel.org>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715121209.31024-2-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, 15 Jul 2021 20:11:59 +0800, Yong Wu wrote:
> Add mt8195 smi supporting in the bindings.
> 
> In mt8195, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connect with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>  SMI_COMMON_VDO      SMI_COMMON_VPP
>  ----------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
