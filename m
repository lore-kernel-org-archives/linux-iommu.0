Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90239FC5;
	Thu, 11 Jan 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLDkw6qD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96EF3C433F1;
	Thu, 11 Jan 2024 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705013894;
	bh=ygJxQWjEMeuXcJV4A8d9hXSK+YZFPpJWCEenbu/xbvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PLDkw6qDyXOw1xzEcVO6CCY7rtTDL+P7lyycyW6LGCJYMMUhNeHgMIOtp0jjjSBJn
	 mrt2TfoxCOEMjYO33ojpXkDVjNtFzCRR83gW57kkp8AFE0eG0NJAvagCsXaeyavy6C
	 m9rPWLRFUcb4c0Ka+bk2hpDwpufhRiX1IP2ER6sidskGWLiInGGFRWJ0Vcg0S3zviB
	 2gXhswCHPUXsICC5MO084mWDFC74L5tvb8oV5f8IGtd8Rr8DqGkvEWMGKnWGHwqiXw
	 ewnukDhwavldsXU8K2EkmVQcs5qK/vLvXyNY8W+YKrWO5gOc4iUEtY69R8adO1ekQc
	 3PkMmDrIdWkfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87220DFC698;
	Thu, 11 Jan 2024 22:58:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZwbgB9MRsqR5uE4@infradead.org>
References: <ZZwbgB9MRsqR5uE4@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZZwbgB9MRsqR5uE4@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.8-2024-01-08
X-PR-Tracked-Commit-Id: b07bc2347672cc8c7293c64499f1488278c5ca3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893e2f9eac9ec8d65a5ae2d99656d5e9f7bd76e2
Message-Id: <170501389454.24643.9287367692100828537.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 22:58:14 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 8 Jan 2024 16:57:52 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.8-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893e2f9eac9ec8d65a5ae2d99656d5e9f7bd76e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
