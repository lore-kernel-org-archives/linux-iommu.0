Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF11FA8
	for <iommu@lists.linux.dev>; Fri, 30 Jun 2023 04:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22103C433C9;
	Fri, 30 Jun 2023 04:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688098610;
	bh=bpYbLvucEyJ32hINQQAQ1CbkrNPXOnYsO/mnvxbBwgU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pRrInoFre+XhTKOgxiBi03JEdDp+Tnh12rKVLC6Csk3NyAwIN6So9WbxEt1V4WFp2
	 66EehYbIgUXUN6wjXXYhPp9lHgquFRrSh0+QBtkMpYlGe6bxdif3AAAZYSSdFvbO0y
	 UG9HFJjmm7QVTt6mmIz7OtpQnAtFWVLwV+zuu0ACdJc0D1kw9+NZkrOQz9t3AXowKW
	 c0wIQdl1zsTbhflUln8DKzX1gNEXdbc4SzPKKkztBrz1Lba6zHM2eOHGzNuvhcRjhC
	 QqSOX/q1clXzoX7mBEl5n25p6/UcBd1TwcmbG6fZKXXbjPntKLQ7Ftb9SQaAg2fpnL
	 G9SeqYFn6X4WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F2CFC6445A;
	Fri, 30 Jun 2023 04:16:50 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZJw95Knh/UEL6vQh@nvidia.com>
References: <ZJw95Knh/UEL6vQh@nvidia.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZJw95Knh/UEL6vQh@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: dbe245cdf5189e88d680379ed13901356628b650
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31929ae00890d921618b0b449722dcdf4a4416cc
Message-Id: <168809861005.23778.16859013806626555298.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jun 2023 04:16:50 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 28 Jun 2023 11:04:20 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31929ae00890d921618b0b449722dcdf4a4416cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
