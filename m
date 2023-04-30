Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160033C10
	for <iommu@lists.linux.dev>; Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E4FC433EF;
	Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682885290;
	bh=1r1D2D0Bq6g0xjD9HH4VPtVZQyARYm8kIxHx2+58W5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OThqrb2lPnh8oiFucr+ZQjkNGWZadxPuTTIZYNKk0GBgGkkP6FwBgJs2ULGGZA4gA
	 iTZdxqLNsEpP/OuXq40oekGJ8qlWmS7jQ2BnJ2o43kodde721M8soLltf79FvApksW
	 h5JAg2ukXDCKgMNq0BnQ0DbM6eKL7AsLiMmlmTdDMB8EC01yqFgmU4QzrJpMO4lLCT
	 RHee9HcDGc9e+h5BKYbwbOytX5yJ7okwEEkFojmYpdC8WdevQ278hTMxUWwzcpt7jx
	 bWpCfacAA9YEOXNWyALcbhw/1M0yKiWFEYWy4OSUfSsURxVJ70gJmAIWenyh4STWNi
	 V5e9yevT9yJhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A367BE5FFC9;
	Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git pull-test
X-PR-Tracked-Commit-Id: e51b4198396cd715b140c0e8b259680429ff0cfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
Message-Id: <168288529065.32747.7019505821134712516.pr-tracker-bot@kernel.org>
Date: Sun, 30 Apr 2023 20:08:10 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 30 Apr 2023 13:13:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git pull-test

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58390c8ce1bddb6c623f62e7ed36383e7fa5c02f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
