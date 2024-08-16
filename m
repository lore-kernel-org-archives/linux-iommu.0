Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9281C231F
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821408; cv=none; b=Mvi3FnAO15iABHJhtU80vEv1wfabqY+NE/QX8L1vIL/c+qzqsAH4TkyhTgzW6Fstb0+XpU6EVQAVE9WaReZIQlT7yQbFVQRhrs7mJT5EDW60A39c4uMqO3JE3Z6jN/uVqnKbYf4vtfpxbBooe1dplrWyG6zqqEX93c0OZRUl2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821408; c=relaxed/simple;
	bh=+Po7fNGKgsSP/aTo3ZFfbyAng/2QBG7S3A5EH3612Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIh3ak0SUT2kv1x6SS6fjBvrkOVHEu2P5Vwt6IjtVzShvYOpDRRiDb47YCebPcCn1ybEOZ9nPsuCG/EqzUjDuhKfoEb3jB+vRbXAGIq3kOUF543Q+brZLuctD5ebi2twjJojzMTl03TNK2LVrU4C4a/8uAlC4LNKaGewDZo2C8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAPAQ6jF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAPAQ6jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E26DC32782;
	Fri, 16 Aug 2024 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821407;
	bh=+Po7fNGKgsSP/aTo3ZFfbyAng/2QBG7S3A5EH3612Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAPAQ6jFbK1gP0y8g7EldnPFgwswYq1A+YIORLtRCUS/vZMhC8NbO5+X7rdtlibwJ
	 SK7BZUileOQC2E6Q56QN1qHxHDA5rT4c7IUPpSB/DI5FKoPlZppSTcau11ysDs5sBD
	 34IK/DljD1gD+X12RutLi5aLP4Kyh/RJ7LIQBFoQJUe+o0evqAKlfCWJ0OLUiLVu1Z
	 Ef9A0elGS9s4zB/ea7HyC+Q+kTZG58pp3+b2waPYBDP8AY9dr07kkQaXnvLNdV3oq/
	 pswY1+m4Kk+qdyrZ2+3YeCN6lRy5PTnvmpIXVnJLuRe42zNTNCpe3wmTu4g6u+3grF
	 zlwatKt7GQfaQ==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	iommu@lists.linux.dev,
	Zhang Zekun <zhangzekun11@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove the unused empty definition
Date: Fri, 16 Aug 2024 16:16:04 +0100
Message-Id: <172381874223.1794820.17402010509613429926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240815111504.48810-1-zhangzekun11@huawei.com>
References: <20240815111504.48810-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 19:15:04 +0800, Zhang Zekun wrote:
> arm_smmu_sva_remove_dev_pasid() has been removed since commit d38c28dbefee
> ("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain"), remain
> the empty definition untouched in header file, which is used when
> CONFIG_ARM_SMMU_V3_SVA is not set. So, let's remove the unused definition.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Remove the unused empty definition
      https://git.kernel.org/will/c/df49881956ba

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
