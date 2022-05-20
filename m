Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC55C433FE
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 22:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18268847A2;
	Fri, 20 May 2022 22:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZTDtiPvHAmY; Fri, 20 May 2022 22:20:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 11FE5847A4;
	Fri, 20 May 2022 22:20:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEA78C0032;
	Fri, 20 May 2022 22:20:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39C9EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 22:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 376C2847A4
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 22:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QYubOKmDpF9e for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 22:20:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1278847AA
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 22:20:14 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-e5e433d66dso11824885fac.5
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 15:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M8rmRCmN4GlSEfCUYx10TspLN6s4IxFkT9OjnFWex24=;
 b=LrB54lV3FIeNF4OigDQuC0IBTLq0MCGC6TamyYfmApTwVMgqoN52Cy2dc1XnAHsyl7
 VC7pLMwdCq3lTIpCLoKoFooWG5RX487ot8A3qa1bEc7CtSEo18MoC5/GiFA4kKtgv9Gb
 tP3Q4wdYQYhrn8pf1bfDw8TvJ+StcuEXAeuOE1qjkaJYzdi3bQAHNnaulMArEhsP03pH
 4dTu50Mb5J9OVrI6Y9+1IaNA5/S0o7qO9Ki9MY4+0T23QEOb0cCpRFhKgCrR/oeap8Bh
 H5s1+qmRrBGm2qBR3Fl/j+uNDQ/vueG6+QznURL3jOrmYd7dn+4UV3s927/fcIvNHig1
 7wMA==
X-Gm-Message-State: AOAM531xUl7d7FyKRY4Aemc+7us5Olbl+n2t04/GGZds8e1fTfAuG7Eo
 q9niu5eZLGXsZpcQiGRcGQ==
X-Google-Smtp-Source: ABdhPJwJjQIXPU0/UMu0hOETcS+SXwtTymvjCnqffWHXLumHewxkv7m+SwigscCX2nOUGYR5V10jnQ==
X-Received: by 2002:a05:6870:d109:b0:f1:ab23:9e with SMTP id
 e9-20020a056870d10900b000f1ab23009emr7621547oac.187.1653085213482; 
 Fri, 20 May 2022 15:20:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 184-20020aca05c1000000b0032698578409sm1572229oif.38.2022.05.20.15.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 15:20:12 -0700 (PDT)
Received: (nullmailer pid 354579 invoked by uid 1000);
 Fri, 20 May 2022 22:20:11 -0000
Date: Fri, 20 May 2022 17:20:11 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Message-ID: <20220520222011.GA354543-robh@kernel.org>
References: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
 <20220518101849.46804-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518101849.46804-2-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, martin.botka@somainline.org,
 konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, paul.bouchara@somainline.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, marijn.suijten@somainline.org,
 phone-devel@vger.kernel.org, will@kernel.org,
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

On Wed, 18 May 2022 12:18:48 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  4 +
>  include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
