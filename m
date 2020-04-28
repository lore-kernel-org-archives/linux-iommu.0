Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F038C8300A
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:32:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAB620757
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JnahAMhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAB620757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E9282286C;
	Tue, 28 Apr 2020 15:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e0c7xUvOj4hk; Tue, 28 Apr 2020 15:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1500722889;
	Tue, 28 Apr 2020 15:32:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4B07C0863;
	Tue, 28 Apr 2020 15:32:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF83BC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D95B387D80
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzpxS3Wajjf4 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 15:32:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 08876882F3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:32:07 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id u16so3339800wmc.5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=fyTgxWA2/HoMwR8ETQ07Hg4eZzNMuWdW9xEgr0yJj2c=;
 b=JnahAMhEEz80r2yHKCjybbTF6t6+SIYUFMUPAtQp+GL3mUUzkfUaqp5KTHLcTJv+bq
 P81fy3Eh2D06/VO0ChUgMzUqlCQznBNcz0ezSC/Grx8Mg9Ct3d9vHUd1Fi4rVLtYvIEe
 M0+tdFHnDzbT2poSNgYQX/Eonc2j0jEST5fYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=fyTgxWA2/HoMwR8ETQ07Hg4eZzNMuWdW9xEgr0yJj2c=;
 b=nLSu+UIYbjUM2OQkO1N1MHt+eVrxWr37TatSABVpdgoFqlQ6hy5t4uAQvsNXwv/Um9
 fGC+GNNkpJ7RwClPwqt0GN7bUNOHyJ9+il8HxzmCP5xbvbCQynE4sxAuhSYRZQHjMkI3
 yMJ5/n2AfZ4cEkwJmpfj54DTLtK5ZvcoJf9GR7NdtPz2SOCSKwRGnp6vJTKglcSh0Mrg
 ODX2XdtBXi5fYUySZ6vEDbhB9Skk6/GukkFEyAN6NFhUMGmT8ouLIH8x+/ECwMbZ8H72
 TjKYTCdH0yPaS98DBD1wZJhrkTkofOZKbiBVGRqMa8RsLcagFpR2YanYVZ1/kr21duah
 zmDw==
X-Gm-Message-State: AGi0PuZSQihXH+qapHXl7QBlgbNhR+HNhoCMWwYPyB7+hXK6Fzuie/J0
 201iRsoNO6RFvRMPIHE/8dy75Q==
X-Google-Smtp-Source: APiQypK6liIbViG0xJy6SG6E2JLUCRqc/Rd4DEdt0buwtJigcJZRTqgPIaD55s8f3mCsTYZkcr3q5w==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr5073523wma.24.1588087925505; 
 Tue, 28 Apr 2020 08:32:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id p7sm27283944wrf.31.2020.04.28.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 08:32:04 -0700 (PDT)
Date: Tue, 28 Apr 2020 17:32:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
Message-ID: <20200428153202.GY3456981@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 intel-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
 <20200428132005.21424-1-m.szyprowski@samsung.com>
 <20200428140257.GA3433@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428140257.GA3433@lst.de>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 28, 2020 at 04:02:57PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
> > 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
> >    a proper sg_table entries and call respective DMA-mapping functions
> >    and adapt current code to it
> 
> That sounds reasonable to me.  Those could be pretty trivial wrappers.
> 
> >
> > 
> > 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
> >    which one refers to which part of the scatterlist; I'm open for
> >    other names for those entries
> 
> nr_cpu_ents and nr_dma_ents might be better names, but it still would be
> a whole lot of churn for little gain.  I think just good wrappers like
> suggested above might be more helpful.

I guess long-term we could aim for both? I.e. roll out better wrappers
first, once that's soaked through the tree, rename the last offenders.

Personally I like nr_cpu_ents and nr_dma_ents, that's about as clear as it
gets.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
