Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C247F69;
	Thu,  5 Sep 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553105; cv=none; b=Ky8mkp5F1UR8I1PI4ZUFDtlp+XebTNuEK2PAKgVdcEadBghsExkZemIKD+Utp63KV4TuP4lKy6IhC1Aq6M6uLpK83WgPSstGIgZjOse8Nxbiunz1m+C6Jl9s4AFqIX2xE1e51i4zEHadFQ25bEHv6liFd+v7AeMnDLxmzzewXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553105; c=relaxed/simple;
	bh=9j4vb6M9tnkcgKnPlGRTlGRdfbJ5Vi4j0Kv0XOqxlKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvxV9Fy2BGA67pbX8ORLXxFlXRRof5/3LGvjL6FYOfk8NkcGNcEooYByDqiSa0eE7mO1zA26neDkEMlqgcI1XVH6f8UlPJ6lWBpMphNqhhpUKR1aZdicrD6XrfOEVuAcB4Wj9+lGHXkzrCy/Xu6rLLlJzvPC4gldNHL+1XCXNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxxCkMjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxxCkMjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84382C4CEC5;
	Thu,  5 Sep 2024 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553105;
	bh=9j4vb6M9tnkcgKnPlGRTlGRdfbJ5Vi4j0Kv0XOqxlKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxxCkMjSxsknNWpIYoc5w9V1IyID4BW18taQ3DjCNrzrwzHklhvL/cxlgu10P9QMO
	 1L4TMhuiIsT5jsuYXPco5o+2jxoRYHJ/ZOo6MZFJoO3QIughD7FmMTU0JYBY5Q6YwB
	 FsEGz8KWWsIT0M7j/TcpaMkvth4RK5cW/v9T9tLx9HxaJS5zeVPiYw+9R9TTzH8i6m
	 DWqbi1WkbQqyBewMmVkXABgV7Yj+cRccnTjI2HE/cr361GMxgLtukdKkPy/og6wGth
	 7zbD0WxKKJyfBZWsJaI7MOWnxA12D4m3soLKZ7mSdDXdgQf6951d6jNXC8LnRM7I5G
	 H6WqCG3sKZJ0Q==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mochs@nvidia.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH next 0/2] iommu/tegra241-cmdqv: Fix two bugs in __tegra241_cmdqv_probe
Date: Thu,  5 Sep 2024 17:18:18 +0100
Message-Id: <172554885936.3732078.16345874292461720632.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1725503154.git.nicolinc@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Sep 2024 19:40:41 -0700, Nicolin Chen wrote:
> Found two more bugs today. And here are the fixes.
> 
> Based on Will's for-joerg/arm-smmu/updates branch.
> 
> Available on Github:
> https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-fix
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/tegra241-cmdqv: Drop static at local variable
      https://git.kernel.org/will/c/2408b81f817b
[2/2] iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent
      https://git.kernel.org/will/c/483e0bd8883a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
