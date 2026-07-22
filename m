Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758C43E9D2;
	Wed, 22 Jul 2026 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756424; cv=none; b=p1QyclYAowq+C2BZwGlyivNhxvAL6EXO7WH6HPQZJyCt+P/iKIma5dBWCKD8axBpDv6hoC/ZUQBaWU2DI/DbVRZF6DiwPx0ftuBx7ip0KCkT41Q3csUWtHEooYosrf9EK3Dwcmky8wRAvAzGEGMt4847QUnP9ngiOcNd+QwAvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756424; c=relaxed/simple;
	bh=mZzxnXJs+hw8P2+qW0vrvLVyEV/GG7O7xviaUHfrHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7fknEx0A6EwJehaLsOdaWiI33ncQ8pHTRlvyOcKqz9lZcULKA10DYKcKkTtSxukT37RlY2hmkLgzHLGgNxA1DTeoLOqlLCOvPx3rCXsiD0MqzuQoHN5Kqgbmhrns9QUsLmyL2HWjqv2JdFdW04PSHtK2o+U22YAwPaeH7NciSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZXjUFl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZXjUFl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF31F00A3A;
	Wed, 22 Jul 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756421;
	bh=fxi4w+/B7pXHn9XdCEw4+G4vTl1xQW/kaBWB75dr2vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CZXjUFl31LodjipmpbwvoT8x5DPGd6uwznXSaxumd9KcN0ajOrgoYc+sWVvcD9Ep2
	 XUyFcgMCeCSj4Abfd/IfnjakEVgYORCnof6ZcVLQQiNKgLZfeclCyoLJ/lSYB0+F3K
	 SoHe3B22RftZNYoljcD8/noK7/0doyGf/6rSMr7uYO/IaKaFkbC9DH41VcWmdksSYv
	 CoiWBtPFTWKdyjJEMS2oINFxwOmf+uF+1/YfDs5F608wx3A2tkyXymezcQOA0VTpUi
	 QjGycePhV7EqEYQBZRMMyLxPLXsute8jRbgVNzhAVKPrVI8N+S7qrdzvYB2IW2trj9
	 lMz+4rR1RJT3Q==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
Date: Wed, 22 Jul 2026 22:39:28 +0100
Message-ID: <178472616634.2880644.9585737854027024973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615194533.3290010-1-nicolinc@nvidia.com>
References: <20260615194533.3290010-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jun 2026 12:45:33 -0700, Nicolin Chen wrote:
> arm_smmu_get_ste_update_safe() declares the eats_s1chk and eats_trans
> locals as __le64, but initializes them from FIELD_PREP(), which returns a
> host-endian value, and passes them through cpu_to_le64() at the use sites.
> 
> Sparse reports the following warnings:
> 
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1122:38: sparse: sparse: cast from restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1124:33: sparse: sparse: cast from restricted __le64
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as host-endian u64
      https://git.kernel.org/iommu/c/445528627447

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
