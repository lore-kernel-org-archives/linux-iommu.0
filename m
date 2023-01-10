Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74947474
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 14:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36251C433EF;
	Tue, 10 Jan 2023 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673359378;
	bh=9H+5eOtv0lKk4HSMYMJMclMcC4uh3lzgtY/ixVbfZVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Irb+756cmGWT2+wchs6pAoVblX1BqQkvhE+90nZVtjD3Bb5tlsZjmBeYLz9/+RJfr
	 ci7WMVw5l9ccU2je/XUeS83j32EGxD/0WLls2XZXYv33V/OGZKS5imdODSOIjbq4KM
	 3NCdwQoFzxBK5F8U7kdiLsvKnRXjkubJMKBQU6AwFjaLF6R4F6BRPL2C0u3P37m+d/
	 p8NpwzrZz8NXgHxSFKd+1kZHX7aUvRvtMMtXQpeA8xkZ16lNFF9OfiY1/Std+Uonf8
	 vRlX/hpKKYP715UIcKR6Wu1pBiFh54kVXt4ZyM/lFUt9D2V7SNOqconJIblOC8ezVk
	 QbhZ942yPcbNA==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer
Date: Tue, 10 Jan 2023 14:02:52 +0000
Message-Id: <167335514704.53636.16139613567040237163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
References: <d6dc41952961e5c7b21acac08a8bf1eb0f69e124.1671123115.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Dec 2022 16:51:55 +0000, Robin Murphy wrote:
> Although it's vanishingly unlikely that anyone would integrate an SMMU
> within a coherent interconnect without also making the pagetable walk
> interface coherent, the same effect happens if a coherent SMMU fails to
> advertise CTTW correctly. This turns out to be the case on some popular
> NXP SoCs, where VFIO started failing the IOMMU_CAP_CACHE_COHERENCY test,
> even though IOMMU_CACHE *was* previously achieving the desired effect
> anyway thanks to the underlying integration.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer
      https://git.kernel.org/will/c/259c2ec3c5f3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
