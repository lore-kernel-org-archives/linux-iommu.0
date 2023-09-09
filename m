Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87367460
	for <iommu@lists.linux.dev>; Sat,  9 Sep 2023 18:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F223C433C8;
	Sat,  9 Sep 2023 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694285625;
	bh=PtyEBnBLcTmBKI6CQDuhWfJGvDYdeg7kTLGUQXuhuAc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jn9HZ9Y/ZcGNZRpAODspAvtlP3l2XVdwVdzAnhTvo5kVA+UMr59MOBiynQCP9f3g8
	 C0qBaW6vGPCH1zP0Dt8atxw1JlDPopwbnU3C/YDQyKzevUccpQcxtNAT4oT2TzbMKr
	 lYEqCi+tMOM1rGPQq2XslLYdtLHFmb+jE3kuRYSfsGs9ltEa3v9l1XjbpUsZhguqgu
	 MNfvwg5f6/+/f2BKkrQxyBj2bZB9gCWTQHWHTV92wPRe1dr6BP6F7x3becH2BNMSWc
	 mvlyYoqwcOo10Vd5hb6sW7HevKIGlCcwSA5tk6usN0ocqFZ2bs9ugErhnhUFqHu6KF
	 EEfs24D9aKkOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E756E505B7;
	Sat,  9 Sep 2023 18:53:45 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZPwxAWSXvmJNgj0X@infradead.org>
References: <ZPwxAWSXvmJNgj0X@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZPwxAWSXvmJNgj0X@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-09
X-PR-Tracked-Commit-Id: f875db4f20f4ec2e4fa3b3be0e5081976e0b5dad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 474197a4f7921a97aa1aabc6f759823a024ff25f
Message-Id: <169428562538.13340.9813278453236449776.pr-tracker-bot@kernel.org>
Date: Sat, 09 Sep 2023 18:53:45 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 9 Sep 2023 05:46:57 -0300:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/474197a4f7921a97aa1aabc6f759823a024ff25f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
