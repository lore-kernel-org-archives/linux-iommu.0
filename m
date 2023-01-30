Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967D79F7;
	Mon, 30 Jan 2023 21:41:33 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15fe106c7c7so16944410fac.8;
        Mon, 30 Jan 2023 13:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8L0iZJB3bUGW9JLNkuI2s2g9EvqK3MUpW23NqWSMDg=;
        b=gB04fic9RLvPQDzP9prffHyJIfKIn4iwXM9111G44PI1QMJoLDjOepdc+f0o7rFegd
         +CwbURqTj5WFUGMuFPV0DE4X5I3mEDtTnpfm9dC7RujodtN8K2hpU+4xmWUYbtA1uH2U
         NSmgCM+O9/9OjZyf+XYOyR6eOVGmWLXdJLE7YfC+d0BEQadonmWtq0zY6VYPW4GcWYL8
         4O5MgHeopbB2gvgH03dSl6X+EOHEeFbyhI2tOCZwpFOae0ZgYGASML0UTc0HC1gtfjtx
         /5vIzcsZkcssmUmk78RqrOJGwSDTj3UH8301Ege4nfyI6Qqwik/cOIK/HHKSQYAVi1AJ
         HpBA==
X-Gm-Message-State: AFqh2kpaAzAJjbA6EsSeSYyi12yRWdLhztRgB0uAnFnWHdA5MLSt2oj7
	cP82g+8Gz2Af2SjTGXMrNg==
X-Google-Smtp-Source: AMrXdXuUUyx0J2fyOl+V0z9H3zFvJSnOqxZ+0A4HPV/Hc7mTZNyygaal32QIuFxRT/LW5jQm6sHG6w==
X-Received: by 2002:a05:6870:b14c:b0:15e:d25e:6d18 with SMTP id a12-20020a056870b14c00b0015ed25e6d18mr28491405oal.12.1675114892154;
        Mon, 30 Jan 2023 13:41:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b004a0ad937ccdsm5421116oom.1.2023.01.30.13.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:41:31 -0800 (PST)
Received: (nullmailer pid 3578192 invoked by uid 1000);
	Mon, 30 Jan 2023 21:41:30 -0000
Date: Mon, 30 Jan 2023 15:41:30 -0600
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart
 compatible
Message-ID: <20230130214130.GA3576591-robh@kernel.org>
References: <20230128111114.4049-1-sven@svenpeter.dev>
 <20230128111114.4049-2-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128111114.4049-2-sven@svenpeter.dev>

On Sat, Jan 28, 2023 at 12:11:11PM +0100, Sven Peter wrote:
> This DART variant is found in the t8103 (M1) SoCs and used for the
> USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
> up to 64 SIDs and require a slightly different MMIO layout. This variant
> is only found on the M1 SoCs.

Looks fine to me other than the discrepancy in the name.

> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> index 903edf85d72e..f9c1843c074d 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - apple,t8103-dart
> +      - apple,t8103-dart-usb4
>        - apple,t8110-dart
>        - apple,t6000-dart
>  
> -- 
> 2.25.1
> 
