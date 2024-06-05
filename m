Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615F155A4E;
	Wed,  5 Jun 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602358; cv=none; b=gjbtHQnvLCJO0LKLDJS7JAtqbo+rHGs0GcYDGpn4V6dP0jVmnIBeubZ74O05K3WQz3F0dQl5JEtG5Tau+pVFEq8FnMiRabKWyARCKnRP4dXss3XQxfjq5v7CQVGjhgPT/Spog38G3pKMGtwvdm4DKu+tM6PzNBV6834IpeA041g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602358; c=relaxed/simple;
	bh=FyldfTzNZPniL6au2gQsSraHX6MskYD8BVPvkrZxxXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py4DwTCiLHhrnUx5updAGxPBLBNDurq6lVCvb5ltfEpQYS7S6oLry71cskgIeSmZ910Le5U9Hcf6e4j7XJmo+uqOQ1bMLcSPgkCUGRdSyZrfLLaTiy4fmBdA6UiJaBu22FsQQmXCF3IXN6TkR2d+MPJmxx54ZGxeKLdro5nE8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzI1vU88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzI1vU88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765F3C3277B;
	Wed,  5 Jun 2024 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602357;
	bh=FyldfTzNZPniL6au2gQsSraHX6MskYD8BVPvkrZxxXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzI1vU88LUfKlmlgo32PjDybshwRWjwpWqYUcHfY9ye2SmeiDYHDGIDPYaZErXrpy
	 ije8AUE7uSBHXWJbP7bx6Gi3gI+HSiwtyXUr3qYzS01/Ps7SA+jQVVqUcVkRj3/AaE
	 hru7ON9yz+Wv0oVrG4lLlgNJA91BAbTQgy3l4XrOXu2+oAhKMfoITAnoVuej99A4bD
	 gQSSEoMPoXATDyb0XS/DV2OGgoG7tAqcSI4+7cUeQJ9aJllbDp5Po/N/eDDku5iLWu
	 Ce23nPhyfVJw6pGpHgLWQH42+UIax3yC54KgLWgz/onMZQkU0yjKM3BcPvZN4tZOfj
	 FMI7hr4n9kEOw==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	nicolinc@nvidia.com,
	mshavit@google.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of error
Date: Wed,  5 Jun 2024 16:45:46 +0100
Message-Id: <171759168166.1126369.9985606897560767685.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240604185218.2602058-1-smostafa@google.com>
References: <20240604185218.2602058-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Jun 2024 18:52:18 +0000, Mostafa Saleh wrote:
> Static checker is complaining about the ASID possibly set uninitialized.
> This only happens in case of error and this value would be ignored anyway.
> 
> A simple fix would be just to initialize the local variable to zero,
> this path will only be reached on the first attach to a domain where
> the CD is already initialized to zero.
> This avoids having to bloat the function with an error path.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Avoid uninitialized asid in case of error
      https://git.kernel.org/will/c/d3867e714831

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
