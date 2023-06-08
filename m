Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CE7464
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 21:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF697C4339B;
	Thu,  8 Jun 2023 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686260173;
	bh=vmgxMYtaeHDhkFNvJytzQO+damBFK48XFvaaOJibDAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDuzOS2qArRfENtUU5fX9CMd+GZB6/rBb6vBCouYRhCMOZu/Y9qYuqwvUqbMSbdv1
	 /p7FRrcmJ1lDJjRoqJaqBbWNg2gjmtgNlF/dWu75kKdYnDgrQrxI4sC4FtXRl4MWku
	 BG7rt9TviKtYnD6UmA0PddIJE97gDcjcaMm708x5dPA4uzIz0PkmUswNNMygAMQkKq
	 YniD5cdejEzPH75HvMAhydCldKpaF2tGDIgk9//dzytWbxEtN+4luyVd0p5dlehKYV
	 dPJGlKWj2gJAQcGBVn7Ih08fjF0CFSqfQmqh2a1CI93Kgcfy2mfiEnUwOgC9gy1L2L
	 4D4FVoLAuJ3VA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jean-philippe@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-v3: Set TTL invalidation hint better
Date: Thu,  8 Jun 2023 22:36:05 +0100
Message-Id: <168625802263.628430.15833629790497414818.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b409d9a17c52dc0db51faee91d92737bb7975f5b.1685637456.git.robin.murphy@arm.com>
References: <b409d9a17c52dc0db51faee91d92737bb7975f5b.1685637456.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 1 Jun 2023 17:43:33 +0100, Robin Murphy wrote:
> When io-pgtable unmaps a whole table, rather than waste time walking it
> to find the leaf entries to invalidate exactly, it simply expects
> .tlb_flush_walk with nominal last-level granularity to invalidate any
> leaf entries at higher intermediate levels as well. This works fine with
> page-based invalidation, but with range commands we need to be careful
> with the TTL hint - unconditionally setting it based on the given level
> 3 granule means that an invalidation for a level 1 table would strictly
> not be required to affect level 2 block entries. It's easy to comply
> with the expected behaviour by simply not setting the TTL hint for
> non-leaf invalidations, so let's do that.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Set TTL invalidation hint better
      https://git.kernel.org/will/c/6833b8f2e199

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
