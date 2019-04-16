Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A152C10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 07:51:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FF02073F
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UhzC1yDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FF02073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BED33CC1;
	Tue, 16 Apr 2019 07:51:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6DE69D
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 07:51:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2DFE25E4
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 07:51:55 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id x61so17008359edc.9
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
	h=sender:date:from:to:cc:subject:message-id:mail-followup-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=7jNtxv9e+QWoL+nxsHxcU+XebVLgfgg8ZHSaQ6Ck++w=;
	b=UhzC1yDYtTlCTl7bwfr1Tz54WT4eoHBS/L0B1C+TRgkAHxGlqANxQ7YAh+fH5hXT2Q
	YL9tZTVnXzC6a+5X2oxpwDXT1fhrwVJebqBswSFv44+ehMkF7TJWO7lXM01GZiztW7j1
	a5JcnO3sCQh6yXLDLZmPHbumdioRC6hsGzRsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=7jNtxv9e+QWoL+nxsHxcU+XebVLgfgg8ZHSaQ6Ck++w=;
	b=SngIystUatzFfrDC+VuDOQlyrJGGfgvS78CHdwoXdBhGIBaS05d3PXoGtoK7MOJ7zj
	B6WX11JlXT1WclB99i5vuVdbe14YSTKSyXaCBWn67/OIebwk1MlKR7Ue1UcAtIGlBdPw
	Wl3/Acq6dnKfGM1jrOmpRxnOgglNqI9rSZ49xnLW7b3mH2xLE6zHXEhOiFuBjrrBrZXa
	PX/opbmXPlp/4cxWYG7Wg/4jlMmlE4iLllXy/9Tz5+Ubec2fqfx5NAQzr58imaPKqJAe
	HI9B1TZpcZNZj9erWQxIxo3Bm44l1zh45mRqLRYSzf4x3EQfxFC5+VmYnM79ekvwsoo+
	wNNw==
X-Gm-Message-State: APjAAAXON+LMsW03px1mtAlmgfgR5r79vdGhFOEj2ocfQvdW3v/3n04g
	655bMcSCbruBenbywi42ZO6XWA==
X-Google-Smtp-Source: APXvYqzoSwwi6rPH/PPCvDSqoisNzF/DHHX2I6RV70LEoyCtIw8qyy8v7xd+Cq1ZmB0cbJ+Y9PeCCw==
X-Received: by 2002:a17:906:d1d9:: with SMTP id
	bs25mr18325308ejb.213.1555401113741; 
	Tue, 16 Apr 2019 00:51:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
	by smtp.gmail.com with ESMTPSA id
	ga13sm9500506ejb.9.2019.04.16.00.51.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 16 Apr 2019 00:51:52 -0700 (PDT)
Date: Tue, 16 Apr 2019 09:51:50 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Message-ID: <20190416075150.GR2665@phenom.ffwll.local>
Mail-Followup-To: Steven Price <steven.price@arm.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org,
	"Marty E . Plummer" <hanetzer@startmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-4-robh@kernel.org>
	<5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
	<20190405161632.GA9160@rosenzweig.io>
	<34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
	<20190415091837.GV2665@phenom.ffwll.local>
	<50682635-4134-f36b-dcb0-2a4d98eedb3c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50682635-4134-f36b-dcb0-2a4d98eedb3c@arm.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	"Marty E . Plummer" <hanetzer@startmail.com>, Sean Paul <sean@poorly.run>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416075150.21f4sJu0jQZfToBEgg25cXJ6xK01HPZLC3QPrPgRQOQ@z>

On Mon, Apr 15, 2019 at 10:30:14AM +0100, Steven Price wrote:
> On 15/04/2019 10:18, Daniel Vetter wrote:
> > On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
> >> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
> >>> acronym once ever and have it as a "??"), I'm not sure how to respond to
> >>> that... We don't know how to allocate memory for the GPU-internal data
> >>> structures (the tiler heap, for instance, but also a few others I've
> >>> just named "misc_0" and "scratchpad" -- guessing one of those is for
> >>> "TLS"). With kbase, I took the worst-case strategy of allocating
> >>> gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
> >>> With the new driver, well, our memory consumption is scary since
> >>> implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
> >>> and isn't expected to hit the 5.2 window.
> >>
> >> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
> >> (reasonably) possible to determine how big it should be. The Arm user
> >> space driver does the same approach (tiny commit count, but allow it to
> >> grow).
> > 
> > Jumping in here with a drive through comment ...
> > 
> > Growing gem bo and dma-buf is going to be endless amounts of fun, since we
> > hard-coded that their size is invariant.
> > 
> > I think the only reasonable way to implement this is if you allocate a
> > really huge bo, map it, but only put the pages in on faulting. Or when
> > really evil userspace tries to export it. Actually changing the underlying
> > buffer size is not going to work I think.
> 
> Yes the idea is that you allocate a large amount of virtual address
> space, but only put a few physical pages in. If the GPU needs more you
> fault them in as necessary. The "buffer size" (i.e. virtual address
> region) never changes size.
> 
> > Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
> > works.
> 
> For kbase we simply don't support exporting this type of memory, and are
> fairly restrictive about mapping it into user space (user space
> shouldn't normally need to read it).

You can still disallow sharing with any other driver (in the dma-buf
attach callback), and then enforce whatever mapping restrictions you want
on the panfrost.ko ioctl interface. That should be roughly equivalent to
the restrictions kbase imposes.
> 
> Since Panfrost is using GEM BO it will have to deal with malicious user
> space. But it would be sufficient to simply fully back the region in
> that case.
> 
> Recent version of kbase also support what is termed JIT (Just In Time
> memory allocation). Basically this involves the kernel driver
> allocating/freeing memory regions just before the job is loaded onto the
> GPU. These regions might also be GROW_ON_GPF. The intention is that when
> there isn't memory pressure these regions can be kept between jobs, but
> under memory pressure they can be discarded and recreated if they turn
> out to be needed again.
> 
> Given the differences between the Panfrost and the proprietary user
> space I'm not sure exactly what form this will need to be for Panfrost,
> but Vulkan makes memory management "more interesting"! Allocating
> upfront for the worst case can become prohibitively expensive.

The usual way to do that is with a WONTNEED/WILLNEED madvise ioctl on the
gem bo. I guess that could also be set at create time to essentially only
require the bo to exist during an execbuf call. Should fit pretty well
into what other drivers are doing with gem shmem already I think.

ofc needs a shrinker to be able to reap these bo.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
