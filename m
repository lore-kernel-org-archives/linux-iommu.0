Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A85A6F
	for <iommu@lists.linux.dev>; Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A711C433C1;
	Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662831532;
	bh=vXcG7YDzIID+VlyN2jEDEB0FovINJ6ZqRj+CEZecMWA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DE7DzarpJ8qPIMmmAvLsTj0FFU/c5uVqxdOg8ZhKIjW5zouWsghIlnD/NfTgVhy+0
	 BeOtQ87eTXAA9O7hXJBO5Wbdny1gMWHtif5IsqhyngU135WSSR8q/U7aSG3bSWLU26
	 RELAecTq+SJ0BhMUggZhsigE6okbWDHync3yrS+bq2YUY3e694b8sCUIKJJLRyQ21/
	 rEK6DAovl43foDfZQWMf8NwCVxO25+UBw8QlDNQvMvQ2CCisnYnC0ncrTmm7d3XzPd
	 vgY5A8YW9eBSr8JM1eYkJaBtrEFqM5YN/F5qHTGy7+Kdo7Bwf4/X7kxZzFjytp1TFr
	 34B6kUUmtUMZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47183C73FE7;
	Sat, 10 Sep 2022 17:38:52 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yxw1CiX1qG9msudX@infradead.org>
References: <Yxw1CiX1qG9msudX@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yxw1CiX1qG9msudX@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.0-2022-09-10
X-PR-Tracked-Commit-Id: 9fc18f6d56d5b79d527c17a8100a0965d18345cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16547b21b1c6c8e8c5546a5206ebccef3e28c92a
Message-Id: <166283153228.31692.13153209837002110738.pr-tracker-bot@kernel.org>
Date: Sat, 10 Sep 2022 17:38:52 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 10 Sep 2022 08:56:10 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.0-2022-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16547b21b1c6c8e8c5546a5206ebccef3e28c92a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
