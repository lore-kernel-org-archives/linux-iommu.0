Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557D202C48;
	Fri, 23 Jan 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190610; cv=none; b=dJL2uMqRXCnHu76yMwDfczaaAB+t0ZaLNbor7VYPmquUF+dAsv8kbnbSPjxXn9X5nIHHN9hLt+5NxOP1U0yWPvnugqLp5cgeEXVj1UEFLQc7M3Yg/PpGP2ixGIcj63tPVBqrQbEwCFAWwHLbuXpVrXRSnJ3HNHoC0Y9LIUmrl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190610; c=relaxed/simple;
	bh=3RYGl5ikcWVxsHgIt/d8TQuGylLISMaMkAM49meYVfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBcYOkg7WfU5IKgLQZPY5Di2rpfoDm3vN0PJwxJhFuLDm0fMiTa1beEI1MSvpD83AY7n8u2rlK3D1AwJVHU1sqYHsvUSL6olW5Dgwkm5wHzxTqjhgH+EcbZBTe+oFxA0JCCzhqpJAhStc5h3ytsoDoUx+diH+/rKJ85z0ecNiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTm4lHDI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTm4lHDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F69C4CEF1;
	Fri, 23 Jan 2026 17:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190610;
	bh=3RYGl5ikcWVxsHgIt/d8TQuGylLISMaMkAM49meYVfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTm4lHDI9ohAngitvV2Ir1NX6XUNm9NyDLBK6qOUu2vQ0rrop1IFHM1f2k/QOO301
	 w9/eM3GuL8l6ygd9jS0Td9mhXKHvjxUVYaor7gUvC/ywlL0HPuUx8rc9Sc4eDfB9qC
	 l6cy9l9JIY4HT/Wcdvvtl5Dq0fj0TCj+YajetKnLrFCW9OY5iY9m2zN8m+uUHWcTf2
	 VHL1ND/9tdMEGUtloAE/gcWjNL9NPoR7CZ1X4UDBIjGtq1XW95F5lzxcChPKlykZ4A
	 qoYt9u5NjzCsm295/XrQClUQcsUyNgV5uxooURZyc87zf8fH2kNtHWbShmWj0LSkih
	 5/AlErgQJLykw==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	praan@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate
Date: Fri, 23 Jan 2026 17:49:50 +0000
Message-ID: <176917671895.804169.18440090230876148994.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115011243.1302402-1-nicolinc@nvidia.com>
References: <20260115011243.1302402-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 17:12:43 -0800, Nicolin Chen wrote:
> A vSTE may have three configuration types: Abort, Bypass, and Translate.
> 
> An Abort vSTE wouldn't enable ATS, but the other two might.
> 
> It makes sense for a Transalte vSTE to rely on the guest vSTE.EATS field.
> 
> For a Bypass vSTE, it would end up with an S2-only physical STE, similar
> to an attachment to a regular S2 domain. However, the nested case always
> disables ATS following the Bypass vSTE, while the regular S2 case always
> enables ATS so long as arm_smmu_ats_supported(master) == true.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate
      https://git.kernel.org/iommu/c/a45dd3466302

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
