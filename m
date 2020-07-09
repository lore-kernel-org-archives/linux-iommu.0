Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A901C433E1
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 09:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6622B206E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 09:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FavBHG8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6622B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A1F987CCB;
	Thu,  9 Jul 2020 09:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZLESdoNpZ5n; Thu,  9 Jul 2020 09:40:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98F6E87CCF;
	Thu,  9 Jul 2020 09:40:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89DB5C077B;
	Thu,  9 Jul 2020 09:40:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF7FC016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 37F8C87CD3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dq70UDB51xJF for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 09:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 15A4B87CCB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 09:40:01 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id w16so1584477ejj.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2THE/Ch7o0atdMFuV+uYcIIPapd2rod4QXyGDJ/dFko=;
 b=FavBHG8IG2M/1g82xJw00majkxmSP5shEMXvMHDHe7094E4Hs00vjp8TSSeR812KOm
 uC7FGqeoRqCDwBgdgygc/j1M0Msyq/Ih3poWhDEiWpFtl68h4WZWGazIM4Nb76BfjWKN
 tzXZHrubqlL/oEkduaS00KzNt4j/7hWc+bBdZBkZ0sR4ZauY5UmPmwJGHDi20CGqw+S9
 A/ofjh4eAf0kBuaLw/NQbbbbm4RNOztwCCAt6vX3Jlo1wlr4gj/NKXc0I47EcR5lzOF/
 UCTt8pKDGUbPmgFRlhMpkF+INN5Ld1zjZLpvr12d6Fca3LQNgtvD2qy/WRGnQGNt84y8
 UdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2THE/Ch7o0atdMFuV+uYcIIPapd2rod4QXyGDJ/dFko=;
 b=XOwqBe98tqZMIt86fyJD9D89jULSLLfr/35sn/OnWL76lRBbOQg/c5tIsQ8VNMAKwE
 VdtOMPH5VchftzJCWBabNZLcqQZngE0C+sOmkchsws9CO/z1FzcBaitRex/NTxuapcg0
 SjXu9gnPk/STZ5Cp6G9+FF9ej7F4/MTdfdP6vzlU9J4kbjnHb3XR7tMxGMNAUsHBCERq
 sUAICkrNAVaUpfoYcbKAjqtgstTWu7eM+awQ1a9PgvyVk89OLqgw7rVYyXXm795deeUu
 aOrWkxLVgDwe+JJfsW4ia9PHckuSBmkGnbooBJq7QAtTLn+vKOLwrXoWc2Gl2/wxlFBS
 086Q==
X-Gm-Message-State: AOAM5305tT/KdjT6J7j+8ucfZdto+LYIZEkuJ5Eydw+j5ReZbaB0jXAR
 WtnpZVH8Xyeu+Yzuxsp902tSN7NGpvg=
X-Google-Smtp-Source: ABdhPJwRIJMZIpLlplX9lPskZd1R8tF64miPnKHMtY82fk3Knb0HoMgI+IgSJLyxwoNHoioyY3/W0A==
X-Received: by 2002:a17:906:945:: with SMTP id
 j5mr56100930ejd.52.1594287599016; 
 Thu, 09 Jul 2020 02:39:59 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q21sm1428288ejr.75.2020.07.09.02.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 02:39:58 -0700 (PDT)
Date: Thu, 9 Jul 2020 11:39:46 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v8 00/12] iommu: Shared Virtual Addressing for SMMUv3 (PT
 sharing part)
Message-ID: <20200709093946.GC4477@myrica>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618155125.1548969-1-jean-philippe@linaro.org>
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 hch@infradead.org, zhengxiang9@huawei.com, zhangfei.gao@linaro.org,
 will@kernel.org
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

Hi Will,

On Thu, Jun 18, 2020 at 05:51:13PM +0200, Jean-Philippe Brucker wrote:
> Since v7 [1], I split the series into three parts to ease review. This
> first one adds page table sharing to the SMMUv3 driver. The second one
> adds support for I/O page faults through PRI and Stall, and the last one
> adds additional and optional features (DVM, VHE and HTTU). SVA needs the
> three parts to work. No significant change apart from that, I just
> addressed the previous comments.
> 
> I'd rather everything went through the IOMMU tree but I'm assuming patch
> 1 will also go through the x86 tree as part of [2]. It is definitely
> required by patch 3 which is required by patch 11. I don't know how this
> kind of conflict is usually resolved, but if it's a problem I could
> further shrink the series to only patches 4-10 this cycle.

I have one bugfix for this series but am planning to hold off resending
until you've found time to have a look. I can also reduce it to 7 patches
for v4.9, please let me know what you prefer.

Thanks,
Jean

> 
> [1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/1592418233-17762-1-git-send-email-fenghua.yu@intel.com/
> 
> Fenghua Yu (1):
>   mm: Define pasid in mm
> 
> Jean-Philippe Brucker (11):
>   iommu/ioasid: Add ioasid references
>   iommu/sva: Add PASID helpers
>   arm64: mm: Pin down ASIDs for sharing mm with devices
>   iommu/io-pgtable-arm: Move some definitions to a header
>   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Seize private ASID
>   iommu/arm-smmu-v3: Check for SVA features
>   iommu/arm-smmu-v3: Add SVA device feature
>   iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
>   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
> 
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  arch/arm64/include/asm/mmu.h         |   1 +
>  arch/arm64/include/asm/mmu_context.h |  11 +-
>  drivers/iommu/io-pgtable-arm.h       |  30 ++
>  drivers/iommu/iommu-sva-lib.h        |  15 +
>  include/linux/ioasid.h               |  10 +-
>  include/linux/mm_types.h             |   4 +
>  arch/arm64/kernel/cpufeature.c       |   1 +
>  arch/arm64/mm/context.c              |  95 +++-
>  drivers/iommu/arm-smmu-v3.c          | 702 ++++++++++++++++++++++++++-
>  drivers/iommu/intel/iommu.c          |   4 +-
>  drivers/iommu/intel/svm.c            |   6 +-
>  drivers/iommu/io-pgtable-arm.c       |  27 +-
>  drivers/iommu/ioasid.c               |  38 +-
>  drivers/iommu/iommu-sva-lib.c        |  85 ++++
>  MAINTAINERS                          |   3 +-
>  17 files changed, 977 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm.h
>  create mode 100644 drivers/iommu/iommu-sva-lib.h
>  create mode 100644 drivers/iommu/iommu-sva-lib.c
> 
> -- 
> 2.27.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
