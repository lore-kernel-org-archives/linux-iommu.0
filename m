Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E1EC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 00:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DAF060B42;
	Wed,  1 Jun 2022 00:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQTzatbc0bk0; Wed,  1 Jun 2022 00:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA15260B4C;
	Wed,  1 Jun 2022 00:35:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A401CC0039;
	Wed,  1 Jun 2022 00:35:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C3E6C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 00:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BBF960B4C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 00:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdz11ZYlVlvh for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 00:34:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78BF460B42
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 00:34:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF01614B3;
 Wed,  1 Jun 2022 00:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A2C385A9;
 Wed,  1 Jun 2022 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654043696;
 bh=AGLxz/xreC1/Xeaa2Sjt8QqZXIylnuwZjPxvPygrygg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=DfuMHCjbgseVb9ElRvU6+fEgDpIv3ulhOxsoIPOQDdh5GUh8KjIJ28oGLRaKeGvWL
 0OGOBkYVHKvSBhLuz9k1LfSVAr5J41JWFoFQ4TABVCeTglNoTjSMmz8FJQ49sdckLg
 qsGKa+Yr+MoyMmAdmNIWUZGeNcE1QpV9WDLAqZFgKgw12wg03tSKY2yAzfzVh+OlIr
 IhSeKnYLMf2s3ZC0XoXksZyr4Mb/ha+g8gPhA0eQAKOPF5QkoCt5VR2mG2iYj77PY2
 +OIvjXfirEI3JrU/2GAu0wBIXEs9XmzEmlNrwfNOn0Ao2FA84oEYKiBszft0wz/igv
 pc1IcOOf15l3Q==
Date: Tue, 31 May 2022 17:34:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH V3 5/8] dt-bindings: Add xen,grant-dma IOMMU description
 for xen-grant DMA ops
In-Reply-To: <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205311726000.1905099@ubuntu-linux-20-04-desktop>
References: <1653944417-17168-1-git-send-email-olekstysh@gmail.com>
 <1653944417-17168-6-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, devicetree@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 xen-devel@lists.xenproject.org, Will Deacon <will@kernel.org>,
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

On Tue, 31 May 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The main purpose of this binding is to communicate Xen specific
> information using generic IOMMU device tree bindings (which is
> a good fit here) rather than introducing a custom property.
> 
> Introduce Xen specific IOMMU for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> The reference to Xen specific IOMMU node using "iommus" property
> indicates that Xen grant mappings need to be enabled for the device,
> and it specifies the ID of the domain where the corresponding backend
> resides. The domid (domain ID) is used as an argument to the Xen grant
> mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> 
> Changes V1 -> V2:
>    - update text in description
>    - change the maintainer of the binding
>    - fix validation issue
>    - reference xen,dev-domid.yaml schema from virtio/mmio.yaml
> 
> Change V2 -> V3:
>    - Stefano already gave his Reviewed-by, I dropped it due to the changes (significant)
>    - use generic IOMMU device tree bindings instead of custom property
>      "xen,dev-domid"
>    - change commit subject and description, was
>      "dt-bindings: Add xen,dev-domid property description for xen-grant DMA ops"
> ---
>  .../devicetree/bindings/iommu/xen,grant-dma.yaml   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/xen,grant-dma.yaml
> 
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

I think this is OK and in line with the discussion we had on the list. I
propose the following wording instead:

"""
The Xen IOMMU represents the Xen grant table interface. Grant mappings
are to be used with devices connected to the Xen IOMMU using the
"iommus" property, which also specifies the ID of the backend domain.
The binding is required to restrict memory access using Xen grant
mappings.
"""


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

Here I would say:

"""
The single cell is the domid (domain ID) of the domain where the backend
is running.
"""

With the two wording improvements:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> +required:
> +  - compatible
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xen_iommu {
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
> +    };
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
