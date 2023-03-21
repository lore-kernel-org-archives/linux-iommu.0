Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6200D530
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 20:04:23 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-177b78067ffso17394554fac.7
        for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 13:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N90XyIxbKyLkJXYLM1vAYGNvhjgTfxNeBEga+2DXaA=;
        b=c2OlNTFIpRK0Oy7gMa/IeacwkIkDTq0ysEN4Z3FmB/OmmhDQaSHSuN0KCVAm+jnxo4
         ZzFvZ95vBJrNLtzIxg/U2GuAPK/0PRHBWZWEMJSQdWdOiNQC+ZAhcMl5vh8ND9DMVWTH
         GhUoLkdoZryI5lSHrO9WGlKfuhUP/V4xOKy0i1ICMNDrt2ZGZRf/YWIQKmvY7nH/RZw/
         ECe0u0kyhFlVl3wYuD0YAkiHpt+WEsWgMn9E7kPxPmVdxdNV+uZYHiP10twA5xevxdj8
         yynaQQ6A/lqczRGVvBo6L3i8PY1zB1qtk7TJpRFzuK8vLKFVVeJbLeRZRMdBRIveZ+mo
         CglA==
X-Gm-Message-State: AO0yUKWPfzpTPqyLqsVoQ9J6lbfRG9DTOUQeKz2xPpRW3UPVc3XT/F8q
	saVKWGY1y5E303Mwx9GSfQ==
X-Google-Smtp-Source: AK7set+BujNjHzku3uTLqRhdbQ+UDuw1QKFffw3xfZjiNEaXc46GCjn96WH6hYU2jdnpwijCR3OXKw==
X-Received: by 2002:a05:6870:7085:b0:17d:22f3:244e with SMTP id v5-20020a056870708500b0017d22f3244emr162900oae.14.1679429062848;
        Tue, 21 Mar 2023 13:04:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp8-20020a056808238800b0037d8c2ff0acsm5106802oib.12.2023.03.21.13.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:04:22 -0700 (PDT)
Received: (nullmailer pid 1362413 invoked by uid 1000);
	Tue, 21 Mar 2023 20:04:21 -0000
Date: Tue, 21 Mar 2023 15:04:21 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, joro@8bytes.org, robh+dt@kernel.org, geert+renesas@glider.be, robin.murphy@arm.com, iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH v4] dt-bindings: iommu: renesas, ipmmu-vmsa: Update for
 R-Car Gen4
Message-ID: <167942906116.1362361.13221797709558007164.robh@kernel.org>
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


On Mon, 13 Mar 2023 21:40:26 +0900, Yoshihiro Shimoda wrote:
> Since R-Car Gen4 does not have the main IPMMU IMSSTR register, update
> the bindings to drop the interrupt bit number from the
> renesas,ipmmu-main property.
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

Acked-by: Rob Herring <robh@kernel.org>

