Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3A3783DA
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099818; cv=none; b=WbRi9NrHuokL0iTAf44b+uXmaDOC8YnFXr64AaJHpdcXczqQ5z4QdBYFSQOjsoDfSGYZWWBjwW1cyXelEaqQ9yBzpQ+s5glMY9ktJvRo9874EVrShoT3C9+ZPVL8cGmhs7FwmYZi/j1DVBoF7WFJ16eBcrSUuVuX4jPPe+VNuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099818; c=relaxed/simple;
	bh=/kLoTOe5FC2CxDqhlFIElETrsMXYSY0UbTK2LjJL8lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxziphu18eS/w1ugLNm8tumfBWe/cnqkCfd4Gbgd3WzXm62xX3SKmpyne79/GN8UX6Q6XALyxCjMzGP3luJ6gOJ9t3oV7ViRpC2cp7FMPSeunRafj77qlyXfwDfHSGHfcDvCJOzKvFcVlpj9n/6/MPm1/tp5ncsTeo4x8uYGIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F135868B05; Tue,  3 Feb 2026 07:23:34 +0100 (CET)
Date: Tue, 3 Feb 2026 07:23:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203062334.GI16426@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp> <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp> <20260203052756.GA15839@lst.de> <aYGSP4luf1nOFhS2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYGSP4luf1nOFhS2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 11:14:23PM -0700, Keith Busch wrote:
> On Tue, Feb 03, 2026 at 06:27:56AM +0100, Christoph Hellwig wrote:
> > >  	iod->nr_descriptors = 0;
> > >  	iod->total_len = 0;
> > >  	iod->meta_total_len = 0;
> > > +	iod->nr_dma_vecs = 0;
> > > +	iod->dma_vecs = NULL;
> > 
> > I don't think we need the dma_vecs initialization here, as everything
> > is keyed off nr_dma_vecs.
> 
> Yes, we should definitely use nr_dma_vecs and skip the NULL setting. I'm
> a big fan removing unnecessary initialisations. Just a caution, my
> suggested patch has this check:
> 
> 	if (!iod->dma_vecs)
> 
> So we just need to update it to use 'iod->nr_dma_vecs' instead, which
> would have been correct, too.

Ah, right.
