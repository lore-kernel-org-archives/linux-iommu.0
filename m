Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A395666
	for <iommu@lists.linux.dev>; Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C65D2C4339C;
	Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682792420;
	bh=/HNq7GtJEFL/5yrBdd3HW2YwUCcsn8+FQOJWLEPh2O4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f/oRHPPl2tkUC+RpGzyNvbvDNXPGUy3lCvbapykIId8RrV37hZFvdhk8fZ2usAJ1U
	 K9L3uT5mrqNTeMlg7iS5Fp4QhvWjdah6PXq3kf4ErCJI6OpjXF+QVWk9Wv0PSjjIoc
	 2PbnpXqPCScC4Z1N2lPi2cCa8p3UZcbwzDo1ACKEfMUflMlvb8bHTN538UsLQ4YLe9
	 UfE2czvpBihuGkArrUlsyJPLTXLBTcAcJg6iPHX8RQTqGgSDqmOUIYtVg+QmsAFw5I
	 nUU01HdY6oHTWjA7NFSys8MlTpAqGzwrDhzBmz8AlIekqpRR86X/HzRjMaI2Rmkp0l
	 ocz1vegypK2UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD5D7C43158;
	Sat, 29 Apr 2023 18:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZEtjUWcp6qm4l+zl@infradead.org>
References: <ZEtjUWcp6qm4l+zl@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEtjUWcp6qm4l+zl@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.4-2023-04-28
X-PR-Tracked-Commit-Id: ec274aff21b6a94c7973384ca80a503c1bc3b173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b28e6315a0b42b39351d1953c1c4b54f80855857
Message-Id: <168279242070.22076.12388422174123596835.pr-tracker-bot@kernel.org>
Date: Sat, 29 Apr 2023 18:20:20 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 28 Apr 2023 08:10:25 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.4-2023-04-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b28e6315a0b42b39351d1953c1c4b54f80855857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
