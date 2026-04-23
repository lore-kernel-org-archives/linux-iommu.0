Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6673E3D9F;
	Thu, 23 Apr 2026 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937455; cv=none; b=HJCCGLqoP32DR7Dp5zpH7tXZC3nQpOiSF74fWtDqtQvGLTAv2z8IzvG6JmQcMtBw4QpUVkVz2Qtgwd7Rxg87Rcdx1sAUfDKtxqEKAg8HxzGqphG7S4SGar/0DWQueu3mItJNXesZB5Gsy74SU1o8A1J1lHdj9tffb+RVb97NGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937455; c=relaxed/simple;
	bh=fDvsL0aY81zyDVkYCGzXT70F+YYlXrLKm52ouhe2SKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmklopAEVThRVENRGxjAgpB4/2SP080pPwLCiHJMNNRD1C8rhWnNi1k5gIJhO0pnuZk1zJcB7HTMWLE10ePXI9gYy0k4g0D1Y0WGxnv3Y6/KxBD6KVpeIH+ly9GDazRH8EsI5QxYyA3V8qnJuWINyA6XFdA3xRP89CWMWwgBGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3+CI0sM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3+CI0sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF8FC2BCAF;
	Thu, 23 Apr 2026 09:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776937455;
	bh=fDvsL0aY81zyDVkYCGzXT70F+YYlXrLKm52ouhe2SKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3+CI0sMhoEpkBBhgojks254wglba/Eook+DIoF0VfPZxEnr1J843GDhv95EZbrZO
	 hhZny20ipACHgc7Grzufn5r7EDOqd83xUB7iOX/lKEzJVpjis2Pkxk/XiC5n3rTCgT
	 ooykqhyj3yosOz0l2ajeZQhf2xcMX6L32J8Kb14p2fupQL3MCLdBFWxQOjG/hpztoE
	 3g43NCr3mUVU9522Y6PehQW9PwuE7+oX3SfV4bgmH9cr8I98ibPoMx7yX2yYptB+NT
	 FrVq7RJahnxZq6+jsTAs3JuCtk1fXFmc8dIVhep+XXhh0f4+5TXiCMkAlpa4O9w4rD
	 ToACv09BiCBuQ==
Date: Thu, 23 Apr 2026 10:44:08 +0100
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
Message-ID: <aenp6FHzx9rtUQkZ@willie-the-truck>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422162351.GK3611611@ziepe.ca>

On Wed, Apr 22, 2026 at 01:23:51PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
> > The motivation is live update of the hypervisor: we want to kexec into a
> > new kernel while keeping DMA from passthrough devices flowing, which
> > means the SMMU's translation state has to survive the handover. The Live
> > Update Orchestrator work [1] and the in-progress  "iommu: Add live
> > update state preservation" series [2] are building exactly this plumbing
> > on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
> > work, and an earlier RFC from Amazon [3] sketched the same idea for
> > iommufd.
> 
> It would be appropriate to keep this patch with the rest of that out
> of tree pile, for example in the series that enables s2 only support
> in smmuv3.
> 
> > For this use case, Stage 2 is materially easier to persist than Stage 1,
> > for structural rather than performance reasons: 
> 
> I don't think so. The driver needs to know each and every STE that
> will survive KHO. The ones that don't survive need to be reset to
> abort STEs. From that point it is trivial enough to include the CD
> memory in the preservation.
> 
> It would help to send a preparation series to switch the ARM STE and
> CD logic away from dma_alloc_coherent and use iommu-pages instead,
> since we only expect iommu-pages to support preservation..

Does iommu-pages provide a mechanism to map the memory as non-cacheable
if the SMMU isn't coherent? I really don't want to entertain CMOs for
the queues.

Will
