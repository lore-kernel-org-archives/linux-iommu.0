Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90E17C9
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 01:50:21 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77797beb42dso250020439f.2
        for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 18:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398620; x=1689990620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2Mze3/Yq/nh7qSNdsMivay/QWy7TAVvFvMJtevVwEw=;
        b=e3bF8LNCULFk8mSNCpB+xtfPEnOAvqg7Z/KqL6n4XRn9kRr9LGNPdb7u//EwwYyWIF
         vSQY0LhmTuzoZymjbojw3LqMUlM0u/3Z8dvzcbj8gu+isOt7yz1p320MZhmk2MGRTH4p
         /k+UfD90K4HUMcOjxvgHkQxEVPmxJkOepLwV5fW3TTwmR4MJv0beUfTDyfGx+hrzSUCE
         tg6GwS4NUEkWT9HDCxy46jb++jEX2L1yaGGeh/NppND1J8KIDRzNlwImsVepuz/FLokW
         eGKDCyH2sGvMuYTKej55z378x2lbkTvMxYXAy3lbQeos00BNGfclG7ckDOddOEz3YNSC
         BYlg==
X-Gm-Message-State: AC+VfDxKXQO8xAICvI60/Up6gVVyTO+zreSQRCiFQbBQ7lk/GlWc+21z
	zN8ot4r87GAifTT/7UhE8w==
X-Google-Smtp-Source: ACHHUZ4gHN5lx1VNqA3lrz/AK7vtmABjF34d3XbtEGB/rEnEY1QOupGofcoS2U+XLPoKgUexzlli/A==
X-Received: by 2002:a5e:8909:0:b0:76c:5ba7:7ef with SMTP id k9-20020a5e8909000000b0076c5ba707efmr8875578ioj.3.1687398620326;
        Wed, 21 Jun 2023 18:50:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s26-20020a5d929a000000b0077e3b1ffb52sm653456iom.12.2023.06.21.18.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:50:19 -0700 (PDT)
Received: (nullmailer pid 40156 invoked by uid 1000);
	Thu, 22 Jun 2023 01:50:17 -0000
Date: Wed, 21 Jun 2023 19:50:17 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robdclark@gmail.com, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-num
 property
Message-ID: <20230622015017.GA37013-robh@kernel.org>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
 <20230620095127.96600-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620095127.96600-2-angelogioacchino.delregno@collabora.com>

On Tue, Jun 20, 2023 at 11:51:22AM +0200, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> index d9fabdf930d9..0446ccc4116e 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
> @@ -71,6 +71,11 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      qcom,ctx-num:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The ASID number associated to the context bank.

If the value is ASID, then qcom,ctx-asid would be more descriptive.

> +
>      required:
>        - compatible
>        - interrupts
> -- 
> 2.40.1
> 
