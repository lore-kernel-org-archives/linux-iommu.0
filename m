Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F637CA0
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDTnFlK4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB0CC433C8;
	Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698421600;
	bh=ICLLe1P77YEAbgrIOoWuE9i17o0dtIBIQ75UB5huibA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZDTnFlK4AbT+APoNSgbezl3RmYPzkFiqGlT/3/mA5YLCulanGCLii6z9KKH3KxtzW
	 8EaC3QWCO9F/glv3Nnc4rohPNTFQmheJVaBwLaEsSDlZDbrSZJl/84pYRC1QHeJWwH
	 0hXf+radWVkbaaK25lltiBMqhrXXiqN4yY42qElbgclz1wyt8cLCm7OCjFhehP5VZU
	 g60pzTiDUiVH8xbzJkKBpcuNaDUZcHVFuXtd+ndVM6b/NDhaC/p902tYbDNeLwA/wf
	 LmrErmYIKUKXJgwASI7sRTGp6DH/vmhs0kJ5ucWHUnoCv5Qwd4iJx1rcZ3utGfuiHH
	 uLiC7hHnfL1Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8997EC41620;
	Fri, 27 Oct 2023 15:46:40 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fix for Linux v6.6-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZTtwNUIIenr5xRPO@8bytes.org>
References: <ZTtwNUIIenr5xRPO@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTtwNUIIenr5xRPO@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.6-rc7
X-PR-Tracked-Commit-Id: 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 888cf78c29e223fd808682f477c18cf8f61ad995
Message-Id: <169842160054.21759.12836632651981604416.pr-tracker-bot@kernel.org>
Date: Fri, 27 Oct 2023 15:46:40 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 27 Oct 2023 10:09:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/888cf78c29e223fd808682f477c18cf8f61ad995

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
