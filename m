Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7772AD25
	for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 18:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E6C2C433F0;
	Wed, 14 Dec 2022 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671041083;
	bh=av1MGpkBAVrOC3/H1ODRwPW9Zkps1Lgfe1vtqovQRA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kadt2vsiAcq7L3uiFtwnmay30cYJ9LNI33Qg72tILJPn+5T8Z+W8i72XEP1+fO05v
	 ACXlVzcnYg1jpwaV2O1fYHFmxybU27YzjI7l7BpnSgYG9wnTMbwgRHrfuWXyc/9exo
	 wQbJ7xamxn8DJdTZEP5W+iFJ0voCf5Em6YCFD49qIdmg9IFh6ckm6Lf7TSUNz0MGwx
	 tmmCYRMO2iiwyAv6zCzePcTzMig6jHf8c5v/D4VvETj6EZnYEDzBUyXsdwl4VYMM4A
	 mHvVBU5bOEXroVsmYfVJJ1nRZgx7bnrJqVIIQz4P4pHhRFQBHlZzle5DMvJigyyaHV
	 EK5s40RXyOfNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D8C2E29F4D;
	Wed, 14 Dec 2022 18:04:43 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y5dzTU8dlmXTbzoJ@nvidia.com>
References: <Y5dzTU8dlmXTbzoJ@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5dzTU8dlmXTbzoJ@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: d6c55c0a20e5059abdde81713ddf6324a946eb3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08cdc2157966c07d3f986a097ddaa74cee312751
Message-Id: <167104108351.17244.14344497629587467451.pr-tracker-bot@kernel.org>
Date: Wed, 14 Dec 2022 18:04:43 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 12 Dec 2022 14:30:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08cdc2157966c07d3f986a097ddaa74cee312751

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
