Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A2200CB9
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227762; cv=none; b=E82a55N74dZS3Vy95uw8BdgPJZ5AWjhFW1UjVOFsjH5bOQEnonikHLypAz/fAzLpNJNBiIuV1Ans0egd0u5JrQ9a/YTyJuNhw14gug/238RF1yEhaznwQUhNA2ihwxK9xvs/MjA+G0vFeKwUHB+pe6RT7jMdzsTFUrLYm6wNGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227762; c=relaxed/simple;
	bh=h/EDbsffLYXS6cs7avjq+cGFajxMGASULrkCqEsfE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf2avGQ1lMvMVv0kMxzgWi9n/8BDcK8WNGmLca4ihdFOkgJjUIipIQgD0TBxauxlrs2h22qSflTxgdZTmuWvE5o1G4gDLCovBaGlbIA1hECt5IhAFCQB5oEZqwuz4Hqwp6WaHeHXeRHuGXMDaVrhaB7AAVRLiQEMgr2Wvpliyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/mfmBM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/mfmBM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67831C4CECD;
	Tue, 29 Oct 2024 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227761;
	bh=h/EDbsffLYXS6cs7avjq+cGFajxMGASULrkCqEsfE0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/mfmBM1wZVBi5dvTFJMV1eMD4TuX9HRpVNHXh+BxrY/hm4V/o+xSWiilORBw7Csm
	 74CbOLQmhxU1sc6lX8zSxHp/Kwo3/TyLdt1Lpl8NGc4w9tNTuyMEN0wtKpkUQEhOpd
	 FJI5DdjDeQy4ZG3xLKhkHJW0vdzhPehmNItjUw+X8EwFA2CJe4cxkmMtH2yHtrKutk
	 kNTA9hxvaykGFOSHzViVElvTmnLaxYUecYpI6aqBSSegEz8GlrCFyiApINcNKLL3R4
	 m5++JBG4toU3aSncE0nEPAbCYA4Br3uyuHCblKD1tX1wjlhMVga9y2P8M+UK3fzmSK
	 KPWo75nbrPRpA==
Date: Tue, 29 Oct 2024 18:49:16 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <20241029184915.GA5454@willie-the-truck>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <20241024131511.GH30704@willie-the-truck>
 <ZxqZX3BxaM3Uhll3@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxqZX3BxaM3Uhll3@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 12:00:47PM -0700, Nicolin Chen wrote:
> On Thu, Oct 24, 2024 at 02:15:12PM +0100, Will Deacon wrote:
> > > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > > +{
> > > +     struct arm_smmu_device *smmu = evt->smmu;
> > > +     char title[100] = {0};
> > > +     char mastr[100] = {0};
> > > +     char addrs[100] = {0};
> > > +     char flags[100] = {0};
> > > +     char other[50] = {0};
> > 
> > I haven't followed previous versions of this series in detail, but
> > allocating 450 bytes on the stack for this seems excessive to me.
> 
> If "450B" raises a red flag, should we do something about these?
> 
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_atc_inv_master.isra’:
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2065:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_sync_cd’:
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1218:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘__arm_smmu_tlb_inv_range’:
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2213:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function ‘arm_smmu_atc_inv_domain’:
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2118:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Seems that struct arm_smmu_cmdq_batch is too big. Any suggestion?

I've not seen those warnings before, but it would be good to address
them as well!

Will
