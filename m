Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE91C03
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 14:49:16 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17997ccf711so13342337fac.0
        for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 07:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HQ2/RBVM5ivbrUSk8sQg1YLF+lsQLWjCSPQVmBOV9U=;
        b=uXoSKFylV2e0zp7R8OKO8VABKo3TXezNbqkPffJA8EW+nx87AIpn8OsMBtHuwJvCdZ
         GaVccEeS1LDXuFvmuIi6gJz+6XScpv9wDKDZjIjRWKWb1wXBYc/E3uaSiYuBnLs6FozZ
         tHYCje2WfhhCj4+PRvEz+0s5kKdlvCKVzZnt97ESW7OSHXkum5C5O4iBEfKbhpR9Vun+
         J3/sB7rQoumxZer0tL2PtpQ/fun9HGNAA5WQNvWswKhWRTBBYNWfGFEA+tANeDSoV89A
         T6qhgcOWvvMGIrEBC1oqLc6vk5HTRtLaNt3evhgKHAWn1a/3Sot0B5wv+WvsXxS8c0kA
         PRSQ==
X-Gm-Message-State: AO0yUKWo0rXUpWoD0uQrfPu6zbOmG6k2GxBcEpqF9XZH6mW93Ea5fgvt
	3o71fhor98dOFGOyqG7Lvw==
X-Google-Smtp-Source: AK7set/ZCTDXdsG18Bu/FCuwWWVwlwzog1n2WnJjg1X7C4DhvYAQ7wmM2mbS4GSt3Ueo1m7Zvq/BYQ==
X-Received: by 2002:a05:6871:285:b0:177:c4c1:db8a with SMTP id i5-20020a056871028500b00177c4c1db8amr5902297oae.0.1679323755507;
        Mon, 20 Mar 2023 07:49:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq24-20020a0568718e9800b00172721f6cd5sm3354302oab.16.2023.03.20.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:49:15 -0700 (PDT)
Received: (nullmailer pid 1615498 invoked by uid 1000);
	Mon, 20 Mar 2023 14:49:14 -0000
Date: Mon, 20 Mar 2023 09:49:14 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org, geert+renesas@glider.be, iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: iommu: renesas, ipmmu-vmsa: Update for
 R-Car Gen4
Message-ID: <20230320144914.GA1609519-robh@kernel.org>
References: <20230313124026.954514-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124026.954514-1-yoshihiro.shimoda.uh@renesas.com>

On Mon, Mar 13, 2023 at 09:40:26PM +0900, Yoshihiro Shimoda wrote:
> Since R-Car Gen4 does not have the main IPMMU IMSSTR register, update
> the bindings to drop the interrupt bit number from the
> renesas,ipmmu-main property.

Wouldn't it be easier to define a value meaning 'no interrupt bit' such 
as 0 or ~0 than having a variable sized property to parse?

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> [geert: Re-add removed items level, add minItems/maxItems constraints]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Changes from v3:
> https://lore.kernel.org/all/20230209133440.2643228-1-yoshihiro.shimoda.uh@renesas.com/
>  - Revise the dt-bindings by Geert-san (Thanks a lot!).
> 
>  .../bindings/iommu/renesas,ipmmu-vmsa.yaml    | 32 ++++++++++++++-----
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> index 72308a4c14e7..be90f68c11d1 100644
> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> @@ -74,16 +74,16 @@ properties:
>    renesas,ipmmu-main:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -      - items:
> +      - minItems: 1
> +        items:
>            - description: phandle to main IPMMU
> -          - description: the interrupt bit number associated with the particular
> -              cache IPMMU device. The interrupt bit number needs to match the main
> -              IPMMU IMSSTR register. Only used by cache IPMMU instances.
> +          - description:
> +              The interrupt bit number associated with the particular cache
> +              IPMMU device. If present, the interrupt bit number needs to match
> +              the main IPMMU IMSSTR register. Only used by cache IPMMU
> +              instances.
>      description:
> -      Reference to the main IPMMU phandle plus 1 cell. The cell is
> -      the interrupt bit number associated with the particular cache IPMMU
> -      device. The interrupt bit number needs to match the main IPMMU IMSSTR
> -      register. Only used by cache IPMMU instances.
> +      Reference to the main IPMMU.
>  
>  required:
>    - compatible
> @@ -109,6 +109,22 @@ allOf:
>        required:
>          - power-domains
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rcar-gen4-ipmmu-vmsa
> +    then:
> +      properties:
> +        renesas,ipmmu-main:
> +          items:
> +            - maxItems: 1
> +    else:
> +      properties:
> +        renesas,ipmmu-main:
> +          items:
> +            - minItems: 2
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
> -- 
> 2.25.1
> 
