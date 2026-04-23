Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78903E6392;
	Thu, 23 Apr 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937675; cv=none; b=GNX2PfByMNT72VZ0qTPA2rDa2BuRLmH/c+LHQvuVyS/lVDTHYKvUdQb6jfiHpH/99AlYqVN5BvbiVN4sA2HaNBs7Jb+K61k8maRjFFMZDEhm9nlPCbbi7GxgPvtqdXjKluA8uT0BVCJmtZy7aKEtm9wTUgZl5h6Ds3GYKy0fAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937675; c=relaxed/simple;
	bh=br5wlc5f09n9mCEqo9WCcoPnuWcALLuWS7e/ixgqzF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9SaH9CsgiUscp32VuxhJB99/KlgciNH/Sdzl9pWCRME3oD6hr55dZ5H17gTIp1Ynw79OJswxNCinT4uvRKSTBVt1Fb0s0O9OzLhpIs9UJk5f6tp8GyumF+arHHvt2B/OHdEyysy9fv8K5VC7kEpyGJddVlDral/BLPvYGA7llA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct0tQNrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct0tQNrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D3C2BCAF;
	Thu, 23 Apr 2026 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776937675;
	bh=br5wlc5f09n9mCEqo9WCcoPnuWcALLuWS7e/ixgqzF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ct0tQNrNoDOxJybDdDRqEJFZs+32ZnzrR6+M9qZKSZDaAdiUm1YiMuknDnjYQI4yi
	 mc+DbyPPBGCIaSHJca5OGtMBvPCleQJsRds1uj5Y0SW29flqfClpiaQv2e7U8IHYyh
	 YqwzyRAcF2bzaYKRqf33rBiG2EOSt0s9vDmzdll6b/cc9YNEsVfg+C0L+6XxRQzy8n
	 G00XSloa4Y4BRvD4rnpQhGBT6NcZj+JxSGSDw/g7JdQuxVMsyR2/lZZru3sDbKMmHg
	 xS59aLLINn5LOU+XP5ENbqMC5YtJdKQIR8n6UiabP+jHhSMGrmW9Cgo00dwkrgB2eP
	 +4khsM6ch74lg==
Date: Thu, 23 Apr 2026 10:47:49 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <aenqxasLJ8yKYqbT@willie-the-truck>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aenp6FHzx9rtUQkZ@willie-the-truck>

On Thu, Apr 23, 2026 at 10:44:08AM +0100, Will Deacon wrote:
> On Wed, Apr 22, 2026 at 01:23:51PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
> > > The motivation is live update of the hypervisor: we want to kexec into a
> > > new kernel while keeping DMA from passthrough devices flowing, which
> > > means the SMMU's translation state has to survive the handover. The Live
> > > Update Orchestrator work [1] and the in-progress  "iommu: Add live
> > > update state preservation" series [2] are building exactly this plumbing
> > > on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
> > > work, and an earlier RFC from Amazon [3] sketched the same idea for
> > > iommufd.
> > 
> > It would be appropriate to keep this patch with the rest of that out
> > of tree pile, for example in the series that enables s2 only support
> > in smmuv3.
> > 
> > > For this use case, Stage 2 is materially easier to persist than Stage 1,
> > > for structural rather than performance reasons: 
> > 
> > I don't think so. The driver needs to know each and every STE that
> > will survive KHO. The ones that don't survive need to be reset to
> > abort STEs. From that point it is trivial enough to include the CD
> > memory in the preservation.
> > 
> > It would help to send a preparation series to switch the ARM STE and
> > CD logic away from dma_alloc_coherent and use iommu-pages instead,
> > since we only expect iommu-pages to support preservation..
> 
> Does iommu-pages provide a mechanism to map the memory as non-cacheable
> if the SMMU isn't coherent? I really don't want to entertain CMOs for
> the queues.

Sorry, I said "queues" here but I was really referring to any of the
current dma_alloc_coherent() allocations and it's the CDs that matter
in this thread.

The rationale being that:

1. A cacheable mapping is going to pollute the cache unnecessarily.
2. Reasoning about atomicity and ordering is a lot more subtle with CMOs.
3. It seems like a pretty invasive driver change to support live update,
   which isn't relevant for a lot of systems.

Will
