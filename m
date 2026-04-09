Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39448368946;
	Thu,  9 Apr 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749191; cv=none; b=OL7MH5z2Xr4H4ZWKEQxIVEQKukoU0wotYiFvUM2X0IX4CiN2bIKHrzPiLRzTEib3VSYPdYdk1aqRdXTVVQh7zVeISGF69rABpXeUS3lsYZbmGJKgUkGLF4BIIfUMpJLer3/VepzmaBXEzoiB9vwsa0djRzbt56ip6Bz9HdaGz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749191; c=relaxed/simple;
	bh=3eBozNsG+/HQGY8c2P5RCiNiyYERSi75c5lmma9lt90=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rAP9OwQ645zk3sDqjw8e3GPFyJggnHb0MMfxJryWURJztDm6+XUIFrMuad9zmNHgxZJWvDYvj1pGwloouCmWX556/GW1hhot/y2fJl8R84V1b1EG5yvHmTOlDEluoRWfT2sR+FAmEemZyKzRFxTL5poJ1kFDHMEC7aFnjOwVTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndt8Dy+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndt8Dy+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B00C4CEF7;
	Thu,  9 Apr 2026 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749191;
	bh=3eBozNsG+/HQGY8c2P5RCiNiyYERSi75c5lmma9lt90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ndt8Dy+qzLO7TJaXZXXxBQizO0IsgFae6bcijGNDrgF5NncverB+nCZNNMnyZIODP
	 moueD6nHtaXPdZS/NHS13qrMIcGR2gJvKOTCLc83SRl/OIIQFBGPpt5fCawJOzhvXH
	 LpJKXzb/qPGSRQbz2UHpfrDxBHMrCDkwPpgWEPVFH4/2wOyNAu9+WyAXTnQe2/Ykf3
	 qHHYz0y3kT6jNeoOh73YwSFP1Pz7+sdOCOOj1DWWHVRF+Mlu2vbvmw07zTQ9aKpFt0
	 ar04yvUjnUaRpFjP7Fi3g4+wLeul/FTDaVgZheghKn9hrIznX0xNTqVT4OG7yynHIB
	 OM6uY8e7XrmWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D0B3930899;
	Thu,  9 Apr 2026 15:39:28 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU Fix for Linux v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <adey_8n4Ux1qhZrL@willie-the-truck>
References: <adey_8n4Ux1qhZrL@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adey_8n4Ux1qhZrL@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc7
X-PR-Tracked-Commit-Id: 7e0548525abd2bff9694e016b6a469ccd2d5a053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b02520ec5f7b0d976e8bbc072242275acd472d0
Message-Id: <177574916659.1617900.4142392589364400492.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 15:39:26 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, robin.murphy@arm.com, jgg@nvidia.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 9 Apr 2026 15:09:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b02520ec5f7b0d976e8bbc072242275acd472d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
