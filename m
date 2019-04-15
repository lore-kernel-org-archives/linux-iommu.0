Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C2C282CE
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242BE2087E
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bfIvQYOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242BE2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B1771E90;
	Mon, 15 Apr 2019 09:18:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6F4A22
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 09:18:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 245F02C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 09:18:41 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id f53so12440679ede.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
	h=sender:date:from:to:cc:subject:message-id:mail-followup-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ynQtq/6aBUoTAipkeDKcQtf7kKsME/OPz6dQg69/ZqA=;
	b=bfIvQYOsMuRfY7e2nyCsEZp366cC8dWDkDaYDWjxwzxadojySJtksZwssf/48Lk7uf
	GUHPNRX/ujNQ1QYwPiFyrGwtJaU7VpLIjhP0kl/W9R9YUMRSfK4Gyd8c0Ab6ecPHf9bw
	kywY6l2dmW2fER/dievAMG/iLNhDovtkvEkX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=ynQtq/6aBUoTAipkeDKcQtf7kKsME/OPz6dQg69/ZqA=;
	b=bpwnh//qw9nmGSUoJl1S29uGejvVZh9thOfPMaEgn2/ukQEHPWHm70UmwjymGDW9Xv
	qea4Bluo0PcyieBnnSGV93jqncYT3pYtMsmSJjGKgZwbsDDKNRJCWXITXW9DNH/p4fXq
	gkkk+Matj5wqDttFpNpjvUUknSB3hLfVzPSJlKY605m1qLDdoeI/ZEDTNh8F5zsrCttJ
	PXFzs49ZRzDliTs+9Ud1ocsqVGF7QpjA9mRDkEYN3maI1uUIwzfdwT53/51XpBtYtYee
	slaXdgzY8Gp2HXIUZjR1yQsUKOKKdJ6MvHnz+LM2p+GXAgjrj0/bXacvJBRXI3EvDJY4
	UBeQ==
X-Gm-Message-State: APjAAAXi2DU2NaWwdhOO4ftt/efyDwyo0u2InN8nD0AYGLp2Iy4Hvsdg
	LaAtXoW9fobrWdNemxbNSGrjrA==
X-Google-Smtp-Source: APXvYqz4bP4buv8PrROHVBzhkpiDUy0i+0wCAHiCT1WKRbo3mf5xVcBaqcpM2rq8dc8Va+iUasniiA==
X-Received: by 2002:aa7:ca07:: with SMTP id y7mr14132059eds.149.1555319920740; 
	Mon, 15 Apr 2019 02:18:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
	by smtp.gmail.com with ESMTPSA id b2sm2635652eds.15.2019.04.15.02.18.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 02:18:39 -0700 (PDT)
Date: Mon, 15 Apr 2019 11:18:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Message-ID: <20190415091837.GV2665@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
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
Message-ID: <20190415091837.jZRyDUiwhgcq8kcFjQ81KHsKcBkFmU_5cXkUT4EY0nQ@z>

On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
> > acronym once ever and have it as a "??"), I'm not sure how to respond to
> > that... We don't know how to allocate memory for the GPU-internal data
> > structures (the tiler heap, for instance, but also a few others I've
> > just named "misc_0" and "scratchpad" -- guessing one of those is for
> > "TLS"). With kbase, I took the worst-case strategy of allocating
> > gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
> > With the new driver, well, our memory consumption is scary since
> > implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
> > and isn't expected to hit the 5.2 window.
> 
> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
> (reasonably) possible to determine how big it should be. The Arm user
> space driver does the same approach (tiny commit count, but allow it to
> grow).

Jumping in here with a drive through comment ...

Growing gem bo and dma-buf is going to be endless amounts of fun, since we
hard-coded that their size is invariant.

I think the only reasonable way to implement this is if you allocate a
really huge bo, map it, but only put the pages in on faulting. Or when
really evil userspace tries to export it. Actually changing the underlying
buffer size is not going to work I think.

Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
works.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
