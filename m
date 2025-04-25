Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB14437C;
	Fri, 25 Apr 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604070; cv=none; b=tl9hUwA9WXzSLa7EBQEUJj0kj7bW/BDiiHh0z7iHEy6SHp3I74c9W1JLUSgwWS1xx9tnCIWHozRwFCcjAeovzaw+XCw6543YvtukNWvd0uyCMuUd1VDnt8F8RknLM2/gNzYmAzuGIQqaCzKEKGOrAoDU9apU7HM7rRkKQkEnzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604070; c=relaxed/simple;
	bh=wQc9cfCd8qwDgCKZRNtTL9ChHDFnIJebEMmgBs6gDmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TDglDRMaSbfPO7xd/eTRvHe3ud7hHbc5doMngqqI0QIO0WCobj2z7aT/bPIvKq5r/NLmJf/KLQUQpFL9UFkE5frRBbLIb1S1LNTz6r55Tz+nNG9jMIYr3TZggcLoGDjzL7IfmT+QvAfrcm4gI7iMwaGX9ozxqEghbr5JzWmSOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjcSGe6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjcSGe6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C78C4CEEA;
	Fri, 25 Apr 2025 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604070;
	bh=wQc9cfCd8qwDgCKZRNtTL9ChHDFnIJebEMmgBs6gDmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jjcSGe6K2J0/EvxcmaL3IMFUjBTRrS9NvgLZ+5L1C68eihW+tI7uv4Ip/Ea+iDfC7
	 aM/sMPTr8hJBwYODg8YL7d1GCHMIrulZUkANeRy4mcUedQyfLbqTtgtzCUFlchkHGr
	 YAnKEHidIyz9ZnuU9I505pt1ZOMIn8TCvSIhDIdM0nwd0dRwK4vLIURsAHnnVh4cRe
	 jQiXSic0sexxVtVzqJ6VluqwWhJDPRSw+8LEj4yRBvssILpXj2UBGkhvPjx678v7nw
	 IbNsysH9wS/YffLNlTAVOUvmulyd539r/t3KnET6fz5KFsJyV7iZ2zPG3LBYN5eAMa
	 YJJRAeXWk7UBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3E380CFD7;
	Fri, 25 Apr 2025 18:01:49 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250425112939.501985-1-m.szyprowski@samsung.com>
References: <CGME20250425112957eucas1p110e8b84689ce013eb26967a47681ee75@eucas1p1.samsung.com> <20250425112939.501985-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250425112939.501985-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.15-2025-04-25
X-PR-Tracked-Commit-Id: 89461db349cc00816c01d55507d511466b3b7151
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 882cd652882a724a128d566af724a9d9470a9e43
Message-Id: <174560410839.3790119.15670186569680649944.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 18:01:48 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 25 Apr 2025 13:29:39 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.15-2025-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/882cd652882a724a128d566af724a9d9470a9e43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
