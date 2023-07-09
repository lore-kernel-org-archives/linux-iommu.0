Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DFC8F9
	for <iommu@lists.linux.dev>; Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CC6FC433CA;
	Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688924795;
	bh=oA9ahBY1MQJgkvVoHm5KboW3jKAdO3eM5t2kJMSM/lo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a96PdzVqwyDfvm4OET0WzFAj1sOh7z8C1xfPyw3sX536aZRtdca3umBBt7Ep9eGsF
	 PRSIO6XBBWJ4lkYNW7I/bd2WNM9GQvH0p9ceIJ2pqlWR7d5af8d6obaPjs7n6RpcY2
	 iHWe2O2peVZGMhOiVLHhHx8BL64001AY9jvKYgCDz7jKauNDM5GaOsy0Nrw02dWyCt
	 EwRfJ3AFTAdMPSlPaiqiu8kJuisrABtPsvktOkpVcISiTY31ViH88sGBGw1qW6jlqi
	 SmfQkOKfu4LNPIy0+1p7Z08z/GCtVY2iu6SfZ0oegyEp9yhEsaLeEZ13K/RvbxVxbu
	 tLL1D+RkS+2iQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ABB5E537FC;
	Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZKroEFssSwC0Lnn8@infradead.org>
References: <ZKroEFssSwC0Lnn8@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKroEFssSwC0Lnn8@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-07-09
X-PR-Tracked-Commit-Id: 8ac04063354a01a484d2e55d20ed1958aa0d3392
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f71f64210d698f603ab119740d1656f7bdfd3171
Message-Id: <168892479510.9789.6171708898049821666.pr-tracker-bot@kernel.org>
Date: Sun, 09 Jul 2023 17:46:35 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 9 Jul 2023 19:02:08 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-07-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f71f64210d698f603ab119740d1656f7bdfd3171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
