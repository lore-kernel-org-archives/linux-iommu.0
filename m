Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6C8CCA47C
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 19:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34247823AA;
	Tue,  5 Jul 2022 19:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34247823AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FWCMOxISst7v; Tue,  5 Jul 2022 19:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A82A81AD1;
	Tue,  5 Jul 2022 19:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A82A81AD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE36C0032;
	Tue,  5 Jul 2022 19:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0649FC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 19:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C04DC40A19
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 19:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C04DC40A19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oUxpnNwCHJnu for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 19:19:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B39C1400A8
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B39C1400A8
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 19:19:00 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id k1so3324229ilu.1
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 12:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=HkWyYi1Y3vFcT2PDs2Eyw+VTCUEaA7uXAXTuzJrLtsY=;
 b=C70CmCGhKx3PLmfXmdsl8K7DD1HqJ3eOBMESakuFpVxqn1EJ/iO3w+ScqnlM/VwlLW
 o+cBRgv71uTKqjH06VVyCOZly4+v+xf3J25utoCPYpeMaU2SyZ+BJJeSPbs6F9XFVWNA
 m4lBozHGZwhvVJKfC9Iibad7tFtJjhmBCCbNSVL47fFmEsbbaXIurVCucqSUpOlMa+AM
 BVR2RyM43SpoXYk96AVCpbxeBeGrnyN5P/nDnSMLWVTNU7C5zvld/7kL3oFikJXcRwvx
 uDXvOAiL8I17rlHY0XEh90rp+l2+PhZrTLtrl3ms/mpieiOCzvdwHnoBWuflCP7g69/+
 wLAA==
X-Gm-Message-State: AJIora/erN2siT91TT73FdnDokKggCBolFAL7cBUYV3XlRxeK6+OGoda
 5c37ousRijlob++9oruOxw==
X-Google-Smtp-Source: AGRyM1vdzd9ImcLTIEnKAzJRYqtQ2TsGIfLnVMJa6Wx/iz9Q52vAZPVFFCMS7A72EzjGf+XbRGSpwA==
X-Received: by 2002:a05:6e02:18c9:b0:2da:da9d:2ab1 with SMTP id
 s9-20020a056e0218c900b002dada9d2ab1mr17158155ilu.90.1657048739720; 
 Tue, 05 Jul 2022 12:18:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 bm13-20020a05663842cd00b0032ead96ee5csm14880002jab.165.2022.07.05.12.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 12:18:59 -0700 (PDT)
Received: (nullmailer pid 2471228 invoked by uid 1000);
 Tue, 05 Jul 2022 19:18:57 -0000
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20220705130652.433496-1-thierry.reding@gmail.com>
References: <20220705125834.431711-2-thierry.reding@gmail.com>
 <20220705130652.433496-1-thierry.reding@gmail.com>
Subject: Re: [PATCH v7] dt-bindings: reserved-memory: Document iommu-addresses
Date: Tue, 05 Jul 2022 13:18:57 -0600
Message-Id: <1657048737.387965.2471227.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Janne Grunau <j@jannau.net>,
 Sameer Pujar <spujar@nvidia.com>, asahi@lists.linux.dev
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 05 Jul 2022 15:06:52 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This adds the "iommu-addresses" property to reserved-memory nodes, which
> allow describing the interaction of memory regions with IOMMUs. Two use-
> cases are supported:
> 
>   1. Static mappings can be described by pairing the "iommu-addresses"
>      property with a "reg" property. This is mostly useful for adopting
>      firmware-allocated buffers via identity mappings. One common use-
>      case where this is required is if early firmware or bootloaders
>      have set up a bootsplash framebuffer that a display controller is
>      actively scanning out from during the operating system boot
>      process.
> 
>   2. If an "iommu-addresses" property exists without a "reg" property,
>      the reserved-memory node describes an IOVA reservation. Such memory
>      regions are excluded from the IOVA space available to operating
>      system drivers and can be used for regions that must not be used to
>      map arbitrary buffers.
> 
> Each mapping or reservation is tied to a specific device via a phandle
> to the device's device tree node. This allows a reserved-memory region
> to be reused across multiple devices.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v7:
> - keep reserved-memory.txt to avoid broken references
> 
> Changes in v6:
> - add device phandle to iommu-addresses property in examples
> - remove now unused dt-bindings/reserved-memory.h header
> ---
>  .../reserved-memory/reserved-memory.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:22.7-45: Warning (reg_format): /reserved-memory/framebuffer@90000000:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:29.7-40: Warning (reg_format): /bus@0/adsp@2990000:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:34.7-42: Warning (reg_format): /bus@0/display@15200000:reg: property has invalid length (16 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:9.5-12: Warning (ranges_format): /reserved-memory:ranges: empty "ranges" property but its #size-cells (1) differs from / (2)
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:27.9-37.5: Warning (unit_address_vs_reg): /bus@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:21.30-24.7: Warning (avoid_default_addr_size): /reserved-memory/framebuffer@90000000: Relying on default #address-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:21.30-24.7: Warning (avoid_default_addr_size): /reserved-memory/framebuffer@90000000: Relying on default #size-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:28.24-31.7: Warning (avoid_default_addr_size): /bus@0/adsp@2990000: Relying on default #address-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:28.24-31.7: Warning (avoid_default_addr_size): /bus@0/adsp@2990000: Relying on default #size-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:33.27-36.7: Warning (avoid_default_addr_size): /bus@0/display@15200000: Relying on default #address-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dts:33.27-36.7: Warning (avoid_default_addr_size): /bus@0/display@15200000: Relying on default #size-cells value
Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: /: bus@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/root-node.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: /: 'compatible' is a required property
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/root-node.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/reserved-memory.example.dtb: /: 'model' is a required property
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
