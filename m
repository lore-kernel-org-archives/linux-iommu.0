Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5F44E65F;
	Fri,  9 Oct 2026 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586832; cv=none; b=je5XzmBv2g5+2MhNRoscrKpNglVgDMDpAv6IZsivOvmAuBTvQDevRle4l/bYG+5h651ujjx3SH9JH3WjOo01X15J4mA9GPOUVgDRqdqSkTQ7FbxyyHzuVgGLFrNp54ujo7oMF+tnnSfrjZC/tQhUNUXOz1CwmSQ22owq3GPLGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586832; c=relaxed/simple;
	bh=BIQX4UGfVxF/4yu/F/hmhLPFjvTmpcoi+aabWAxuLCI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F9LKeD9pp7zUfPUhcEy6Is9qOTO8e08Kz4kBpfss6BpWwrot2KcAeimkAHy/cmGJYyWBnZCnf69wA8O2eAik3JnTQbBbCEJBaN8X9pcO16I0u7IEOw89Uo/mt5azOlsd+yMsP8KEJC6zQBFXyayeDphgGuiTs+F2a8PyvvQlGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1dtvms6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1dtvms6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09511F000FF;
	Fri,  9 Oct 2026 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791586830;
	bh=+2DMoHPvwW5z4I2erUWUY0G1s+3ugJBEkN7jNb0VVKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=i1dtvms6MmnUhPXxN3VDKGVq/Ne9dW19odTg8XTDPWAi5iUWx680SVYjZZTODy8oG
	 JYSvo2LCZzYFXrRfWG2lL/f93CWo1u3PTUd2UYqDzRtKmb0Wg3IDtEihep82VWXHeL
	 EywXhsDzNvBho5PGu033cUcTuc7srXfi0YWKCoiJOP3SmFtnDat+kxQfINRwZ9OhPm
	 qtBZ9Hlac/R0xhEE/WTKLxbmDJJOWof/TMLKqfIJ4MKKn6gX40e1ZU2zRqaimU4dU6
	 6gZ4R1VA6Wwogsq7qEvv2/djFmx9D9qxNwMPR8AX3sOdAXkE4FbG60T0/A+nbQfYh5
	 9AlkOUyyzZvZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B939263A7;
	Fri,  9 Oct 2026 23:00:30 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd dma-mapping fixes for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009110348.43841-1-m.szyprowski@samsung.com>
References: <CGME20261009110401eucas1p18f48109c4922503c4a371dee94aac268@eucas1p1.samsung.com> <20261009110348.43841-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261009110348.43841-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-10-09
X-PR-Tracked-Commit-Id: 911655ab1dfb9d526978a75df3b210132620d30a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8d4256f1081c191773de9f46e2ad8f5e8d05d30
Message-Id: <179158682933.1038063.12033543500707222782.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 23:00:29 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Peng Fan <peng.fan@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri,  9 Oct 2026 13:03:46 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-10-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8d4256f1081c191773de9f46e2ad8f5e8d05d30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
