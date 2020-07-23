Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C6C433E5
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 20:47:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016FA2065E
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 20:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016FA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BA50F203CF;
	Thu, 23 Jul 2020 20:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKooHQlH2zyk; Thu, 23 Jul 2020 20:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 959792040B;
	Thu, 23 Jul 2020 20:47:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67E89C004D;
	Thu, 23 Jul 2020 20:47:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54A02C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 20:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3CC152040B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 20:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zm5bKp1xYyXj for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 20:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 5F56E203CF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 20:47:32 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id p15so5456525ilh.13
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 13:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ykIh0i0xy9qqdWkp/0xl4AY6xx/230nGu1DDjaI5lo=;
 b=Bmz2LAr9RfT8UwO+3Bn8+aAj9XRnMFc7XXSG2pcNf02XCR2U1Y5JmT997UkT2+W3/B
 7U6UPb1KzG3/uuXG2q4Lc8Qbz9OUEJWEebCnKX2/rKLLX7dnlBvQbKQDmW7ucLksUCBI
 p0GIKUJgBvId/cbprcP8iusVcRnlJCQ7yeYjbF0P6IdprH8JzGtLMQgS09WEsqNSRaK8
 WrPViTE2N1QE63VPfjYs9dCCs5Fx/xBwOQXye5bpbdttNRNaN6NGM0avls6sTtou3YbD
 Cwy9/aiWdnvWWurvXPKr3OwyIUMt0RCkKRDhL8ape8TslZBa9V9h+bBMJccpPk3LdRre
 ksGg==
X-Gm-Message-State: AOAM532M9uHYoX0eUPcqWwIMpyDy20xTCfKGHca2Cv4lIZHausA5Tcg2
 yThSbjU/CjXAasGdbuCVHQ==
X-Google-Smtp-Source: ABdhPJxj977xyK987KA25YXvHJw0KF0pYIdsSwCRmIfXKkWWW85uigcOZS4pmbBfQX5gRynZmqjiXQ==
X-Received: by 2002:a92:c792:: with SMTP id c18mr7006999ilk.223.1595537251697; 
 Thu, 23 Jul 2020 13:47:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id w5sm2032325ilm.46.2020.07.23.13.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 13:47:30 -0700 (PDT)
Received: (nullmailer pid 833108 invoked by uid 1000);
 Thu, 23 Jul 2020 20:47:29 -0000
Date: Thu, 23 Jul 2020 14:47:29 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 18/21] iommu/mediatek: Add support for multi domain
Message-ID: <20200723204729.GA823856@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-19-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Sat, Jul 11, 2020 at 02:48:43PM +0800, Yong Wu wrote:
> Some HW IP(ex: CCU) require the special iova range. That means the
> iova got from dma_alloc_attrs for that devices must locate in his
> special range. In this patch, we allocate a special iova_range for
> each a special requirement and create each a iommu domain for each
> a iova_range.
> 
> meanwhile we still use one pagetable which support 16GB iova.
> 
> After this patch, If the iova range of a master is over 4G, the master
> should:
> a) Declare its special dma_ranges in its dtsi node. For example, If we
> preassign the iova 4G-8G for vcodec, then the vcodec dtsi node should:
> 	dma-ranges = <0x1 0x0 0x1 0x0 0x1 0x0>;  /* 4G ~ 8G */

BTW, dma-ranges should be in the parent node of the vcodec.

> b) Update the dma_mask:
>  dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));

This should happen for you automatically. The DMA PFN offset 
should also be 4GB here.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 49 ++++++++++++++++++++++++++++++++-------
>  drivers/iommu/mtk_iommu.h |  3 ++-
>  2 files changed, 42 insertions(+), 10 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
