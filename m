Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C7BC433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 17:47:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257F1233FD
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 17:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F1233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B318F872E6;
	Thu,  7 Jan 2021 17:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMv9yngM6hW9; Thu,  7 Jan 2021 17:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F13D86D41;
	Thu,  7 Jan 2021 17:47:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CEEC0891;
	Thu,  7 Jan 2021 17:47:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98D79C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8749B8671B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHi2rzDqpcOu for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 17:47:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B42B4866EA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 17:47:19 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id n3so4352975pjm.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+0HS3c+10kITlDelN9sS9O+z0w2Ups5kLpisbgPnIuQ=;
 b=TmrbFqeMmnksB1vaMhBMwmgHvojsvOdZ6TLQjSgGvlt9aJwr9bFzrlNmZkoEKaXZrA
 BzhRl+J0o1KlSCMk8lZODbp2N6pkKBO2ZLOdx2Na4jfQSKA1o8yFNpUtcIwDAMJ6DBdH
 07WtF3X92be4zrXT7ssItC8OK2EEQXGttgp4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+0HS3c+10kITlDelN9sS9O+z0w2Ups5kLpisbgPnIuQ=;
 b=YHgqR2IPGHt4KZnPPfXkuTl3tZvPUySi9LiCl2t2ptgkOWf+sirMER/eXZtSMGJBRo
 aDoXAezMyLPhe0OWRKvg4blVeyU2aBiG4EElzhO3rFvKEBzDelRPYhx9VDrZPb8RJopO
 7gYYyZac0obpMStXg9KopbZIm4gDxvlD5zwLF047y0YqHL/YXqf6K/YUIhLlHj+FvM9k
 WAqliJ74vd+1ZKfaP+azSGsslWDhNbzy7f7FeiAqB7fZhSyroiN4NrIS3lvVmLgEkffV
 ilDQwiLHCMFOkeVMAU5ErTHxJbDcLEKmO/qDRchJmg5JxFjMqgpt1oIf0p2Pxq++vAtX
 AJ5w==
X-Gm-Message-State: AOAM532VnaI+/FRbEAl8LbsQaaGoINidljZgGbIcoiHadrgM/FkS9fBb
 iOv8osuGP8kzn49vZHveRnMObI8D+Dgb4Vfr
X-Google-Smtp-Source: ABdhPJw5Aqp+8HMSL1rt2EfuHdB9/wtEsZ4Vt4YujFWrIpePRBcZRdEQnm3IIvoaY4m4A/adm/+/Vw==
X-Received: by 2002:a17:902:848e:b029:dc:b38:98f0 with SMTP id
 c14-20020a170902848eb02900dc0b3898f0mr4185plo.82.1610041638985; 
 Thu, 07 Jan 2021 09:47:18 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com.
 [209.85.215.177])
 by smtp.gmail.com with ESMTPSA id s21sm6744610pga.12.2021.01.07.09.47.18
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 09:47:18 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id i5so5465230pgo.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 09:47:18 -0800 (PST)
X-Received: by 2002:a92:9ada:: with SMTP id c87mr10270546ill.5.1610041194703; 
 Thu, 07 Jan 2021 09:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-6-tientzu@chromium.org>
 <20210106185757.GB109735@localhost.localdomain>
In-Reply-To: <20210106185757.GB109735@localhost.localdomain>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 8 Jan 2021 01:39:43 +0800
X-Gmail-Original-Message-ID: <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
Message-ID: <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Jan 7, 2021 at 2:58 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Jan 06, 2021 at 11:41:23AM +0800, Claire Chang wrote:
> > Introduce the new compatible string, restricted-dma-pool, for restricted
> > DMA. One can specify the address and length of the restricted DMA memory
> > region by restricted-dma-pool in the device tree.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > index e8d3096d922c..44975e2a1fd2 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > @@ -51,6 +51,20 @@ compatible (optional) - standard definition
> >            used as a shared pool of DMA buffers for a set of devices. It can
> >            be used by an operating system to instantiate the necessary pool
> >            management subsystem if necessary.
> > +        - restricted-dma-pool: This indicates a region of memory meant to be
> > +          used as a pool of restricted DMA buffers for a set of devices. The
> > +          memory region would be the only region accessible to those devices.
> > +          When using this, the no-map and reusable properties must not be set,
> > +          so the operating system can create a virtual mapping that will be used
> > +          for synchronization. The main purpose for restricted DMA is to
> > +          mitigate the lack of DMA access control on systems without an IOMMU,
> > +          which could result in the DMA accessing the system memory at
> > +          unexpected times and/or unexpected addresses, possibly leading to data
> > +          leakage or corruption. The feature on its own provides a basic level
> > +          of protection against the DMA overwriting buffer contents at
> > +          unexpected times. However, to protect against general data leakage and
> > +          system memory corruption, the system needs to provide way to restrict
> > +          the DMA to a predefined memory region.
>
> Heya!
>
> I think I am missing something obvious here so please bear with my
> questions:
>
>  - This code adds the means of having the SWIOTLB pool tied to a specific
>    memory correct?

It doesn't affect the existing SWIOTLB. It just utilizes the existing SWIOTLB
code to create another DMA pool tied to a specific memory region for a given set
of devices. It bounces the streaming DMA (map/unmap) in and out of that region
and does the memory allocation (dma_direct_alloc) from the same region.

>
>
>  - Nothing stops the physical device from bypassing the SWIOTLB buffer.
>    That is if an errant device screwed up the length or DMA address, the
>    SWIOTLB would gladly do what the device told it do?

So the system needs to provide a way to lock down the memory access, e.g. MPU.

>
>  - This has to be combined with SWIOTLB-force-ish to always use the
>    bounce buffer, otherwise you could still do DMA without using
>    SWIOTLB (by not hitting the criteria for needing to use SWIOTLB)?

Since restricted DMA is for the devices that are not behind an IOMMU, I change
the criteria
`if (unlikely(swiotlb_force == SWIOTLB_FORCE))`
to
`if (unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dma_io_tlb_mem)`
in dma_direct_map_page().

Also, even if SWIOTLB=force, the restricted DMA pool is preferred if available
(get_io_tlb_mem in https://lore.kernel.org/patchwork/patch/1360995/).

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
