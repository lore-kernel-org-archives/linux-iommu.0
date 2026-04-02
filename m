Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFB3D7D9B
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123203; cv=none; b=SmwikAh9NAefYRm4gy7dS+qxgIzZKM6PruvJNeqByTSsd1WM7Jj+n/kWclOitRZPAMG1+/WekBqGLVbJwWjzcJleP3AOFdhNDtP8oU3mRGgmYLBck8mTk4CKRveU+hXDUAAZXbQtPX/cJogXsSTyUjlkGvn4e1/Ua6+7sYA4Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123203; c=relaxed/simple;
	bh=vUXO7T2/ld75TTELgi990iW9iowLKdyh/iNLP/ORvjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhgZQ+zxGw+g4tRqAVQxXHuU1N24zbjtxloTCA9rK36XfKYkPy3VuHj3zGKyRB5mRzXBJ6crfLAZ6dhOgOd4i4duyyvLhHgtSUnaeBdBww83wTJBe8pu3PloUsklT0BR6D5Dg/F+Meer/dptekMcdULBk9nkHH+GLQRVnVqq4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=limxPrir; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="limxPrir"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1A4791A6210;
	Thu,  2 Apr 2026 11:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775123195;
	bh=vUXO7T2/ld75TTELgi990iW9iowLKdyh/iNLP/ORvjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=limxPrir6umf6Dg0sUHXTunTgy2lMQoYo8uKwHpaw/ugeWDtTBsW2oYRQi103JoKf
	 OYzjYyML1aFBqN2C9txivY10qV8wFeCmhgATAgkredBK0g8UH7ETzBCtklvOfYjC7U
	 s1/k2Wj7lm7YS7+dmlwo7Xtojhx2AA2lh51R3jug9Mu7p3S0HLETExP0DWyrA3s1R9
	 Ix9zobp5YxGPVMWKN5k/jt/op7GB65OGplp6bY9SzxRpESJeTURbKE5XEcj6mXfDSx
	 ZLWmqGpysrPgZwNPoigRn/TP5Omzspkf75poliSz3B2FUKv6CVPhfR/KsHFtWetRko
	 E2Wh9yBjz7VPg==
Date: Thu, 2 Apr 2026 11:46:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 10/10] iommu/vt-d: Simplify
 calculate_psi_aligned_address()
Message-ID: <iy34vvsd6yak2v6bssapqoiotiu5mhhebarq43coh4lwcesgqg@p2cq55gahg4f>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
 <20260402065734.1687476-11-baolu.lu@linux.intel.com>
 <5b23df32-ed14-417f-b694-a191f4423aac@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b23df32-ed14-417f-b694-a191f4423aac@linux.intel.com>

On Thu, Apr 02, 2026 at 04:39:08PM +0800, Baolu Lu wrote:
> On 4/2/26 14:57, Lu Baolu wrote:
> > From: Jason Gunthorpe<jgg@nvidia.com>
> > 
> > This is doing far too much math for the simple task of finding a power
> > of 2 that fully spans the given range. Use fls directly on the xor
> > which computes the common binary prefix.
> > 
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Link:https://lore.kernel.org/r/4-v1-f175e27af136+11647-
> > iommupt_inv_vtd_jgg@nvidia.com
> > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > ---
> >   drivers/iommu/intel/cache.c | 49 ++++++++++++-------------------------
> >   1 file changed, 16 insertions(+), 33 deletions(-)
> 
> Hi Joerg,
> 
> Can you please remove this last patch from the pull request? The AI
> reviewer reported an issue in this patch.
> 
> https://sashiko.dev/#/patchset/20260402065734.1687476-1-baolu.lu%40linux.intel.com
> 
> We need more time to evaluate and address this before it is merged into
> linux-next.

Removed.
