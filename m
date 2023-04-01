Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47E2CA4
	for <iommu@lists.linux.dev>; Sat,  1 Apr 2023 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67CCDC433EF;
	Sat,  1 Apr 2023 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680367380;
	bh=bK71Tf9aGjYkLqtP+4eWub+sZl4Z+ULqWbbOI2/Z0fU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=thYDK3Tk9y9QRsz+MjV8wo0jiaBtHiHDSmkQPcG1/B0nllkS+VjCI+tAlNYyKBvmP
	 YqR4apiyT8oob4aTfWZM1HWBJd8ozvwEB6CmUXMu5i0qA5BDYhZwstcd/XyHIt71mJ
	 Q5XLU2d0QsczDVSsRyjZJA18DKxzWyvBp3ATy0gRCCMV0vD7k9IC7hFZAAazBP4jO4
	 2LC+R6qp++ZxEioXO093HLRN2s0+FlFvoKtpv1EiQcJfB6De0GsMgUwQUfmcC77JOY
	 FbcQIaLxBm4RBP6TISZNqLm4ewKGVCcNBy0ZIK3aa6IQdxrdOss/ZwDKVzsz7uXfB3
	 d/DFskkyciAug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54A94C43157;
	Sat,  1 Apr 2023 16:43:00 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZCgrfX7DoO9puGmY@8bytes.org>
References: <ZCgrfX7DoO9puGmY@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCgrfX7DoO9puGmY@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-6.3-rc4
X-PR-Tracked-Commit-Id: 16812c96550c30a8d5743167ef4e462d6fbe7472
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92367fdf3b699e97acb4d5fbf7159f5c458b2b30
Message-Id: <168036738034.24776.121645524690964319.pr-tracker-bot@kernel.org>
Date: Sat, 01 Apr 2023 16:43:00 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 1 Apr 2023 15:02:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92367fdf3b699e97acb4d5fbf7159f5c458b2b30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
