Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E3FC55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:39:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D992087D
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 18:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D992087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F4AD8527D;
	Thu,  5 Nov 2020 18:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UyeOiwSgyRZ; Thu,  5 Nov 2020 18:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 088B58506D;
	Thu,  5 Nov 2020 18:39:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD1AC0893;
	Thu,  5 Nov 2020 18:39:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2585AC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F32208542B
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TFayo5F1hb4 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 18:39:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B0B78506D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 18:39:23 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id k3so2353877otp.12
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 10:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oPwP/MMeCFhUmSj7N3WE3Z62TN2tMAgfxgbJBwkddp4=;
 b=G7JqKP8aoiAU0bYq0ypY+aoGh017Qo12jQX5APoOQpZQCg1z515AYVA+OXqCSJfi71
 4C4nN3ysTBiQ972RvSoCmD4t+K7ohHEwfJqSJwKO3Mtv9+SfJDcDwSNtUTVUIo+NoZHZ
 6dClxonv1/WXDGztAruT7og0BVUw0QwDnelkV56cPO8d4z0SOU5mY/hM7h+zDMCwS9Hm
 vMjWNzU4+pINOgVKUgg9bOcDMygqbeWMjszJNstpdw6u1fr+7XXw4JdrJHZ/k7s1WiSQ
 GC9ql1eKqkXfHx7EWTAeno92eVu1dCTS8XaoWEs9lw3rr17ccnx+IvngAxhoWGpSDOj6
 9AwQ==
X-Gm-Message-State: AOAM533G9+xz0GzAm2ztoGkf3kygKxNf4PKObPLCNz8bPS3WE8K8cCAs
 tyEawfRslRKKWJ4VnSm/PA==
X-Google-Smtp-Source: ABdhPJzRBgP5+/f3MDZQcsFSgW1dFGhtocXexNDBCjlPVJJSHJJGb717wfAecWqYjVCmXRQb6VMRYA==
X-Received: by 2002:a05:6830:1dab:: with SMTP id
 z11mr2479004oti.247.1604601562347; 
 Thu, 05 Nov 2020 10:39:22 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j3sm556796oij.9.2020.11.05.10.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 10:39:21 -0800 (PST)
Received: (nullmailer pid 1607749 invoked by uid 1000);
 Thu, 05 Nov 2020 18:39:20 -0000
Date: Thu, 5 Nov 2020 12:39:20 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201105183920.GA1607689@bogus>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, anan.sun@mediatek.com,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
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

On Tue, 03 Nov 2020 13:41:58 +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 130 ++++++++++++++++
>  4 files changed, 270 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
