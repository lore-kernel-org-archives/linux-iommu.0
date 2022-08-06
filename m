Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B771C3E
	for <iommu@lists.linux.dev>; Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22E02C43144;
	Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659809979;
	bh=cWq9xheP+7KOe7HUe2ZItiz2GrkvlBi+Ja9/8eTJd0w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j7pDPHUyROka3EugCp+N8WdcYmwqwLKyJemxQ3K8CKIysM4hGj9CgDPScAUEj/1gD
	 yek0Q7HKjTeM2gSdPbowlOSzxt8pWQQKtbwAisQFi6zApGAyNWUh/2w8HOH964wv++
	 Jz5suuoGCqB3U1thVwqjWDxd34AzuFJa/P16dvOSDlf8G/TCb3Zp2BSkQDAlO3xLGC
	 XZLw84VL5JoX/affGiuqhb+1bxiJZ01b0fnll4BdDcCNPXHdQaL7qHnOHb5UUMd0/X
	 /jgymjwXmxOQN1guMrKKUVhqn5RHrhHZFnjLznftP8sHX1z9fHwgmYyQF4Qa74BpuX
	 SF3zVwrYKHQiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13BE2C43140;
	Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for the kernel formetly known as 5.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yu4iZzP92/f/lNEx@infradead.org>
References: <Yu4iZzP92/f/lNEx@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu4iZzP92/f/lNEx@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.20-2022-08-06
X-PR-Tracked-Commit-Id: 5c850d31880e00f063fa2a3746ba212c4bcc510f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c993e07be023acdeec8e84e2e0743c52adb5fc94
Message-Id: <165980997907.27284.2765862935033134982.pr-tracker-bot@kernel.org>
Date: Sat, 06 Aug 2022 18:19:39 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 6 Aug 2022 10:12:23 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.20-2022-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c993e07be023acdeec8e84e2e0743c52adb5fc94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
