Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2B4B5DD
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRa3DPvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C129C433C9;
	Mon, 11 Dec 2023 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702309222;
	bh=eEARbxBJkZ/efiBv8Giewl8Z07aX6TUbEhixN4kJUbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRa3DPvUedGz1P2F+GjCd0+4CMEVnz1xLpSC0Krxq4+aCR6Mtzg6gSxJEXKUTgx9l
	 ofc0bZtSmlVX1ynk3zbw1LwnV9RdbiX2RS+jyBGun4vUdXKhpwVnkB6Mcxqftb+kVz
	 vgXEvPnXzQk4jbQyffPlhyuDHv0V5K3ouIfdRf6Uzwn6SqOIPF+QZaIuQnQDhRT8Ty
	 hO7RfhGb30PSrwnBSe1/UosYHWbKuHPf9luCnp1kOJKKzqkoTIe5chXwGTvwAviEB6
	 LeQYvXgt4F77Qh6nqqm9XLiTlRRe2XlkDkPia2h+UzOt9w2tmgAAU12e7pxsiXqFj2
	 EWl79NmF20sWw==
Date: Mon, 11 Dec 2023 15:40:16 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 0/7] Convert SMMU to domain_alloc_paging()
Message-ID: <20231211154016.GB26048@willie-the-truck>
References: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <20231130004905.GA1395649@nvidia.com>
 <ZXcZL19OLbctV_W-@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcZL19OLbctV_W-@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Dec 11, 2023 at 03:14:07PM +0100, Joerg Roedel wrote:
> On Wed, Nov 29, 2023 at 08:49:05PM -0400, Jason Gunthorpe wrote:
> > This is still pending, it doesn't need rebasing on v6.7
> > 
> > The DART patches were merges so all the dependencies are in v6.7 now.
> 
> This is mostly ARM-SMMU, so I leave it to Will and Robin to
> decide/pick-up.

Cheers, Joerg. It's on my list of stuff to look at.

Will
