Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D179C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 04:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5C364EE3
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 04:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5C364EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 239EC4ECB1;
	Fri, 26 Feb 2021 04:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3OIX7kRTb8-5; Fri, 26 Feb 2021 04:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C393A4EC72;
	Fri, 26 Feb 2021 04:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95815C000A;
	Fri, 26 Feb 2021 04:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A760C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 04:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 172554EC72
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 04:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyZJeSs09kJJ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 04:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
 [209.85.166.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4642C4EC53
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 04:18:04 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id z13so8366409iox.8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 20:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fDTKQXWPODousjcFxfPrAdhXiScgfthwkHIVsnIoPbM=;
 b=abTtJIMMZ8KToSFWbjzFi32HOkPDN2rxZ+IfBv+eO62ap/dN702Uq0mU9oHC9j+snt
 vnVWV+5jH/p/0R+4U10lm2zTMAo+mTTld64KVC2G+prj4nocAzeugJM4VE5FsldHI9zg
 D677137O5m7d9bvVpQQ+IkqHWrA56M7YEa+Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fDTKQXWPODousjcFxfPrAdhXiScgfthwkHIVsnIoPbM=;
 b=Wcv0YAmVnWomy+SXkGbeYgePLMQ8n0LVNydH+X1JevVYRFxIb/VQTcKlwrEVSyQVSt
 L1vP1NQKx9tmEwPjdnOJgG+eNAJDZ08HqKXuQlcxuUo2Fqgzo3V2RQZSH4ILQ3M2rh5t
 YT/QxLxZ6oXj8sGfS4YnHlWYpJKOrth0OSN+dErPwR/WNGiWD4JeTwEsIf4W7XKx3gfa
 qVUCZuT8EO2KXLKTiHulAEKUWXi9WgoM8dqID9W9KsNLlhkxaR+pCWYU5/29d/mGp7tc
 Vy027hojvaopQ/6jX+uNs9zwxRL0q664YXtKPTAe1E+hH9bsjqwKPVxonDzZQyAlb2l9
 WsLw==
X-Gm-Message-State: AOAM531LZaugL52y7CUFJCih5OWzNPnP7RFJLKXMzLgSfFcmQ9y5gX/b
 cgKArUZxWAFhMxI5J4d2LewC1Uj/AQR0WQ==
X-Google-Smtp-Source: ABdhPJzgNJLi+AGlN+61gNdgLOm7ktxcGCNcN7u7J+69BNmZ8CEpL4QryuDP/2AdhItw+TAxWxt/3w==
X-Received: by 2002:a6b:3ec3:: with SMTP id l186mr674947ioa.193.1614313083069; 
 Thu, 25 Feb 2021 20:18:03 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com.
 [209.85.166.46])
 by smtp.gmail.com with ESMTPSA id y5sm4195904ilh.24.2021.02.25.20.18.01
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Feb 2021 20:18:02 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id n14so8385967iog.3
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 20:18:01 -0800 (PST)
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr1097392jao.84.1614313081344; 
 Thu, 25 Feb 2021 20:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-13-tientzu@chromium.org>
In-Reply-To: <20210209062131.2300005-13-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 26 Feb 2021 12:17:50 +0800
X-Gmail-Original-Message-ID: <CALiNf298+DLjTK6ALe0mYrRuCP_LtztMGuQQCS90ubDctbS0kw@mail.gmail.com>
Message-ID: <CALiNf298+DLjTK6ALe0mYrRuCP_LtztMGuQQCS90ubDctbS0kw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] swiotlb: Add restricted DMA alloc/free support.
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, 
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index fd9c1bd183ac..8b77fd64199e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -836,6 +836,40 @@ late_initcall(swiotlb_create_default_debugfs);
>  #endif
>
>  #ifdef CONFIG_DMA_RESTRICTED_POOL
> +struct page *dev_swiotlb_alloc(struct device *dev, size_t size, gfp_t gfp)
> +{
> +       struct swiotlb *swiotlb;
> +       phys_addr_t tlb_addr;
> +       unsigned int index;
> +
> +       /* dev_swiotlb_alloc can be used only in the context which permits sleeping. */
> +       if (!dev->dev_swiotlb || !gfpflags_allow_blocking(gfp))

Just noticed that !gfpflags_allow_blocking(gfp) shouldn't be here.

Hi Christoph,

Do you think I should fix this and rebase on the latest linux-next
now? I wonder if there are more factor and clean up coming and I
should wait after that.

Thanks,
Claire
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
