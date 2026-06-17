Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009B38888F;
	Wed, 17 Jun 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725211; cv=none; b=VqJbMobcmGlUk/oCWEnmS2V4y/MmU51DhUxeOa0IOgNQzWD/G5N14bsavw2/RHcbMpp5QPtqa/qf/uCUlnCAhn76JZHklQaeYh54aeS54oNE04L+wjl7tsCtKboES3PVMHIQ60HalftmohbBzUYFoornYSoBC+9XI3tCPtwewSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725211; c=relaxed/simple;
	bh=947J89SWjZfCUiPSSxzzAedIfowFACSsH566iKNVo2Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ixV9E9i1ieFMnUwVucheqAh2gCYK2PA5DlIpWJkjISSYdhQPsV7jSAlks4btQcVgP27CNsK1xZSmFVYgwaXLJGlw/YZdgnhxekN3dwCVAg+48RLLFtbL5nyYibF2ETR1li91ukgVeUhsbmErm+oNJohxuAZdbE19yt+4FB0gR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXhZer9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXhZer9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6161F000E9;
	Wed, 17 Jun 2026 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781725209;
	bh=IClkHY2PeDX+TubJ9IvCE2TwAWEzTT8KfzPm99zeXCM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FXhZer9P5E8J5rDmFpZxbXX8dRSTGS2oVgjxLbKaV6jbKhWiKb4YH/lKUywv31mA8
	 J0TqWkJ3uG8ExgrQkYwjtZLPeM+XijwyBXMFv9L5K1mEikoQ3d2vsyoIE2m2Xc0Cp6
	 0rkRCY9WN3mI27usj2HjTn/XKhTPpoWWz2Zcb8VlYYC9gI2FrWwziPf+Fgt7xz7Qb8
	 Y7S6AF13GFd09mW9ZgRMy0Ee2xvU5EzxuZGyHG1sO0uXUD5dH7ibhbuGLpW+2mLrI8
	 slZYMUb8/mZ75ZGOfipMYFIGEVTC+AgdSDCsKjFRIZ1CLoo3mbjrNLHo0I8bLeN6Ry
	 PiKkBVJ1PVUcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199973931008;
	Wed, 17 Jun 2026 19:40:05 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajJL1Jx3bTh1EaVV@8bytes.org>
References: <ajJL1Jx3bTh1EaVV@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ajJL1Jx3bTh1EaVV@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.2
X-PR-Tracked-Commit-Id: dd8a3c6cd531dca5917111a94fa3074077f6ba5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d076a8d3b9b36563fdd029ef33c79f713445970e
Message-Id: <178172520393.1784504.483158179698654827.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:40:03 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 17 Jun 2026 09:26:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d076a8d3b9b36563fdd029ef33c79f713445970e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
