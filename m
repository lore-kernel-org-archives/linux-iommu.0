Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84343379EF2
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789525; cv=none; b=DDZ5gTko6CpXCpFuBzQqsG/v1b46rzKorSyGH/nyvXBwHG5xCKUKBsEz6e5LQPfTsIfhBGpsODhzXzY2RKnmaspu6eIJ151XSvzfTyK3cobnJvWqrpjhc0jCCIP6a4JMkvsvfDKYg2MX1Ys+M4XNKRcBWKy3H7pWjl7IOWAWSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789525; c=relaxed/simple;
	bh=cNH70jj6roLIqiFmeg0hHrGoomIMGMcjiS/OFfPnRsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUdSBjWjHRE09bzv9SJIDUPBTITaMwjc7jRzmZt5ffoziSU6snpN2cRvShWmv0RDwLnRlWbWL3M3+XIwR/OfG0xY5cvRriKtFg+qoGI5A7ZTS3JvDG/fJVFGoZvIp1KwJS92G5T9OAWJqGby50MzkR1y/Rx/YwDFnjJzttJ4pVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egro2/lr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egro2/lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AF8C2BCB0;
	Tue, 21 Apr 2026 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789525;
	bh=cNH70jj6roLIqiFmeg0hHrGoomIMGMcjiS/OFfPnRsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Egro2/lrsv4ELOi0wXo+a9TJvYGxntQgC0M3JjmHcb7nxIOhwkyLlLSOPxiZxSik8
	 3Vz80YPce4PNdos8Pqk1NhqJ62YVd8lWbQk1Gz45K5YPNzaaA1XsLvZldCbibaZ5jz
	 KRn77oI4I0vwVmYrnsYZLiGBPRA+O3/UydZ9XkNWmXDoTsnd5GwU4MRbkK9Y0Ttua/
	 3crFam3yge6+dh3FeVVrcTtYRzWjwTk8Xr6uLxLgdjxqWQAS/nhpXA4PzJadfjLG80
	 bUnMKkpYLBjYEvUMg7loA4GSaNZlMRJTOiZ3ZHd80Sdhw40uT2m1GruG3vMn5vz7Je
	 cZHYGPsz93Smg==
Date: Tue, 21 Apr 2026 17:38:40 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: leo.jiang1224@foxmail.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
Message-ID: <aeeoEHHNKPo32H9R@willie-the-truck>
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
 <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>

On Tue, Apr 21, 2026 at 04:56:47PM +0100, Robin Murphy wrote:
> On 18/04/2026 6:31 am, leo.jiang1224@foxmail.com wrote:
> > From: LoserJL <leo.jiang1224@foxmail.com>
> > 
> > In arm_smmu_init_one_queue(), the loop reduces max_n_shift if
> > dmam_alloc_coherent() fails. However, since dmam_alloc_coherent()
> > allocates at least PAGE_SIZE, retrying with a smaller size after
> > a PAGE_SIZE failure is logically redundant.
> 
> Says who? It's certainly not a guarantee offered by the DMA API itself, and
> indeed some allocation paths can definitely still allocate less than a page
> - e.g. anything which hits a per-device or global coherent pool.
> 
> > Moreover, if a sub-page retry were to succeed due to concurrent memory
> > release, the hardware would be configured with a smaller queue depth
> > despite a full page being allocated. This leads to inefficient memory
> > usage and unnecessary hardware performance limitation.
> > 
> > Terminate the loop once qsz reaches PAGE_SIZE to ensure logical
> > consistency and optimal hardware configuration.
> 
> That's really not an argument - even if an allocator does happen to
> over-allocate for the requested size, that is hardly the caller's concern;
> and as far as "optimal" queue sizes go in this case, those very much depend
> on the number of CPUs issuing commands and volume of expected stall/PRI
> events - in many cases PAGE_SIZE would already be far too small to really
> work well.
> 
> Also note that if we _were_ to fail to allocate a PAGE_SIZE or smaller
> queue, there would be very little chance of the subsequent allocation(s) for
> the stream table succeeding, so realistically the driver is probably going
> to end up failing to probe in such circumstances anyway.

That's all true, but tbf I think I just fscked up the comparison in
d25f6ead162e ("iommu/arm-smmu-v3: Increase maximum size of queues") so
I'm not against fixing that up even though the "rationale" given by
Loser doesn't make a whole lot of sense.

Will
