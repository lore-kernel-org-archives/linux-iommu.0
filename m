Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCE8476
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 12:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C26AAC4339C;
	Fri,  2 Jun 2023 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685709452;
	bh=HY91tQBTBM0+UjI85NT0LNfJo8kJQ1k7j32gkJ6NI/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u9I6lkHji4QuYD/HV/D0oRcKpqcmtswDlmpy6vP3hxPT8IxNKNT8rNBNgArNDdBdg
	 KdbXU/nTeb6YHPYqe2K3c053y9keEUDegnhsaqd2YRQfFFVencQRfYRwOYYrF5tVMi
	 ztHaLG7SyuP80qorjOtRz6YAWOjCd8p2Ba7O47YKmjmPz2WpirZPIi+yY1G3tVjpbj
	 l1IbQ1NlKZK6RxphSy9MiBY37MVxtpeZYUAQ76PVu0pF6puWGLcjKIyQMUSSVfxNRZ
	 deNmwHjH+ZjWwTjdLqhIiEAwWAwt5eDtYn2QCkya9xV+c5RypCPLY/LyStAStY+ldk
	 B5vZvCBgE3XxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADE26C395E5;
	Fri,  2 Jun 2023 12:37:32 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZHmoJ_TIIzruBSIY@8bytes.org>
References: <ZHmoJ_TIIzruBSIY@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZHmoJ_TIIzruBSIY@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.4-rc4
X-PR-Tracked-Commit-Id: b3fc95709c54ffbe80f16801e0a792a4d2b3d55e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bdecc26722710bad806bc583a92881a2fa51c73
Message-Id: <168570945270.3943.7507177544187327717.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jun 2023 12:37:32 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 2 Jun 2023 10:28:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bdecc26722710bad806bc583a92881a2fa51c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
