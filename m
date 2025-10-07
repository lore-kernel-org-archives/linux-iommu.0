Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C571A8401;
	Tue,  7 Oct 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867602; cv=none; b=pmav+OwJRLfZqe2+A+Q3m933Qi65x5/G1uHmmDrNcV7KB3Pt8rEsP3OcHN+s99+HcAV38RlrIHNS2S6s5DSveybLs92asSS13+CYvx7hhtPgywF3apUwaoM+LopCBX/fPKNRRD1HO8ydathSsowd5HmXInE3F+r7NP9L6iuF49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867602; c=relaxed/simple;
	bh=1CYwRcEryBLpfA09ZOYRlZD+HbTnLHhJvvhi5dGnYwI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ne8ffjpMecuvn/w9wDx5/dPoHOx4AcHcvK+XAJ9bwBwqleu3tSgX3PBol3LADGRRsHBtidxCwTQkJwLRG70W5gpIseAGOdFTeA7ZdzZquESTdFXtFSoOwQjFzhKWl8rt+IkMtkmm8nnmhCx2WQc7aUrgtF/Ri77TwtFi6tpRYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcprDpQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcprDpQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69662C4CEF1;
	Tue,  7 Oct 2025 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759867602;
	bh=1CYwRcEryBLpfA09ZOYRlZD+HbTnLHhJvvhi5dGnYwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KcprDpQIHYMDA3+32f4hmDQtxl4Cb3GJgc7/sNsYQyigpVOInDcBXasZIiu5/oIne
	 dniqCRdWVVdrhGQTamYn126Zekntl0f5UcbQKLo+5/ddhsenO+U+rUGaCW1zepr6I9
	 fVCrTWv/AoekrcEtcMXlA1OdESXxmF8vj8SeI/alLh8V7qAr5C8qcClDapgdpqwjWe
	 YkLf4JyATYXUXoC/efAlkZ6CYZcLUc4n1VT58zxhG//8NNIQ85tu4q5jCbIFN03EpO
	 g+avhPAvXh3WLHbxapBugvApdqyEE6gQDqclGCzogGnw7wLj7rRVGrtTDIBtc9B+M/
	 0s9Avg2+GECxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE05B39FEB75;
	Tue,  7 Oct 2025 20:06:32 +0000 (UTC)
Subject: Re: [GIT PULL] more dma-mapping updates for Linux 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251007144545.2208636-1-m.szyprowski@samsung.com>
References: <CGME20251007144600eucas1p245415d2578628bca535155cf94679cc6@eucas1p2.samsung.com> <20251007144545.2208636-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251007144545.2208636-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-10-07
X-PR-Tracked-Commit-Id: 16abbabc004bedeeaa702e11913da9d4fa70e63a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16d1ba7c9675ee16e0f7fb22d51cd2898aab625d
Message-Id: <175986759137.2764520.4603940413810606444.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 20:06:31 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Petr Tesarik <ptesarik@suse.com>, Shigeru Yoshida <syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue,  7 Oct 2025 16:45:45 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16d1ba7c9675ee16e0f7fb22d51cd2898aab625d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
