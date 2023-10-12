Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F38DDD
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGK+NAKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A2C433C8;
	Thu, 12 Oct 2023 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697134029;
	bh=axeVVnMAKN1esWZVbwxpsfj2uA1BnBo59XNlWHwYp+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGK+NAKP7Hs+dxFy5KnpClI/nmlc5PAETgqJfH3a/JTvQ6vi6TfiSv7043+wxfYxR
	 cl9wEYQT+p152C96xLjjS2QFlBzp6C02YuHJSkJDmHhsqsoGJ/X8tF4IxzrGnSD1SU
	 oJIp7oB15nfO+A0Iyp23SUN9aZfH27E32sqJqmToaNjs9andT1RXjJRQbB+/BV2QYP
	 aobgj64ERN+DSkiqKyUASTbb1yR6HbFUjNSpOxSWTzm4GIrPORAZjywgtP2JQRmXq3
	 rlENlmcqI7cBdfF9aq14Om8oYrabMRfKh9r7pysqqxY1JNPNvuV5g5vgScKf6DHelb
	 FL7KomIQxNpag==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Michael Shavit <mshavit@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	nicolinc@nvidia.com,
	tina.zhang@intel.com,
	Yicong Yang <yangyicong@hisilicon.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	jgg@nvidia.com,
	Tomas Krcka <krckatom@amazon.de>,
	jean-philippe@linaro.org,
	Kevin Tian <kevin.tian@intel.com>,
	Mark Brown <broonie@kernel.org>,
	robin.murphy@arm.com
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
Date: Thu, 12 Oct 2023 19:06:47 +0100
Message-Id: <169713222742.3248815.8112629001762142966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
References: <20230905115013.1572240-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 5 Sep 2023 19:49:11 +0800, Michael Shavit wrote:
> This small series was originally part of a larger effort to support
> set_dev_pasid in arm-smmu-v3.c and a related SVA refactoring. But it can
> also stand on its own as an initial and prepatory clean-up.
> 
> The crux of this series relies on the observation that SVA won't
> allocate multiple SVA domains for the same device and mm pair. There's
> therefore no reason for the driver to try to normalize data allocated
> for a device/mm pair across set_dev_pasid calls. This simplification
> then allows set_dev_pasid to use the SVA iommu_domain to hold
> information instead of allocating a "bond" to represent the attachement.
> Note that long term, we'll likely want to represent the SVA domain using
> the same arm_smmu_domain struct used in arm-smmu-v3. This series serves
> as an interim step to make those later refactors easier to reason about.
> 
> [...]

Applied first two patches to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
      https://git.kernel.org/will/c/d912aed14fe4
[2/3] iommu/arm-smmu-v3-sva: Remove bond refcount
      https://git.kernel.org/will/c/37ed36448fcd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
