Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3381BF315;
	Fri, 16 Aug 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821392; cv=none; b=Ao0r6uAOltosU7XdJvDhmcBbvQBFqckuk5Zr2Z/Jw5zOl50Ekp5M6flp8G0wSdQT/itIGSj7Tb6n4c8S1VIYYVJHNmOpkFPTiNW6iMCwu7Z5Gb8rzQ0/fXBxRsraYGRz6B8nzGWA0buSlQ96PS/CvP87y9DbQC50FwuPIP9kVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821392; c=relaxed/simple;
	bh=yWWNx6BeN3bNDNPu8WhxlsRmGiU5W9kSaETwg3COSq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQiZI5it/1MeTBh0F8sIr1tQXNkRx4CsMof/oIhNO+IMItcid4VezomP6Ws2OeF7ULQjQft+SZWE6PTSJr/p3F4xKmwAIKd2nX5gE6MuM/fGrHuo5XSsluYxhtAYJZhHHitc0LW8w2SXUO+2Z3SCoGa3/uEmgMcxGxOi2F19ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1MY10e4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1MY10e4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF30DC4AF0B;
	Fri, 16 Aug 2024 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821391;
	bh=yWWNx6BeN3bNDNPu8WhxlsRmGiU5W9kSaETwg3COSq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1MY10e4HJWsfOp/AAtHzqRuGlyw599ZBBbz0Crr0qJ0gnwCffoZPUdfIIY1lMgKr
	 i27vHVT+6yRv7bmwebAajl3o/YzBl1G9qCDrz4cBncAu9X/kzUAlZaJ/MLFbJJ+0WV
	 W1bJp/Ush4dzLWbHBz9kNyBdHPwmVZfG841FuDjfI3TKSBURXuz1fXjNq1pHGs9uCu
	 guGY2XsWCrnhk8880lmHZOWsglcDclnm+Ld4XWBO9g3stDP23M3tUgPX2jx84q6HK6
	 Cshh7W7GeM+LHznZUJpXB0y4uSHE2xM9HK2KQQkdy+s1rBdD8nEr6ad+fha2ytMucO
	 qGX+cYQGKkrpQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Rob Clark <robdclark@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Un-demote unhandled-fault msg
Date: Fri, 16 Aug 2024 16:15:58 +0100
Message-Id: <172381862229.1794487.17068761066364130246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809172716.10275-1-robdclark@gmail.com>
References: <20240809172716.10275-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 09 Aug 2024 10:27:14 -0700, Rob Clark wrote:
> Previously this was dev_err_ratelimited() but it got changed to a
> ratelimited dev_dbg().  Change it back to dev_err().
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Un-demote unhandled-fault msg
      https://git.kernel.org/will/c/98db56e49008

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
