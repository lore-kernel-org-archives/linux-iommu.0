Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E999405AAD;
	Tue, 24 Mar 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364914; cv=none; b=YvT3ylxHxHnLfpfDlnOe/5JZbzTHu6knk7oSLAX5JqcKN+NdhLle84N6jRGT+JVH9H0QCpWQekdYyEjR8e2x4ki8pAax5zdxMS8IiTUUAEuOeoCQ1OZYkYt/PP3MbtZrZclIE8+fAYn75i397r1H2J1uiKbdi5BwmnWaHnVCDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364914; c=relaxed/simple;
	bh=0mH7uYZYueiKrHRYK9hJo/SYnSaUZjBuHsQJhpph3vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XotTvqSKZqQLscX3qqTL+h3jMCcOPOM4aT5hsCHSMjFuYG+DXfMlIRHU2PbgeyT0nFeHNlODY841kM8jpZ3iawehzx5DJ2LLWi9mq4ymnhvvTXk8oScPMRrG4im2dcpDuEDUQbaslkNzbLhRqQFMZ/uZ0MxyW6R9XncloyX+7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3YoXAS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3YoXAS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38132C2BCB3;
	Tue, 24 Mar 2026 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364913;
	bh=0mH7uYZYueiKrHRYK9hJo/SYnSaUZjBuHsQJhpph3vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3YoXAS12VFGUCYlTIYVxMt9XDszX/QDBqmPH3a++qcU715k6GEZ7B1CZlNuZd65s
	 pnG6smiEskwgC/ZaG41o7fxjBLqO5+AOcXd1PfcYrNn3r6QjIKiVCiNbmX+QYE8hRz
	 KCxTknlFFkMpw/nmFVyYXYtuNTO6AQ++ClfPSy+CDvwryIqi+aMrPw725AtJ/QgZ+Q
	 LcQx8ve1DgcE5u10hUxTp1VFbJJITZYCxgDFGFrY/NTAKbAoEzWZsRHZG9JS4A1vVA
	 0eXmmRnQeO0zY+8gZGIbTd0G3hUZYc827YKVanTwuSlGAiH283WgMxey/UpZPMlnyT
	 QCcU62J8QiLVA==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/2] iommu/arm-smmu-v3: Fix bugs and typos in arm_smmu_invs series
Date: Tue, 24 Mar 2026 15:08:12 +0000
Message-ID: <177435987281.1850677.12953681041548853263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321225041.11090-1-nicolinc@nvidia.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 21 Mar 2026 15:50:39 -0700, Nicolin Chen wrote:
> Thank you for taking the series!
> 
> I found a couple of small issues in those commits. And here are the fixes.
> 
> Thanks
> Nicolin
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Do not continue in __arm_smmu_domain_inv_range()
      https://git.kernel.org/iommu/c/6a01b9f0a5ec
[2/2] iommu/arm-smmu-v3: Fix typos introduced by arm_smmu_invs
      https://git.kernel.org/iommu/c/86bf8580d5b8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
