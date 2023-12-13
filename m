Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52551C31
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFnXzxcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A19EC433C7;
	Wed, 13 Dec 2023 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702488326;
	bh=KSLR38qRIJgnAPI8e5kHeTaPsCJPw33MiMgn7E2cx3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFnXzxcEQZNzYGfpDgmG3L/w2oRc7BYnpBnISQ+0dREMZbwCc87R301+/yLC1SlD6
	 3PDl5GdP9IfK6qNOtjBp6fjexmcQt2GkixcnEQyTzwf0AG6mvoiXzagFHBGd1KOJ/d
	 P/Eto5FasMhE1QzrLullVQ+JJDmU9awUkEMOIWI2wDDqcLhDQuqhw+1nYTdzzSWJFI
	 363rMRPosbXoNIAIjmY5TPx0JyLtKnqzXzHfCdaYFDAaXCnO97sR7Bii4oXoUGXhRf
	 JTceh4X2xQhbSmG2VqeeX6TbARjwSORcRE522vJDJKzY9b1HccZPUgERWGMZq2Cxyw
	 QFauZJEoT5Bng==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 0/5] Convert SMMU to domain_alloc_paging()
Date: Wed, 13 Dec 2023 17:25:17 +0000
Message-Id: <170247134058.2137421.298272092445922389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Oct 2023 15:11:39 -0300, Jason Gunthorpe wrote:
> Add the global statics for IDENTITY and BLOCKED to the SMMU driver and
> change to use domain_alloc_paging(). This allows SMMU to finalize the
> domain during allocation.
> 
> This relies on the first few patches of the dart conversion series:
> 
> https://lore.kernel.org/r/0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/5] iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
      https://git.kernel.org/will/c/ff0f80297413
[2/5] iommu/arm-smmu: Convert to a global static identity domain
      https://git.kernel.org/will/c/22bb7b41476a
[3/5] iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
      https://git.kernel.org/will/c/bbbf11eea38c
[4/5] iommu/arm-smmu: Pass arm_smmu_domain to internal functions
      https://git.kernel.org/will/c/e0976331ad11
[5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
      https://git.kernel.org/will/c/9b3febc3a3da

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
