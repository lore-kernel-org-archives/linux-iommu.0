Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326001AC444
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710607; cv=none; b=h8C76G92Mu4OA7fc4RY41I9UMOcVUXas29vzYkFyKmIH3JfCl4/zFgR9ps6CplISvvVNGj4hibbgJgBW9+NzYkKZwKl4W6EXqsSkQLm6CFgf+bgSIGmGzOmZgpx9G6+31/+gner+VsCouLHhbxyZ12Y0FGI6rRELYRTZU6ISKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710607; c=relaxed/simple;
	bh=Cd7w1aJWj9RaW8qRI2u0FHF8/JEncSVlg+8XB/AbH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYlK3yVGjvNNPhC9IdAr1FzAqe6HquiV5EO+CaalDxvRV/xDDKT2FPZgs6EJjWOYwg51HrFRMcb1pBofZO7cula2S0yh8kw56WrujPQ6FcQxC9ZskFF93IzCktoySK+Dpdt+xOwl/T9AR3Z/GsWH2QH79gAA6jkKlaB2v2OAD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13FD4227AB3; Mon,  4 Nov 2024 09:56:43 +0100 (CET)
Date: Mon, 4 Nov 2024 09:56:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20241104085642.GC24211@lst.de>
References: <cover.1730037261.git.leon@kernel.org> <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org> <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 02, 2024 at 08:39:35AM +0100, Zhu Yanjun wrote

<full quote delete>

If you have something useful to say, please quote the mail you are
replying to to the context required to make sense.

Ignored for now.
