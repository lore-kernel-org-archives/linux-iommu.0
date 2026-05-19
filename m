Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578A3E559B
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182905; cv=none; b=QkS8qB1MoBmQ24RSWZiqrfp64gZOcyFjd90I17A9nezGrcHVvDfCFrvOmKrJgV14xjNnvCAFKRZbeHRylfyjNC0c270I8U9sOmfxKizSF4sOzfTN6k85++IBA2NVz7uPDkcC0eihHztPuROj5S3kpQStOtlZxPp4ttbVo8B0jho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182905; c=relaxed/simple;
	bh=+tjWDgau8jMzw6fm+7DCBZzTY1V7+2SzdSrQXczIZ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODmZuOHdE8ZsTo65MOsQcM/dBLnbgxXbHbJX/Xh1SQv3pIVLuosfHAWWXjvwKt5gG1TEjF7jDCnw1ZzCEN3Gs/GH9FIDPHeRpbd8lECYB4W3mUNsZqTDla1nSJege5xvVWOT1g7fE+dYNZANFozoRFTdFnT9AxmiNR9orrQCDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E689268C4E; Tue, 19 May 2026 11:28:19 +0200 (CEST)
Date: Tue, 19 May 2026 11:28:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	m.szyprowski@samsung.com, robin.murphy@arm.com, djbw@kernel.org,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260519092819.GA20292@lst.de>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com> <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com> <20260518125330.GT33515@unreal> <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com> <20260519071758.GB10037@lst.de> <CABXGCsNg6NUefejbqGBpH1iff9H6mJ-3Zamb0A54ay1zrfuJeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsNg6NUefejbqGBpH1iff9H6mJ-3Zamb0A54ay1zrfuJeQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 19, 2026 at 01:03:08PM +0500, Mikhail Gavrilov wrote:
> On Tue, May 19, 2026 at 12:18 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > It is not.  We could require direct I/O to/from devices that are
> > attached without DMA coherence to require cache line alignment.
> >
> > Now that Keith pushed down the checking into the driver that's even
> > fairly easily doable.
> >
> 
> Good to hear. Is there a posted series or branch I could look at?

This work is upstream, IIRC it got merged around 6.18 or 6.19.

