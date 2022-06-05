Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB1C433EF
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 21:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF6684207;
	Sun,  5 Jun 2022 21:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUUz9ge-QE9Y; Sun,  5 Jun 2022 21:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD68984104;
	Sun,  5 Jun 2022 21:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 902ACC0039;
	Sun,  5 Jun 2022 21:13:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13648C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 21:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECDD8417DC
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 21:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5njER65tlMRa for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 21:13:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BE8F41701
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 21:13:30 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id az35so2529690qkb.3
 for <iommu@lists.linux-foundation.org>; Sun, 05 Jun 2022 14:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KpfFSC1M5yGrSdZeqGTbFQEXLC9iY/J8j0nw6v1d9eA=;
 b=I0Dz7LVcuXLny5E59fUCJ7+1Tq0dzdsTMh00AplzF4m5mk/Pz8F0I91MU700TUONYe
 xg4CBXzu+oCDi6MnooqFBqa/Re/2iBnIxUuWZB8krUmpyeP7jp+Taiaz3K6Se9CI4bae
 ywOq6VG4gIxKik1/wqASH4iArUAombWixFq6BHpMqrJHl3BNCEo/Z2HNq0pWps/umkdr
 D4K2bpGVzd0qYqyEgwQbq8C6eZK3gMuWFPBYJXZbmc8vIgwAq/HKj1vHwZzjPjozFlQV
 J7/BDbuK9zuOqjQCC/UwT2xHDTMp/ew5MzTknstBmeHjt7RBtVwqbMEF3Uo62xjNYr+P
 fmJg==
X-Gm-Message-State: AOAM530lH6xMp3CeojMQWSg7YAFRIahiSoR+BJGQEM0Wb0+1xecNlCFl
 pio4gOWbDcN28a1ZC8SUyg==
X-Google-Smtp-Source: ABdhPJxj+kVxZu2//p08PSHYzTQNamVKMAVwaHKls0V8bl/cpaDKySLz6Jed2QcRGNYVSKQw1ooWIA==
X-Received: by 2002:a37:97c5:0:b0:6a6:8d77:1b5f with SMTP id
 z188-20020a3797c5000000b006a68d771b5fmr11485785qkd.216.1654463609916; 
 Sun, 05 Jun 2022 14:13:29 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a05620a424f00b006a69d7f390csm6411744qko.103.2022.06.05.14.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jun 2022 14:13:29 -0700 (PDT)
Received: (nullmailer pid 3527763 invoked by uid 1000);
 Sun, 05 Jun 2022 21:13:26 -0000
Date: Sun, 5 Jun 2022 16:13:26 -0500
From: Rob Herring <robh@kernel.org>
To: Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Message-ID: <20220605211326.GA3525347-robh@kernel.org>
References: <20220530180328.845692-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220530180328.845692-1-fparent@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
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

On Mon, May 30, 2022 at 08:03:26PM +0200, Fabien Parent wrote:
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  2 +
>  include/dt-bindings/memory/mt8365-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8365-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 97e8c471a5e8..5ba688365da5 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -77,6 +77,7 @@ properties:
>            - mediatek,mt8173-m4u  # generation two
>            - mediatek,mt8183-m4u  # generation two
>            - mediatek,mt8192-m4u  # generation two
> +          - mediatek,mt8365-m4u  # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -120,6 +121,7 @@ properties:
>        dt-binding/memory/mt8173-larb-port.h for mt8173,
>        dt-binding/memory/mt8183-larb-port.h for mt8183,
>        dt-binding/memory/mt8192-larb-port.h for mt8192.
> +      dt-binding/memory/mt8365-larb-port.h for mt8365.
>  
>    power-domains:
>      maxItems: 1
> diff --git a/include/dt-bindings/memory/mt8365-larb-port.h b/include/dt-bindings/memory/mt8365-larb-port.h
> new file mode 100644
> index 000000000000..e7d5637aa38e
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8365-larb-port.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
