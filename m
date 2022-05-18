Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC24C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 01:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25541813CB;
	Wed, 18 May 2022 01:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-ydvJfEm8Yg; Wed, 18 May 2022 01:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 393A78175C;
	Wed, 18 May 2022 01:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 116B8C0032;
	Wed, 18 May 2022 01:41:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6165FC0032
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91ED340436
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eXqktqe34H2F for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:41:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08C7040500
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:41:45 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id j12so1063117oie.1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 18:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=INqLY13hD2JDCbK9Kzj2SkFwh0u4TnDrvBoPZ/nTnLs=;
 b=DEdd/TcR3wIzJwcyRoO9h0SYuwwqLYxdHuX3zWMA6TL+nlw0J7zBGvUrMS5/Wp9nBa
 xb6vAGb93fRlL9t3fCb4HskqHOZCCT5JcceYXseMStX9eHfO1iLNmJE5y66uPsnpDtxT
 SFS6ZLYoJihB8DWLq1AfcXGSRTfauZ1JfxINsSBxcb/FbR7l27buruSojF94B9ax9HjX
 4owpJv2T5godpEp6L6hz2TUJA6QDcRcz2/IZFp+XZuyCEpf1mHVfvEbRlkSsQJyv9IoS
 9/vn/uOQgLrsml63PLZcG2MdAG7TqfRdsyEwzp5M9m4ozIEFDA+1fosOKBG9m+ZOtDNJ
 INVA==
X-Gm-Message-State: AOAM530zDXsEEZ+p/mu0kzN0wCTTVJmM5hluWBQSQUr0zWCJuRsEdVSj
 vvxp+ZBl+Ksu7S6JmT2Nsg==
X-Google-Smtp-Source: ABdhPJx139iTWFrPfr5U9wHbjv2MePhCFY50wUeMLu11V52NqLmVBr0mHI4WiJnDdO+yAl/0Q2cQjw==
X-Received: by 2002:aca:e155:0:b0:325:6d76:da4b with SMTP id
 y82-20020acae155000000b003256d76da4bmr12579250oig.125.1652838105035; 
 Tue, 17 May 2022 18:41:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 g3-20020a056870a70300b000f174840b4fsm444606oam.17.2022.05.17.18.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 18:41:44 -0700 (PDT)
Received: (nullmailer pid 2044234 invoked by uid 1000);
 Wed, 18 May 2022 01:41:43 -0000
Date: Tue, 17 May 2022 20:41:43 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 7/8] dt-bindings: iommu: mediatek: Require
 mediatek,infracfg for mt2712/8173
Message-ID: <20220518014143.GA2024242-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, will@kernel.org
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

On Tue, May 17, 2022 at 03:21:06PM +0200, AngeloGioacchino Del Regno wrote:
> Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
> the required properties for these SoCs to deprecate the old way of
> looking for SoC-specific infracfg compatible in the entire devicetree.

Wait, what? If there's only one possible node that can match, I prefer 
the 'old way'. Until we implemented a phandle cache, searching the 
entire tree was how phandle lookups worked too, so not any better.

But if this makes things more consistent,

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
