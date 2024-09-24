Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8113AD20;
	Tue, 24 Sep 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206569; cv=none; b=CwLRanhIr997txKFehkXmXDVuoRKZhHlChicP9Bf8u3dZOgTxzWoNcC3gJhT8voNaye5GnA3NF0s2wJluAyxaC2/WTjDIAwK8WcwcSQkr2R7FQc26snHzkZ9whfAnnK6Ip30XQZ2/PYoQwvt8mwEwjI0tmbvvWMnDaV8xy15GH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206569; c=relaxed/simple;
	bh=gV8QLoKksSY/l8RktoL1oDtw8YZXJ/mLS4+L/bntyFo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RG/l2BnOHQlsoVNAVoDhYWBUs7r6EpPMff7uXp5xBzW+WyW6B7fHzFBpRKeuv+9FZohjiYwDGPAPnbZmLyfeZazUgFTEkcts4Y0gCeS1nXnnYXdBNEz4QwC+yteBVCq4jYi4JLgd53OwCimd/nH6y61OZN6bq8Msb3QG9HeHSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9Hz2A2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9Hz2A2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F8C4CECD;
	Tue, 24 Sep 2024 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727206568;
	bh=gV8QLoKksSY/l8RktoL1oDtw8YZXJ/mLS4+L/bntyFo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q9Hz2A2sKuqc9W/wWk9UeMcxz1CHseGaffLrEoXqOxeyqRvUzYy+iHBOylR689cKN
	 MMSQ82ezg1L3A1Vzlgi4UtyG2jNkjykvD3sCqMZ2jJH1KREudVbezWVNBkg1rA7zGT
	 +G085ObGt0cdd+sEKGmICJ024F4DcJaLtsdB7Zup6cvTbZbHPj42c3nAKAc6G+i4gw
	 mVmimob5ZfC9GJnEji/9hZ/wfUZD722FiURDKheSS7FN9i/DBTs7tJPezofgtgH3/f
	 fWJw//3wMHsAd3L5TgJ5KBXX3/Ayy7oQIwQ16M1lRw39Um3BkIgQ5HsyIm3qrryT7N
	 GGIxRuogLBFEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E203806656;
	Tue, 24 Sep 2024 19:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvJbcRLlblu7s2kd@infradead.org>
References: <ZvJbcRLlblu7s2kd@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZvJbcRLlblu7s2kd@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-24
X-PR-Tracked-Commit-Id: b348b6d17fd1d5d89b86db602f02bea54a754bd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4491b85480c8ca2d85b2a06262828ec1af5c00ba
Message-Id: <172720657110.4172315.5286764629604181268.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 19:36:11 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 24 Sep 2024 08:25:53 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4491b85480c8ca2d85b2a06262828ec1af5c00ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
