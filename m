Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB956B8B
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654566; cv=none; b=o5PIPvjFk1hmSgQWQaNuCFVjFFXzzsd/3wirIEkI7/Kg5clfLyHXRcujwAzy18Yy/XOawZxClsFBCUjC5DjABbPe6RVqmB1s/PLVbZv9DwVclgQ1KJK5MOniIp+AHRYIiNw6PVe0oGh9lIIlqAfhYLuxwB/74EbiQuUlVN2E/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654566; c=relaxed/simple;
	bh=Edm49+lEiDwR/UHak/i9XLp8JHz+DtOyt1ZL8rAyQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEWfAbxfe65fqbEVQwkDQENFaKZ1FR5G314at2cPFN3t5PCrdivGPEnXSe5v4dOSOIeArkaoh8stXCVV2xvgiZYgGTrt9X0ti/XVAL8lM0gbCnJO4vZQd20Q9vVhYknBV6FsqMeSt4Ayp/4w9JVVmRS81NNw3LvYsJ2zNWRQB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FC47227A87; Thu,  2 May 2024 14:56:01 +0200 (CEST)
Date: Thu, 2 May 2024 14:56:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikita Ioffe <ioffe@google.com>
Subject: Re: [PATCH] swiotlb: Initialise restricted pool list_head when
 SWIOTLB_DYNAMIC=y
Message-ID: <20240502125601.GA20723@lst.de>
References: <20240502093723.16820-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502093723.16820-1-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-linus branch.

I plan to send it to Linus this weekend unless someone find a grave bug
in this pretty obvious one liner.

