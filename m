Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB84C433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 21:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07B614025E;
	Mon, 29 Nov 2021 21:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQpOQr1atEEd; Mon, 29 Nov 2021 21:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E74D3401F7;
	Mon, 29 Nov 2021 21:03:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C66EAC001E;
	Mon, 29 Nov 2021 21:03:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A0E1C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 21:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 154C140234
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 21:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyEKDrSQsirw for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 21:03:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCE6940366
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 21:03:26 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id n66so37001819oia.9
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 13:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WIr5+cJhpJp25U0PIV6j9kvUDudzJu8gP7H4qjx4440=;
 b=qYmNjXke0XOuxEkNayhmrhM9kVPlLbCk4Zqcn03AzatSwg9XPm52tc7DliVdAXlX+6
 PNNUbdVN781rpMfxI6UPvVZvBSjgre1A5vX3vYSeh4BmNaqiOJDNC4jssn5pvcQDHGNO
 i+wR+B+UOALhQE446/9LV8xtCT8uPn4uMWtJGzRG0sQIzQnKV/LZNj9AcVsNbwSiYk7p
 IO8x15ls5yrDR8s0cltQC1Ize2X2cTqJZ0OZnuoRu1nH+cINGJ123QbIIIMrMIJfry/E
 3Fwt4D5jhsiMr4/RDw6CtedHG8G2mYZzhbD+JyQyeM4ApmgO9wGftK66yE+og6zUCRJE
 jK7w==
X-Gm-Message-State: AOAM530V/MhXio5DzdxrJaW+/GCRPxnaR4VQn8/XxKM91rOO/xCXnjuS
 sJyTdtd+HVJgmbluz6OA1w==
X-Google-Smtp-Source: ABdhPJyHkwMvOrebHRlLhxyXq6Y1AW58fccLfFKwmowNesf7NO9AMidcfpraDVsx9FQuRbMFaXXjzQ==
X-Received: by 2002:a05:6808:144f:: with SMTP id
 x15mr414851oiv.157.1638219806008; 
 Mon, 29 Nov 2021 13:03:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id v19sm2817356ott.13.2021.11.29.13.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 13:03:25 -0800 (PST)
Received: (nullmailer pid 604956 invoked by uid 1000);
 Mon, 29 Nov 2021 21:03:24 -0000
Date: Mon, 29 Nov 2021 15:03:24 -0600
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: arm-smmu: Document
 nvidia,memory-controller property
Message-ID: <YaVAHNXpQS8gG+l0@robh.at.kernel.org>
References: <20211112131231.3683098-1-thierry.reding@gmail.com>
 <20211112131231.3683098-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211112131231.3683098-2-thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Nov 12, 2021 at 02:12:28PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> On NVIDIA SoC's the ARM SMMU needs to interact with the memory
> controller in order to map memory clients to the corresponding stream
> IDs. Document how the nvidia,memory-controller property can be used to
> achieve this.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index f66a3effba73..cf32a7955475 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -155,6 +155,12 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  nvidia,memory-controller:
> +    description: A phandle to the memory controller on NVIDIA Tegra186
> +      and later SoCs. The memory controller needs to be programmed with
> +      a mapping of memory client IDs to ARM SMMU stream IDs.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>  required:
>    - compatible
>    - reg
> @@ -177,6 +183,9 @@ allOf:
>          reg:
>            minItems: 1
>            maxItems: 2
> +
> +      required:
> +        - nvidia,memory-controller

That's not a compatible change. Document why it is necessary if that's 
intended.

>      else:
>        properties:
>          reg:
> -- 
> 2.33.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
