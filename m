Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B98635D;
	Fri,  8 May 2026 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260868; cv=none; b=rm3Xy9hquCfw/m+4aR6N7iftxGfYWKRJFA2ZeTOoXHx9vXSPxv3T82Jure+zq+s3w5FShk+MKgTdf1Tw7v+Ej2Qi+jhUp2bYllLo8sFKO7YXpUlFeBAyezpghQFnYdKBWF59xf9jbdyaZN1aw4iAy1BG1NwVzfsiJnaazdESndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260868; c=relaxed/simple;
	bh=ouWWBe2eeOridgyirPCrdFeeKPmMFNpj7gndlmCFpd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SEJl/zrYfMJbT8Xxg85IT8E2LGpX+B/6/g0tOee5jXU77UziTeqdWv4cpiInDOpt6LhsVaOS0+gcFLicPC9Ll8rBcyYwUkYlKSAIzjw2SfcP4fHPtpwp4SH7HkPpc+gFTNBv4lw44Mfc7IMkk8/0a5YJI0oM0HFnoxogO95h2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbI0wiQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbI0wiQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E4C2BCB0;
	Fri,  8 May 2026 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778260867;
	bh=ouWWBe2eeOridgyirPCrdFeeKPmMFNpj7gndlmCFpd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FbI0wiQYMUW6Cggw9Sgqjas/ymc+tUFm47BpOkdHuqiNt7qBkM72kXsen3NyqOr5U
	 L6cr3Mn9oYbAl2OVOeIU+se2jMY7HtSOmgvdoJZSf0/WdYQRqG/FvQLCcJtmPT/qNN
	 HTkKkjd/xLvNLTdHbTIqrWr/GVaMlK/N3LD6qb6vmyb2CKDXjpdTI+0V7e+nX7VEU2
	 GdHO/HqgjLrx9wcIBi6kpD9G56AMzaMxaohAHmaFCNzp/sDoi6aHXY4bkGfYwv4Von
	 TfSiPNfTmkRETgH4ptkoNByOHoWmVeWSNcY3VgALhdYS6dZVVaXQBeIjQI5gzuxpaq
	 xENfdxiU1AerA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 427523811979;
	Fri,  8 May 2026 17:20:17 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <hczz7n5onhjxyrwum2quka5braofmab7wstrzni7cvx36ti4c2@pddvq6ufemun>
References: <hczz7n5onhjxyrwum2quka5braofmab7wstrzni7cvx36ti4c2@pddvq6ufemun>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <hczz7n5onhjxyrwum2quka5braofmab7wstrzni7cvx36ti4c2@pddvq6ufemun>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc2
X-PR-Tracked-Commit-Id: 10161b4a791d5c4b7ea16512c1ddb133c3f8f953
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa7431eb99245e0a283d470101e44be1d2c2aeb3
Message-Id: <177826081671.771267.4388990852978511136.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 17:20:16 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 8 May 2026 08:47:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa7431eb99245e0a283d470101e44be1d2c2aeb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
