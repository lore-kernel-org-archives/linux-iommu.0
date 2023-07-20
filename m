Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC73383
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtNCKI30gUb2ejju1iAv/z/Xf+Tlc73YIKqusu5O8yY=;
	b=AmoN8Tiu+2ZuBWAOgM/gON2bzPibUg3sG4aNY5U/iNK+6uSk+zBCOAtajwDQ8+J5abFyvb
	2pWU+T0fQzDY5g2r/QM4QNgKOONe4lJRLeAwNFR33e1zqs1/8ieZ7/qH8lZQTg7wzGAkS1
	4pSMoo5NIdS1zbVS6ILjvwDHXPmyfws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-6fGPEgxBMZqg1n41rf-1uQ-1; Thu, 20 Jul 2023 02:34:46 -0400
X-MC-Unique: 6fGPEgxBMZqg1n41rf-1uQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso7066455e9.1
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 23:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834885; x=1690439685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtNCKI30gUb2ejju1iAv/z/Xf+Tlc73YIKqusu5O8yY=;
        b=kHXZxnBQ/3E5rgFJmG5KPKF2pgdvlRAULIJJPqzMYPcknScIoh7gO0ZfpxVH+izpd9
         JJShc9Le36awp2BwO4KpGOSD5nFnLjGv7wLYBZ9LvlAf1ZI1W1A6aGo5XJBfPI245Ii2
         mk5v3lHSOxDAeO1Qu6Lk5PC80R3iUgrRFKNgkmpw8mbEcGy3V3kP/rdqxRBj7vn17lxw
         3ThQ4kZigzvT2rxaRkJQe7OvUe4lMeTZ1L5Xs8FbMp1mddUyRcHB/jPIr7aYLh62mxg1
         GG4fBozum8mqiV9qFOv3mbz6XJX8Iu+8RORT4VoFttN83s2h9DJVCBtdJkGomKrp8Wae
         6fKA==
X-Gm-Message-State: ABy/qLbaNLhv31nV0w1A5rvGxmR+Drk+uRGtgf5E5UJhXVAw7RbjnLJN
	a7tC1fMiegptyrPOivZ3z/50Y3g4kRw93FkaH3XIsYFDoQkVH6Y62j/ZNjOXLZYAnDoimUxeHBP
	SgOLoVWCQUtrI77U=
X-Received: by 2002:a7b:c5d6:0:b0:3f4:2a69:409 with SMTP id n22-20020a7bc5d6000000b003f42a690409mr3717561wmk.11.1689834885485;
        Wed, 19 Jul 2023 23:34:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/md4YMGZnSVmWQIIDVMHy+n/6oKujQJGj4xD8x/EzYsJTyApNBYgjSGjDE5JrX+Ajl2WgQA==
X-Received: by 2002:a7b:c5d6:0:b0:3f4:2a69:409 with SMTP id n22-20020a7bc5d6000000b003f42a690409mr3717539wmk.11.1689834885126;
        Wed, 19 Jul 2023 23:34:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:65c:3b05:aa8f:9ec2:7e3e])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b0031424f4ef1dsm322685wrn.19.2023.07.19.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:34:44 -0700 (PDT)
Date: Thu, 20 Jul 2023 02:34:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720023359-mutt-send-email-mst@kernel.org>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com>
 <20230720060742.GA2987@lst.de>
 <20230720021914-mutt-send-email-mst@kernel.org>
 <20230720062525.GA3723@lst.de>
 <20230720022702-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230720022702-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 02:30:08AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 08:25:25AM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 20, 2023 at 02:21:05AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jul 20, 2023 at 08:07:42AM +0200, Christoph Hellwig wrote:
> > > > On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> > > > > A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> > > > > might be easily misunderstood.
> > > > 
> > > > .. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
> > > > often a bad idea and all users probably could use a really good
> > > > audit..
> > > 
> > > Message-Id: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
> > 
> > Do you have an actual link?
> 
> sure, they are not hard to generate ;)
> 
> https://lore.kernel.org/all/20230710034237.12391-11-xuanzhuo%40linux.alibaba.com


actually there's a new version

https://lore.kernel.org/all/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com

you can see it does map, sync, unmap

unmap immediately after sync seems to be exactly the use case
for DMA_ATTR_SKIP_CPU_SYNC.


> > > 
> > > 
> > > Looks like there's really little else can be done: there's a
> > > shared page we allow DMA into, so we sync periodically.
> > > Then when we unmap we really do not need that data
> > > synced again.
> > > 
> > > What exactly is wrong with this?
> > 
> > A "shared" page without ownership can't work with the streaming
> > DMA API (dma_map_*) at all.  You need to use dma_alloc_coherent
> > so that it is mapped uncached.
> 
> Hmm confused.  Based on both documentation and code I think this works:
> 
> 	dma_map
> 	dma_sync
> 	dma_sync
> 	dma_sync
> 	dma_sync
> 	dma_unmap(DMA_ATTR_SKIP_CPU_SYNC)
> 
> right?
> 
> -- 
> MST

