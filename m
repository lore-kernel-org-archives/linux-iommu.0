Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121741C7A
	for <iommu@lists.linux.dev>; Wed,  3 Apr 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137352; cv=none; b=R8cP7fYfQ0iHkvJFLP4/coEuk8EuSdI/9kioJThdiuoFuYd+hLPLVvDIhHeOVFCJccOKTXYkcEgs2hpO8+GX48H+/5RY/IVBZICpfHGxVOjMMWrYlnpe16jBAB9H202mYsZcbI+sgymEQ6yH0+Vqe/oqXqv32A2YwztoVyeMoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137352; c=relaxed/simple;
	bh=QRA1YwCiHBI26HpUVKJGnNMRhX+qFRxiIVI0/xjn2E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S11gcLj0u7y36tt+BZPIG9oHGx46ZGG8P6Vo68+2436KjGrl4jlhAjvp32wrlQVP1QP8xnGmsDio1ofwMgiS9jEWpn7j7Mwvi1JqVy9LY1iCPvsYgQXnL4JLgBKBjuq7Y+dA3BuxvrOWu2QAc1STV3IohsBG0TWWd8u06Km/uoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B47A68BFE; Wed,  3 Apr 2024 11:42:25 +0200 (CEST)
Date: Wed, 3 Apr 2024 11:42:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Yajun Deng <yajun.deng@linux.dev>, Binglei Wang <l3b2w1@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 14/34] dma/congiguous: avoid warning about unused
 size_bytes
Message-ID: <20240403094225.GA4828@lst.de>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-15-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-15-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

contiguous is misspelled in the subject.

Instead of the __maybe_unused annotation I'd just conver it to a
cpp #define.  I can take care of that if you want.
