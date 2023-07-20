Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01514011
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 07:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689836816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKZfYzuy4E/p4i4FmKgAIZ9a9JybiBKol5y+hz08Ow8=;
	b=DfkEdrQi3U8PbHmAX139YPkvg0KVAMsoD+URZPAmvEnC2KevRosTlw1skwQAfrY80ze50K
	amk50uLfNbzGvZ1Uyl12X3F7FO7rpAk3BeY9b4A2iOceHwzwIN5SfaKXyEzxTVvdVHLcqk
	N/tesY/mHLFnjznyIH136zWslSrfa0A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-BAIFFihjMZ6C03MI2G52bg-1; Thu, 20 Jul 2023 03:06:55 -0400
X-MC-Unique: BAIFFihjMZ6C03MI2G52bg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b701e0bb10so3491051fa.3
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 00:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836814; x=1690441614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKZfYzuy4E/p4i4FmKgAIZ9a9JybiBKol5y+hz08Ow8=;
        b=cHL+Z0CYlScXurFasMsz+95tlSTaSCLg+CB/+gqHDG9d/0Snlb4oywsDIaxFkttI/l
         37A+lINWp7K+fkWi1AJAsOZZq1hv9mdMZqWvOCGfnSUsweyoFhWXgmUp25zzz2CnfAdH
         yUeJDQsdi+hZtz0SouIlNDIyXPGUOUKzrsxysmTANeRMD/XmslckfP1o7U0nXABuwR4H
         ohpPUEGxiYH7S+KVpQ5V7DC2YoIch0PVEL2Ksffzv1R8JybDHSluVlLaSB6yVPAJ8aAe
         R8lqBGmDCVDVg/cY6S4Q5DufLPPBEAtlE30Jypns4zeWlMJMYhMWHu8dNp7hsyXVGC2e
         qYRQ==
X-Gm-Message-State: ABy/qLajd1ly/xFr5QGeqZqm4lb0yDMAyKTvsnoBf6sq9n+fL20TrM0z
	HAypookXBsNxV1g+fJlMsISg/7c6hSHOO/KK8T9n4GaZ52qBCpAUX1XJ6H7FdN9JT2ARwla/dnW
	0bfzBw7+W3VdvdB2xm7c1L8Q=
X-Received: by 2002:a2e:86d1:0:b0:2b7:3633:2035 with SMTP id n17-20020a2e86d1000000b002b736332035mr1708631ljj.32.1689836813847;
        Thu, 20 Jul 2023 00:06:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFb3DdJpOxK9cF5ht1/AH7KtkJnsdZ3w8mElpI2B0W+viUyDR+t1spT9RkiGQgxxAwTq2UA1Q==
X-Received: by 2002:a2e:86d1:0:b0:2b7:3633:2035 with SMTP id n17-20020a2e86d1000000b002b736332035mr1708608ljj.32.1689836813428;
        Thu, 20 Jul 2023 00:06:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:65c:3b05:aa8f:9ec2:7e3e])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003fbc0a49b57sm461752wma.6.2023.07.20.00.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:06:52 -0700 (PDT)
Date: Thu, 20 Jul 2023 03:06:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720030233-mutt-send-email-mst@kernel.org>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
 <20230720060742.GA2987@lst.de>
 <20230720021914-mutt-send-email-mst@kernel.org>
 <20230720062525.GA3723@lst.de>
 <20230720022702-mutt-send-email-mst@kernel.org>
 <20230720064318.GA4349@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230720064318.GA4349@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 08:43:18AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 20, 2023 at 02:30:04AM -0400, Michael S. Tsirkin wrote:
> > sure, they are not hard to generate ;)
> > 
> > https://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo%40linux.alibaba.com
> 
> Thanks, I'll chime in there.
> 
> > > > Looks like there's really little else can be done: there's a
> > > > shared page we allow DMA into, so we sync periodically.
> > > > Then when we unmap we really do not need that data
> > > > synced again.
> > > > 
> > > > What exactly is wrong with this?
> > > 
> > > A "shared" page without ownership can't work with the streaming
> > > DMA API (dma_map_*) at all.  You need to use dma_alloc_coherent
> > > so that it is mapped uncached.
> > 
> > Hmm confused.  Based on both documentation and code I think this works:
> > 
> > 	dma_map
> > 	dma_sync
> > 	dma_sync
> > 	dma_sync
> > 	dma_sync
> > 	dma_unmap(DMA_ATTR_SKIP_CPU_SYNC)
> > 
> > right?
> 
> Depends on your definition of "shared".  If there is always a clear
> owner at a given time you can games with lots of syncs that transfer
> ownership.  If there is no clear ownership, and the "device" just
> DMAs into the buffer at random times and the host checks bits in
> there we need to map the buffer uncached.
> 
> I'll chime in in the thread.

Each chunk of that buffer is DMA'd into separately and then sync'd
afterwards.


> > 
> > -- 
> > MST
> ---end quoted text---

