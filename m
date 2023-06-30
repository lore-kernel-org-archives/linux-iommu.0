Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E331FA5
	for <iommu@lists.linux.dev>; Fri, 30 Jun 2023 04:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE7FBC433CA;
	Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688098610;
	bh=sLOtTqIL8YaZM9HWK9J7PHvWjUIOhhEZCGjeRErYQPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L02Nab3/QQgmjnlV9+xJaxbqbMsZQBkMCfxqwEB3uxtjZjm9d8sclPLUpR9RyTgOc
	 IaYwUV98RMmhZQQmBd6zg/T0aG4ocT9LppdsVb0+AiZtbQPEHpvj6eyqf89zb3+NWF
	 AV2yyQJ0XZ/o7rhVak5DO+68r/NOes4NytxUPALMBmy5jFK+IEO7ZX0WGHqE+2m8XW
	 XgQWumb1tPnJanS4KC2PG10KHVrALWLygy5v9SE2prKH9A3w6ptz8cWiBZPKCanpLf
	 eFF3vDsRmryNTpJgc4VreMZ2zpsRmyk5buLJMMw19u+TQwf9Y+qnYc8LHHmdxVruO9
	 HLCqnjLe3J4gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD26FC561EE;
	Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZJwdrJTHn8gaI5Zb@infradead.org>
References: <ZJwdrJTHn8gaI5Zb@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZJwdrJTHn8gaI5Zb@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-06-28
X-PR-Tracked-Commit-Id: 0a2f6372a43ff5e948b8b10be34d4473f6c2ef6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e6d5dea34325df8dc204575cd0726cd5f2b864f
Message-Id: <168809860990.23778.13683786882941932267.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jun 2023 04:16:49 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 28 Jun 2023 13:46:52 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e6d5dea34325df8dc204575cd0726cd5f2b864f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
