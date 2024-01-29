Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014351020
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514651; cv=none; b=BhpLNSkIRFPbwsqj633f1+SOUh3WMo2BtZ+RuRbu4ShHVK8WmB6czgfLrz6cElAkTp9n9EVLwsr9IbhhwIZdXmA0K7gQmzqb+h+YygQdkOIGP3ORqHNN/v9xgRPBuneTT1OoLIcH33yypmtTWP77Fef+x2OT1cNc/ya+c/LkYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514651; c=relaxed/simple;
	bh=QJqzApANPWi1c/IKma69Rh0xMu+xAafFAo/2J2QZVgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8ji/2YI0oVuIl3zBxGxfeWW9SZCeCLDf0iimSbe0S2HWJUlBBT2L3x9CzPKZ5xVM8jj6GgNO539pf+jxxS1zb4RUKc79sST3t6w/UP3mAH6h6x6AjuD8k6tgLPUTnOMxt9KmzpK9UggRsR55iEAFVlaUgtBDpWx6mMa3FsBQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9D1468CFE; Mon, 29 Jan 2024 08:50:44 +0100 (CET)
Date: Mon, 29 Jan 2024 08:50:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129075043.GA22019@lst.de>
References: <20240126151956.10014-1-will@kernel.org> <20240126151956.10014-3-will@kernel.org> <20240129060853.GB19258@lst.de> <20240129084326.4667af6a@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129084326.4667af6a@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 08:43:26AM +0100, Petr Tesařík wrote:
> > So PFN_DOWN aligns the address and thus per se converting the unaligned
> > address isn't a problem.  That being said swiotlb obviously should never
> > allocate unaligned addresses, but the placement of this check feels
> > odd to me.  Also because it only catches swiotlb_alloc and not the
> > map side.
> 
> We may have to rethink how alignment constraints are interpreted. See
> also my reply to PATCH 1/2.
> 
> > Maybe just throw a WARN_ON_ONCE into slot_addr() ?
> 
> Yes.
> 
> Or, what if I write a KUnit test suite for swiotlb to combat this
> constant stream of various regressions?

Both sounds good to me.

