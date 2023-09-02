Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9877F
	for <iommu@lists.linux.dev>; Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D84C433CB;
	Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693612852;
	bh=j6368SGGCT5955CBrDnXY50NE0Ss5DNSuPNZM6Ponuo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fvxzN/Rqdomc257zsXH0g2FIi2BqWmED/r+yz83/qWW19tnlqG2EkuNXmEnnCJTVF
	 7kI1S0vCvh9aZx4OqAOQ5XiN12KANvOGqqWTUmsTK15tUbb8nKXnPtQ0RUx2E9iYul
	 4eiQEUaZvQ43PnQ3m6sqtifAuw8EA/6ekf8A1vy9H0QViGoWetIoUBPuP2wvps0Vsb
	 5OAs1xc7l0mWx9AZGC4iJqyz2boK1iXqaGzZ/H2mM6Ic0lxIE77S4Yi7V1qdaiYjWY
	 l4KLFJNvnzzhb+WbVdTSjqIrWzzNC3hgGeUJElpqdwZXAdQ2CYO1GYmZO2zSqMcmPe
	 PxAf2OhdJSiwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16557E29F3C;
	Sat,  2 Sep 2023 00:00:52 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZPHw-MSyehz1wF7c@8bytes.org>
References: <ZPHw-MSyehz1wF7c@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPHw-MSyehz1wF7c@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.6
X-PR-Tracked-Commit-Id: d8fe59f11096d6470b5f53739e49cdce67f3e127
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0468be89b3fa5b9249cee1097f1d50314950a2df
Message-Id: <169361285208.26727.10463797394902478198.pr-tracker-bot@kernel.org>
Date: Sat, 02 Sep 2023 00:00:52 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 1 Sep 2023 16:11:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0468be89b3fa5b9249cee1097f1d50314950a2df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
