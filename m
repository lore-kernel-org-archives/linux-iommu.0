Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBC182DE
	for <iommu@lists.linux.dev>; Sat, 30 Sep 2023 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A83B4C433C9;
	Sat, 30 Sep 2023 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696097534;
	bh=rODG9meJvQQKVZQq3SEU3TKXsowFJwEyJ6gP61XYwFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cheQi4FWKv6Gvd7ZNLn7/ad7lyo/FJ2C6BX9mgw/gf4CosD7aKbRGtPKqliWBvHNk
	 QGJTSgB/zDdIxeaSAmmiMGZaJKzuQFQ797U64TYDjx5ev1YAcg4mM8zqXpyrbt9tyN
	 GLjfUd3NvWTYYHYwUx3TkDEf0NGg6C2oNJRQmb4D7/MUy8kjZadogwP2U1thAOAdOY
	 1tbvHHYW6W560kRpFVvU3OhIgUD+PtK/OzRXloU4YnN4ihI4QyZPt6zui409qAhruX
	 pPhWB6jDjL5dkCwJrbYsrvbWJ0XoGWJ+IrYUP1c8N1BQac7oswIPFaBJ3rgmwPxO2q
	 mTcHoveuSPRNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94837C395E0;
	Sat, 30 Sep 2023 18:12:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZRhZrvxhAf78PgAt@infradead.org>
References: <ZRhZrvxhAf78PgAt@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZRhZrvxhAf78PgAt@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-30
X-PR-Tracked-Commit-Id: 2d5780bbef8dbe6375d481cbea212606a80e4453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b517966c5616ac011081153482a5ba0e91b17ff
Message-Id: <169609753459.20440.4990827339784432932.pr-tracker-bot@kernel.org>
Date: Sat, 30 Sep 2023 18:12:14 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 30 Sep 2023 19:23:58 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b517966c5616ac011081153482a5ba0e91b17ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
