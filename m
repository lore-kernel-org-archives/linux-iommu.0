Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD114A0AA;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412571; cv=none; b=BBUBM2wen555NBvKlIGc8LhubmDDDUKGaT3IXCKRK8pCR2ET3XAemWVHR+4sN+ksWIrcJ5iIJ1ZZXiHz8y87UvyWz49dOxZDG7POzOj5RDRQ4rO/ZVnxogC8LlJBMWxGpQfwnH5WEJJcsjwwqEqO9FA9RXg2HlVAHVxgDrLmQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412571; c=relaxed/simple;
	bh=q3Dgs/i3wDvWSQF/Bv0tHr5l6i0S12mqkF7qUvvwXZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M5LY0Lfbli3Cg6QNyZLFvUscm85d5sb7g2hh7qL8jL+uXqz3W6o3Y32bXL0GTcN/Z6L9hh1SC3eU5vRYGz1pPCf/mhV96yDrIBztNdn8AEQOSzLcMoSXC3tLrDmE7Wcc+Ydppz1py8/Rp3hQwn+l8pF+Tmm7BnlP5ZI5UUljEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SevPmk0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SevPmk0C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 595DEC4AF14;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721412570;
	bh=q3Dgs/i3wDvWSQF/Bv0tHr5l6i0S12mqkF7qUvvwXZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SevPmk0CMP2AG1MB0YEDY/X3+7q/7CQmQbNEx6024qymPKM61muuasIzYmBxmHbuQ
	 tIvu3foEFWj51c4bN8vu++lr44NDioi2Fm+mrzve0U2/L2J0AluNcnDD7m0Xys6jTr
	 pH8D0Mq+EEZamvX9kFbQ6/vZH3zQIP4e+oPfK2liqQnaeJN7bV1bs9NF2lVm0cP1zk
	 rzqHVZl38H/vMNycAnVHaKmWOCsU1O9kAYZ/uQ5SQIXcvXN6NmuPRNEByBbkaBzUCl
	 b8Ku6oUBvkMZbHPkBfXAsALRS8dxmcJJTk5HHLA3K0oKGy3aQ7DPl3e7IPXKh0kHp2
	 aYu8mWyf9YQ8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EC16C43335;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU Updates for Linux v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719112138.GA22869@willie-the-truck>
References: <20240719112138.GA22869@willie-the-truck>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240719112138.GA22869@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.11
X-PR-Tracked-Commit-Id: 8b6c32e831ef4496b51a68ddc5be9bb9e8d2337d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebcfbf02abfbecc144440ff797419cc95cb047fe
Message-Id: <172141257031.2862.9106652316004054725.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 18:09:30 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 19 Jul 2024 12:21:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebcfbf02abfbecc144440ff797419cc95cb047fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
