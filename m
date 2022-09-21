Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18D4C72
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2499BC433B5;
	Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663776931;
	bh=JW+hViMKt1r6lWulLNKU+E16DgdeDjWXe+Jw1HYGLA0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mV+kd7T+f8L4bVzufECzLQEspc2/ZlGG6QwrN97Mf2hhw3BNFzv7x4YOSIMxfv3Ny
	 P6MwA08HM47fARtsoQn4Cz8PzVERl8NI2dM8bGlfIvyP6Fc5wKfTybUlAqh55Hk7WJ
	 tu4N3HEh5khtF6TCK8W2kwbrDO1irznoRHIkLlSs3ct7YRNiECqjaVq20Tw+pVVjJu
	 oGecD1w/WKu+vfaEJoOW82tbm5Oi5wkGUlmy9TTpyxTpjvITwJ0IeaJngXzxCY8CVd
	 ntWaneUTAUyPPfaoKyM7Fn72A2485OGUXadg3FzO0sq2pc/lew31ha5k7PfyUF507H
	 HaiEVXWnvYu3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05291E4D03E;
	Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <YysBOff9ZGM/EfQh@8bytes.org>
References: <YysBOff9ZGM/EfQh@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YysBOff9ZGM/EfQh@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc6
X-PR-Tracked-Commit-Id: 154897807050c1161cb2660e502fc0470d46b986
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06f7db9499937c6496d697a765ac05cdcd37f381
Message-Id: <166377693101.7162.6643161946869174835.pr-tracker-bot@kernel.org>
Date: Wed, 21 Sep 2022 16:15:31 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 21 Sep 2022 14:19:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06f7db9499937c6496d697a765ac05cdcd37f381

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
