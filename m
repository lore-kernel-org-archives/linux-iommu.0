Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A1192D72;
	Thu,  5 Sep 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537013; cv=none; b=t6BXoHHEtxhrOKNzTorGPzxFQOniNDjjdmqTZCsoOGHoxeXFer1iL0AINGwTV8s0u9z5YskIIr6SqlW9oEvVMVqD4wfocGVJJPIX0ok3sGZG6eIW8jt90LARZ9BHCSeqfBH1/Wkq/+lt10djXXe/qrtEmR39tXuIGuLVNgvINqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537013; c=relaxed/simple;
	bh=2jL4Esy1LGngJuoA1eZbqYGV8ku9E/wWFa/WOBVL9VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNPi2QaaxZORGrPy/sTDHIACUrC5+SAloNgodDeF+omVGEi8uA4JtirBrQI5urfHzjck8h+AU4kr9gENwlA+Z9tBYn/v6+519OemrDM9vqQmDwRaiaRzMgqYzDT6y87DwuKKq4yacYgNy55kX6NUh+TjXUI6mrEMFEuoL0ecTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIyYOeFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIyYOeFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5B4C4CEC3;
	Thu,  5 Sep 2024 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537012;
	bh=2jL4Esy1LGngJuoA1eZbqYGV8ku9E/wWFa/WOBVL9VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIyYOeFLw6DR159BZGV30HxQiro5FlGQdU4K6svU2qjvSDA84KbaupEXu/H1BXtYU
	 NgzqmMom/JRUaTih2GiLUZXMbmpsOZo2ZouhoOC6fqEa9sgdcDBfY35avY/JtQC0UI
	 lmj9Xg8jMujnbaC6CM85Gixqto2s2EEYLBUWnKSXzm5+MqBgsUwDGOLGMWPgl0xHJA
	 mpJLvyspKsyuvllA0YptAcez85Bki6g5SK/s8bB/WZkgkKg5qIwf+ODS3YX+R71K0H
	 vJV82ldPFSEG/++tFkk7H7slMrGEZ3F0/+1cYh6WwBpdedNm51ZyPXQQZc2NPcoa2P
	 ONUrYvxmUvPew==
Date: Thu, 5 Sep 2024 14:50:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH] dma-mapping: Use IOMMU DMA calls for common alloc/free
 page calls
Message-ID: <20240905115007.GV4026@unreal>
References: <62ce544e41d233eb6f591514a53f2eaabf488a7b.1725519850.git.leonro@nvidia.com>
 <20240905113151.GA25243@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905113151.GA25243@lst.de>

On Thu, Sep 05, 2024 at 01:31:51PM +0200, Christoph Hellwig wrote:
> Thanks  applied.
> 
> I'm not entirely sure if simply duplicating the helper logic in dma-iommu
> would be better, but unless Robin has a strong preference we can just
> go with this version for now.

My plan (if it is possible to call such) is to progress towards new DMA API
first and then see how to refactor the code to make it more clean.

Thanks
