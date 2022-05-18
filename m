Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B39AC433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 18:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E16CD60F1F;
	Wed, 18 May 2022 18:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V75Mof4oT_TI; Wed, 18 May 2022 18:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC13F60F6D;
	Wed, 18 May 2022 18:43:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBA1C0032;
	Wed, 18 May 2022 18:43:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC19C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66D9F4102B
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Po0pMQiwoE7h for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:43:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5094840374
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 18:43:42 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id i66so3713452oia.11
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nSo8w7W+OSVBY2zTRn/yV76t4zc61Jk0JXEwQ0qGoEY=;
 b=b9X3y8l6tTklfBg1+wcKekMUkbeFnig2ERgHPSt8oPHeYNpii2N6f5tCS86VSQvxVB
 gFrtlsjbQoKU4q7+oyOnO/ayCcIx9sQrOEIz5TqsVta+jsOAxs1Oa2FE4N/625TbQ8am
 bwiDm1DeVTFJk20BmdfcAHn6XuRG1j1tRKTtYKWC9qsQX7fM0jnFLYNaYKUHe8meNTix
 Sta4I4WO+OvV18xkWDutjfcCJp9gD3s1RK1K/SVIgvCu7qfdXv9sdEM0nP3tQkThgcfz
 wacdz706vxQ+Z3RlfGskX+1RhI+FmuzMELfvpupNJrK6M29nfC/e6R2HYg+EQFvPc3tC
 omWQ==
X-Gm-Message-State: AOAM532VD5DDufOdpJNps0UeERsQ/UJ/AKmUQBwO3/QDdveZrtp0vzMD
 HtZrH+j377I7kM1WrzPWaQ==
X-Google-Smtp-Source: ABdhPJxURTR1dLIW0z+AO7IFoBsGn5LcndospzqQor1Bg/tjfzW1ykX2baF3rSpYYdFTb74t+ZoaaA==
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr590558oiw.253.1652899421160; 
 Wed, 18 May 2022 11:43:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 q19-20020a4a8353000000b00333220959b9sm1265718oog.1.2022.05.18.11.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 11:43:40 -0700 (PDT)
Received: (nullmailer pid 3669786 invoked by uid 1000);
 Wed, 18 May 2022 18:43:39 -0000
Date: Wed, 18 May 2022 13:43:39 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 7/8] dt-bindings: iommu: mediatek: Require
 mediatek,infracfg for mt2712/8173
Message-ID: <20220518184339.GJ3302100-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
 <20220518014143.GA2024242-robh@kernel.org>
 <4ed63c3a-ec47-5801-ab89-b7d1a597c0da@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ed63c3a-ec47-5801-ab89-b7d1a597c0da@collabora.com>
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

On Wed, May 18, 2022 at 10:14:43AM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/05/22 03:41, Rob Herring ha scritto:
> > On Tue, May 17, 2022 at 03:21:06PM +0200, AngeloGioacchino Del Regno wrote:
> > > Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
> > > the required properties for these SoCs to deprecate the old way of
> > > looking for SoC-specific infracfg compatible in the entire devicetree.
> > 
> > Wait, what? If there's only one possible node that can match, I prefer
> > the 'old way'. Until we implemented a phandle cache, searching the
> > entire tree was how phandle lookups worked too, so not any better.
> > 
> > But if this makes things more consistent,
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> 
> Hello Rob,
> 
> This makes things definitely more consistent, as it's done like that on
> mtk-pm-domains and other mtk drivers as well.
> 
> The main reason why this phandle is useful, here and in other drivers, is
> that we're seeing a list of compatibles that is growing more and more, so
> you see stuff like (mockup names warning):
> 
> switch (some_model)
> case MT1000:
> 	p = "mediatek,mt1000-infracfg";
> 	break;
> case MT1001:
> 	p = "mediatek,mt1001-infracfg";
> 	break;
> case MT1002:
> 	p = "mediatek,mt1002-infracfg";
> 	break;
> .....add another 20 SoCs, replicate this switch for 4/5 drivers....

This type of property is used for poking random bits in another block 
(that's usually a collection of random bits). These interfaces don't 
tend to be that stable across many SoC generations. As there's no 
abstraction beyond perhaps what the offset is, the client side ends up 
needing to know the specifics of that block anyways. If the block is 
that stable, then perhaps it needs a common fallback compatible.

Sometimes these instances are also just places we haven't created a 
common subsystem for.

> and this is why I want the mtk_iommu driver to also get that phandle like
> some other drivers are already doing.

As I said, fine.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
