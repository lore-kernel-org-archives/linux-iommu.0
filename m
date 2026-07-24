Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAF4908DB;
	Fri, 24 Jul 2026 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921009; cv=none; b=YOQmZ9zrEd84kydncZQDbDj165m7d8S5LxBhBhYbK7mUsDhKNeI7NAdahSrTUkEQ3Q+w/G6CmTNhUy9DutUG+eGMbqjwoJixqVqcqrR1cdAkFlCkk05c9kXC1chq2xWyzEljPnHSHfR6E2cAu/T6WF0eWQnpLbyanq9nMfrt55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921009; c=relaxed/simple;
	bh=g2nwS+FXuj5Foigu0dntsNINbPaB9h/pmnK/2MzAei4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HdgNPGk0uxfxyd4J62/fhVUrP3taqSEiasu+6+04HzkQetDYA3TcVagZbLS1cOxLLdWtzqIPfWX/i7PAmG+NsSr+SKHgEu5M7Xfit4S4sKv4fcpA3sJ4TgcGGh6KqvGohBDQL2qU5mZefC2SniQvMNW5c8nK7JWwD5HdKVW2PSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrJj7L+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrJj7L+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626491F000E9;
	Fri, 24 Jul 2026 19:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921008;
	bh=0KPEtzZwW4K9metBMPM6OrndysX7eBHXBllvo9NvyaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UrJj7L+Y3u97+JgH+vvmHXFvPXyBQwWVDZRnkGzrfgzwWulIcFg/16I7te+wirTkH
	 J3jJw/dU8c/o3OnwlguozPczFNxB2p3kRhEJKYPPoWpT3qaf6/BIMM4OO/cEQQtz9Z
	 TQRNkBsNe0puOsQoCWCJDFSBtuW0s2B88U7B2mZJXxQ7izrUo/A/b/A3eqFd+cd5kp
	 J3onHdR7C1pQKruUz+OB91szC2qM8WGCvtPhl3xeuaHkRmBEF2SB6wqgRx59ZljFVc
	 fO39m7luJYGMw5EYdJZU7lHLrqD+db1gSfy/IAGGjMuxOP4ClKO6L1j0K0+vYjjo3h
	 oA4Q6Ddv7I6/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C25380CEF6;
	Fri, 24 Jul 2026 19:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU Fixes for Linux v7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <amOSCGEa5N4lEUFM@willie-the-truck>
References: <amOSCGEa5N4lEUFM@willie-the-truck>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <amOSCGEa5N4lEUFM@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.2-rc5
X-PR-Tracked-Commit-Id: 754f8efe45f87e3a9c6871b645b2f9d46d1b407b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a93212b3d1f517859ec8f540cd8d587155edafc8
Message-Id: <178492097546.3280582.17051723743307793844.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jul 2026 19:22:55 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 24 Jul 2026 17:25:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a93212b3d1f517859ec8f540cd8d587155edafc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
