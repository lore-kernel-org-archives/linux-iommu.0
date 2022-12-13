Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE1748C
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 18:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E89BCC433D2;
	Tue, 13 Dec 2022 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670955223;
	bh=NjSuw5djg2TT4zm3Gy7G9QB9Wo7L0B7UuQ6DG1fNZ2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NAk8S4JwdHKuiKjCRodmhHu1Rk4UJ/t2zr9TZDRPdFOfhqjnwJIJE74ftcWHCwsgZ
	 u/uHPXz/FQXt6F78eiSC6ecJSu9JIkKErbj92ESfvWmxNMRpiw18drNW5eSUhjF+1L
	 o6R5VsHhK5S/ThUvpB2aWMDdIjH0iib+wQ13b9/5ZwdmRhtO2NtsGC45Yz5UDmzw1k
	 zQt5LbAvOKsP8QzGnhWpOyOomwTlZyxE0om8UThJ6zleehrl48MAGbHVs5Jon4/2hR
	 tqUpjYageEJdACjH89pAbxqNTIemkbTxX7T9gIMFo1uClk1DFqJsfkHpOqEXZzFl6N
	 A9g2wla6nyGbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6363C00445;
	Tue, 13 Dec 2022 18:13:43 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y5ire5HIAi/kc3cg@infradead.org>
References: <Y5ire5HIAi/kc3cg@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5ire5HIAi/kc3cg@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.2-2022-12-13
X-PR-Tracked-Commit-Id: ffcb754584603adf7039d7972564fbf6febdc542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e529d3507a93d3c9528580081bbaf931a50de154
Message-Id: <167095522387.23919.14232615760653811121.pr-tracker-bot@kernel.org>
Date: Tue, 13 Dec 2022 18:13:43 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 13 Dec 2022 17:42:35 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.2-2022-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e529d3507a93d3c9528580081bbaf931a50de154

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
