Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F1C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:39:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B927613F9
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B927613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAC29404EC;
	Fri, 11 Jun 2021 15:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrccFDRCP8fD; Fri, 11 Jun 2021 15:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D6524023D;
	Fri, 11 Jun 2021 15:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E565C000E;
	Fri, 11 Jun 2021 15:39:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E083C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A84B40253
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ppa-uHhCsnO5 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 15:39:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1077B4023D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:39:41 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id u13so16739285qvt.7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
 b=UdgbVNlCM2Z2m4AZZMvHuq5iZqq6a6B1k1NgNWN8Vbr0FhlXEkOMcXQOmqkTt81W9l
 ZZvZ8qEfilw4IVJQmcyphxlOFoGk0yzalYprjSKjTm0i0iDciVsO4hDbAAQ2CGlI10y9
 ZbSgy3asVidQE8sG2vEkYEnh2JJM0V3DCy6O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
 b=cXGqLR9MuPWGhXtPFHbnetBBuLKi70systZjZNSK8ryufTG0PMG0clojhFnI/aOqSh
 SIsBlpm+hgtTNah2l2MaO11ncVMcN/waQAfKagO0JoQt7KYe6KF47Egy+J2J4WmtWGV8
 beQdymMtfC/l+LO8ywXhDYpAXiGwtFELVNhDVaM2y9uX3gHL8V5tbVJndJER/+85EueT
 UvLzMVk7Vbnx9z+RBJf9B+iDw+GpOL/ccxPtBB/EVoshui5ZrvM2qkHfyK/93+GUMKrP
 gUCP1oADu1bjlE1aQJ/+a4AF+N+l7Y9QHuBsNdL2gLhBX9J4eDUCCXbOB7GmGvq3Rjga
 F3qg==
X-Gm-Message-State: AOAM532k1EfgMTLP/XwXVy9uQFdj3ruQG1E0G0cOqjsdHhLO4QvxCXCF
 +mZk0t1u8U8ase9U5v37v4+ExwhqQ2IL7w==
X-Google-Smtp-Source: ABdhPJxetUfG6m8UGNMnFubdSgE4LKihcy2xSb47S2927HZp0GI1p0Utafek2+pDeTtFhKUny15qJQ==
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr5401246qvn.62.1623425980596; 
 Fri, 11 Jun 2021 08:39:40 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com.
 [209.85.160.177])
 by smtp.gmail.com with ESMTPSA id c23sm4611440qkc.3.2021.06.11.08.39.40
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 08:39:40 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id v6so2874573qta.9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 08:39:40 -0700 (PDT)
X-Received: by 2002:a05:6638:151:: with SMTP id
 y17mr4471864jao.128.1623425522838; 
 Fri, 11 Jun 2021 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527125845.1852284-1-tientzu@chromium.org>
 <20210604174818.GC3703@willie-the-truck>
 <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
In-Reply-To: <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 11 Jun 2021 23:31:52 +0800
X-Gmail-Original-Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Restricted DMA
To: Will Deacon <will@kernel.org>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

v9 here: https://lore.kernel.org/patchwork/cover/1445081/

On Mon, Jun 7, 2021 at 11:28 AM Claire Chang <tientzu@chromium.org> wrote:
>
> On Sat, Jun 5, 2021 at 1:48 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Claire,
> >
> > On Thu, May 27, 2021 at 08:58:30PM +0800, Claire Chang wrote:
> > > This series implements mitigations for lack of DMA access control on
> > > systems without an IOMMU, which could result in the DMA accessing the
> > > system memory at unexpected times and/or unexpected addresses, possibly
> > > leading to data leakage or corruption.
> > >
> > > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > > full chain of exploits; [2], [3]).
> > >
> > > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > > specially allocated region and does memory allocation from the same region.
> > > The feature on its own provides a basic level of protection against the DMA
> > > overwriting buffer contents at unexpected times. However, to protect
> > > against general data leakage and system memory corruption, the system needs
> > > to provide a way to restrict the DMA to a predefined memory region (this is
> > > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> > >
> > > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> > >
> > > v8:
> > > - Fix reserved-memory.txt and add the reg property in example.
> > > - Fix sizeof for of_property_count_elems_of_size in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Apply Will's suggestion to try the OF node having DMA configuration in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Add error message for PageHighMem in
> > >   kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
> > >   rmem_swiotlb_setup.
> > > - Fix the message string in rmem_swiotlb_setup.
> >
> > Thanks for the v8. It works for me out of the box on arm64 under KVM, so:
> >
> > Tested-by: Will Deacon <will@kernel.org>
> >
> > Note that something seems to have gone wrong with the mail threading, so
> > the last 5 patches ended up as a separate thread for me. Probably worth
> > posting again with all the patches in one place, if you can.
>
> Thanks for testing.
>
> Christoph also added some comments in v7, so I'll prepare v9.
>
> >
> > Cheers,
> >
> > Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
