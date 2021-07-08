Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E804C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:26:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE373619C5
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE373619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6BD8406AB;
	Thu,  8 Jul 2021 09:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnMNTwaPqgst; Thu,  8 Jul 2021 09:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6621A404A3;
	Thu,  8 Jul 2021 09:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED5CC0010;
	Thu,  8 Jul 2021 09:26:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 882D0C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 680C8404A3
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B55SN_5JBR-U for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 09:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96BCE40603
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:26:11 +0000 (UTC)
Received: from mail-wm1-f70.google.com ([209.85.128.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1m1QIL-0006Bp-3j
 for iommu@lists.linux-foundation.org; Thu, 08 Jul 2021 09:26:09 +0000
Received: by mail-wm1-f70.google.com with SMTP id
 h4-20020a05600c3504b02902190c4d3d18so380337wmq.8
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 02:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=koIPrhzeeGnASWujJpf7LVgsTrCU+gcQgVFV1kcN3ho=;
 b=r2hn5MqOhWYG/z7n1olc+fK9uC/a28YgoyRfF9zzktnGWtRI4MUAuO+lr0YTJ6oq4D
 zL67cA6l/Tm/a8nEZJO1fKiZN8MVCYqOtClaTb7n8blP7gairNm3jCbsR6QohFJayT1K
 yCS1FzseVWLuN0yeCRlg+zLqNeyRMpqjkAYnArY7Fsbx1O5p1Y36Cnx696i7343eB7vA
 0IdS0NBJR6rkLA5rFiDjOn0/etLDbNTc3B9uMyuwdDO2ECitqNArfU0awF/u6XOKajT7
 LXuIs4S1IxBvwsaVuTrm6S1NMz62gKSTMHnDurzmj/wZxhvyBZBLl2Vyk0C81UXT2ToI
 psFQ==
X-Gm-Message-State: AOAM532Z1v1cYpuy/jzjHktwh7KcK0yR3RK3HqXFfs1ZuV+h7VuJmANO
 B9wBUGqgp1gLwXsAAu+3YAYhNjx40rdyQslCq66TTgGtEUshEiCkQHepHsTlBJMUXLCDZMeQwHc
 CACieCecFxIFFpCpaTeNAelh8qcyZhy6EZ8WMoWcMZ59FjZ0=
X-Received: by 2002:a05:6000:1ac6:: with SMTP id
 i6mr29153776wry.327.1625736368926; 
 Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9bTjhzy4ewOg0e87DpVaZF42E3AYLNFYRiKycIX46b0OEGS9rxawBZpCgOiwlhnyBj7S+/Q==
X-Received: by 2002:a05:6000:1ac6:: with SMTP id
 i6mr29153760wry.327.1625736368771; 
 Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id h10sm4020332wmb.46.2021.07.08.02.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 02:26:08 -0700 (PDT)
Subject: Re: [PATCH 1/9] dt-bindings: memory: mediatek: Add mt8195 smi binding
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6e512d15-3acc-2097-1fd1-e021552fdc8d@canonical.com>
Date: Thu, 8 Jul 2021 11:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-2-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 16/06/2021 13:43, Yong Wu wrote:
> This patch adds mt8195 smi supporting in the bindings.
> 
> In mt8195, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connects with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>   SMI_COMMON_VDO      SMI_COMMON_VPP
>   ---------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

I cannot find it on devicetree list, it seems you did not Cc it. Please
use scripts/get_maintainer.pl.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
