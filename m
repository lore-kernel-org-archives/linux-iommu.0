Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7AA49D
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65691C433D2;
	Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671826113;
	bh=5rCuwx60PAGyYzejORrmURo2MBtSfJ6GDgThJgNrgqo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZSDo25rdCkc4ftQt9yOLnq/XPYGVsPZRbEDmuWKMwoGiGhPAg4qbai1d6nL/Cz1UQ
	 0xgbHaJf9FEPWO90nmC74J9nGQxf/jqVQC55lJQA9PDIJVv9WW6EohTSnigNMnlN4w
	 mXCFnES///jihlXWcMWYQXE4l/rg09VbJxSGH0XoTU4YFz6uuPz7B/VVua3E7yhO3t
	 KFJBqe6s3LI/z7TnyyLkTnc1jh4U9DDB6VQYIwumWG2MyLCCvIxb0mFdGABKC0SYYl
	 CJGDgfDx/rdJmggYuAKxbj3yYwpR6hdwuPurNBOi0n7mSLOF5Zuuc717BgOenkfkxO
	 /BGxqI9rAIJJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50885C395DF;
	Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y6W+k0hUkeRaXCTO@infradead.org>
References: <Y6W+k0hUkeRaXCTO@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6W+k0hUkeRaXCTO@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-2022-12-23
X-PR-Tracked-Commit-Id: 3622b86f49f84e52fb41fee9eb55f9290613dfc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59d2c635f6cfb0a8c7e5acb06b10c4e587fbfd1a
Message-Id: <167182611332.4135.10054718204972322093.pr-tracker-bot@kernel.org>
Date: Fri, 23 Dec 2022 20:08:33 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 23 Dec 2022 15:43:31 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-2022-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59d2c635f6cfb0a8c7e5acb06b10c4e587fbfd1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
