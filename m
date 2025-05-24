Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3D28EB;
	Sat, 24 May 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748103008; cv=none; b=RNW01q9KHXDH2OcOkp/nPUA4yHJ99yHIuOVR9k3jK6XA9dh6FhiNx7vOHvWXE8zKc7Bmb9/FYCg4/x61ve7DNmlMajdMalEB83zFXORMIUzdEuvN5WqxG/CngJsBZ7YZnzf+DOmEQYDjkP706KWMOJK6rXh9aneD8KAtv9WzvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748103008; c=relaxed/simple;
	bh=aVUPBVUQRVD0U3c0NA5Z1EyP09SCql3R2P6+bX5w9Tw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XrrmS8//6D1wusd2sT3KgUzXIhg8Bp6qNAWbUbATHFN5bc5H2olk7MiA/4ravOah6bQRBOwCvjccuxPxP/l/S7REtozj6jfiM8ffTQAGkAsPxr4wHnkqF2QWIJFEhuSym3iUxLRpKPI4PedCA1qcKk/MZ00K0udUu0E4N7/Z1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTaUTkXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTaUTkXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F758C4CEE4;
	Sat, 24 May 2025 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748103008;
	bh=aVUPBVUQRVD0U3c0NA5Z1EyP09SCql3R2P6+bX5w9Tw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rTaUTkXDYaNTpeAyukPszDLADwUpaxKWXRwUo0BSWwxa98YnSX+mv5kZGtM2aehYh
	 YhCp1SL2gJEvAg4WuITHzvnyJkSJvQCSjDkKm+lPI89/uSFk7pI9CnQJOl8AW7qScK
	 ZPfNUiI5K4ksksJW2nEtJfCTFGd/Tm91nGaAvdE8hczldzSqRBrCRm6h6e1rvCXdAL
	 i7N+nA57M7B8KB2K66tm/TfVD2AvniYsuJ4xkL0VQL+OsrhRc3+bWWwVPDQh3M96q4
	 5w+2UGkoq+4Z3RC0hvD18pIJYCJrhm7a9H4Ne3qU5a+435f3SQaVy92WqddAnmdGKv
	 Jq82MoQ5W3Qig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713A539D60BB;
	Sat, 24 May 2025 16:10:44 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aDHmdAoAE_gP6Xup@8bytes.org>
References: <aDHmdAoAE_gP6Xup@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDHmdAoAE_gP6Xup@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc7
X-PR-Tracked-Commit-Id: b3f6fcd8404f9f92262303369bb877ec5d188a81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1427432d3b656fac71b3f42824ff4aea3c9f93b
Message-Id: <174810304297.3935495.4785262100607086038.pr-tracker-bot@kernel.org>
Date: Sat, 24 May 2025 16:10:42 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 24 May 2025 17:32:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1427432d3b656fac71b3f42824ff4aea3c9f93b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
