Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53DBC43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 17:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D1BF411A6;
	Fri, 24 Jun 2022 17:26:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D1BF411A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXS4y8_RkRRB; Fri, 24 Jun 2022 17:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A750A405C7;
	Fri, 24 Jun 2022 17:26:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A750A405C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8761AC0032;
	Fri, 24 Jun 2022 17:26:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A59DC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB4BD8493C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB4BD8493C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVTDYhCfWeMF for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 17:26:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF24084938
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF24084938
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:26:54 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id i194so3345964ioa.12
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 10:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=W9o9Q8p3oMHAVX7O1A1F5sZAeGnXCxQ/vXrDDAt7Do8=;
 b=eC3vw6grQB7EKJRMirxNAQ15Iduaw6rVODMe3w/79YOY5NUMYsxbLrQl8O2OYsmrMb
 NkDfHdt6bF4w08YYhAazu9Q+jgLEGsm9L2NW8gEsoLZfCR3o2vT0wpy1mT8ri4qhMF/+
 hW+2oE4/AqxHvdltMp59rJsWgAIuCGqyuJOSDgCH+/1AqVsEJV72eyKLNnQVuYUaUhk/
 L3WlKWEDnQAAaP8OniV4Fq5sMYh7HMX2TGWhtEPhtl+51YtCwsmxqgdhOyP3LxVMcLPg
 3zOAb1rvcZVzV8QqHPqDntN982mm73e59jl2FLBDKj9T28I+KmLYaJz5C3yjZ+u/blq7
 4bsg==
X-Gm-Message-State: AJIora/YIg0RWE9+TRd8UVDWm74XP9kE+wD8gZdm61auZQxVIr2f6QAO
 DI3jdGPIikZuKW6S/0SNlg==
X-Google-Smtp-Source: AGRyM1sVEh8rq+3905/IcPFgRU7Fy1TLeRbAXiXeOp+CmyUaFz0EH/Vzb8EIUR4m9bvLyRLCKVigUw==
X-Received: by 2002:a05:6638:31c2:b0:335:dd22:83ec with SMTP id
 n2-20020a05663831c200b00335dd2283ecmr164947jav.88.1656091613790; 
 Fri, 24 Jun 2022 10:26:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a022b16000000b00339d10e9d22sm1308243jaa.111.2022.06.24.10.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 10:26:53 -0700 (PDT)
Received: (nullmailer pid 146332 invoked by uid 1000);
 Fri, 24 Jun 2022 17:26:34 -0000
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20220621151022.1416300-3-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi>
 <20220621151022.1416300-3-cyndis@kapsi.fi>
Subject: Re: [PATCH v6 02/10] dt-bindings: display: tegra: Convert to
 json-schema
Date: Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.348474.146331.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 will@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, robin.murphy@arm.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 21 Jun 2022 18:10:14 +0300, Mikko Perttunen wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra host1x controller bindings from the free-form text
> format to json-schema.
> 
> This also adds the missing display-hub DT bindings that were not
> previously documented.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra114-mipi.txt    |  41 --
>  .../display/tegra/nvidia,tegra114-mipi.yaml   |  74 ++
>  .../display/tegra/nvidia,tegra124-dpaux.yaml  | 149 ++++
>  .../display/tegra/nvidia,tegra124-sor.yaml    | 206 ++++++
>  .../display/tegra/nvidia,tegra124-vic.yaml    |  71 ++
>  .../display/tegra/nvidia,tegra186-dc.yaml     |  85 +++
>  .../tegra/nvidia,tegra186-display.yaml        | 310 ++++++++
>  .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  45 ++
>  .../display/tegra/nvidia,tegra20-dc.yaml      | 181 +++++
>  .../display/tegra/nvidia,tegra20-dsi.yaml     | 159 +++++
>  .../display/tegra/nvidia,tegra20-epp.yaml     |  70 ++
>  .../display/tegra/nvidia,tegra20-gr2d.yaml    |  73 ++
>  .../display/tegra/nvidia,tegra20-gr3d.yaml    | 214 ++++++
>  .../display/tegra/nvidia,tegra20-hdmi.yaml    | 126 ++++
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 675 ------------------
>  .../display/tegra/nvidia,tegra20-host1x.yaml  | 347 +++++++++
>  .../display/tegra/nvidia,tegra20-isp.yaml     |  67 ++
>  .../display/tegra/nvidia,tegra20-mpe.yaml     |  73 ++
>  .../display/tegra/nvidia,tegra20-tvo.yaml     |  58 ++
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 163 +++++
>  .../display/tegra/nvidia,tegra210-csi.yaml    |  52 ++
>  .../pinctrl/nvidia,tegra124-dpaux-padctl.txt  |  59 --
>  22 files changed, 2523 insertions(+), 775 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-dpaux.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-display.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra210-csi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-dpaux-padctl.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: allOf:1:if:not:properties: {'contains': {'const': 'nvidia,panel'}} should not be valid under {'$ref': '#/definitions/sub-schemas'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.example.dtb:0:0: /example-0/sor@54540000: failed to match any schema with compatible: ['nvidia,tegra210-sor']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt

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
