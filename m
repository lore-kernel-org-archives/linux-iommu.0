Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA03D8F
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 23:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3ED6C433D2;
	Fri, 24 Feb 2023 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677281243;
	bh=Pqa2kD1e3ty1mu/6mFhXtOA85raIOxf6WhYPqFB7Ut8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dueHWze63ngFe6BFTbNMnjoTJJTDNHWBex5H6O8GRGuZUQqFMSSMubMaJPkcMFct5
	 0Sg2/p1jpmTey23hdvW7xbX3oe1NK/5e9AqDuoHj1A0xDjQY5z2//UmsyXopdTQuER
	 efXodsPeLdu6C2FAeuHyoOxNSNDyM3rP33AKPCGZAPI6IaQb4AhRODbXFG9KGhAOlZ
	 A/Cdmjjpul7gGhh4ne8c5aJoF19lgoeyEolzPO+2uO6JUPFyB2uRdWXyA5jAgG1uyP
	 mdntLl0z58k4CTpcjjszMN6tvBGoOKYCuYaQ8xWKQRZvmCkbFR56wgquBS0P5B2OyK
	 LjbYzgm6dwcyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2F78C43151;
	Fri, 24 Feb 2023 23:27:23 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y/SGAafMEGBn4fWy@8bytes.org>
References: <Y/SGAafMEGBn4fWy@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/SGAafMEGBn4fWy@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.3
X-PR-Tracked-Commit-Id: bedd29d793da3312e1350a56245c4971a38d4453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a13de74e476532e32efb06e96acae84c634f0159
Message-Id: <167728124365.28021.16477662593673489130.pr-tracker-bot@kernel.org>
Date: Fri, 24 Feb 2023 23:27:23 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 21 Feb 2023 09:51:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a13de74e476532e32efb06e96acae84c634f0159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
