Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7213E5560
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758218; cv=none; b=JMlCRUwrhb4MugRHZkNm5KTJA1MLwUQqC631tPTefRkKRRbFpIC9ywRFxiuUanUuScK/4R+60jQgkuPs+3yVB19NreR+byds5T2SenVNmhNPVe5TOztNd5pBpTZnngiS09n/kK78Yf8l7cK3E/7lcuFrBhbK4wx2K1BmudNcWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758218; c=relaxed/simple;
	bh=B78I22qlOSMlm3znuSGlssbuIuirdHTXlq/YUV/eu9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzVasb176hbbgv0rD8ch7Tf1GGyDapegWbyXHaUFr5hH6GftDLGRupWfLXvpJupJgYWZOVce3eaMgqQADSqOFjCRKrsw/JbkuViobbycqtR6KOGDVHWZ/GPY8x6E0KglHzxIM3amb7tkLdEL6+FQEspKY97o57sIHm0jTAS1alk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7989B68BEB; Tue, 17 Mar 2026 15:36:52 +0100 (CET)
Date: Tue, 17 Mar 2026 15:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
Message-ID: <20260317143651.GA5186@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 17, 2026 at 09:11:59AM +0000, John Garry wrote:
> For SAS controllers, don't we limit shost->opt_sectors at 
> shost->max_sectors, and then in sd_revalidate_disk() this value is ignored 
> as sdkp->opt_xfer_blocks would be smaller, right?

That assumes opt_xfer_blocks is actually set.  It's an optional and
relatively recent SCSI feature.  So don't expect crappy SSDs or
RAID controllers faking up SCSI in shitty firmware to actually set
it.

