Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47168211A15;
	Fri, 11 Apr 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385993; cv=none; b=F0lY04HBpWN+Oix62rCVuiEhHaN+44fTNebHWfV697IiCmYBGJJVErPKwcHnNAFzPNK/D9aqb+KjOxSQ6+o+Nes4dkZ1zhqGU3w89DJUpN87G7UaB54OSJFuCBmPRkqBBj1sp1GaLCnRWm+9HxLQrj4or0wU7yGTyq+6TJlf980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385993; c=relaxed/simple;
	bh=cOQI4BMUYmghDea8lt2yj/ZikdjRVh+R4H1bXByWp9A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O9wbFBKWxqJGs2nQAthl7Jxy8LFc5v+o4eCohg2RMX+JkOwrPPzAB3OdnNMwrUGJ7e3NIQt7nZzkRswrctXoKNGv3tfbj8Vj5Zh3HLAxfXUnbp9rLzp4HtbsRay5f4e3OlFmAndDrNsqsfNem0wi7KDKws4XuJ18spEvlr3Vq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox8Bzaa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox8Bzaa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADEC4CEE2;
	Fri, 11 Apr 2025 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385992;
	bh=cOQI4BMUYmghDea8lt2yj/ZikdjRVh+R4H1bXByWp9A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ox8Bzaa2fSfQLKWfmRbm0/m8uwFNkycFho5N3uORQdVV80345AmPyRofskJmDPy3Y
	 fJqlzFDOrwtKT1pyeoNb1HWYj3WW6UX9fS0vMSH/x/FVNcbIQAF6r0MZ1lqgKdy9tX
	 ZrBwuQwSlD0Jh0z/YjP4VNDevAfOvbKUMFClY1VRjr6YTdSqgrCZU/sz2TbGT4S88q
	 wetIThudkGdpj5jVushrJNWs4MkslkedKWjdCiAMKhl/mJA+uJ5yxFC6m+TrAI3thN
	 zDOcRXj0QKMBZgVxntlAvO+O99ReY0WbI04X2ujP7X4Lr8hXpJNHZ82fOMiHKf1EoY
	 UmDeF9qKnzaxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCA38111E2;
	Fri, 11 Apr 2025 15:40:31 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z_kntkZxksOfGwpt@8bytes.org>
References: <Z_kntkZxksOfGwpt@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z_kntkZxksOfGwpt@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc1
X-PR-Tracked-Commit-Id: 767e22001dfce64cc03b7def1562338591ab6031
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 023e62ce85ced0ea6e71719d168be6b269d7f836
Message-Id: <174438603105.317646.16978393681216942971.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:31 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 11 Apr 2025 16:31:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/023e62ce85ced0ea6e71719d168be6b269d7f836

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
