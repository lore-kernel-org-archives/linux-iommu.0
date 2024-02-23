Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5F12B6E
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670249; cv=none; b=X7tn2jQQiqqY4BmYBuXpRvZjCMEtSYt6PZjgj0n8ICI9dTYSTZKOfHtCaQkDl7oP6fMbkCIuWHBru+0UEsArnMkVq5LpOEGBmxQBDPCP7RZqoV9gJIifwYZ+OrSqvzohQp18vp1Jcb7ZqMpLeKBYRm8Ak1Q/Vo8CE38r0xaqjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670249; c=relaxed/simple;
	bh=G7FfstsSz/agmPlMrQQ3PDPo+7Tic3vz0ZsyZkVN+Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm78mjFPj86GPhm9NSssprrPLpaZv+mTjYhtmzhMr3BBMg4p5KWUvfVPEEjx0DU1/8tiz5v87v1PQo24pCW22fB6lUHknzHupqje+vFBqgpaEkDMSQUDSFb2pgtfYL5aQO/L4aUPsDU86Ng+55sck3Qd/7HLMd+DZYEEBf+WEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3FE468D07; Fri, 23 Feb 2024 07:37:23 +0100 (CET)
Date: Fri, 23 Feb 2024 07:37:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Howard Yen <howardyen@google.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
	robin.murphy@arm.com, gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, rafael@kernel.org,
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <20240223063723.GB11004@lst.de>
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com> <20240220055241.GA7554@lst.de> <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
> The reason why I tried to propose this patch is that in the system I'm
> working on, where the driver utilizes the coherent reserved memory in
> the subsystem for DMA, which has limited memory space as its primary
> usage. During the execution of the driver, there is a possibility of
> encountering memory depletion scenarios with the primary one.
> 
> To address this issue, I tried to create a patch that enables the
> coherent reserved memory driver to support multiple coherent reserved
> memory regions per device. This modification aims to provide the
> driver with the ability to search for memory from a secondary region
> if the primary memory is exhausted, and so on.

This all seems pretty vague.  Can you point to your driver submission
and explain why it can't just use a larger region instead of multiple
smaller ones?

