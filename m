Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B8C4360C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 23:58:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D2A21A4C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 23:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNQIebcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2A21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FEDCDA5;
	Wed,  2 Oct 2019 23:58:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2536ADA4
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 23:58:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 80F6E19B
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 23:58:42 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id y72so492143pfb.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 02 Oct 2019 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to;
	bh=PH0TVlptMFdFZ9SoJTuyTfXJKlgPpa/0x/CIYNASyXQ=;
	b=BNQIebcW8imd/BryLx2tGf090/MdRtGKiAIdxV+pGfFq9zQ/YmeSI9MEvl1pFl+ZmB
	g5MtZRW/8VkM+iEW4brSZWu0RFyyTxhP5GubvJr0M5+wQp2AT2IUnZywGJkwk9s+PYMg
	9RTLXCS14kBrYS5lwB01GGuX2ArbYvFDl2KXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=PH0TVlptMFdFZ9SoJTuyTfXJKlgPpa/0x/CIYNASyXQ=;
	b=hIzwR1pqgmDl61PQcDTKHGznDcVhwvHQ7R4Wt8ch/8jDclmvCyT4SmrshTYKUH8CkE
	KoQJxPYDqzMJbmSIqG+ro3gNAQL7oIpDMCBLe1aRkkYKDhGO7TPqW7cPnzVWE4WPgDDb
	JWJFU/StrqvqPZBWb7ykFE+fWkElNO9cQ3R4sOksIMCaUKWQl1HgqOLxf5rsIpWPmU9+
	na/qIMzC2vOVP+/O7YBwDV/nJuEanodHyRxnsCFAtOhheWnhY6Up+w5yn960nuUQiaPo
	91HuyS//tt1DV9iC3tnnt+unLhCi69nEr7Rx83c+eJy54eBuHuKJTUg2yMPHr6X4fVIb
	+kTQ==
X-Gm-Message-State: APjAAAVGC+1ZuevZtRpDQhHxp5eZxrScltsy2rmipv6cSobKtKspz/TO
	1oR0v2Z0LejQaRf02j7JtXuA5Q==
X-Google-Smtp-Source: APXvYqyjGev5+2vi2/tdFJi2+wdkZLQNTruTzLAkCBI1aI7WQOssSzGUb8T1kwdZT7r1wk5YRimfxA==
X-Received: by 2002:a62:1747:: with SMTP id 68mr7925839pfx.63.1570060721898;
	Wed, 02 Oct 2019 16:58:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
	by smtp.gmail.com with ESMTPSA id g5sm472581pgd.82.2019.10.02.16.58.40
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 16:58:40 -0700 (PDT)
Date: Wed, 2 Oct 2019 16:58:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910021643.75E856C@keescook>
References: <201910021341.7819A660@keescook>
	<7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Semmle Security Reports <security-reports@semmle.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Oct 02, 2019 at 10:15:43PM +0100, Robin Murphy wrote:
> Hi Kees,
> 
> On 2019-10-02 9:46 pm, Kees Cook wrote:
> > As we've seen from USB and other areas, we need to always do runtime
> > checks for DMA operating on memory regions that might be remapped. This
> > consolidates the (existing!) checks and makes them on by default. A
> > warning will be triggered for any drivers still using DMA on the stack
> > (as has been seen in a few recent reports).
> > 
> > Suggested-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/dma-debug.h   |  8 --------
> >   include/linux/dma-mapping.h |  8 +++++++-
> >   kernel/dma/debug.c          | 16 ----------------
> >   3 files changed, 7 insertions(+), 25 deletions(-)
> > 
> > diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> > index 4208f94d93f7..2af9765d9af7 100644
> > --- a/include/linux/dma-debug.h
> > +++ b/include/linux/dma-debug.h
> > @@ -18,9 +18,6 @@ struct bus_type;
> >   extern void dma_debug_add_bus(struct bus_type *bus);
> > -extern void debug_dma_map_single(struct device *dev, const void *addr,
> > -				 unsigned long len);
> > -
> >   extern void debug_dma_map_page(struct device *dev, struct page *page,
> >   			       size_t offset, size_t size,
> >   			       int direction, dma_addr_t dma_addr);
> > @@ -75,11 +72,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
> >   {
> >   }
> > -static inline void debug_dma_map_single(struct device *dev, const void *addr,
> > -					unsigned long len)
> > -{
> > -}
> > -
> >   static inline void debug_dma_map_page(struct device *dev, struct page *page,
> >   				      size_t offset, size_t size,
> >   				      int direction, dma_addr_t dma_addr)
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4a1c4fca475a..2d6b8382eab1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -583,7 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> >   static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >   		size_t size, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > -	debug_dma_map_single(dev, ptr, size);
> > +	/* DMA must never operate on stack or other remappable places. */
> > +	WARN_ONCE(is_vmalloc_addr(ptr) || !virt_addr_valid(ptr),
> 
> This stands to absolutely cripple I/O performance on arm64, because every
> valid call will end up going off and scanning the memblock list, which is
> not something we want on a fastpath in non-debug configurations. We'd need a
> much better solution to the "pfn_valid() vs. EFI no-map" problem before this
> might be viable.

Ah! Interesting. I didn't realize this was fast-path (I don't know the
DMA code at all). I thought it was more of a "one time setup" before
actual DMA activity started.

Regardless, is_vmalloc_addr() is extremely light (a bounds check), and is the
most important part of this as far as catching stack-based DMA attempts.
I thought virt_addr_valid() was cheap too, but I see it's much heavier on
arm64.

I just went to compare what the existing USB check does, and it happens
immediately before its call to dma_map_single(). Both checks are simple
bounds checks, so it shouldn't be an issue:

			if (is_vmalloc_addr(urb->setup_packet)) {
				WARN_ONCE(1, "setup packet is not dma capable\n");
				return -EAGAIN;
			} else if (object_is_on_stack(urb->setup_packet)) {
				WARN_ONCE(1, "setup packet is on stack\n");
				return -EAGAIN;
			}

			urb->setup_dma = dma_map_single(
					hcd->self.sysdev,
					urb->setup_packet,
					sizeof(struct usb_ctrlrequest),


In the USB case, it'll actually refuse to do the operation. Should
dma_map_single() similarly fail? I could push these checks down into
dma_map_single(), which would be a no-change on behavior for USB and
gain the checks on all other callers...

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
