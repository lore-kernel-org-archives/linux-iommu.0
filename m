Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869B17F5
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxzadzaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0BAC433C8;
	Thu, 12 Oct 2023 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697122232;
	bh=jTeKmCZozGobpMYGFZ7ihH4Bj3kZQ7OWdrTKoXPpUXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxzadzaU1JzcuT6x7gFq1FurH5mRJuOcU2qmQHxQBfW74V6/V8siyUHSjr1DBKIF9
	 Fs9tOASWmW5NY58rcwavj4MCuMeDCCGNpAqtAKRVVBNHs2u3J0o9cMbekmDbi5vVTY
	 +buqK6kVkQQSO1h/t1xoS6ksnN0E1OYXKOPKDjhpf8nvca8ucNeZwOnhhO6fCR1309
	 FQ+MsqZ/fEEZ2pyhREESuyfCOqvtWl9OZi0QClJPWoY9juCuP0VVhNk3NJUOWl8PRd
	 pin6131NgPK0cL5rtCYFQVxacSW7Gg19DGOU6M6EcBdY9nymA7IpSkOoJq3Ty6mpsX
	 Pq1awmLX/SSvg==
Date: Thu, 12 Oct 2023 15:50:26 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Shavit <mshavit@google.com>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
	jean-philippe@linaro.org, robin.murphy@arm.com,
	Alistair Popple <apopple@nvidia.com>,
	Dawei Li <set_pte_at@outlook.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tomas Krcka <krckatom@amazon.de>
Subject: Re: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
Message-ID: <20231012145025.GB12374@willie-the-truck>
References: <20230915132051.2646055-1-mshavit@google.com>
 <20231011234848.GA257246@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011234848.GA257246@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 11, 2023 at 08:48:48PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 09:17:31PM +0800, Michael Shavit wrote:
> > 
> > Hi all,
> > 
> > This series refactors stage 1 domains so that they describe a single CD
> > entry. These entries are now inserted into a CD table that is owned by
> > the arm_smmu_master instead of the domain.
> > This is conceptually cleaner and unblocks other features, such as
> > attaching domains with PASID (for unmanaged/dma domains).
> > 
> > This patch series was originally part of a larger patch series that
> > implemented the set_dev_pasid callback for non-SVA domains but is now
> > split into a distinct series.
> > 
> > This patch series is also available on gerrit with Jean's SMMU test
> > engine patches cherry-picked on top for testing:
> > https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/16
> > 
> > Thanks,
> > Michael Shavit
> > 
> > Michael Shavit (9):
> >   iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
> >   iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
> >   iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
> >   iommu/arm-smmu-v3: move stall_enabled to the cd table
> >   iommu/arm-smmu-v3: Refactor write_ctx_desc
> >   iommu/arm-smmu-v3: Move CD table to arm_smmu_master
> >   iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
> >   iommu/arm-smmu-v3: Update comment about STE liveness
> >   iommu/arm-smmu-v3: Rename cdcfg to cd_table
> 
> Will, can you take this please?

On my list to look at today!

Will
