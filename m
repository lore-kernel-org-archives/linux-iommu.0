Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8742036F3
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188557; cv=none; b=BBERfOby2WcSbmqf0xnwvnn5MYb8p4/oMQfltAvO3WWC/b0zoL9aW1j/JHd6pcWoeC+CCoJoSeoeh8kbkloxyMFVBfh2X2ynQBQ2gEESNpSy4CKl0QV6DDBEjegLgEMaKLyEkkQketova4GXo59X1S/44n2Fp3PUtHfQfxkDL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188557; c=relaxed/simple;
	bh=9X5HzpGMNhITwz5P/zDUNMTKoZK6sG55VCCs7gQYj44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwXCkxOPfiIt8m22thD2ZHOSvj/hT87K7KxvAsoRyo5bdbMutmSBjThn5XQP4UyECY5I7Md5gZ5gMiM/TUo88GGu4YI77SWt25ToqHqrD703NQAMobvWrXIOghGhgphtFbcS8+eiFaa0NoNZ7TT9HXw1OBO/4MDX10MCJ+0M9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5FDB9227A88; Tue, 29 Oct 2024 08:55:52 +0100 (CET)
Date: Tue, 29 Oct 2024 08:55:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Levi Yun <yeoreum.yun@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, nd@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Denis Nikitin <denik@chromium.org>
Subject: Re: [PATCH] dma/debug.c: fix possible deadlock scenario
Message-ID: <20241029075552.GA23876@lst.de>
References: <20241025100600.3076319-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025100600.3076319-1-yeoreum.yun@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, I've applied this to the dma-mapping tree with small tweaks
to the Subject and the comment in the code.

