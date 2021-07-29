Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C8C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DD860524
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93DD860524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5909583AD4;
	Thu, 29 Jul 2021 09:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iaubEVgm4rZI; Thu, 29 Jul 2021 09:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2901883ACA;
	Thu, 29 Jul 2021 09:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CDDBC0023;
	Thu, 29 Jul 2021 09:51:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B77CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC65040312
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eh2fYJfTk0Kl for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 04:30:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D20E4402F0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 04:30:24 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id q2so5404101plr.11
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=PPE0zooLgyR9UCdP8xX+4M+xn5NMefkRnT3Z8S+2rxo=;
 b=jVAy9Axj38CP6qzQCubayURG3GC5N6GQpLn7DerOn3bVNLAo5e2aBMRAWBAlFMjEyZ
 4472RxpG50pI67eMjOrpldqqqzhay6vk6Lb7CdtG0zE9KbIZhrZNpknQ7LG3XXrvYvvg
 9+ZSD0KURwgn7rDsa3vOQIlvOF/4bvQlt3z85tXylMVwPsRRQu9cgVkI0mhelF7lUeAk
 xQxAlcTZ1pz36ZJN1RENmEhvawUmrcKaMmggmRUkq9j6Rnz1lCCJOrjmn8RiIMw/CgQ1
 oalmOGZtWH9kw2Qo/EmvQ1AVOxl6Sgao67e78xpQhmKEDKMDx0mtHp7NEy74QZ3RM8bG
 +HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=PPE0zooLgyR9UCdP8xX+4M+xn5NMefkRnT3Z8S+2rxo=;
 b=FwST5l2Xs3KL5Fl+S70853B1s3dCsz0JGKNZuTwgr8XGnRTSKB0RzaSiSFkXvWObi1
 sM/MYCTAWUNmtc6TsB50jM4FcqtmH3e0hQr1oT/MvmChj7yTbiOSN5dSNAJSIVl7NHFx
 vHcsamOQLCB+em6sV8lvGCGv0WiPydy5deYGc4XPcadN1XsdAhYQYDPXMydPkDAshwdH
 hkJktSuB0sk8l59bVGyCL31qg78uyaj0WMOlf2PApoiNLwraLVXw7hF4MGlozpiE07v/
 hIHSqB5L3A9FLoVq2eFAXPD76IeoLD1uXlIu7GJnfevZ4Gz7DTlpGvBc6lBbYinQfWX3
 xd0w==
X-Gm-Message-State: AOAM533MPXh6DAI5TU61eDPHbMUUsCXUAnA4I7N/txWR6vw8KmOJvH8b
 g5nhdAHlb0QaGtUyT/5ZTobdhA==
X-Google-Smtp-Source: ABdhPJxnCACwbpVayPk6V7fFVJvDGneCsIVO8qAKvIDi/fVY508+0MplapegPRHObLAXo+BVyVhlUA==
X-Received: by 2002:a05:6a00:9a3:b029:355:d45b:ad9a with SMTP id
 u35-20020a056a0009a3b0290355d45bad9amr3098900pfg.73.1627533024171; 
 Wed, 28 Jul 2021 21:30:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id z2sm1752300pgl.61.2021.07.28.21.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
Date: Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Jul 2021 20:39:59 PDT (-0700)
Subject: Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
X-Mailman-Approved-At: Thu, 29 Jul 2021 09:51:07 +0000
Cc: devicetree@vger.kernel.org, aou@eecs.berkeley.edu, tklauser@distanz.ch,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Atish Patra <Atish.Patra@wdc.com>, iommu@lists.linux-foundation.org,
 guoren@linux.alibaba.com, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, frowand.list@gmail.com,
 Christoph Hellwig <hch@lst.de>, dvyukov@google.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> RISC-V privilege specification doesn't define an IOMMU or any method modify
> PMA attributes or PTE entries to allow non-coherent mappings yet. In
> the beginning, this approach was adopted assuming that most of the RISC-V
> platforms would support full cache-coherent IO. Here is excerpt from the
> priv spec section 3.6.5
>
> "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> due to software complexity, performance, and energy impacts."
>
> While some of the RISC-V platforms adhere to the above suggestion, not all
> platforms can afford to build to fully cache-coherent I/O devices. To
> address DMA for non-coherent I/O devices, we need to mark a region of memory
> as non-cacheable. Some of the platforms rely on a fixed region of uncached
> memory that is remapped to the system memory while some other modify
> the PTE entries to achieve that.
>
> The patch3 solves the issue for the fist use case by using a global
> pool of memory that is reserved for DMA. The device access the reserved area
> of the region while corresponding CPU address will be from uncached region
> As the uncached region is remapped to the beginning of the system ram, both
> CPU and device get the same view.
>
> To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> cache operations. Any platform can use the generic ops to provide platform
> specific cache management operations. Once the standard RISC-V CMO extension
> is available, it will also use these generic ops.
>
> To address the second use case, Page Based Memory Attribute (PBMT) extension
> is proposed. Once the extension is in good shape, we can leverage that
> using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> option. We will probably need another arch specific hooks to know if the
> platform supports direct remap at runtime. For RISC-V, it will check the
> presence of PBMT extension while other arch function will simply return true

IIUC this is another extension that's not yet frozen or implemented in 
hardware?  Is this one compatible with what's in the c906, or is it 
doing things its own way?

> if DIRECT_REMAP is enabled. This is required as arious different config
> (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> unified kernel image can boot on all RISC-V platforms.
>
> This patch series depends on Christoph's global pool support series[1].
> Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> at [2].
> This series also solves the non-coherent DMA support on beagleV but requires
> additional beagleV specific patches[3] which will be upstreamed soon.
>
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
>
> Atish Patra (5):
> RISC-V: Implement arch_sync_dma* functions
> of: Move of_dma_get_range to of_address.h
> dma-mapping: Enable global non-coherent pool support for RISC-V
> dma-direct: Allocate dma pages directly if global pool allocation
> fails
> RISC-V: Support a new config option for non-coherent DMA
>
> arch/riscv/Kconfig                       |  8 +++
> arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> arch/riscv/mm/Makefile                   |  1 +
> arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> drivers/of/of_private.h                  | 10 ----
> include/linux/of_address.h               | 12 +++++
> kernel/dma/coherent.c                    | 49 +++++++++++++++---
> kernel/dma/direct.c                      |  7 ++-
> 8 files changed, 152 insertions(+), 20 deletions(-)
> create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> create mode 100644 arch/riscv/mm/dma-noncoherent.c

Can you guys please make up your minds about how this is going to be 
supported at the ISA level?  I get a different answer every day here: 
sometimes it's that these systems are not compliant, sometimes that 
Linux is the compliance suite, sometimes that we're doing an ISA 
extension, and sometimes that we're doing the SBI stuff.

I don't really care all that much about what the decision is, but it's 
impossible to move forward without some semblance of a plan.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
