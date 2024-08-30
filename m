Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C781BD4F4;
	Fri, 30 Aug 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043056; cv=none; b=aWsHgGgr/KX6fYtRSU8BNw6RN9UkYIWcLH8+Wxxv63Z2g5mL8RDtybu9I9FtHiaSK5YQ+elj/ZAhJQANKEl9ETBxt0NCpNvUJp74O9FHJN+uObd7DqtqIJ3H6RVQo27gnmVtvUluMdInjLE0WypD+j/Al8fb+/6/LEkUCDD3PqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043056; c=relaxed/simple;
	bh=ePB8Qt0OCQ8Gk1gBNwvJr2eIs+gqTsvJSmWunPBsrAM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PNISgKFGTSATNmmeNNLt0UmxCoBO+hSCrPfJsUU0QXEWLo+9GHCtRDOUYC5PkLmiMn3VVR0/8z13aFaJMyBEssBR9yBRAumnnjWfLFhucq7zlpdnduJAOMphASq7zB9CUdLIyTexzPJrusoll7NkEYhJCvfdKV4/Bsyh9GAmo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZWRSYdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZWRSYdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935AFC4CEC2;
	Fri, 30 Aug 2024 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043055;
	bh=ePB8Qt0OCQ8Gk1gBNwvJr2eIs+gqTsvJSmWunPBsrAM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LZWRSYdOgTmx6rJbL8h7fN2gifwcp3cpSNU0Gr1gJ//POU9jZLt8sZYLqJ8TFmnFU
	 eoUUL36z/RJGU6SKJybK/4T5pqtLz1vB1tKUOyFKfay+rwmY/0nu40j0YdxJQxXQEq
	 nch0v0Tyst9abUl8BQuCX1QiOxiqK1Bzo4t8YRwvAq79I2ztIRbI++E1HTjrsjZWo7
	 yh/iZGMS4qfgPAuJq/v+VEToIbD7RtpcaQ3RdwmDnGEMvFwmZhwgrzNmBmHJte1l6r
	 0iJ2t4K7h21Tp6GLUol5SpcdxbiHWPrQdwej7kVZ09WL+UZ71xnRHMJAP156zIcn/J
	 km45UerjY+mTQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47EDD3809A80;
	Fri, 30 Aug 2024 18:37:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtG_sa5UUrAoYkKd@8bytes.org>
References: <ZtG_sa5UUrAoYkKd@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZtG_sa5UUrAoYkKd@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc5
X-PR-Tracked-Commit-Id: 51eeef9a482bcb00f6f75eda4de9bd013092b76f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13c6bba601ac2928e330e14e178c7ebfabb19392
Message-Id: <172504305728.2681732.3675397160922444038.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:37 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 30 Aug 2024 14:48:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13c6bba601ac2928e330e14e178c7ebfabb19392

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
