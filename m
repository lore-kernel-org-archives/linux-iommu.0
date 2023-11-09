Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0338DEC
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+qYJQdl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFF4AC433C8;
	Thu,  9 Nov 2023 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699566523;
	bh=nSgX0L/aawAWLwrD2jqlQfUSo2zBLd0v+KjU+CVpnHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f+qYJQdlK7lubmm6B1hcZ7JB++s3szZChlsdMT1aIahez8+EUiZjrjV8Lhs2klosX
	 2N0DuQTZZTXzuk31q6+Pzf5Stj9xGajc2KkKvUQp/+Mpq91MbUsSLobQm4LHZ4q2qk
	 5AQTXYO9VEhh9ed73rCqnwMbOuigrA9pRK7CTuAoctM81sAMqimCE5AXf4q3cgEgzZ
	 BBWmJcH32VmAAvW3+bl6Rf3z000bmJ/QVLkOwI2kILSK09sVWwo9MRNEmXZ+rNSIeP
	 1TNcAgpMcXjoaP0FlOOk5SG4zCzuehHONUKJ9jZOJemrnVGLJ7NBmhkbDem2ojKcyk
	 d6cZc0L+dDITw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF718C43158;
	Thu,  9 Nov 2023 21:48:43 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZUkXojmVf2CmkXHh@8bytes.org>
References: <ZUkXojmVf2CmkXHh@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZUkXojmVf2CmkXHh@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.7
X-PR-Tracked-Commit-Id: e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bbdb725a36b0d235f3b832bd0c1e885f0442d9f
Message-Id: <169956652371.24420.8103405540077152180.pr-tracker-bot@kernel.org>
Date: Thu, 09 Nov 2023 21:48:43 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 6 Nov 2023 17:43:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bbdb725a36b0d235f3b832bd0c1e885f0442d9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
