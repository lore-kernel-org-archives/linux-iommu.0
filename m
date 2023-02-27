Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E079E0
	for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 18:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0861BC433EF;
	Mon, 27 Feb 2023 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677521891;
	bh=QiQzYSGEYbDulghC9uA026aE6bWEsEXAa4zZo+ohEvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E3IhVg6k32sq0J+Un2fg9lf0m6o7vudDkrmKK5C3vUwH9g0FYKfosA+if3n3YZ1/t
	 niFCFs1t5iANq535xt84kLKn9DptOA6PUY6lgasTdL7W5idOy0DdpTwGW+cJxH4Z0s
	 NPD+kN8J2l1ihIyz4S4MGgXid7S0Z8Mq5TVE78DwaaV0cFwb2eWda8YNPL3c/L79kQ
	 TFk+tuYODZbSc3h1uf2ywD9sNUwfDb0EfV2KlNxfc5x2kk87hRAv7zyq8utVTkCPfL
	 hlis56vpfuEjXcpbZns8SAn0U/fsrv4idmTe92FWZuJGhdDmE3gTttYFncd+GcMiv/
	 odlRTKF2Lq96w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC5CEE1CF31;
	Mon, 27 Feb 2023 18:18:10 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y/yz1im8klkg0J84@infradead.org>
References: <Y/yz1im8klkg0J84@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y/yz1im8klkg0J84@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2022-02-27
X-PR-Tracked-Commit-Id: 9b07d27d0fbb7f7441aa986859a0f53ec93a0335
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ffb575bebb983b982240372ecf976188451dd1c
Message-Id: <167752189096.27343.9543390132973660152.pr-tracker-bot@kernel.org>
Date: Mon, 27 Feb 2023 18:18:10 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 27 Feb 2023 06:44:54 -0700:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2022-02-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ffb575bebb983b982240372ecf976188451dd1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
