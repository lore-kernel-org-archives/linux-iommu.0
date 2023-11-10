Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A93B287
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbHthTL1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FE64C433C7;
	Fri, 10 Nov 2023 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699644531;
	bh=ywUW5j97OHKk1zv7otB3YR/kwql+zwlFhc/cQmlB928=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WbHthTL1QJT4BGB16uJ8F17opGlBrwrUcnoug8roAyP1eFnHN1cFBl6QY+FrukA2Q
	 KdV2nsKBBZoFA1TrCxV0PDKUArA2YazWSGbR/hyW4QD1b4V5y9QGj41rrNWOj8ZP9R
	 rYdizjZgBVXQOGSrfbOg6F/diPVZIdK7W2gIebFvq1fsfo7RHkGLa/KlvGV9P2W+HL
	 xvoz25CXBnJgSXMIZUD5HjRHc+nduZsc4KRC287kfbTf8cRlPa/MZeNHD/9phLHS2K
	 yyrqhadrMvJXINs/h9d6qPu9Qs/PP3GsOSQvSyr+HpBp1WPADJbhC6bZxhDTq5CvMI
	 u4mzFiHHWkRtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BF8CEAB08C;
	Fri, 10 Nov 2023 19:28:51 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZU3U759SwIC4Vv-F@infradead.org>
References: <ZU3U759SwIC4Vv-F@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZU3U759SwIC4Vv-F@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10
X-PR-Tracked-Commit-Id: 53c87e846e335e3c18044c397cc35178163d7827
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 391ce5b9c46ebf23cd049bb552a899dfc0cfb838
Message-Id: <169964453143.4685.3653756585506805115.pr-tracker-bot@kernel.org>
Date: Fri, 10 Nov 2023 19:28:51 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 10 Nov 2023 07:59:59 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/391ce5b9c46ebf23cd049bb552a899dfc0cfb838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
