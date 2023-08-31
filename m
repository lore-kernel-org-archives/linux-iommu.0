Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2715A0
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 03:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1414CC433C8;
	Thu, 31 Aug 2023 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693453828;
	bh=t3EE8gZClnitP93lMZaNUDvdu2WS6qWOWyQTFfsI4qU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O3Ha+sz9dIMCNFbnTBwmLrw/KPsX0TcZNQnqc5bDVS/kADWwPOa/5YQO1lcgj6cYA
	 pZ39400zoG6EcGzycnAHKvtBRsNYBHzSmq85jLqD9QA/swZQ1ONq0F5tJZA/U5fUQW
	 I5TSMKjDDJtLxN03xb1CiFkpqIzBHTzPtlh24FZIZHbEOsWHAR/wgLiybLNkdgM+tw
	 SAz5tkpNIV5qPSXIAqvFzOeJXrlRgDnpoiFAdwb9G0/ZaYY8pIggm1ImzNkNpBinX+
	 FaMY1WsCG/N6RQEtTrZT8WsodcVsUT/b2E8Y8HdliFnEx0iTDWKnAnI5ogEOIFHT/8
	 c4wlrw+GxFJow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 027CBC3274C;
	Thu, 31 Aug 2023 03:50:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZO/Te6LU1ENf58ZW@nvidia.com>
References: <ZO/Te6LU1ENf58ZW@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO/Te6LU1ENf58ZW@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: eb501c2d96cfce6b42528e8321ea085ec605e790
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4debf77169ee459c46ec70e13dc503bc25efd7d2
Message-Id: <169345382800.18053.13760113364662858886.pr-tracker-bot@kernel.org>
Date: Thu, 31 Aug 2023 03:50:28 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 30 Aug 2023 20:40:43 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4debf77169ee459c46ec70e13dc503bc25efd7d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
