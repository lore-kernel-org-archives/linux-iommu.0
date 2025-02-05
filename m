Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C21519B1
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770598; cv=none; b=H2TjUIvIp83sJzZxwzw8+bbqrN3gxfKeHKf8W9rlM6mf153NDhRG8KEfqps3Cirk+YWyeQvfgpQC9Vzu//Lfq4ajgYQtrpTxEz/ceSW6vXFvwrt+RTJOliuscpyBoT1QnWLBONPrn2ZQo0YfdogFQ4M38F858q7ZPHeJHYi/LTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770598; c=relaxed/simple;
	bh=22Rw6aTCfU9ZsKA1nTmC/m+5DLdNAG1pnfwzEH8LGLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZJrPJxowqThs2BPoOpZBgMVChU9aPJ9Aj7QbUTjjV2km5IDgP6Q/xFN49xlbF1niIJv9jUsGzQkg3Vw9qSVQDpu18pUXRN8FRwRaSlcX2eZHT9hv6li9uj+ugzixc9vrxks4WE2QAh/amKqNTOskQfoaWi6ZxSObXv0hZOvkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9Y5+TEG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9Y5+TEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=22Rw6aTCfU9ZsKA1nTmC/m+5DLdNAG1pnfwzEH8LGLs=; b=Y9Y5+TEGHHXuffAZiV4Wa/Tq4u
	DEO+G5N24t33gfpMi9CLyoyo3nVDiN676expLOEEI71aF1HXeOsvjMjPtJvbmaBwbaUogYlQXBX8o
	3wvPqdRfz58mckjVFQZrs4ajTMGgza88fWs9LJyoc8I5/gJQb6yA+Gt0xYVtLxWmvHRKh7EeSI7qy
	00m2b8zj/W/gH1zHizVX4SMRkC0H35j8dKsayjj99DlhaDNhAYvBG418yl5znZFqdu8tvUGUO1Jfo
	5jqSvFMScABZrndJyF2kqXRMaXspCftRJq2IPwUQFFKlucX8joUdkX8JL9kjIlvnI/QDtEZdi0XFH
	5e0NcdIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhf0-00000003qk3-2VUc;
	Wed, 05 Feb 2025 15:49:54 +0000
Date: Wed, 5 Feb 2025 07:49:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Adrian Mardare (amardare)" <amardare@cisco.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Make intel iommu disable swiotlb
Message-ID: <Z6OIon1w6AgwlYyt@infradead.org>
References: <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
 <8b2e868e-2b0d-49dc-b703-4e33138a03b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2e868e-2b0d-49dc-b703-4e33138a03b4@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 05, 2025 at 06:35:20PM +0800, Baolu Lu wrote:
> Why does an iommu driver need to care about swiotlb? The extra memory
> consumption might be a problem, but I don't think it should be fixed in
> the iommu driver.

Not only should the iommu driver not care - the patch is broken.
We need swiotlb to bounce buffer partial pages for untrusted devices.

