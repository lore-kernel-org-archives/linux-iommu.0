Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517165C91
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 14:16:22 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2D27A2409CF;
	Wed,  7 Sep 2022 16:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662560181;
	bh=mWEuyxNnLFEuWr/B5zVqtLxKlnUo2kXwDNlXah392lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igdMSmZmbsufrTAuZsKu2UQcMcFUgvfgbyCYJTgjHTV9GoDpqL2AxEwCtUH9UdQAe
	 DjBBYlh1v09vZ8VAqbLFmTEOyWa8FnAfaRF3yUGFh2P8jc8o1bB2Kw0ktnofB2E4S9
	 icFz03CC0hAfTpvy2OE2AJDykRg5Q9HskUK62M6S9Nkc/zVN1Ck8COfAxAmtue2lur
	 jDYNfwci04CYuimhMV3TDnEeXdVOv6XeZznKvRsFndaDndah2C+IRRPM6POEWeFj2S
	 /tSDalJoQMHOZwEqp905GvXK7Blmr2bOB9WXXKwJGKhaNcJBDMLxsaqcV8ZtXF4tyI
	 qkk9hJcM9Z+fQ==
Date: Wed, 7 Sep 2022 16:16:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxintMDEmzSXJUl5@8bytes.org>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>

On Tue, Sep 06, 2022 at 05:35:13PM +0100, Robin Murphy wrote:
> Will this series also mean that the domain shenanigans in
> amd_iommu_init_device() can be replaced by just making sure the GPU gets the
> proper type of v2 default domain in the first place, so KFD can use its
> PASIDs on top of that directly, and the audio driver problem goes away
> naturally?

Yes, on IOMMUs supporting v2 page-tables and declaring a default PASID
this hack can go away. Unfortunately a lot of AMD IOMMUs in the field do
not, so the identity mapping hack needs to stay around.
