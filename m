Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1E1E505;
	Fri, 16 Aug 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816417; cv=none; b=d8uSCF7vC0xonOcR7iPoRJ18JyzrBIsbA/HUV3uc4UaiF8oaGGkPmM7LpC6r504A+aI+gfcAqQoCUPpeXjOWKp+7w2WnJUdzomQtmrS9ZA0YbFdc0meRxpI7WAguTTTEVcLbRuOFa2PA3PRtVkBtpEofQcn2mT+QV9f58iVV8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816417; c=relaxed/simple;
	bh=I1cI1Ny0H4g/lNQvAGQgRTIrokQ8aivqsHqBmdZtkDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me0mNu7n+8uaJTNjq79u85PoMeK5t3KnQRMvnFdkmGtY9EgdZ5aTPQnEuPnHd01nmrjbixMKAFhMAmyj85C8cPDujHOiFNLUZ9LepoDqzikYC9RUErPyNDbCQc5IaS7NCNvrl305JgVwsJBZQedLAeKl7bf0Ft0mGQ0A+ADviVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6vdj1Qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6vdj1Qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E0FC32782;
	Fri, 16 Aug 2024 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723816417;
	bh=I1cI1Ny0H4g/lNQvAGQgRTIrokQ8aivqsHqBmdZtkDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6vdj1Qe8EJeh7ovIB7iyFJcQaCK5HfYlEQ9XsIKQITWDoRtRuFk/0/hfK3r0/ZDd
	 cL8JspC0xYQHo95NlSkbij8J/tHt2Yfzs1y9JJ9ifOwfBCi5f1t67rNqVrvXpEMl4t
	 QLsewN20p7WqfrmTd07QUCBZEfAFl0XsvRfou+wDAz5/V6GbWEH9jUvGp+sm6OGe76
	 WRv4Gbve+Ku95td0x2FP6S1IhxkMwN6diWBkPk9r6PAk2oQI5JSnG05h+0lnu9eHrs
	 OmtVF3C/nrAQNzNtj4t3yo7dYtSDf6P8V9TTJSWNJnxYxBaN0K7nc/zMTYGwo/kiQS
	 0ExjyvSlkXJcQ==
Date: Fri, 16 Aug 2024 14:53:31 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 2/9] iommu/arm-smmu-v3: Enforce
 arm_smmu_cmdq_build_sync_cmd
Message-ID: <20240816135331.GA24607@willie-the-truck>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <9e59a460c969357a98b3434ed5007ddf9381899b.1722993435.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e59a460c969357a98b3434ed5007ddf9381899b.1722993435.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 06, 2024 at 07:11:47PM -0700, Nicolin Chen wrote:
> There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
> call it at all places other than going through arm_smmu_cmdq_build_cmd()
> separately. This helps the following patch that adds a CS_NONE option.
> 
> Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
> in ARM_SMMU_OPT_MSIPOLL=true case, from previously a non-MSI one to now
> an MSI one that is proven to still work using a hacking test:
>   nvme: Adding to iommu group 10
>   nvme: --------hacking-----------
>   arm-smmu-v3: unexpected global error reported (0x00000001),
>                this could be serious
>   arm-smmu-v3: CMDQ error (cons 0x01000022): Illegal command
>   arm-smmu-v3: skipping command in error state:
>   arm-smmu-v3:  0x0000000000000000
>   arm-smmu-v3:  0x0000000000000000
>   nvme: -------recovered----------
>   nvme nvme0: 72/0/0 default/read/poll queues
>    nvme0n1: p1 p2

Hmm, I'm still a little wary of this. The only reason we emit a CMD_SYNC
in __arm_smmu_cmdq_skip_err() is because the SMMU doesn't have a NOP
command. So I'd really like the SYNC to have as little functionality
as possible in this case.

I think we could either propapate the 'cs' field down to
arm_smmu_cmdq_build_cmd() or just open-code the command-creation in
__arm_smmu_cmdq_skip_err().

Will
