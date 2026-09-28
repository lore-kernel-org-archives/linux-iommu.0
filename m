Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1EC35C680
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572630; cv=none; b=dG9eMP8oqfMT1izhy7gsUXKe5MBy7PXgOkGom4UVMAVZ2a/EeTOE2fRya2kDJT26iWmKc0GzGrWP6vsj3vRezK0/gvruObzhcUuEeUVLUs/poURLrgsTslK2s+taYnPDjwsBOlOLgZJerPlBL1sXHi/PyiP12+r9IMsj9rZCzP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572630; c=relaxed/simple;
	bh=VCs93ur2EgHHNDt6F5a+Q1ilPkuN5pAZOs6WlQeR/IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EimpChaX6laUKNCMatqm3hXUWXz5lTHajczE94hbegMAEA15/VzhoLavwG5B9YdedBlgZMXpiGBagl3DlHzXxEWupcV22ncYjcM1vl8rXtv2PxSo4nesW51S7PfnjSL277jftOFr8ihzYBqUlqvm5O7qZ/yz6/VuYihopMSbnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vCL999nq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCL999nq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4ZS6kstd6BIICwqAN1M2ypMQk8KRKCHT0lhVaYKNm1A=; b=vCL999nq/HIPd5KJ+zOLTAyz4G
	Aw+mGCRquekPCRK6EW4p/d6S76wWDKPuh+mMXENLfmRIi4gbC2DdaKKzsGgZMNfNTZocf5qcOGgrn
	Qd+BdMZauAbgFut1usVOeVGIswhc+/dd9d3D5o2i2P6lpryuXbcqPzlZYPlmjwD0JwzLQKRZUCLhl
	6wMN4QhKY//mhh/rk6iba/taGwIG58PXYCMpH8q1P3BQVR54tPRo5kt/3UlGC2C06rzie1PDXSqy6
	jVDOaIJ8iSWGQpWuOUEdLwxdfeo7HId8mIXZovj6TNHeJwP/UXn/OapGxmd6S7g1Hzak2INU72ltH
	sVSnI2UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB3jc-0000000HLnt-2UJA;
	Mon, 28 Sep 2026 05:17:04 +0000
Date: Sun, 27 Sep 2026 22:17:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <arn4UPLhYJeNNxnZ@infradead.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924225018.GB16465@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> > +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> 
> Last time we hardwired the GPU and IOMMU drivers together it was a
> huge mess to undo.

Every time a driver depends on an exact iommu driver is a major design
problem.

> Why does the GPU driver have to request this? Why can't the iommu
> driver know that this is a special device that can use this magic fast
> path and then auto set it when identity is asked for?
>
> How does the GPU driver even know it is magic special?

Yes.  And WTF is "perfopt" supposed to mean.  Everything is a
performance optimization.

