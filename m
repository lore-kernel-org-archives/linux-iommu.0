Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC3C432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 03:50:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1613760F39
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 03:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1613760F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D142C406CE;
	Fri, 27 Aug 2021 03:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WYPQ78IrBprK; Fri, 27 Aug 2021 03:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D686E40003;
	Fri, 27 Aug 2021 03:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C4AC0010;
	Fri, 27 Aug 2021 03:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFDE5C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90B28828DD
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3-Wk-vNsoBw for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 03:50:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F09E8268F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 03:50:25 +0000 (UTC)
Received: by mail-io1-xd29.google.com with SMTP id g9so6797731ioq.11
 for <iommu@lists.linux-foundation.org>; Thu, 26 Aug 2021 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aO31d1ja5MAKunYUAZZRLdfg9N4l+qmRykC9m1jC/pQ=;
 b=LHO3ECTKxrFvHrNircCd8rdZ+1fd28Cmb0yeGOAFZz7tvi23JfdsoKQlBQ/osBU2PS
 uSjlHhkxT55kRAddmfXWJAAOEApdxidxxDW04W+WXtBEpgeVUzkf4uqWPWAg7OHZiZJx
 7DqmkAUptTsy2yC8hMD6ce5SkESGfwW9yU/Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aO31d1ja5MAKunYUAZZRLdfg9N4l+qmRykC9m1jC/pQ=;
 b=uUzD/xW4xwbi5APWQ/9aTKzqOGXXnEggCpTLHzEn79kSDy8e2HQ1lDdcqC4V1TLowe
 MuTG7JwVwamGZSE2i/M6dZNS06MROCtO9df1uDBAMtnW10iBKS6z1i70mcOfDVvT5+W3
 wDwnVOVvwYgHxhXRv89fKpOtkhAlgKgPWBS8+n1WmOoz0jPzmu69fFLEIj91N/quPkvh
 afUIUVrhMbjcmSAQ/S7OqmlA8wDBWVn0sqKAoX3oUz2tUChENxBQhwglh6vK+6v37j13
 oH9gjXGV3DviyLKkTDbqx3eXjmBXVOjZmGU75hZtEuQFUpCtMf15uaucxANQ89lYXO1p
 v6UA==
X-Gm-Message-State: AOAM533f/XOyBo3u6TXLFuU32DzD3Wa/J5ZacyEjv5lX6HBvCw9rlzFR
 VSmH35iNbvG6X+T+tzKZZAFy1jQujUtvGA==
X-Google-Smtp-Source: ABdhPJy4TRD3kN2pr7+Sb0Tbk6zjMDihTBTD4R7rQ2E2dW8lB106wsXJ9QNZcV0XQ+c6roYWzoNh5Q==
X-Received: by 2002:a05:6638:380c:: with SMTP id
 i12mr6325322jav.49.1630036224157; 
 Thu, 26 Aug 2021 20:50:24 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com.
 [209.85.166.48])
 by smtp.gmail.com with ESMTPSA id r18sm2791183ilo.38.2021.08.26.20.50.22
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 20:50:22 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id b200so6797299iof.13
 for <iommu@lists.linux-foundation.org>; Thu, 26 Aug 2021 20:50:22 -0700 (PDT)
X-Received: by 2002:a5d:9ada:: with SMTP id x26mr5606315ion.50.1630036221774; 
 Thu, 26 Aug 2021 20:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-11-tientzu@chromium.org>
 <20210824142601.GA3393158@roeck-us.net>
In-Reply-To: <20210824142601.GA3393158@roeck-us.net>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 27 Aug 2021 11:50:10 +0800
X-Gmail-Original-Message-ID: <CALiNf2_NoJwU7UUT4mNkbKWRKsTP9R9E=9qBZzjdjOduO5WZDQ@mail.gmail.com>
Message-ID: <CALiNf2_NoJwU7UUT4mNkbKWRKsTP9R9E=9qBZzjdjOduO5WZDQ@mail.gmail.com>
Subject: Re: [PATCH v15 10/12] swiotlb: Add restricted DMA pool initialization
To: Guenter Roeck <linux@roeck-us.net>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Qian Cai <quic_qiancai@quicinc.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Aug 24, 2021 at 10:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Claire,
>
> On Thu, Jun 24, 2021 at 11:55:24PM +0800, Claire Chang wrote:
> > Add the initialization function to create restricted DMA pools from
> > matching reserved-memory nodes.
> >
> > Regardless of swiotlb setting, the restricted DMA pool is preferred if
> > available.
> >
> > The restricted DMA pools provide a basic level of protection against the
> > DMA overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system
> > needs to provide a way to lock down the memory access, e.g., MPU.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> > Tested-by: Will Deacon <will@kernel.org>
> > ---
> >  include/linux/swiotlb.h |  3 +-
> >  kernel/dma/Kconfig      | 14 ++++++++
> >  kernel/dma/swiotlb.c    | 76 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 92 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3b9454d1e498..39284ff2a6cd 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -73,7 +73,8 @@ extern enum swiotlb_force swiotlb_force;
> >   *           range check to see if the memory was in fact allocated by this
> >   *           API.
> >   * @nslabs:  The number of IO TLB blocks (in groups of 64) between @start and
> > - *           @end. This is command line adjustable via setup_io_tlb_npages.
> > + *           @end. For default swiotlb, this is command line adjustable via
> > + *           setup_io_tlb_npages.
> >   * @used:    The number of used IO TLB block.
> >   * @list:    The free list describing the number of free entries available
> >   *           from each index.
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index 77b405508743..3e961dc39634 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -80,6 +80,20 @@ config SWIOTLB
> >       bool
> >       select NEED_DMA_MAP_STATE
> >
> > +config DMA_RESTRICTED_POOL
> > +     bool "DMA Restricted Pool"
> > +     depends on OF && OF_RESERVED_MEM
> > +     select SWIOTLB
>
> This makes SWIOTLB user configurable, which in turn results in
>
> mips64-linux-ld: arch/mips/kernel/setup.o: in function `arch_mem_init':
> setup.c:(.init.text+0x19c8): undefined reference to `plat_swiotlb_setup'
> make[1]: *** [Makefile:1280: vmlinux] Error 1
>
> when building mips:allmodconfig.
>
> Should this possibly be "depends on SWIOTLB" ?

Patch is sent here: https://lkml.org/lkml/2021/8/26/932

>
> Thanks,
> Guenter

Thanks,
Claire
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
