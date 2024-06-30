Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8C22071
	for <iommu@lists.linux.dev>; Sun, 30 Jun 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719726955; cv=none; b=IvgBQlpzHmnzwWUprmZertny9E7rXpbUXlHR+mJn/G48pYN6IjkVxHIIrv4OT7ynAL/TP9WV1BjgilWEvfDEqzaFnDMolgxIR7IcAG3WYbiQnVU31C8oqCwddLQiLJ7Eb8cp65qEFifO3wGVUMLzSJvSR+jwdLgQWwz6ltiS6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719726955; c=relaxed/simple;
	bh=kdNNzBNwWhhTBCliA9xMNB5uaSrKxzU5UmirzijbIUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnBxn+4tQztzOkKdzGpEgZUmPaQ22MjrXhEEke3Rm+fPGiqVy/CkCbg7SYuZTVi2CW2S0UsRDYDT9WgW+hOcsiHJ/CxY0HyNWEeCAtDbPuWGB8ImKCOVpkXuvFHWhEmBlk8lqnI/Np+ZCxYuVBadp/DrKL3XCISAYofkcGF3s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3943868AFE; Sun, 30 Jun 2024 07:55:42 +0200 (CEST)
Date: Sun, 30 Jun 2024 07:55:42 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	"hch@lst.de" <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240630055542.GA5379@lst.de>
References: <20240607031421.182589-1-mhklinux@outlook.com> <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627060251.GA15590@lst.de> <20240627085216.556744c1@meshulam.tesarici.cz> <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627152513.GA23497@lst.de> <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com> <20240628060129.GA26206@lst.de> <20240628094708.3a454619@meshulam.tesarici.cz> <SN6PR02MB415781789CBD6597142BEC68D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415781789CBD6597142BEC68D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 29, 2024 at 03:55:58PM +0000, Michael Kelley wrote:
> Unless there is further discussion on this point, I'll just keep the original
> "is_swiotlb_buffer()" in v2.

That is the wrong name for something that returns the pool as pointed
out before.
