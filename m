Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3613D62
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 14:55:08 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11eab59db71so41606956fac.11
        for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 07:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tByLw1qEkiOZGzDHv1iwtkakEjYoENISc7jNLUAn1ZI=;
        b=HCASbP0eZhyNlJXoSZbiM0coxzx8hHlUZ6DEoww59DJ2jy2uAH6DP0jGDr3W9zny0A
         LCXr0gr/2KXVtbGSnISy/OYDdDpUXCWIdYEUoml3meVj1ovVDt503tShPAgk6QqASUNj
         SquNxm9h0FrwjLHFK/BWo6MehQs7lXaWMo8JttsKUPE62Dg3gMmR2b0vZ8UeX3DbdffS
         yqYpQkQA+GonHY0lAe9oHH3E2PcG8o245tUAlKqAx7DI1wC2cqEpof/zF1xEHB5+96zc
         fGN01CUTHxz49E7Z8NOsQyRSsu9qGaIJx8hY81NKLyWNtj83p9m6pg3ikzRm46mODjIw
         C8NA==
X-Gm-Message-State: ACgBeo3AkSi0FsalTMgfCxlx+t3pi1gB7DKLVjFplwTdTpnDSUS+KSjM
	hOje7pIyAWEUR60lja7Cow==
X-Google-Smtp-Source: AA6agR70yLqmwAo8ampR4EIA+plNY4V86lsveWAcGrBtki2l9qALN86LHK3Z0XMIwQY5gPpxtS1baQ==
X-Received: by 2002:a05:6808:ec7:b0:2f9:6119:d6ed with SMTP id q7-20020a0568080ec700b002f96119d6edmr1974104oiv.215.1663167307860;
        Wed, 14 Sep 2022 07:55:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020a056808028800b003431d9b3edfsm5303651oic.2.2022.09.14.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:55:07 -0700 (PDT)
Received: (nullmailer pid 2198793 invoked by uid 1000);
	Wed, 14 Sep 2022 14:55:06 -0000
Date: Wed, 14 Sep 2022 09:55:06 -0500
From: Rob Herring <robh@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>, 
	Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Borislav Petkov <bp@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Hari Bathini <hbathini@linux.ibm.com>, Kees Cook <keescook@chromium.org>, 
	- <devicetree-spec@vger.kernel.org>, 
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Message-ID: <20220914145506.GA2149379-robh@kernel.org>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-17-opendmb@gmail.com>

On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
> Introduce designated-movable-block.yaml to document the
> devicetree binding for Designated Movable Block children of the
> reserved-memory node.

What is a Designated Movable Block? This patch needs to stand on its 
own.

Why does this belong or need to be in DT?

> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  .../designated-movable-block.yaml             | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> new file mode 100644
> index 000000000000..42f846069a2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: /reserved-memory Designated Movable Block node binding
> +
> +maintainers:
> +  - devicetree-spec@vger.kernel.org
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +
> +properties:
> +  compatible:
> +    const: designated-movable-block
> +    description:
> +      This indicates a region of memory meant to be placed into
> +      ZONE_MOVABLE.

Don't put Linuxisms into bindings.

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reusable
> +
> +examples:
> +  - |
> +      reserved-memory {
> +          #address-cells = <0x2>;
> +          #size-cells = <0x2>;
> +
> +          DMB0@10800000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x10800000 0x0 0x2d800000>;
> +          };
> +
> +          DMB1@40000000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x40000000 0x0 0x30000000>;
> +          };
> +
> +          DMB2@80000000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x80000000 0x0 0x2fc00000>;
> +          };
> +      };
> -- 
> 2.25.1
> 
> 
