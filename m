Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EC329E46;
	Tue, 25 Nov 2025 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091163; cv=none; b=rv1vg9tICdFuAH+1pf4gwCOjS8APp6qm/vBeITwfTbk/Ns9QiSbel0d9W5POpGCta9et3IpOWaAVySzALIma758p05sp71waIzPiZ0gnrD7lFfjEUUc6Z/a0YSaXqtrrGT3f+xHZZtDXwFkbqVP8gLDRTk+/2LpzvlOvOpAooh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091163; c=relaxed/simple;
	bh=I/rnwL1VDr4DIy5Ix/ic4bCcTptHKDL4s7lH93si388=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhtYF/2Tqvul20ULfDZn820BiffgAhe+X5h8bOusnoGmjAmj+R6QvEsZQkBPeiLjjTLIpdhiogLMoUBlSLgOEUeCll7yqSlxmHIoCxK6RkGX2lM8VOSP4HgAnvLFshRt/2kDBO+Z8z8+fwCqY8V+EIAIEThNG1kZPutDZPxYhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnEEYzyL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnEEYzyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0AC4CEF1;
	Tue, 25 Nov 2025 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764091162;
	bh=I/rnwL1VDr4DIy5Ix/ic4bCcTptHKDL4s7lH93si388=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnEEYzyLVpJFKF25uIqfERa0uAEBY0qYBPPYT7n5xY9rSMZVwKLxfRhmqk1WOqvN2
	 p4W/e5JMk1HdoKPWIV6/nBkZFTTlxJ0/rW5grLt9kpgdVo5i3mEbzcwEe4v/5tHfP9
	 t0l0/dPYNtdrUcMwB1pcMGq1tZGGmnn1NlYNmsxhncOlgMpCI8wUawR936oeUuJVHk
	 yDeCV5D4gKCy49/yCnwyzJrEJhZNSl+5zgnMrEQZnQbEcWmtDriwCB1KHCgw8dCOsp
	 UHu9shttpqWRPDg0Qc8Ywoe4cDx5AV4cJifiawdyPlab2WYpv1t/RHh26tfXIZOrKs
	 AQE5xIv/FgyjA==
Date: Tue, 25 Nov 2025 17:19:16 +0000
From: Will Deacon <will@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <aSXlFDAa672dZGVm@willie-the-truck>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
 <20251114171718.42215-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114171718.42215-2-jacob.pan@linux.microsoft.com>

On Fri, Nov 14, 2025 at 09:17:17AM -0800, Jacob Pan wrote:
> While polling for n spaces in the cmdq, the current code instead checks
> if the queue is full. If the queue is almost full but not enough space
> (<n), then the CMDQ timeout warning is never triggered even if the
> polling has exceeded timeout limit.
> 
> The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit efficiently
> nor ideally to the only caller arm_smmu_cmdq_issue_cmdlist():
>  - It uses a new timer at every single call, which fails to limit to the
>    preset ARM_SMMU_POLL_TIMEOUT_US per issue.
> - It has a redundant internal queue_full(), which doesn't detect whether
>    there is a enough space for number of n commands.
> 
> This patch polls for the availability of exact space instead of full and
> emit timeout warning accordingly.
> 
> Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion")
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

I'm assuming you're seeing problems with an emulated command queue? Any
chance you could make that bigger?

> @@ -804,12 +794,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	local_irq_save(flags);
>  	llq.val = READ_ONCE(cmdq->q.llq.val);
>  	do {
> +		struct arm_smmu_queue_poll qp;
>  		u64 old;
>  
> +		queue_poll_init(smmu, &qp);
>  		while (!queue_has_space(&llq, n + sync)) {
>  			local_irq_restore(flags);
> -			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> -				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> +			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);

Isn't this broken for wfe-based polling? The SMMU only generates the
wake-up event when the queue becomes non-full.

Will
