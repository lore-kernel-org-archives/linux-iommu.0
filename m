Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D8292B25;
	Mon, 30 Jun 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303961; cv=none; b=Pgs1tkESH54uw7+y68kmMIKbpux4CGV9c3HPYBqPVWs0UGwWxNkF/5sATncgrRGwjKWmU/RL+6RIwDnqnUsUmWx/r3EGgxAVc+8YuYRAfHbmY6pFNw6V2qWH7tRXdnFL3YgPqucBCCmhF2T3FHXI9GAIKATHutsrMDgUg9XS2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303961; c=relaxed/simple;
	bh=jo1IF2pZkSbKcofr/cGm017l2YthC5rKRBKO7j15hdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+qHR8vxd6gw97WURNjN2WNS5a3z5o6wulScpxSk5HQc+uas+l+jnMLNJcBIwG+cS/aWY0HAszMixq8xwItFFbYTfLFETz41jG7rIatyuuWbioyt4lAZn/dEcRT20xC+9fYtA7bNcVTq35iuBOT3eepsJvKEYf8aI7tS/eHFcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08F4C4CEF1;
	Mon, 30 Jun 2025 17:19:16 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	=?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: Re: [PATCH v8 0/4] Initial BBML2 support for contpte_convert()
Date: Mon, 30 Jun 2025 18:19:14 +0100
Message-Id: <175130394786.1397341.8393706123668185892.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625113435.26849-1-miko.lenczewski@arm.com>
References: <20250625113435.26849-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Jun 2025 11:34:31 +0000, Mikołaj Lenczewski wrote:
> This patch series extends the cpufeature framework to add support for
> easily matching against all early cpus, and builds on this to add initial
> support for eliding Break-Before-Make requirements on systems that support
> BBML2 and additionally guarantee to never raise a conflict abort.
> 
> This support conceptually reorders and then elides both a TLB invalidation
> and a DSB in contpte_convert(), when BBML2 is supported. This leads to
> a 12% improvement when executing a microbenchmark designed to force the
> pathological path where contpte_convert() gets called. This represents
> an 80% reduction in the cost of calling contpte_convert().
> 
> [...]

Applied to arm64 (for-next/user-contig-bbml2), thanks!

[1/4] arm64: cpufeature: Introduce MATCH_ALL_EARLY_CPUS capability type
      https://git.kernel.org/arm64/c/3eb06f6ce3af
[2/4] arm64: Add BBM Level 2 cpu feature
      https://git.kernel.org/arm64/c/5aa4b625762e
[3/4] iommu/arm: Add BBM Level 2 smmu feature
      https://git.kernel.org/arm64/c/212c439bdd8f
[4/4] arm64/mm: Elide tlbi in contpte_convert() under BBML2
      https://git.kernel.org/arm64/c/83bbd6be7d17

-- 
Catalin

