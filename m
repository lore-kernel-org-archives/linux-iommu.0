Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B817E903
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822061; cv=none; b=FKYj7ioemt/FHV249qk6wIiAp9th5d7ZbsDIJiUYsSlMyIIdp5Ys9y3O2VYToOpHS/AwLJBtjCLS513kbjgJI6wbTJZUmfovlEVt5DvR/UqU4QogRoatnMQ6vQyhDtKcTX1cSwKKezdJHj6zyWpzJcb3UPkwfwrhkPUMjCTngtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822061; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdisPLVrMbGZvHhvTi5ud7aGvfRedvnvixLaucd+uqxL+twAS+OLTSgq26i1O7Fon+HLgxPklySlvYHTpcPcaiSqdkVbAY549nL/2G4mudVWNEwq1sKpA2Dl0Lai1roT7iQ1ll5LCIMiuRpRXE2IohF/e1IFW25GnpP+GK/qHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE2DE68BFE; Mon, 27 May 2024 16:52:38 +0200 (CEST)
Date: Mon, 27 May 2024 16:52:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Petr Tesarik <petr@tesarici.cz>,
	Michael Kelley <mhklinux@outlook.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation/core-api: correct reference to
 SWIOTLB_DYNAMIC
Message-ID: <20240527145238.GA9113@lst.de>
References: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
