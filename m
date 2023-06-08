Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076E7464
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 21:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B34C433EF;
	Thu,  8 Jun 2023 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686260171;
	bh=I5fyTwhadiYvXOAb5nv2O0zWaYhbEYqn7CMXYp1R5Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9mgJQx4RZdKJCdcEHzyJEWTa35B70L9Rj8wEO7hGbMH5HBH26wATY8XbgORveCDf
	 r4+Q+6ssDPBmunESRZV2WFqxujF19KKNnyNIkncrUbfTOzrULZfMu8KFwtN/6BR3AV
	 hCxlJ2HdVL4krp1FXkO4R4vV/jek/UsDTh5G2eiUImEoYohTfxtdWquk49gFeQPh2f
	 lNoJhIc1JuDKxpoBMbwDg+p5Vc2TKk3x02YvfGFrA/CH1Zk5e9TSTl144P4DnHv4hy
	 eUP/NBhBq7/82W7V+DpHh/Feyry3SPfP8IHihXb4iQVIAASNij2AW+39VV++doREkI
	 6kIxu85zlK5Kg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	jean-philippe@linaro.org,
	nicolinc@nvidia.com
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Arm SMMU errata bits
Date: Thu,  8 Jun 2023 22:36:04 +0100
Message-Id: <168625789305.628187.322001342569321506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1683731256.git.robin.murphy@arm.com>
References: <cover.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 May 2023 16:38:42 +0100, Robin Murphy wrote:
> Further to the discussion on the nesting series a while back, here's a
> mini-series to help us start taking more of an interest in SMMU errata.
> Patch #1 is more about the infrastucture than that erratum itself, but
> since I *had* already written it up (5 years ago!) I figured why not
> just build on it as-is. The rest is effectively just documentation at
> this point, but getting us ready for all the hitherto unmet conditions
> that IOMMUFD nesting is going to open up.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/4] iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
      https://git.kernel.org/will/c/f322e8af35c7
[2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
      https://git.kernel.org/will/c/309a15cb16bb
[3/4] iommu/arm-smmu-v3: Add explicit feature for nesting
      https://git.kernel.org/will/c/1d9777b9f3d5
[4/4] iommu/arm-smmu-v3: Document nesting-related errata
      https://git.kernel.org/will/c/0bfbfc526c70

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
