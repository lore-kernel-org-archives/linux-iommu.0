Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7E0C4332F
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 11:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EE6141694;
	Tue, 31 May 2022 11:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsAx9MpBwLyM; Tue, 31 May 2022 11:52:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91C4C41610;
	Tue, 31 May 2022 11:52:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B389C0032;
	Tue, 31 May 2022 11:52:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC826C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA9A54167F
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:52:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBW_x4366dCl for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 11:52:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 607EC41610
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 11:52:18 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id c2so7623869edf.5
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=pgwp2VdYx+Vpnhun4TNi+eC2topHBL0Uwk1ptGJfZcE=;
 b=iS5jhowOcF/lfXAMYJ1n2lLpF7hUtwsQikH8pir763iCnTkaHoMbpuD2JWonqpofGu
 qjyArBVFBAgZQ9fQpr/S/sNnTQgp1XR5p/rqsj3MhdJ+R24/EaY9Jbv7/STxX0BhfOae
 vvpJfMMcFbUtqlhICqYrW8DyeWTZfTB31dRM0WNqVaDsLbFsSSYIr3kJMkl8EIu8eyG0
 IjQQuD7laFKec1PktUnxtrsiM3a+rYcN+wihWCwjJw7hyQww5pG4m0uXI4PcjIotDFcu
 f+NP9XC8R9LGUd3NPhygDtKFvwynWln1GjMt/3m1CHmsTLxPB1Nv/M1Gb8i3wsWht7ok
 zmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=pgwp2VdYx+Vpnhun4TNi+eC2topHBL0Uwk1ptGJfZcE=;
 b=Dx98Zy4KGq8pRJd6KySj7wnXt6pr/ak7K6LthZ2fBvC9kLNYXzOnrpbauHkDkdmR0H
 h6ly60Vb18agLJ6UgLyk6H3eQ2MHLUWGo2+nlf7OQURW8V8yeOZEwHJm5LYh5jTEd4SS
 v1z3e5SrTcK9WrcdhRZN6mxP6MsCUJbIs1Z0G/6fVtqH6/cB4W6OBvLAEbw6CDhjgmA8
 ijhCpewCjOghyDYDFPog+A+X9JSwgq7N74k6gEJ5du1k39wrsnrMYmkfObQe+cjxpGqP
 40V1IWb9KMNmh0n0/NZeD70tCuMD5IZFgXTPX2YBj51+fDAWIrO1kUexksKkDioY6jlb
 hLCg==
X-Gm-Message-State: AOAM530Pd80s4/lDO1cmFC9aCyEvn9IvYAbaj2DBhB/pDZIClq19BUdv
 Jv4c8k1H0XY9rPCkm2uOC0RY1Q==
X-Google-Smtp-Source: ABdhPJzLoz1xLJgBhIhIcXu/CVKt7lUZqurHOJkAtVo1mU8l+2AAQXVVLJ65/yyrjl+Cx6OqWRo0rg==
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id
 g18-20020aa7c852000000b0042d70d82864mr19815609edt.379.1653997936660; 
 Tue, 31 May 2022 04:52:16 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 c13-20020a50d64d000000b0042617ba63cfsm8278497edj.89.2022.05.31.04.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 May 2022 04:52:16 -0700 (PDT)
Message-ID: <15eef004-74c7-0eb5-3f87-86e164ef70ff@linaro.org>
Date: Tue, 31 May 2022 13:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
Content-Language: en-US
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>
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

On 30/05/2022 23:00, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> new file mode 100644
> index 00000000..ab5765c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/xen,grant-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific IOMMU for virtualized devices (e.g. virtio)
> +
> +maintainers:
> +  - Stefano Stabellini <sstabellini@kernel.org>
> +
> +description:
> +  The reference to Xen specific IOMMU node using "iommus" property indicates
> +  that Xen grant mappings need to be enabled for the device, and it specifies
> +  the ID of the domain where the corresponding backend resides.
> +  The binding is required to restrict memory access using Xen grant mappings.
> +
> +properties:
> +  compatible:
> +    const: xen,grant-dma
> +
> +  '#iommu-cells':
> +    const: 1
> +    description:
> +      Xen specific IOMMU is multiple-master IOMMU device.
> +      The single cell describes the domid (domain ID) of the domain where
> +      the backend is running.
> +
> +required:
> +  - compatible
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xen_iommu {

No underscores in node names, generic node names, so this looks like
"iommu".

> +        compatible = "xen,grant-dma";
> +        #iommu-cells = <1>;
> +    };
> +
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <41>;
> +
> +        /* The backend is located in Xen domain with ID 1 */
> +        iommus = <&xen_iommu 1>;

There is no need usually to give consumer examples in provider binding.
If there is nothing specific here (looks exactly like every IOMMU
consumer in Linux kernel), drop the consumer.

> +    };


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
