Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB0C12002
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:12:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A2D6109E
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A2D6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56B1C40665;
	Wed, 14 Jul 2021 21:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NgqXh5lnMsB1; Wed, 14 Jul 2021 21:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C57C4037E;
	Wed, 14 Jul 2021 21:12:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 800E4C001A;
	Wed, 14 Jul 2021 21:12:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E88BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 075C66078A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AJ6SEzxSd4NV for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 21:12:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63D0560763
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:12:07 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id l18so3871271iow.4
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 14:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u0T8yxk3ADHwBjHH2WxpSHI7hYdlroWexCd530t9WFM=;
 b=VVa7MQlD5gXP/8DbYxalgPXkz6GXTtSf5k92MAF29IAIqC0daFbmlcsfltFD+Ja/yj
 +gNBEmVZiYkpEjKADqtl1aZM6H++6IgCfcNk6TKyjZVRXuag5YdW3oMJ4HXwdunoGshX
 niMi1VyucvdcnJLvi7fAs0GfLBV6rfet7tq36xa/CR36lEHP2spPNnLHS3lVQYQhbtTk
 kuOYdmKx36KdYNEWUnLO7pLrgSdNiU1kGavh79cOwsCDdXwXwfxPZynKBb1qExf01Ci/
 yPMq3rhp/sM5vsGspcIqY/IUVsHX0Y6tmma1gl0Grhbc5t7yH71pSpXUHxSzXCMkBd7J
 DpLw==
X-Gm-Message-State: AOAM532NuxQpmVEKUw5ONID/kvqzjdlDxZkuHJImRLAJXGA+JZxog9ZI
 3iBHbg/lWWHOLTG2zCJvDQ==
X-Google-Smtp-Source: ABdhPJwZWyyb2dpNruY5IFtlfTSV040Z1vLqwIxyzwYdK/m+mJL5npLfz6lMrc/RXg+/pntDInkeoQ==
X-Received: by 2002:a05:6638:218:: with SMTP id
 e24mr227669jaq.38.1626297126510; 
 Wed, 14 Jul 2021 14:12:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id w8sm1732316ill.50.2021.07.14.14.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 14:11:44 -0700 (PDT)
Received: (nullmailer pid 3531794 invoked by uid 1000);
 Wed, 14 Jul 2021 21:11:38 -0000
Date: Wed, 14 Jul 2021 15:11:38 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
Message-ID: <20210714211138.GA3531732@robh.at.kernel.org>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210630023504.18177-2-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>,
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

On Wed, 30 Jun 2021 10:34:41 +0800, Yong Wu wrote:
> This patch adds descriptions for mt8195 IOMMU which also use ARM
> Short-Descriptor translation table format.
> 
> In mt8195, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
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
> Another change is that we have a new IOMMU that is for infra master like
> PCIe and USB. The infra master don't have the larb and ports, thus we
> rename the port header file to mt8195-memory-port.h rather than
> mt8195-larb-port.h.
> 
> Also, the IOMMU is not only for MM, thus, we don't call it "m4u" which
> means "MultiMedia Memory Management UNIT". thus, use the "iommu" as the
> compatiable string.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>  .../dt-bindings/memory/mt8195-memory-port.h   | 390 ++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
