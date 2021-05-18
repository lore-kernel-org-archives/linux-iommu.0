Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A7C433ED
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 07:02:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24AD61263
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 07:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24AD61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABD54403AB;
	Tue, 18 May 2021 07:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPl8CLR_Iptf; Tue, 18 May 2021 07:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 696FD400BE;
	Tue, 18 May 2021 07:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3CFC000E;
	Tue, 18 May 2021 07:02:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2664BC0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 07:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06F2883D46
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 07:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k_3E89Ps3lwA for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 07:02:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCB8683D26
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 07:02:14 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id o59so4470701qva.1
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XgyF0OvHzw8KTyadFBcEzsCamkUD+/ukWzei3hnGvkc=;
 b=VO0BvOlWIIiGkUdtOb1VSOWiBrk2KLMr0fiDCPwaBrvrf/j2/7hCX1JlEDcxzMqFmv
 42I6m34flwgfsu+jKFLERtm6bjzporQ7M0BTCF240tpdoJChz4PcESq3XpYvN81Vfxez
 ZW4CMor3EwZRISv4nvwP/XJ/8ZZ+MrGyZniYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XgyF0OvHzw8KTyadFBcEzsCamkUD+/ukWzei3hnGvkc=;
 b=iEYaBPEbVNM1xjqtcD+FBplGQTQcAA8S6UNI6Lf2+CrGBbHOFfyO78dA8DrWTb4YuH
 nrIs8C9BY5/vX7Spa09PCNULB9UKrQECFiA0CfzPxtRKGyUMY+Stnd6/PpCAJL7XJIhL
 oQED9U3vr83vwFt1t/clqJoe4jgVqBril6o6xHfosTrp7Y41ZL2rqSMQaJpQP/63/KT1
 cVOJFEOW4R9p0y+C1BDMge9Dw/KgwsaIT5SCdhGTJ/BBBsxWvuIU0fQfu3njfiEIcwEw
 HX3pRzXN1xisHs9znf0n4r8ouFhqD95sunAU2NBee4UPEVThAH+QS9ia01agE25csvEX
 +Lug==
X-Gm-Message-State: AOAM5308r3j5kaZDJpIFl36LAx0y61xiDjjd40wVM1YkH/bJl9IiDej2
 CZ8iuSdY4KquUY4V4aDNeT3uqonTaVZvwA==
X-Google-Smtp-Source: ABdhPJzK7H6Ms3QzgUh36DlIldeWN0hUD07/zo2rnUKpO2lcnkVvAdZZoccobLGhrIyZqY92yzqzgA==
X-Received: by 2002:a05:6214:84c:: with SMTP id
 dg12mr4324340qvb.32.1621321333382; 
 Tue, 18 May 2021 00:02:13 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com.
 [209.85.222.180])
 by smtp.gmail.com with ESMTPSA id 30sm523379qkr.73.2021.05.18.00.02.13
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 00:02:13 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id i5so1117762qkf.12
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 00:02:13 -0700 (PDT)
X-Received: by 2002:a05:6638:10e4:: with SMTP id
 g4mr3960623jae.90.1621320877050; 
 Mon, 17 May 2021 23:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095026.3477496-1-tientzu@chromium.org>
In-Reply-To: <20210510095026.3477496-1-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 18 May 2021 14:54:26 +0800
X-Gmail-Original-Message-ID: <CALiNf2-LhQqAX3kJSETOxG4ipu9Nhs97yYiGm0XZKG7vBQ_hNQ@mail.gmail.com>
Message-ID: <CALiNf2-LhQqAX3kJSETOxG4ipu9Nhs97yYiGm0XZKG7vBQ_hNQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Restricted DMA
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, 
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 nouveau@lists.freedesktop.org, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

v7: https://lore.kernel.org/patchwork/cover/1431031/

On Mon, May 10, 2021 at 5:50 PM Claire Chang <tientzu@chromium.org> wrote:
>
> From: Claire Chang <tientzu@google.com>
>
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
>
> For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> not behind an IOMMU. As PCI-e, by design, gives the device full access to
> system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> full chain of exploits; [2], [3]).
>
> To mitigate the security concerns, we introduce restricted DMA. Restricted
> DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> specially allocated region and does memory allocation from the same region.
> The feature on its own provides a basic level of protection against the DMA
> overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system needs
> to provide a way to restrict the DMA to a predefined memory region (this is
> usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
>
> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
>
> v6:
> Address the comments in v5
>
> v5:
> Rebase on latest linux-next
> https://lore.kernel.org/patchwork/cover/1416899/
>
> v4:
> - Fix spinlock bad magic
> - Use rmem->name for debugfs entry
> - Address the comments in v3
> https://lore.kernel.org/patchwork/cover/1378113/
>
> v3:
> Using only one reserved memory region for both streaming DMA and memory
> allocation.
> https://lore.kernel.org/patchwork/cover/1360992/
>
> v2:
> Building on top of swiotlb.
> https://lore.kernel.org/patchwork/cover/1280705/
>
> v1:
> Using dma_map_ops.
> https://lore.kernel.org/patchwork/cover/1271660/
> *** BLURB HERE ***
>
> Claire Chang (15):
>   swiotlb: Refactor swiotlb init functions
>   swiotlb: Refactor swiotlb_create_debugfs
>   swiotlb: Add DMA_RESTRICTED_POOL
>   swiotlb: Add restricted DMA pool initialization
>   swiotlb: Add a new get_io_tlb_mem getter
>   swiotlb: Update is_swiotlb_buffer to add a struct device argument
>   swiotlb: Update is_swiotlb_active to add a struct device argument
>   swiotlb: Bounce data from/to restricted DMA pool if available
>   swiotlb: Move alloc_size to find_slots
>   swiotlb: Refactor swiotlb_tbl_unmap_single
>   dma-direct: Add a new wrapper __dma_direct_free_pages()
>   swiotlb: Add restricted DMA alloc/free support.
>   dma-direct: Allocate memory from restricted DMA pool if available
>   dt-bindings: of: Add restricted DMA pool
>   of: Add plumbing for restricted DMA pool
>
>  .../reserved-memory/reserved-memory.txt       |  27 ++
>  drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   2 +-
>  drivers/gpu/drm/nouveau/nouveau_ttm.c         |   2 +-
>  drivers/iommu/dma-iommu.c                     |  12 +-
>  drivers/of/address.c                          |  25 ++
>  drivers/of/device.c                           |   3 +
>  drivers/of/of_private.h                       |   5 +
>  drivers/pci/xen-pcifront.c                    |   2 +-
>  drivers/xen/swiotlb-xen.c                     |   2 +-
>  include/linux/device.h                        |   4 +
>  include/linux/swiotlb.h                       |  41 ++-
>  kernel/dma/Kconfig                            |  14 +
>  kernel/dma/direct.c                           |  63 +++--
>  kernel/dma/direct.h                           |   9 +-
>  kernel/dma/swiotlb.c                          | 242 +++++++++++++-----
>  15 files changed, 356 insertions(+), 97 deletions(-)
>
> --
> 2.31.1.607.g51e8a6a459-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
