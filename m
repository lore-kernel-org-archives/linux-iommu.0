Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BFC2D0EA
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:09:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B086220A8B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B086220A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 691D1204F7;
	Thu,  9 Apr 2020 09:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8iQWKy4XCuB; Thu,  9 Apr 2020 09:09:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5959520390;
	Thu,  9 Apr 2020 09:09:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46114C1D7E;
	Thu,  9 Apr 2020 09:09:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC53AC0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CBBA784F24
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lUJr2lyQP6Y for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 09:09:04 +0000 (UTC)
X-Greylist: delayed 00:13:18 by SQLgrey-1.7.6
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 139A284B46
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:09:03 +0000 (UTC)
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 0398s3us004063
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Apr 2020 03:54:07 -0500
Message-ID: <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>
Date: Thu, 09 Apr 2020 18:54:01 +1000
In-Reply-To: <20200408122504.GO3456981@phenom.ffwll.local>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
> On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
> > If this code was broken for non-coherent caches a crude powerpc hack
> > isn't going to help anyone else.  Remove the hack as it is the last
> > user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
> 
> Well Ben added this to make stuff work on ppc, ofc the home grown dma
> layer in drm from back then isn't going to work in other places. I guess
> should have at least an ack from him, in case anyone still cares about
> this on ppc. Adding Ben to cc.

This was due to some drivers (radeon ?) trying to use vmalloc pages for
coherent DMA, which means on those 4xx powerpc's need to be non-cached.

There were machines using that (440 based iirc), though I honestly
can't tell if anybody still uses any of it.

Cheers,
Ben.

> -Daniel
> 
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/gpu/drm/drm_scatter.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
> > index ca520028b2cb..f4e6184d1877 100644
> > --- a/drivers/gpu/drm/drm_scatter.c
> > +++ b/drivers/gpu/drm/drm_scatter.c
> > @@ -43,15 +43,6 @@
> >  
> >  #define DEBUG_SCATTER 0
> >  
> > -static inline void *drm_vmalloc_dma(unsigned long size)
> > -{
> > -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
> > -	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
> > -#else
> > -	return vmalloc_32(size);
> > -#endif
> > -}
> > -
> >  static void drm_sg_cleanup(struct drm_sg_mem * entry)
> >  {
> >  	struct page *page;
> > @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
> >  		return -ENOMEM;
> >  	}
> >  
> > -	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
> > +	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
> >  	if (!entry->virtual) {
> >  		kfree(entry->busaddr);
> >  		kfree(entry->pagelist);
> > -- 
> > 2.25.1
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
