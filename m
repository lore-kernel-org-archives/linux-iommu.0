Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C011C2D
	for <iommu@lists.linux.dev>; Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82743C43145;
	Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659809978;
	bh=8BpY/QQLQbdPv0gkRb0Z+RxdTvnAGx2By5cH68aKaXo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O9orUsnD8+fOE6AaKvpIDjecexC/bLaU6qgILDeJWRFqgOQwAvFyXmEM7OpxYFBpF
	 rNYqevZMyqs9c257yn2MYZVrGDRHsJHO7P4gp7CiUXLlA6EZlnCJABMW+GDPmC/Up4
	 buaFfQbIaJySk973GodX+u5EOZHxn+ykjKvSg72CD+5YjEyauFNluyq8TxqT+DQy9w
	 y1JGnbSWYRQcd/3Cep2jM1dZQf1TcbTyTU41aHzrEGExWcGZM1cD2p4dpeLFWc7Khi
	 CJx7JVydUjcuKk4T3oce7ZidDXY2cnLm4uamuud+I7O0H8yiaPy7CSPPCf2P6ETULT
	 b1WrE9EbAl4Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 719CEC43143;
	Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <YuzlAT7RW1U36+ap@8bytes.org>
References: <YuzlAT7RW1U36+ap@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuzlAT7RW1U36+ap@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.20-or-v6.0
X-PR-Tracked-Commit-Id: c10100a416c16b598bf5155e759307b34dac0d7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d239c1eb873c7d6c6cbc80d68330c939fd86136
Message-Id: <165980997846.27284.3824257141690673878.pr-tracker-bot@kernel.org>
Date: Sat, 06 Aug 2022 18:19:38 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 5 Aug 2022 11:38:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.20-or-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d239c1eb873c7d6c6cbc80d68330c939fd86136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
