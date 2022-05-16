Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4788BC433FE
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 16:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D61A4418DA;
	Mon, 16 May 2022 16:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ko7LQY7HKUTa; Mon, 16 May 2022 16:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4AFC416F1;
	Mon, 16 May 2022 16:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 900BEC0039;
	Mon, 16 May 2022 16:03:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA249C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B605F418D1
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Efb7jhJhLL36 for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 16:03:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1622D416F1
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:03:09 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 s12-20020a0568301e0c00b00605f30530c2so10353585otr.9
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yo1mI8/R7Wy9riO53UED6LxgLrSXbz5A0ENaW2C9bpU=;
 b=Eixh5es+kc2ZHmlOtdJ7zNuEcU2wllLZw7+XfH41MNRPPTR7HJvPeGRp2JtMp4uzq6
 measj3ZSnj0sOJuRAbWvTlhaBAGa3+19VJr8xmJOWRwkUbDecCWj6ht/Qq/fnoheY/yW
 0cxXaKFha3IfVOTUkv+8kjyGECj8oTNCyDKHt9PklPFk5NFEXPwAsFXGBIllZm7PQ0YD
 ygqXLzwM5L2yBwkRp9T12EzrropkN94xdLtb6GsPZNGTLVI1d32CZi3Z6TMkEz5iDXSS
 9mR+0P2+Ckog7qvw5Vqa8IvFqbalJGH4VAvqNBIxa52XjBYFT6SLrV0jE+bI+vFYa989
 rwgw==
X-Gm-Message-State: AOAM5326cf9R0N8+Liy28xDgeOdGqleMvhXYlfqjZfF+82yNsfMtU8Gp
 XTL8rVJhKQnmU7nwTi5eYQ==
X-Google-Smtp-Source: ABdhPJyZnvv3MvtJ0BpFTLVD4WxJ+CJ0091/m0FsrkT5PDbPjdHQaNeoSy79FCWg/C3J1d8uUv1Vyg==
X-Received: by 2002:a05:6830:12c9:b0:606:4482:74a0 with SMTP id
 a9-20020a05683012c900b00606448274a0mr6234159otq.17.1652716989012; 
 Mon, 16 May 2022 09:03:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 q5-20020a4aa885000000b0035eb4e5a6b6sm4288330oom.12.2022.05.16.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 09:03:08 -0700 (PDT)
Received: (nullmailer pid 2732699 invoked by uid 1000);
 Mon, 16 May 2022 16:03:07 -0000
Date: Mon, 16 May 2022 11:03:07 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Message-ID: <20220516160307.GA2732645-robh@kernel.org>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, paul.bouchara@somainline.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 marijn.suijten@somainline.org, matthias.bgg@gmail.com,
 martin.botka@somainline.org, phone-devel@vger.kernel.org, will@kernel.org
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

On Fri, 13 May 2022 17:14:10 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  3 +
>  include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
