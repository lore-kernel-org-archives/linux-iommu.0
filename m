Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4431FC433E3
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E334207FC
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E334207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D986C85264;
	Mon, 20 Jul 2020 22:59:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ms47-JsPIWyQ; Mon, 20 Jul 2020 22:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 856DE8543A;
	Mon, 20 Jul 2020 22:59:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 694BEC0894;
	Mon, 20 Jul 2020 22:59:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C319C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3510788173
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UGnNvEXrxvzO for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 22:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5643188127
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:01 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id y2so19400296ioy.3
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AqV3qpi0FGYhyxxFKRbye9k2fummzEc60BukPe/XJ8Y=;
 b=goQJll37QHPYNCXuciTFlSlG1x/y9kubRltxnaMmy6QfJEmKEymHWPCKzP0aWyOoom
 JaubNrzVxa7r7fFh4QtaLAcIT5ol9NolMIp+8jkfuvlfYbg6TwWDwKuQEOpnfkMAcfDE
 LU/p9De3cJqhUHUrWjZZed3VLPBdtsNJBtfpdhXPseRgmJk5MAR64lIh6OlgzRCg9M5V
 D6UJfAXQHYFs7UCco5mOITvkqRKA7thJuYYliTJ/n34S1Sjb9memqpgmKm0RkW7JH5pX
 BBSR89t7gB5ahu7E7lA4UE+EE+6hPlBvdwMwMJvWur5xJAcF/Vl3E3rqtCtsWV4/fKR6
 TdtQ==
X-Gm-Message-State: AOAM532nzZsIgzipdxv5t4jCnzplb0JtUh7HKr+13O1pqQFhNCNFNSbm
 cXwJ6y65hnowxrXja/17Tg==
X-Google-Smtp-Source: ABdhPJyo2Hp5eLauB8HQjo3cnKWrGzjaOFfQckHGVee5U7GvWwSQW2q4MVMOF13cNUie2SuBdIrSfA==
X-Received: by 2002:a02:5b83:: with SMTP id g125mr28527695jab.91.1595285940732; 
 Mon, 20 Jul 2020 15:59:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id f9sm9522979ilq.9.2020.07.20.15.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 15:58:59 -0700 (PDT)
Received: (nullmailer pid 3105685 invoked by uid 1000);
 Mon, 20 Jul 2020 22:58:56 -0000
Date: Mon, 20 Jul 2020 16:58:56 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
Message-ID: <20200720225856.GA3105636@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-2-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, Tomasz Figa <tfiga@google.com>,
 Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
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

On Sat, 11 Jul 2020 14:48:26 +0800, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>  5 files changed, 19 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
