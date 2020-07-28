Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63286C433EB
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:59:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31158206F5
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKxVLScN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31158206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7EC4623B88;
	Tue, 28 Jul 2020 11:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dv6ohqRyWsi2; Tue, 28 Jul 2020 11:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A46022FC6;
	Tue, 28 Jul 2020 11:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B32DC004F;
	Tue, 28 Jul 2020 11:59:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 675C8C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 504D88487B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DzRUu-MDed5N for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 11:59:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A284B8486F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:59:26 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id v6so5178935iow.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tl/xK5nksFGek4I0hJhjtnSKtWmsm7mD8uEP3H8tAJc=;
 b=dKxVLScNmH+IxfLYOJHi2FyLa1HeUI2rsPJTmMupKBaQWimNey/qP3/d62lN/wRW/l
 eQ4lrfidDx/qDiuCsBs8jqw6PRXawqwMoVVC3s9ak2gMfUMN+L9SwWpIE/lgtTa/OWao
 ZE7kRtmQ9VEQjfKvpIUMjvlPOFlq1JqJQiEEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tl/xK5nksFGek4I0hJhjtnSKtWmsm7mD8uEP3H8tAJc=;
 b=W0c+UQ9pu4Gupqn0Mh9NRq1NFch2fInUd7NPq1JuN+wycOoNmDXFlEAO2ejnrHg2Wn
 le4EVsNEpYe82nJd5T4B1KO2GQwQ84TgrBZqwXAj9CxixMkNIJiXNTeP1hCxfBgd6vhk
 8ggCp3we+HXaFe/GEljoU17T3/869tY/d/mW8e7itiF5/SQLrPAy7LB0j+C1hmsVfx08
 Rn1TTH/WE/9iIJ3e6mCOfVktnhhBfBEjEr/3p3xPURDIlq9CWRxMtx+I0kMsUaBJyR/V
 0Wnu2OvVT3h6n97R/isX5jZRpOodzeB27nVNpDAyhPvClogfl5bh2JcOhGABCqy8r1JZ
 17wg==
X-Gm-Message-State: AOAM533NgoWAyfbF9qff07fmS/0U8saa0j1R66x/7BgHdQp594zhZqFh
 foJnwrI/Nu8bMhfvzGGSdrbECWvmLOk=
X-Google-Smtp-Source: ABdhPJzvcjf1b+C10lk+1gKpQtVpX0lt0mj8qbI1oEVWIjlOT3YAn9EIaZEd3zCucjtme1IPsZjsHA==
X-Received: by 2002:a02:7815:: with SMTP id p21mr32755822jac.32.1595937565572; 
 Tue, 28 Jul 2020 04:59:25 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com.
 [209.85.166.50])
 by smtp.gmail.com with ESMTPSA id s85sm5626492ilk.77.2020.07.28.04.59.23
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 04:59:24 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id k23so20374126iom.10
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 04:59:23 -0700 (PDT)
X-Received: by 2002:a02:6947:: with SMTP id e68mr17279172jac.3.1595937563294; 
 Tue, 28 Jul 2020 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org>
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 28 Jul 2020 19:59:12 +0800
X-Gmail-Original-Message-ID: <CALiNf28XXGpJ=hV-S3dLyq1U18_trr4e4rr6OPr5W5DxHD9XcA@mail.gmail.com>
Message-ID: <CALiNf28XXGpJ=hV-S3dLyq1U18_trr4e4rr6OPr5W5DxHD9XcA@mail.gmail.com>
Subject: Re: [RFC v2 0/5] Restricted DMA
To: Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com, 
 Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
 Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
 Greg KH <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 Nicolas Boichat <drinkcat@chromium.org>, dan.j.williams@intel.com,
 treding@nvidia.com
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

It seems that I didn't rebase the patchset properly. There are some
build test errors.
Sorry about that. Please kindly ignore those rebase issues. I'll fix
them in the next version.


On Tue, Jul 28, 2020 at 1:01 PM Claire Chang <tientzu@chromium.org> wrote:
>
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
>
> For example, we plan to use the PCI-e bus for Wi-Fi on one MTK platform and
> that PCI-e bus is not behind an IOMMU. As PCI-e, by design, gives the
> device full access to system memory, a vulnerability in the Wi-Fi firmware
> could easily escalate to a full system exploit (remote wifi exploits: [1a],
> [1b] that shows a full chain of exploits; [2], [3]).
>
> To mitigate the security concerns, we introduce restricted DMA. The
> restricted DMA is implemented by per-device swiotlb and coherent memory
> pools. The feature on its own provides a basic level of protection against
> the DMA overwriting buffer contents at unexpected times. However, to
> protect against general data leakage and system memory corruption, the
> system needs to provide a way to restrict the DMA to a predefined memory
> region (this is usually done at firmware level, e.g. in ATF on some ARM
> platforms).
>
> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
>
>
> Claire Chang (5):
>   swiotlb: Add io_tlb_mem struct
>   swiotlb: Add device swiotlb pool
>   swiotlb: Use device swiotlb pool if available
>   dt-bindings: of: Add plumbing for restricted DMA pool
>   of: Add plumbing for restricted DMA pool
>
>  .../reserved-memory/reserved-memory.txt       |  35 ++
>  drivers/iommu/intel/iommu.c                   |   8 +-
>  drivers/of/address.c                          |  39 ++
>  drivers/of/device.c                           |   3 +
>  drivers/of/of_private.h                       |   6 +
>  drivers/xen/swiotlb-xen.c                     |   4 +-
>  include/linux/device.h                        |   4 +
>  include/linux/dma-direct.h                    |   8 +-
>  include/linux/swiotlb.h                       |  49 +-
>  kernel/dma/direct.c                           |   8 +-
>  kernel/dma/swiotlb.c                          | 418 +++++++++++-------
>  11 files changed, 393 insertions(+), 189 deletions(-)
>
> --
> v1: https://lore.kernel.org/patchwork/cover/1271660/
> Changes in v2:
> - build on top of swiotlb
>
> 2.28.0.rc0.142.g3c755180ce-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
