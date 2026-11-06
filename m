Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999747;
	b=jx+wqmWwXljQSH88lWuTqshkmJUV8GJBmQa044meIGaruHTszNvLPWGOX/+BNP83QIwK
	 bZ4i/R8Udm2JPDOzv9lWOLN6356pVn6B+ziMw0rZkD0dbZfeEV+ALuOMVadMNAahTP6gH
	 ByydBOI4T0ihvNgwqrmnzaxKFj8HOOiM+hqAPr/hbIlruivV27cyvKmUpdmJBpSgax+Cy
	 EhYqd5MzmRjbH825CauLRSG3gHCAN4BMxAAFMEpCPYLlH7eTy33q8aTRoHw/ASJrcZOzZ
	 /0NKVjCCmAjk8SE59og2k5llGMWrdIQ4Ls8C5h5IWNoq69ukOgaM/TPuntLAMCAixFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999747;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=nWT6ZUO9wUtfHcoWhUDO6qGQis13sphlLAQpDV25df8=;
	b=QFxvy0S5w87jFGFYf4Jpw5uMUBWNe+m6iWyVwxlWyBif98csYlYvgfdMR8L9nlFgyUK9
	 r5Cnfs2QnekV9fJn5eKgwiHTEI5BpbrngBaUtK639CwWUP1iW12LBkULSHobgb6mBI5XF
	 2YxYLQwZKSGWPR4V0TDbtsvrDZI15mq1spVzXQKfob0s4biZuihUpS7Nxa4nvZ6+ekDUo
	 0qKvTFGwLKTi9Jdm+6F4O9rCBZ8IIakBZHgAkbAjQMceFV/72AAcJQ0GwvJMHPsIAGTu8
	 B3B4el46XDxMA1vfg/YOoAIeXoknnAWuC79fq0wjJ+qJXBj96fX3MCv5jnbOS1RF7Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu0gEKg4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831A606A326;
	Fri,  6 Nov 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lu0gEKg4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EB31F008A2;
	Fri,  6 Nov 2026 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999746;
	bh=nWT6ZUO9wUtfHcoWhUDO6qGQis13sphlLAQpDV25df8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Lu0gEKg4aoN+Nn0zAZ46bgAUyqpA88NBTQyUIXlAyGtCgnoxLSbN5KoW99keq8ILe
	 e+hBb3O61nKMjhk2jblMxhNZr+TB2bAVd3ypO2LRkPrDmMtV8Og/mDvsJdZQQ4jYeM
	 leDuszaMlHNT3Irb2SLl3x3gPtZ+J72Xw46B0qMJRXp8tgPNU/GVTZiuTWHFBbWffP
	 skiFmcCqyT5tO1zbph7iDC9P6cYsZBT0EySor33mQhXQttIu9p0YWsEGrWA+EtRFyw
	 i1AhFSYnzR6feK+GrduDCxqRbsZYUBXpwFKf68Hh6WQEcNwrIKK4nNrbsNlsGG0YjN
	 qFttjyCeiQ+pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2693A549A9;
	Fri,  6 Nov 2026 21:15:46 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <au32DJVMbP6j5_gq@8bytes.org>
References: <au32DJVMbP6j5_gq@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <au32DJVMbP6j5_gq@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc1
X-PR-Tracked-Commit-Id: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7963b12ca3e764e6ad3b15d1373430eb02492ee
Message-Id: <179399974515.876369.111564075775474678.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 21:15:45 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Fri, 6 Nov 2026 16:45:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7963b12ca3e764e6ad3b15d1373430eb02492ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
