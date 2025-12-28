Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755181F956;
	Sun, 28 Dec 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766933445; cv=none; b=JJ4cYYg/s0UbGfFXWt/uX4MeOS+Jawvf2uhrKQPhuVr4NW+x2e7W5GYCOYUT96uX2CzksWgZaRmPGC/HmiHgF+HAm5OomxVWwxgnDhxTuuBHtwjilsW5vYaC4Rk7a29tM7yF4yoowPAjZ3h/3/z2CMO91YGi+ivQt7kEHzAZjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766933445; c=relaxed/simple;
	bh=qbiHTFr5GuNGzRGenhnbtkv5WysSVwMoyJI42ZMBbjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6r0bomKqZhRBRxQfOeHZi031x7zgDV1NSi1ba/ieQlqelEBDxCN3/+YEB4lkvR1wOrNMpsjJY6fmu5uYbIgL6z7riIHzsR3TgiET4ls7i78Fh+6c3CSBid5WglbKsbUVtPV7GkCVT6Fx+RhVgCRDWcUMPxthrkrsTr4jjvxh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR1KTIMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR1KTIMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDB8C4CEFB;
	Sun, 28 Dec 2025 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766933445;
	bh=qbiHTFr5GuNGzRGenhnbtkv5WysSVwMoyJI42ZMBbjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uR1KTIMbxcfjIMp5BeqFx3rLg3y1/DslfD3E9dpTGsYLDXumEMvyTDlrtJexRliP8
	 4rMhxVlEgscTX6SMvyoGGbqBB9s3IhOyr0Dq1rOTTq9DRKyQCs5R4MMaiXq5SMJDv8
	 ypPf4xJu36IIq2elskChlmVCggK0X5P0P3iMsdzipt3Q/Pz09VtoJGRlajt3LsI+Wl
	 gbwuGIGXFZFArEze9cY3ogr29kq3DbeOzLDvfFkXuQM3i0eAPwqneC1a0xL9kATsPV
	 e7ey8Ht1VOWWZqIFGccgi1XAHIthQy1YRdTkX615ut3eBb5C2AjajZOKWeMy6qELr1
	 bfIt1iNGLWgqA==
Date: Sun, 28 Dec 2025 16:50:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for
 dma_direct_sync_sg_for_*
Message-ID: <20251228145041.GS11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-6-21cnbao@gmail.com>
 <20251227200933.GO11869@unreal>
 <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>

On Sun, Dec 28, 2025 at 09:52:05AM +1300, Barry Song wrote:
> On Sun, Dec 28, 2025 at 9:09 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
> > > From: Barry Song <baohua@kernel.org>
> > >
> > > Instead of performing a flush per SG entry, issue all cache
> > > operations first and then flush once. This ultimately benefits
> > > __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
> > >
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> > > Signed-off-by: Barry Song <baohua@kernel.org>
> > > ---
> > >  kernel/dma/direct.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > <...>
> >
> > > -             if (!dev_is_dma_coherent(dev)) {
> > > +             if (!dev_is_dma_coherent(dev))
> > >                       arch_sync_dma_for_device(paddr, sg->length,
> > >                                       dir);
> > > -                     arch_sync_dma_flush();
> > > -             }
> > >       }
> > > +     if (!dev_is_dma_coherent(dev))
> > > +             arch_sync_dma_flush();
> >
> > This patch should be squashed into the previous one. You introduced
> > arch_sync_dma_flush() there, and now you are placing it elsewhere.
> 
> Hi Leon,
> 
> The previous patch replaces all arch_sync_dma_for_* calls with
> arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
> functional change. The subsequent patches then implement the
> actual batching. I feel this is a better approach for reviewing
> each change independently. Otherwise, the previous patch would
> be too large.

Don't worry about it. Your patches are small enough.

> 
> Thanks
> Barry
