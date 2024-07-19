Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BF29CE6
	for <iommu@lists.linux.dev>; Fri, 19 Jul 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721366881; cv=none; b=puWoT0LgZXcJPyuo58XYRcol0vkqAET9m7gfqJ7nTNtNvBg4X81OBHH2gwa/vIzyOA/q04wuB0M2Z0wvpmMuLJq6ehfK5DV3BSsEP/NbXDUuLGNkH7Ogx0haEfUEvC31K/vd+EE9p/Yd3EtLNXEGQiEXwMU6O8nndJl+K/8JgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721366881; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoeUDAbbDm30/BZ2k/U7sdyh4eMvT+mIPvE/HrG832yx7vdMbEaoStD4xSlRYolwyJmYh/0IbyHZ1YxX4qXywZJkjIRZCiBOlxtbPbO6I94D02phAVWWnbPBj5kG/I4UWMySvfGZD7o9sBes/kl49XA58S9ekq7AKcjacHfcmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B0F968AFE; Fri, 19 Jul 2024 07:27:53 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:27:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lance Richardson <rlance@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Jeff Garzik <jeff@garzik.org>,
	Tejun Heo <htejun@gmail.com>, iommu@lists.linux.dev,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] dma: fix call order in dmam_free_coherent
Message-ID: <20240719052753.GA21363@lst.de>
References: <20240718143824.3729715-1-rlance@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718143824.3729715-1-rlance@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

