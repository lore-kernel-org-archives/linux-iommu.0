Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A52154BC
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 18:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE298C433C8;
	Fri, 28 Jul 2023 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690569570;
	bh=ekJmFxg2g3kH89CuUtzM5Ayd0aUXp/XgOQDgCNBy2h0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NXS6m11RWNORjqdODWImtvNmtDOg31IkCPkoBnP6RSI0DZ6WzOinUTXRoYuE0LJJk
	 XQgFTkdLeqddpUjDH3+7g4sqnYdxVpk0Md7ObmPXuCptojNd6OO3qpB7tdiUfUErnH
	 JELOWY7ahcntFDJC7j8j2PY03BRskhSHhQSW/rwS5uapHM+5Ppb2Vn9XProsKvZL+P
	 xfmXPRcDg1zb837Ml0rlJEQWzqb1b7NUZc5bWKavbMLu0+jDPoEKqja9A1sHaa5KSO
	 zBkQXwsWZ94Lz3LQAtk14FVSzDbRpPOENjju+xBIFgyKzPN70mznmTY98ZWIeeUd+d
	 d32Pls2gHUbzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8EA1C4166F;
	Fri, 28 Jul 2023 18:39:30 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZMPHGPLDXK46QF+K@nvidia.com>
References: <ZMPHGPLDXK46QF+K@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMPHGPLDXK46QF+K@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: b7c822fa6b7701b17e139f1c562fc24135880ed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0299a13af0be43f2679047c7236e3a58e587f3f8
Message-Id: <169056957081.21363.12613540591613546001.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jul 2023 18:39:30 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 28 Jul 2023 10:48:08 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0299a13af0be43f2679047c7236e3a58e587f3f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
