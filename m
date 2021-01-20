Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301FC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 16:53:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5F9233EB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 16:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F9233EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58F0B86C82;
	Wed, 20 Jan 2021 16:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIZ7xQvte6wJ; Wed, 20 Jan 2021 16:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95D4C86BC1;
	Wed, 20 Jan 2021 16:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF6DC08A1;
	Wed, 20 Jan 2021 16:53:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98F75C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9459C86C82
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VqEXsxvtRrhh for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:53:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1B0286D5A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 16:53:51 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 36so12469324otp.2
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 08:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Nevn/Hsb1/pSSLD/4PKRZrIOGJGLolaHEVGjwXHh7g=;
 b=nGgfv50eksH8mPO4vxmBS3pqCGzMxQFN/YGOks0rttUAUVZoT0fV2Xcug9ILIo+v5l
 b18Gb18SXuJBaBGSmJTc+P6Jft79uMhJsHIU5UBZZBuRDDE7cVr13MjcmriqZBvXTC5W
 nTOLefWD0cDqjn1JilN+g+v5YUvcj3/CKnW5c1vqsy85NQdaPx/7ruY7Yw3sMRJ3pYQv
 L09MLzp0BTZ8wnfh9l9weR/YqeR09czSQ3GlzxqCyunoElrP4HhgbyssTuC4WdzvQOZz
 TG1WL3K/CQJhHupPEvb3qjZLJkEjdwlBjl2Fkd6jPnq2pLzKFcpUuQxGut+1vKeA5Ewx
 +UHw==
X-Gm-Message-State: AOAM531mRMCuNm3A58ViXIhrG2j3UxVh/JEG07kGhx21HH30E+OKIK+/
 RZx5qNeYt2hNL7482nf9Sw==
X-Google-Smtp-Source: ABdhPJwaG3j9UrY6/UvK8tGFavZ8pchhV25GbY2yn1OpU1TWw5L3kI0PQYj6i0y3Xx2xzLR+yGRYiw==
X-Received: by 2002:a05:6830:20c2:: with SMTP id
 z2mr7356498otq.322.1611161630884; 
 Wed, 20 Jan 2021 08:53:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d10sm444480ooh.32.2021.01.20.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 08:53:49 -0800 (PST)
Received: (nullmailer pid 328496 invoked by uid 1000);
 Wed, 20 Jan 2021 16:53:48 -0000
Date: Wed, 20 Jan 2021 10:53:48 -0600
From: Rob Herring <robh@kernel.org>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210120165348.GA220770@robh.at.kernel.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-6-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-6-tientzu@chromium.org>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org, grant.likely@arm.com,
 paulus@samba.org, will@kernel.org, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 hch@lst.de, bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org,
 treding@nvidia.com, devicetree@vger.kernel.org, konrad.wilk@oracle.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, drinkcat@chromium.org,
 boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org, frowand.list@gmail.com,
 iommu@lists.linux-foundation.org, xypron.glpk@gmx.de, robin.murphy@arm.com
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

On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> Introduce the new compatible string, restricted-dma-pool, for restricted
> DMA. One can specify the address and length of the restricted DMA memory
> region by restricted-dma-pool in the device tree.

If this goes into DT, I think we should be able to use dma-ranges for 
this purpose instead. Normally, 'dma-ranges' is for physical bus 
restrictions, but there's no reason it can't be used for policy or to 
express restrictions the firmware has enabled.

> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index e8d3096d922c..44975e2a1fd2 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - restricted-dma-pool: This indicates a region of memory meant to be
> +          used as a pool of restricted DMA buffers for a set of devices. The
> +          memory region would be the only region accessible to those devices.
> +          When using this, the no-map and reusable properties must not be set,
> +          so the operating system can create a virtual mapping that will be used
> +          for synchronization. The main purpose for restricted DMA is to
> +          mitigate the lack of DMA access control on systems without an IOMMU,
> +          which could result in the DMA accessing the system memory at
> +          unexpected times and/or unexpected addresses, possibly leading to data
> +          leakage or corruption. The feature on its own provides a basic level
> +          of protection against the DMA overwriting buffer contents at
> +          unexpected times. However, to protect against general data leakage and
> +          system memory corruption, the system needs to provide way to restrict
> +          the DMA to a predefined memory region.
>          - vendor specific string in the form <vendor>,[<device>-]<usage>
>  no-map (optional) - empty property
>      - Indicates the operating system must not create a virtual mapping
> @@ -120,6 +134,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  			compatible = "acme,multimedia-memory";
>  			reg = <0x77000000 0x4000000>;
>  		};
> +
> +		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> +			compatible = "restricted-dma-pool";
> +			reg = <0x50000000 0x400000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_device: pcie_device@0,0 {
> +		memory-region = <&restricted_dma_mem_reserved>;

PCI hosts often have inbound window configurations that limit the 
address range and translate PCI to bus addresses. Those windows happen 
to be configured by dma-ranges. In any case, wouldn't you want to put 
the configuration in the PCI host node? Is there a usecase of 
restricting one PCIe device and not another? 

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
