Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDAD34B438;
	Tue, 23 Dec 2025 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519016; cv=none; b=YhQHFPgkzoT8pc9jxencG48CUfzdJaPQYTjfwjRmnVV0MA8Xcae9s/FGWT0IUG6dyOya1UZJcCfqtWNeSUzrm45X7E/Ux3BScBHqvhoKsSg2SxN2PcrSGFEmAnv4bW4aDEQzD9ZLwYMf1B5Ghy4AzOj0az8yDdB6SADo1iZVesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519016; c=relaxed/simple;
	bh=0DO04P02bi9HHERX/8Zhc4LFYWkrVx21he9rwsb+pkE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a0KRSxOfSiWe5GWgAtR1C0eNrIOD/qO04uCZhIxkNoMTUCaZS/f1ier+DeUx7kq1zNLYpr0qn515OLebWAMQ3E9VhuPFW4kPaJAMX9cPAlv/Kqf+K5+8zvAmL+w/AAxD8gWcxFAsx3/OLH6QpRpInjJ+bbZxB1sKLPWDuHByGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhCDvBzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhCDvBzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB88FC116B1;
	Tue, 23 Dec 2025 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766519015;
	bh=0DO04P02bi9HHERX/8Zhc4LFYWkrVx21he9rwsb+pkE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LhCDvBziXeFDdGK1SoJQu1qtLYrpN1K8gtvJeNgxhGNbGx93Z44uHjopHQ9LZHScK
	 oiBYmO/tSxpN685e1pPg7BMGKz7VyRuk5ZWYYuJH/NghMlZzKJ0M2b1GN6SujFYaje
	 BpFerRSipp1WBcqblZmIMDBIoMt/m6wQq7HkcmhDi5w3lefCgTXuZ+PCDsWDJ4OT7s
	 gLfISjVQq17WbHMKx9rvGvrrB3zfYRtVDfhrsYsaXMNAUvoffqNAsOuioWYI523KCn
	 4m/FBuAHULtHwGmT0qinL/v2CWHeUfmQ4iB92GSduNF1G01YqzzBj1FxWYU772mRsc
	 zm4RylEoCTGpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1EEAC3811A41;
	Tue, 23 Dec 2025 19:40:23 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251222160328.2523773-1-m.szyprowski@samsung.com>
References: <CGME20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4@eucas1p1.samsung.com> <20251222160328.2523773-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251222160328.2523773-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-22
X-PR-Tracked-Commit-Id: 7f2e8e1d22f6e28edff3782535c16cfbace30902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b927546677c876e26eba308550207c2ddf812a43
Message-Id: <176651882195.1294228.634393066705031644.pr-tracker-bot@kernel.org>
Date: Tue, 23 Dec 2025 19:40:21 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 22 Dec 2025 17:03:28 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b927546677c876e26eba308550207c2ddf812a43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
