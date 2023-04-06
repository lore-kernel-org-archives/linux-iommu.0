Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD2320D
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C893C4339E;
	Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680806770;
	bh=4dxODKZZfoqLpUA1ABZqmTsHHOW/ReH/5zsWDpM5nII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mUK0Mg82n2nw8B9AyQjFSJKlNci+g/KxwEFIPaUfFSoWSv5NPIg0VybCsNm0gcoJu
	 ASSCwPvGyWRndenNPJFgm3hnCagIU9d0EPo4jyVUeRh8oRPeJZHMJXC9VNu8BwpkzQ
	 d6O1+o6AEwT9Pxy262kbxZkr3UEBYc0WKyXZcI9E5EF9Gm8iS8qZ5IQm7Y5d30wDPl
	 +dEhE8h8Xv6USOmfN4K6NxsJA4ObjfrihAR682io4OrzZ/Fgn9kS0sjrSqTRbSZhdp
	 nLkDPP57oF4vwUu6XtQC+blHSf1IZMJ5yiZeeoC5GqNTZ0JPSR9YFiM0++r++FQup5
	 XwjdYOI/2SZfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32D26E4F153;
	Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZC7Kb3WmjvooWtLE@nvidia.com>
References: <ZC7Kb3WmjvooWtLE@nvidia.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZC7Kb3WmjvooWtLE@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 13a0d1ae7ee6b438f5537711a8c60cba00554943
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 105b64c83872c39d86c1e3dea9ee4185c62114dc
Message-Id: <168080677020.24406.5130803914063115504.pr-tracker-bot@kernel.org>
Date: Thu, 06 Apr 2023 18:46:10 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 6 Apr 2023 10:34:39 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/105b64c83872c39d86c1e3dea9ee4185c62114dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
