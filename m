Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E824400DFE;
	Tue, 19 May 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204258; cv=none; b=dqsW6rJUxMC35yA3XHlkO6GEAWWadyZRaM6n+isH65yUxQxdnPMdvdp5zmGEO5UQLWeyAni4iqQoFggVr18EHMFw2npUopSQPJkf2c0CdCKl1Z3kRALP0mjGzfWbEgI9qZC44HQ9Jf1frgjBvRZjvo8iHc5OlM9hu/6ph9UV6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204258; c=relaxed/simple;
	bh=WFSF8Bu9R2fWrWkPUVMtmNOhuTJlzJ38NfbwWlpjOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATst5qSwDrdDK85TwZm1GefQaRgC8Z6jeUnE38X6wd79DmyVPt6jA2BwfvrvkS79f10idHXGNSO3r0UudIhgJZmPWAofCaFDrm3cyc3kAe9SVDN8RmKzF0fQJ35u+twJyJZ1WOoWz2gqARxGaAfNAcx2x8SKg1jXZ9iMpfPmcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMlcohLd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMlcohLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C66C2BCB8;
	Tue, 19 May 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204258;
	bh=WFSF8Bu9R2fWrWkPUVMtmNOhuTJlzJ38NfbwWlpjOi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMlcohLdEZrL13xN6TLZmNmot8IWhR8rpzqEtvnwz0KvBIb2zctMIZkpyTbZo4ZjG
	 g/b2jtcsz57OhJiK1zZ7j8WjUqpD0qP503F585lLBRqykSIYRrW4SZVMw+vtUvscTJ
	 +RcoSMRdTw+ApyLdzjz9N1O2ONBEKQApZ/0tPT/8YLLso8s0nD341bkJFWsp0h4RYr
	 UwgJNwxbCT1tmXAysbevooLOy7ETaDZmPS6IG6CZDSEsqb1lW5ubLFh+pHCEblFHvw
	 t8vc4tN6xZAKn7/k3KYXH2Pfj9z+kWA5BINzHqOKJSa0P3FbXLrLRKLkxKeBfFRujz
	 Ic+20zJ1M4FWA==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	=?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and Hardware Dirty bits
Date: Tue, 19 May 2026 16:23:07 +0100
Message-ID: <177919969031.1013920.6454574496615860619.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260503135413.1108138-1-nicolinc@nvidia.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 03 May 2026 06:54:12 -0700, Nicolin Chen wrote:
> HTTU is introduced by utilizing the Dirty Bit Modifier (DBM) in the PTE.
> When kernel maps a clean but writable page, it will set PTE_READONLY and
> PTE_DBM (aka PTE_WRITE) at the same time. When a write occurs, an HTTU-
> capable MMU will automatically clear the PTE_RDONLY bit without software
> intervention.
> 
> On the other hand, SMMU has the same HTTU feature, yet it is not enabled
> in the SVA CD. As a result, SMMU will not clear the PTE_RDONLY bit while
> sharing the CPU page table, resulting in unnecessary stalls.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3-sva: Enable Hardware Access and Hardware Dirty bits
      https://git.kernel.org/iommu/c/74fa4c177ad0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
