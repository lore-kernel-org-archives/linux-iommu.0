Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F51C433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 16:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95F8E6080C;
	Tue, 23 Nov 2021 16:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4Eisz385gdF; Tue, 23 Nov 2021 16:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5ABDF60751;
	Tue, 23 Nov 2021 16:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC04C001E;
	Tue, 23 Nov 2021 16:35:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12A2DC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2E2F40219
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhGF-Shq3VNM for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 16:34:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD9E440140
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:34:54 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id k21so28719405ioh.4
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 08:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=tTDqJqEpn3lJVr9hvHIdnLnM0QZTa6cWxZTxlXqyveI=;
 b=q939lffgSq6YlhyNOiMHsqbm8LeDkQqm/6wnzDIh8wCshamvBp8fiirDz1ReDyTsES
 Xu5WEwFPVQIaMvlghEO/JOzKlmasVHtF/SUWl4UydZAAGoeUequcWScDxm+bennSjp08
 mrNJe02g2+5h05v7SllJvnlDCRH7i5THTHwAIj+n9uXTGH2yxdEJSr0W1+4Aazx+CgKd
 oaWS5RCpYiHMKwuHhu3uLs8oLFmc4hsA39bwjW64Wn9798g57vNi/99ngEs8ZEx6Nq7I
 hUeEHJOcvlpKkcqc3j9VcwwxELH7kUA9B6DxkxlZH4MuBBFNOgfSUAAg0xRl71ODOkGK
 BDew==
X-Gm-Message-State: AOAM533aPuztE0s/10mnsyac0UuIBIj5AB2zsq1Xecb3lVZ5P6S/kzCe
 lAI4imuqDaLOJGhZxt6WEQ==
X-Google-Smtp-Source: ABdhPJzpKxUJnoCa0cAVi7P8tqEKN9cFnfuz6QPVzyOgjxBNvvRZQNUJPZWW6WEKX50SRbXuuf9lzg==
X-Received: by 2002:a02:cc29:: with SMTP id o9mr7751315jap.116.1637685293477; 
 Tue, 23 Nov 2021 08:34:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id o22sm8929890iow.52.2021.11.23.08.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 08:34:52 -0800 (PST)
Received: (nullmailer pid 3442912 invoked by uid 1000);
 Tue, 23 Nov 2021 16:34:29 -0000
From: Rob Herring <robh@kernel.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
In-Reply-To: <20211123112104.3530135-3-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
 <20211123112104.3530135-3-hsinyi@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add io-tlb-segsize property for
 restricted-dma-pool
Date: Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.659918.3442911.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Maxime Ripard <maxime@cerno.tech>, Matthias Brugger <matthias.bgg@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, 23 Nov 2021 19:21:03 +0800, Hsin-Yi Wang wrote:
> Add a io-tlb-segsize property that each restricted-dma-pool can set its
> own io_tlb_segsize since some use cases require slabs larger than default
> value (128).
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: properties:io-tlb-segsize:type: 'anyOf' conditional failed, one must be fixed:
	'u32' is not one of ['array', 'boolean', 'integer', 'null', 'number', 'object', 'string']
	'u32' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: properties:io-tlb-segsize:type: 'u32' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: ignoring, error in schema: properties: io-tlb-segsize: type
warning: no schema found in file: ./Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/display/msm/gpu.example.dt.yaml:0:0: /example-1/reserved-memory/gpu@8f200000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.example.dt.yaml:0:0: /example-0/reserved-memory/linux,cma: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.example.dt.yaml:0:0: /example-0/reserved-memory/restricted-dma-pool@50000000: failed to match any schema with compatible: ['restricted-dma-pool']
Documentation/devicetree/bindings/dsp/fsl,dsp.example.dt.yaml:0:0: /example-1/vdev0buffer@94300000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-0/reserved-memory/dsp-memory@98000000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-1/reserved-memory/ipu-memory@95800000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-2/reserved-memory/dsp1-memory@99000000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dt.yaml:0:0: /example-0/reserved-mem@52800000: failed to match any schema with compatible: ['shared-dma-pool']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558503

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
