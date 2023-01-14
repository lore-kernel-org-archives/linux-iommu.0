Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFED7C
	for <iommu@lists.linux.dev>; Sat, 14 Jan 2023 16:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25766C433EF;
	Sat, 14 Jan 2023 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673715521;
	bh=ys0fWZz1eoacTuHBDBBahYVuGFjQpnMyP6+JdJPTsNI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UB0iqWEyVMCkwaVjJtN25D+6uofgivMryT1XrOHBWDMW4Ra95KLN78++usi78o5Hj
	 9m5oiI215KsMPW7nQNoJlRsjKdQilyaPrQUjQdEFAIiYmnasi9IIwccwGFywHVNBoe
	 zUB7I25C0YOOSEQkgZG+eHrHtqZvnJ1wiwPk/6br2vAQ+50F3WbgPkOnZLO3mdumL6
	 LTdtMiexhFcg4WoqSPEB44V/VPR6Uyq+UGm90/a0DuN9mjpOw4BzJmPmENWo5nkylr
	 akk44EMAbpeX19HXFFitaW7kAmeAVZ8OxZX34xY9D256Kj1jE10M75se0gxVwN//K7
	 2+DhkTavN5T8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 042DEC395CA;
	Sat, 14 Jan 2023 16:58:40 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y8LYARivqaRbWWja@8bytes.org>
References: <Y8LYARivqaRbWWja@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y8LYARivqaRbWWja@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.2-rc3
X-PR-Tracked-Commit-Id: 142e821f68cf5da79ce722cb9c1323afae30e185
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c698440524117dca7534592db0e7f465ae4d0bb
Message-Id: <167371552086.22078.6666131430289552808.pr-tracker-bot@kernel.org>
Date: Sat, 14 Jan 2023 16:58:40 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 14 Jan 2023 17:27:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c698440524117dca7534592db0e7f465ae4d0bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
