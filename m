Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA56CDBF;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929180; cv=none; b=kUlwUyI3fPPBNaEAvdlgXdw5h1SV+xnof8z5zga7Rl4sJBiqbWx487wVTDMt0e8WawnI9QrYoizgnjp36Txb6RiSpNPeHE/yzDpIUtkNbT70mh2iTup8ZKCcz6XsOJXHNGONkKiIu8jYFX4zLQ+7/KWXHvbEGgECSlJYtTEkkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929180; c=relaxed/simple;
	bh=2e1aqBxsKPf2upJeumsLAWKy0iUSEV0EDKsUal2iC2c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cBDcmb9kW1bKYkWDdp5KPRdmlbxoBcGztfy3FHzndIYazehG5VsyspWi7jS83o5zsRYothMCd52RZxm8qvjKGcIJy4d/HC2VDtcdUa33W292+Ho5vQBrv2l4ZK0sJ17+r+g7sSon0x9ZsY3qzLMvQC1tbebmBli3Cp29zVnLseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk21tc5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk21tc5O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AFA2C4AF18;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929180;
	bh=2e1aqBxsKPf2upJeumsLAWKy0iUSEV0EDKsUal2iC2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gk21tc5OkLuS5UqDng9wB3PJtqapgX2JFQv2Ky7ikAkjiW726dfgta0hJmqgojOV3
	 cfw1GYWp6Q5LptGPtNUDP1bMV8WtdlHZ/Uk3yQJpN9vWswq/qZJ9PJoPXFnzjIgAAV
	 alFb6OpZ3HYJDhIiMTfuq1cTDcMdDFOQqb0iScr4JlKapVZ6wNHT/lpfu6W9/Z8kAx
	 6VQLlG67X+iXjKyprU5dwGgCR/fd8ZLDQRM8n7R8sFuWdP7NYxAWXXi2Yy1EXPuev/
	 IGhGsB3KodJSxiv0vGphiZeVK15d8Ica3QZqLzZlJfjBrPubiGgGkT4Ta0h872pFBn
	 XrSjNDKp/ogLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83583C4339F;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjW50TUK_CvTAXrj@infradead.org>
References: <ZjW50TUK_CvTAXrj@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjW50TUK_CvTAXrj@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-05-04
X-PR-Tracked-Commit-Id: 75961ffb5cb3e5196f19cae7683f35cc88b50800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fbcf58590a85cdabc48c1541d4f7031b22829f0
Message-Id: <171492918053.31500.15660514002876369711.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:13:00 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 4 May 2024 06:30:09 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-05-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fbcf58590a85cdabc48c1541d4f7031b22829f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
