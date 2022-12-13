Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F92563
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 16:35:08 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1441d7d40c6so13198526fac.8
        for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 08:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJVQxyn8gXiSA1AhPudrUs7ABz5sBN5zDoG4vdYkTS8=;
        b=z5gQCqe/AzStJsTr1r0RqBn2U0AxW+20rYZyfRxEquiBwSjgr9EhacLDobTz7GvaGq
         HQWvdGrl95Wzd7y3MSlPtScvQjU7Hgr7cvaqHcXG/qAOpNEWY1bTOlVGbUaB40iVYnHC
         chL/tXTsoKeESznvE25KODqOxPA9CUKwcfljvo3FuoGQ3knr69kC4QIp7KQI1neZy/RP
         uXCuDMqyYRvZgymd0EWC9axf6c+8mzPTtNxgB70OcJFj+vGAY2KdzTUAhM6IjNjTMNpL
         bhE6zSga+VIyk31rlbDPFEx2/1LhDGO+gAjLcZ1hMGJe2yO6KhP23gq1b6+DSyA79Zp9
         xgmg==
X-Gm-Message-State: ANoB5pkzmSjYmhJcZfX3nt96KcgcQeP2wL0537jQT3Nd5vx/8R4qY05D
	XZfb5CQYHxxE8utzAAapsg==
X-Google-Smtp-Source: AA0mqf6gAyXmBROc/uHUvFJFQsXUK5ZsOJyrNY4N5rAb+6eVQ/bZLAv3s7BlqspIZ6lr1OzI3lo9/g==
X-Received: by 2002:a05:6870:4608:b0:13b:e0a:20e6 with SMTP id z8-20020a056870460800b0013b0e0a20e6mr10759985oao.34.1670949307632;
        Tue, 13 Dec 2022 08:35:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k16-20020a056870819000b0014866eb34cesm1570367oae.48.2022.12.13.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:35:07 -0800 (PST)
Received: (nullmailer pid 2014809 invoked by uid 1000);
	Tue, 13 Dec 2022 16:35:06 -0000
Date: Tue, 13 Dec 2022 10:35:06 -0600
From: Rob Herring <robh@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [RFC v2 1/2] dt-bindings: iommu: Document iova-best-fit property
 for IOMMU masters
Message-ID: <20221213163506.GA2011062-robh@kernel.org>
References: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>

On Mon, Dec 12, 2022 at 01:51:37PM -0800, Georgi Djakov wrote:
> Document the "iova-best-fit" device-tree property, which is used to
> describe that the iommu master is constrained on memory and the system
> must put more effort when allocating IOVAs to avoid holes/gaps in
> memory. This improves the memory utilization and helps with memory
> fragmentation issues in some cases, but it could take longer to allocate
> an IOVA compared with the default "first-fit" algorithm.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/iommu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

No new properties in common .txt files. Schemas only.

However, this looks like kernel policy which doesn't belong in DT.

> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 26ba9e530f13..ca1b4813c5bf 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -88,6 +88,10 @@ prevent any driver from properly setting up the translations.
>  
>  Optional properties:
>  --------------------
> +- iova-best-fit: When present, the best-fit algorithm will be used, instead
> +  of first-fit. This reduces memory fragmentation when allocating IOVAs in
> +  some cases, but may also increase the time it takes to allocate an IOVA.
> +
>  - pasid-num-bits: Some masters support multiple address spaces for DMA, by
>    tagging DMA transactions with an address space identifier. By default,
>    this is 0, which means that the device only has one address space.
> 
