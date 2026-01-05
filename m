Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E62836AF;
	Mon,  5 Jan 2026 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653932; cv=none; b=M6q1EhzhMORYgSpdOKPfYamCe8AM9NxrA7WMolzaBdcl/bkiIAu964CTwADp9ri45obl4ow/5qYGydYss5iROS7lg+RDGA6J2z2bCq71accc/dO30UAhyJP3hhs56AFvEXfpQpPl6CEnomKxCwH+7vuKm2GOCyYMBX3zrzegBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653932; c=relaxed/simple;
	bh=cLXwZ1WD6XB2ttdqYuMSJm8C7jJVWMio9fAwVSYUEI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBM7lagZ3wWUEQO8StlO2GQwpaV0Bimo5cNA4dWo2VzuOTNV8vSqLLoABFFMxUaAI0OfL8/phga3LD0BJE1kOilKOTgbmA3cAZQ5w5zg4PM1y88p9nnAx5B5ig0kaLeWZbFxgB44vbohpwaPyBSXk0b+o8oDlSBV6FVFawOu9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0Z+6WzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0Z+6WzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C370C116D0;
	Mon,  5 Jan 2026 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653931;
	bh=cLXwZ1WD6XB2ttdqYuMSJm8C7jJVWMio9fAwVSYUEI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0Z+6WzG0T5ybYBS8g+X6WeKSBsTKdT3JubTbsUPjqPx59Wq92GnP95rJWZLcE1Ys
	 W2E9ZKzPlZFc2V5QznkfqGrK7GO3UZDLk9xq5FMyA9pk/lCMmnRHERgX+IRQ0yrAZg
	 zj4EJktYpKlAJ1ZT7JlviGUF11FflI6dKpf3pzdS5BFNLOcdCiAM+7YQnpHPYQxmiY
	 ZgTK814WYo3bQ5aQmH3f7xN26vfC9DpW3bkU6QqDHgGtsbXikAX8J2AMAVBsJH1RZY
	 BSDO33GSfumjwXpr8eOeSTIdN8XukvMd7VoDbvhb8koa7+cA7rHVJOHxQeFuQI4u9p
	 +sB26HE0CAKyQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Alexander Grest <Alexander.Grest@microsoft.com>,
	Jean-Philippe Brucker <jpb@kernel.org>
Subject: Re: [PATCH v5 0/3] SMMU v3 CMDQ fix and improvement
Date: Mon,  5 Jan 2026 22:58:23 +0000
Message-ID: <176764512514.1439618.10919808867972292538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Dec 2025 13:28:54 -0800, Jacob Pan wrote:
> These two patches address logic issues that occur when SMMU CMDQ spaces
> are nearly exhausted at runtime. The problems become more pronounced
> when multiple CPUs submit to a single queue, a common scenario under SVA
> when shared buffers (used by both CPU and device) are being unmapped.
> 
> 
> Thanks,
> 
> [...]

Applied third patch to iommu (arm/smmu/updates), thanks!

[3/3] iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
      https://git.kernel.org/iommu/c/df180b1a4cc5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
