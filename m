Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0E2E36ED;
	Fri,  4 Jul 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650568; cv=none; b=jeZ1wb8P1JvUQ1WUwh1jQ1TKor5xNAkyI4eRvUEbGSCnGLfvgTSL87s9xHWm+l86o1dxSW6RcKgl26R8PIefPupWxZvZJoZ+dWUFx86ysitTJbwCogj/4J/XfGE+oooD2oKBmcfTSMa6VU7UFmcb9DysHUlOKW1aE/bCsCA5uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650568; c=relaxed/simple;
	bh=vuytvSfcCyGFAFENL5yEHpjFxBx/BXS4PYNVz1zTiYo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tUnaefoaXbFcWSgbfCKlnHqs9nXIpN1ve4ajMAy7ZP38Dot2w6kUcIPd/Mbxco3kyqGi6JDuMNhL+D8uGlzAaeY1Gv6WWkkqEVM3wQzhgulkwBFNA9Dn0ZIAnw3J2FI92qRfuOK+nDl3MITEhpKpVyWLekUxt17Vomd4os+lPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNHA0cKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNHA0cKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19CBC4CEE3;
	Fri,  4 Jul 2025 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751650568;
	bh=vuytvSfcCyGFAFENL5yEHpjFxBx/BXS4PYNVz1zTiYo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sNHA0cKnRSG2370T8+bOOISCDylQdF9AXgzCwip1V03UG0ZGaXRmGreSpm29hJS0q
	 vPsHVmERf1UJ6HCW8cNcRhDyAXsH8+FO5tMWigHEOIJvNagdjaG6f6tkLRrqAYB36a
	 eRLs1PFtF+2lxBcCCmhPV6WLPlik0KzOzmw7QAfGLUWqVbPjvRuujb29vyvqFk26C8
	 5mMDYV2dNjXjqq9R/Xk/JStCt9lkiJvb42nHjBnUYM+JfHIOlP6yufSMw8EqMi4X+T
	 RT9gPsVY1I1shwOEvGupaTN9n+MKlw9MR79eB+vPc0+oICpzsT0urRfXCZatT6MfVX
	 l6b3jvqYWABlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2CC2E383BA01;
	Fri,  4 Jul 2025 17:36:33 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aGfji8aafXu3hTQl@8bytes.org>
References: <aGfji8aafXu3hTQl@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <aGfji8aafXu3hTQl@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc4
X-PR-Tracked-Commit-Id: 25b1b75bbaf96331750fb01302825069657b2ff8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 923d401238c590f39833a2015f6f9493f146d98f
Message-Id: <175165059177.2287194.9983918768670209599.pr-tracker-bot@kernel.org>
Date: Fri, 04 Jul 2025 17:36:31 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 4 Jul 2025 16:22:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/923d401238c590f39833a2015f6f9493f146d98f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
