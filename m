Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0833471D;
	Fri, 29 Aug 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485571; cv=none; b=rbpNsUd3jCviiwIoBXD9GnpLjoorbKJ+y8rJvB7r0bfji7KkY/uEvKpPPSkt16gmpwE1et2NGk431JTWI9JoPh18/hc7LmSjo2zSBkauCFxhabwayZwsMUBVyQgjnhZ//Y+KJsLGTA6nFVKUOGtP686t3XOv0qlCsJ8CkLtgJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485571; c=relaxed/simple;
	bh=khCtrHCeog1EefSFgvvP48JWRB70p8paq+xILsiNUhc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W2XDP911rr5Tgupi6HFyW0/+6Zb6+JFjtTFvGz3II5nFFognNkZGlzMl3THqBUK8/hALysRq/g2ALhpqSUc7KsvedF62QUx3t5qEhDcS8GbXV6g6xtgdc2P17xZ1dNUXpvzSYqhfsr+n0pmO5MoC8x0IHd7nHbdgobuAA6IwBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqmIlzb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqmIlzb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2346C4CEF0;
	Fri, 29 Aug 2025 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485571;
	bh=khCtrHCeog1EefSFgvvP48JWRB70p8paq+xILsiNUhc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rqmIlzb2lRgtPgsEp7qENbL5Lp45hlDufcOW21DkaBui/7mjWUxUwlG4xmpaGwYef
	 KWh8TnNc1mDY6JkW9q+EfWz9IglfR+TsLnte47AGzLuaVmV6/QXgVz+/0W6OogdHYv
	 0sxugdnfSYGhxkQ14BpimrjQpAy1LCfFvFx/AqpoOJtxBvCl362uSSfdLIUfie3SHU
	 KrAuwcMEcVpw2ZAROe3pS20CMI/JsokDVFVCOkWLaaXJ71CZMgp197lRoMCSgiyqk8
	 uTNxgwI7wZUiNLtN5Qtiwa5lIX0chZ/vR9PVXj/n3ikwZNj4FdTeobFZLPsgpKandQ
	 9wmTnWfBfDf2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1D383BF75;
	Fri, 29 Aug 2025 16:39:39 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250828091132.860125-1-m.szyprowski@samsung.com>
References: <CGME20250828091145eucas1p2293261860e89a33ae54ce1c908ef8619@eucas1p2.samsung.com> <20250828091132.860125-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250828091132.860125-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-08-28
X-PR-Tracked-Commit-Id: 89a2d212bdb4bc29bed8e7077abe054b801137ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d28e280981337360b20ac9812bf0eab9224d5a3
Message-Id: <175648557838.2275621.17178159374986489157.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:38 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 28 Aug 2025 11:11:32 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d28e280981337360b20ac9812bf0eab9224d5a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
