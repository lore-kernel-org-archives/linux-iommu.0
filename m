Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAC1494B1
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710530; cv=none; b=BpCZ3UJro0N8or4Sqrv4UUtJoEpPmhnArGEJTEszHYZ+es5lSZR2Hx4ZWKrsaFs7L9gazbOlyrOHMJYEvWiKpiTy7203SRRqZKaFa0+uPjrWsOQCillZI0JkjLs3dWA1iE4sPtpnaHg3Ync58cuUQR69FT22n7Cb26tu9IHgDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710530; c=relaxed/simple;
	bh=XJMROuE4JjYsw4wo8HK5SvAvW9x90cNUd3R+iiehUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDUsFIb+UjsB4g8Yre7G82HwpRWgrETDjVtIuomsDE0iCfhE0GRyXFDwCyX/yqhUwpagOV4Lx1L20lhiG6I9AO3tlRgcSjmnfhp50wRRJhmEUeFWOl/CzZZPBPR4l8J0sAQCXR10ixiBBtn1OR1SsWMAiE9Hh9ZPtswgKeZDrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95EF3227AAD; Mon,  4 Nov 2024 09:55:21 +0100 (CET)
Date: Mon, 4 Nov 2024 09:55:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [RFC PATCH 1/7] block: share more code for bio addition helpers
Message-ID: <20241104085521.GA24211@lst.de>
References: <cover.1730037261.git.leon@kernel.org> <e6be9d87a3ca1a2f9c27bce73fbab559c21c765f.1730037261.git.leon@kernel.org> <4c7e679a-d3e6-4426-a679-ee581b5c728c@acm.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7e679a-d3e6-4426-a679-ee581b5c728c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 31, 2024 at 01:55:11PM -0700, Bart Van Assche wrote:
> Does "_int" stand for "_internal"? If so, please consider changing it
> into "_impl". I think that will prevent that anyone confuses this suffix
> with the "int" data type.

_impl is even more unusual than _int, so no.

