Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9519CCF5;
	Sat,  4 Oct 2025 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542062; cv=none; b=QWMtLUjF2ygdJDdUzIBaUMvlzI9+41jDgDKbxRyruVl2P4/1nqEUF9ELOlDVgF6geadO8ejbJHMMlRfmitrDCPGSMIATQGzS/F6HoX/tEZzdvfWxPjsmWc4q3xKBM8/oT1Xxry60oK+P2i1446Qoqt/DetmXbHV+5KgRvF5/Oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542062; c=relaxed/simple;
	bh=5TCXq2i81L+x//4KgPIGMbNPcg+kmmqwXrUdeYSH8dc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jbX0aamBgZcpV+QsvDr10Wr4Ki7B2h5VQEXw8K61AekDYy7RVsUonn19F3gwkSmWmXR36Pn5Cr05pYJl+j+8kwapGPnYsv36EIIXhxWhPu0hrpEQyp7v1SO/JiWmzag5s+XKenYxy0bywsiET0oaYzqZ3Kd4HS+GyEK35vYgyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nId4tBzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nId4tBzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0F5C4CEF5;
	Sat,  4 Oct 2025 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759542061;
	bh=5TCXq2i81L+x//4KgPIGMbNPcg+kmmqwXrUdeYSH8dc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nId4tBzAKQ/fNNyqV3w8kuASO2LfhsQRocR4rgQfE2gUlFydDzhgY52hk/iizm2GH
	 +KMG9s4t4O1nTcIZpccXaCFcPqh3wwnmA1XO3EtpiYBII2s1L8re3Ixp+szZSoQ4P2
	 2OlWw1CTPVpTvyDtSw26CQOffTg39SOOAbsDQ45/IU0hGwXnnx/lTUD8r5L28k9Igs
	 gclm6yf1m+J5i9ZPvRDF9zymDfU39Ipnq50FsJ/UAdRIZW/NbmrT2qldSyIVtdyY0w
	 UQMsMWNEtU1bCWcdtVaKPx3UJ40tT1jj5jL2N73quA4fUW86kQY9LCiXHLTDzsdCXj
	 QBvtsi8qnAs+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482C339D0CA0;
	Sat,  4 Oct 2025 01:40:54 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250930100818.350934-1-m.szyprowski@samsung.com>
References: <CGME20250930100920eucas1p138d1f0aef1a43aea9f9d22073469847e@eucas1p1.samsung.com> <20250930100818.350934-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250930100818.350934-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-09-30
X-PR-Tracked-Commit-Id: ef3d979b3e270b6a41b6f306bfc442253c41a4cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a498d59c469bf1cab2710ffeb34050f475de28ce
Message-Id: <175954205309.144727.1052987132075053005.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 01:40:53 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Qianfeng Rong <rongqianfeng@vivo.com>, Petr Tesarik <ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 30 Sep 2025 12:08:18 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-09-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a498d59c469bf1cab2710ffeb34050f475de28ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
