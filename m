Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFFBA51
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 23:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECB58C4339C;
	Fri, 24 Feb 2023 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677281244;
	bh=n645UGmCRsD8B402VG8f29+Unah6hw5bUNA0zxb8/b4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TMybbokhW3YmBW4bGh6B5V4TzoROIVXT9h4ZKEtHUy37yLjnFH/IOZjqwfYRZ5J6Y
	 v06lgQu/MPN3pKTRhKVK3Hq24rU4q4baW2PqJYfXkO+JAdYm6msPdj5nCfe3MaWEks
	 W5GXz1yFrd9dGxWg5+EMfzZ24oqmn/7gTB2y2cL5aatcamXf5lqgBG7Prvjy2WsNc0
	 FcugA9eDZpF7hkMPFOmsmwrpVq+4F6jK1uqpktmzfbsFQmnA6e7gMMltdScual/An3
	 mcdipK1KJXdW6175oqGNexZ5BMpkpXNLSsQvrMcYB11DStO55A2qrljVkX9bT9Z9+N
	 +oyWC4kgbeAlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD75C43151;
	Fri, 24 Feb 2023 23:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y/Tlx8j3i17n5bzL@nvidia.com>
References: <Y/Tlx8j3i17n5bzL@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Tlx8j3i17n5bzL@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 939204e4df962982cbc84acc26b29b421dd530a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 143c7bc6496c886ce5db2a2f9cec580494690170
Message-Id: <167728124389.28021.2369650643044234170.pr-tracker-bot@kernel.org>
Date: Fri, 24 Feb 2023 23:27:23 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 21 Feb 2023 11:39:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/143c7bc6496c886ce5db2a2f9cec580494690170

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
