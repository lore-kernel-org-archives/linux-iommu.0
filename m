Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEFC48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 06:34:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FE46101B
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 06:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FE46101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E853483B1D;
	Wed, 16 Jun 2021 06:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFWvwfTV33Uy; Wed, 16 Jun 2021 06:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E557783AFD;
	Wed, 16 Jun 2021 06:34:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC1CFC000E;
	Wed, 16 Jun 2021 06:34:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A00C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0D8440358
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RIuYTFhSOxm for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 06:34:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 985784032B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 06:34:50 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id t7so1165899edd.5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tQ+aFclY7mFrJp03PtWRtGMxzfcha+8ZtdzqiTJIvPY=;
 b=sodWDtxolW8SZ4J/QbhtvXgN8sJJ1NwrEnLg7GNAcl4DP6pyr87NJe+hWWQH+h8kOs
 tDJAUDHm36j6aaV5hGC5Tq0vuUYwMTRnevpzFTvaJ2dNI7W+gqoOfCmg26dC2cfogWXy
 pmWeyw04BWf7kCfFYvHz9ei/2wECnUW2ltF1VbbxccX6NtYbkHj7mbLx4saqs42dHXtm
 qQuiM1JwK63NVlVfNzgA6ziUbKAGQQwtarrvlo3q8bsQ07oGsGI8YoEaKHgDgp7chOvs
 noOKUqGAbLPJub8gCD/oCpjqYFP6qlhUOXHwKk1VNct+Ta3stxyC85QB0J6GPsZhuHx/
 2t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tQ+aFclY7mFrJp03PtWRtGMxzfcha+8ZtdzqiTJIvPY=;
 b=JsBdYy6jB+jQsnGbm6bKm5RP45WgJR5GM+bVx08UFEeOgbAtCSc9EbjPym6h3sPcCe
 wVD7SsrT90SmOJRigRMAdz3GNoGG6UQbrB6PDVMEX42WzAv8aDnghRl0YZdgfLzQHKr2
 xG88sCBZqdWNur2m9ElcuT3Aju7jSJ94DGZeVq1VIx5UgTFIL3BrVUIToXwG9GvuwehZ
 b44oP/WBMq5KQnBkX8oeaO/mhkqv3KGLevKKWgiMQa2RPIGo5ZDmKoNeUp6qlnXoU5a9
 cq1HUjnkmw0Jxlux+Jqm+bCY7A9Vg1YgtqyuRaT1VsKKvZyaqsfxUtsyQcH+HP/q9NPU
 7AHg==
X-Gm-Message-State: AOAM532/Pcmhl+kKbNYVClJw8ZJccKS4SPhsGqh11ABHmElGX6ttkXtz
 iT08KUdw6XV/0d1nR1u0UFBO6Q==
X-Google-Smtp-Source: ABdhPJytn6iV+QqlLDcEBGVV9cwmZHvnBd0b+hyOWIjCF87Ob32rWc20CRqdZ0W0K7O0ZWMVsmoufA==
X-Received: by 2002:a05:6402:3514:: with SMTP id
 b20mr2254993edd.12.1623825288710; 
 Tue, 15 Jun 2021 23:34:48 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id b10sm649538edx.4.2021.06.15.23.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 23:34:48 -0700 (PDT)
Date: Wed, 16 Jun 2021 08:34:28 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Subject: Re: [PATCH v4 0/6] Add support for ACPI VIOT
Message-ID: <YMmbdBuKzkoxEgme@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
Cc: kevin.tian@intel.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

Hi Rafael,

On Thu, Jun 10, 2021 at 09:51:27AM +0200, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which provides topology
> information for para-virtual IOMMUs. Enable virtio-iommu on
> non-devicetree platforms, including x86.
> 
> Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
> take this series through the IOMMU tree, which requires Acks for patches
> 1-3.

I was wondering if you could take a look at patches 1-3, otherwise we'll
miss the mark for 5.14 since I won't be able to resend next week. The
series adds support for virtio-iommu on QEMU and cloud hypervisor.

Thanks,
Jean

> 
> You can find a QEMU implementation at [2], with extra support for
> testing all VIOT nodes including MMIO-based endpoints and IOMMU.
> This series is at [3].
> 
> [1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
> [2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
> [3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi
> 
> 
> Jean-Philippe Brucker (6):
>   ACPI: arm64: Move DMA setup operations out of IORT
>   ACPI: Move IOMMU setup code out of IORT
>   ACPI: Add driver for the VIOT table
>   iommu/dma: Pass address limit rather than size to
>     iommu_setup_dma_ops()
>   iommu/dma: Simplify calls to iommu_setup_dma_ops()
>   iommu/virtio: Enable x86 support
> 
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  include/acpi/acpi_bus.h      |   3 +
>  include/linux/acpi.h         |   3 +
>  include/linux/acpi_iort.h    |  14 +-
>  include/linux/acpi_viot.h    |  19 ++
>  include/linux/dma-iommu.h    |   4 +-
>  arch/arm64/mm/dma-mapping.c  |   2 +-
>  drivers/acpi/arm64/dma.c     |  50 +++++
>  drivers/acpi/arm64/iort.c    | 129 ++-----------
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |  78 +++++++-
>  drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c    |   9 +-
>  drivers/iommu/dma-iommu.c    |  17 +-
>  drivers/iommu/intel/iommu.c  |  10 +-
>  drivers/iommu/virtio-iommu.c |   8 +
>  MAINTAINERS                  |   8 +
>  20 files changed, 580 insertions(+), 150 deletions(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/arm64/dma.c
>  create mode 100644 drivers/acpi/viot.c
> 
> -- 
> 2.31.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
