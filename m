Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB11C2339;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594067; cv=none; b=MmedUqWbGhgZ8E52EA2x60X4hUFPkcTsR3ORFiE8dAP0Pp3dCdsnJaUg3xh/sg0IHsyQJfflRNlnm2aMQes4+4yRjx9eBxJMtjING9c9yd1yygSoJvDC+QLeHCxuXaX1vwsBJ7dvhf/pO6/51caBIJjv7IEITYP/oGUgw26tKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594067; c=relaxed/simple;
	bh=Gtl2l2I2axGm22U09YZj6e5yHBt9kUn8JOWiRB86VSc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PxhWCVxUC3OKMMN/kH9t+jEWleTkHpiDGZld0dqBxQ2rd/fMU556GDZCe6pEcItqMVWDmdoYyXO0HN4yG4fpBQhsLTS02BIj5mvCST8vxebvkfNy9GTgDB+DtmD/JwkMKcqZ2yLVMVBH2IKWAHvCFXxbc7P4kFus5cGK7hMY0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsEYeRmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsEYeRmO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7A5AC32789;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594067;
	bh=Gtl2l2I2axGm22U09YZj6e5yHBt9kUn8JOWiRB86VSc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AsEYeRmOENEJ59Kufmp/JufNiTgyQ+KwLofXRAfu4Kv3qWyGtJsxKLSIprc/fgoxS
	 VajtaTcY9ry09a2/sXp0wy+zslhKo1JLt5rFFkU8d0Eo0RLMh7MxZcIm7j/piv1Zsg
	 6Af492aw2ZoBpk+12DAE/Nc9te3CdcygJgX0Zc3CCZU3K3DEemtEioabo4DlxSTN+8
	 QcY1WnVpakQikXXu5hpPqJdxOMVh4yf/lXF1SCA9uJcAsMEfEL6Wlk/s2WoihXQ1xI
	 i4OaNGEIVIgtOlZwmILL5fvopU7KiE3PkZhorQiIndwVwlGdxJXoXMakulCyOKDnYC
	 G/q+GlN3U9H4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 993B9C43335;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zn6vWO1Caf6R998K@8bytes.org>
References: <Zn6vWO1Caf6R998K@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zn6vWO1Caf6R998K@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.10-rc5
X-PR-Tracked-Commit-Id: 09aaa2d0642359fddae607b6950b2ca7bd1cf04f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2316dda071fa651c40dd322110081d489651c07
Message-Id: <171959406762.14402.15731831115635032119.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:07 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 28 Jun 2024 14:40:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2316dda071fa651c40dd322110081d489651c07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
