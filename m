Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7B370AEC
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198112; cv=none; b=eiQZGR/Dsr1XVhBzFB+BiU6HwZfQN2Cu5I4lFjLvdmynJ8hzGHZ9KyJXtfb1vnbNL4gP4Tm8KdYakyOVM5jML0l5eRjzfIt0WlulHo1PRXBrd9IEipp1pWoWr/0kV3MZ6/DcCuGfwHBablXGsP1IUXrLHFbAjEBnSHBBlSb4r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198112; c=relaxed/simple;
	bh=XBOffOhB/9qLimda2QAP8c1r3War90H/Z69bX8D7upY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndy7DpjwcdT0pUUdXTdcpIKZlk2Fz3sjUOe8ywHiAdOixs9nVgPijEy897If15Y8WHxSQZ7s2j1WEbC0L3dZ1AdU9xoKgm09AontSC6K8wDQI3wxoKE1Alqv1xA416GDJRAuCqsIffjPeDB0/+xLpJucJSmtQYrOMXVFZKx1sLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liFFIOH5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liFFIOH5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso50a12.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198108; x=1779802908; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=liFFIOH5I2dOq9XNTR+OwjhuA4xx7b6hji544oDqaCfwvkcyyUi0gVk2TIT/4lqmoA
         ElORNFlJexAMdmliTTRbrMNbc9RMHPtyOyW0qx/VYziSpdQZfOyKVga75A9flRs2Qr8C
         BEYKiqt+IMC7GmnzOR6p0oaKO8mu24GJAdm8gxOpGgVlhCwd3O1ZopjRbfRp6KSszkgN
         dALNpQuW/EH99amUGRTHOBaAbzoKo+Nf0C/SY9qDmsB7up92XnlU3k4bhstDG+p/EoIK
         rGeAM6ZA7S2m1YZH4SsdIg/AEK1rUVhPvY8ukqTTa/cWu0bGTMmQOBEFGS7LDiIQEb9O
         9naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198108; x=1779802908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0rbd5r2XPU85ZjN9Z8MDWtjzmRcNTYnxCurh+UMIug=;
        b=TuDSaqUbruYve5/2UM4ieUeldx70vKd2FZQNfSG6XdFACKf3egStW93zPfTv9xClK3
         dq+u+txOKHNT20rEgHlr7h/T3tbCSGFCswzRz/ir0SRr3BvE1fMwlEAivm3T+AHnM6AM
         c5FV+1p18OXH/8Zd5r0FJQbsJxpwZS2BMTDipiJkghn4FRIaedyPWP+BZiZ2vHa7Hkvj
         sPwQ9loD2Xe3HK7GB3+AJgd/NEw42oRV2o8E+sYKJjpmsT99PyN91eiLl7/VqEuJiBT7
         dCS/gYboAXeRE1tu0emrSgTs0kXwDJ8aejlKcvWAl1Ob7pohJwVYXJX6WA5IYL6ZSwNj
         Fx2w==
X-Forwarded-Encrypted: i=1; AFNElJ9Hw/8S9256GDfIGP5EbnZsMVGNTI9uSZRUKwNjugBlipy17XlchEaqJs1PJxBtrIz1Z3ctIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxcc8JMOyrMtGiuVr4BLxbYPtZNeLwQyuv+cQ7YowfiO6vyyHxi
	SDU6qjKnlLJ+nn0lWmcT/IowKmeDoBc7msbeSmm5T60ypbewvXDbDYGB1hxtaz8hHw==
X-Gm-Gg: Acq92OGrrJwe+giG/fwEIe2m8quktvSEH//4zoqlm1CNw/6Ml4YFSfwvLpFbusF8h8p
	DDhFukEfAi7w1/viP5lTLUXT+WmQgR2XHztArfyQG9b2IpFibn9QIq7/zFZpPz7GhB2gLLXjZiV
	ASYt4gQn0+kBr03Ug+3RKFrkh43k9pD4RJhJjDNK5w5eecH6zgAIT/9/vZy7q6nwBBsXIf1A+xT
	hIELqv8WubiY3TGNNep7gSdWvfyAKsZL3EPGUT1JhsbLB+I1KUPllqKbmiUunIn9PxAWMxNa5jz
	+PxHcSN/ypIyWuK1K3+nk4V2tcvUgZEtT4bv0YcMz8ze6iJd9BgqKRqILigEnk3dwStR67w3wgj
	dJvesBBxSNj8YQLcJSeiVPCt31tCoio6m3LO2lrxywlpoPdC1q2O/giFnxYq2xybQ2S2ShsbvUQ
	1ZH8jHIJ3LhOd8iWrYIq7SwNB2/8SqYOjbyH8KuyWvsVLRu6Fk2doqTngL2uDCcaD4l3/leHjPZ
	x4=
X-Received: by 2002:a05:6402:21d3:b0:672:9c8f:910a with SMTP id 4fb4d7f45d1cf-6848a7425fdmr177638a12.8.1779198107616;
        Tue, 19 May 2026 06:41:47 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded942sm705903166b.36.2026.05.19.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:41:46 -0700 (PDT)
Date: Tue, 19 May 2026 13:41:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxolksC_1nfO34X@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519132911.GA7702@ziepe.ca>

On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > >> 
> > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > >> that we can use it in the conditional above.
> > > >
> > > > I have this patch, with that I can boot with your series unmodified,
> > > > but I will need to do more testing.
> > > >
> > > 
> > > Thanks, I can add this to the series once you complete the required testing.
> > > 
> > 
> > I am still running more tests, but looking more into it. Setting
> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > guest shouldn’t try to decrypt arbitrary memory as it can include
> > sensitive information (for example in case of virtio sub-page
> > allocation) and should strictly rely on the restricted-dma-pool
> > for that.
> 
> ??
> 
> Where does force_dma_unencrypted() cause arbitary memory passed into
> the DMA API to be decrypted? That should never happen???

Sorry, maybe arbitrary is not the right expression again :)
I mean that, with emulated devices that use the DMA-API under pKVM,
they will map memory coming from other layers (VFS, net) through
vitrio-block, virtio-net... These can be smaller than a page, and
using force_dma_unencrypted() will share the whole page.
And as discussed, that leaks sensitive information to the untrusted
host.
I am currently investigating passing iova/phys/size
to force_dma_unencrypted() and then we can share pages inplace only
if possible without leaking extra information.
I am trying to get some performance results first. But the tricky part
is to get the semantics right, I believe in that case those devices
shouldn’t use restricted-dma-pools as those should always force
bouncing. Instead bouncing happens through the default SWIOTLB pool,
if not possible to decrypt in place.

Thanks,
Mostafa

> 
> Jason
