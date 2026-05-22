Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE52421F16;
	Fri, 22 May 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459949; cv=none; b=U+k37piup98a3c0qDXgGTaFUDMawHmn4EUAWRtdtMs5QSqg2bncsaVtYiNuYC23rKUXforleKOQF2SetXHbPQ1qPUoce4I+kylTO0R6axai0WuiCcGLMWSsSF55cJr07enLKprJM6gYEHLmb5am4TDuZmM0rkGKZCoAehlMUU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459949; c=relaxed/simple;
	bh=SAv6+I7+8WeD7SvcgRY/BmXno0jMNujxnDUHqTKJexY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u4cZRHYmGdDlkdfWTstLQPoDC5pqNAoUjNhhfYOQQC0u1wWgERyVSEJiQzdGKllgzlzB2mKs7/4T2gg8hdYWMmyhV1hf53/I5oSgxoie5OXjXe+9tgu86fNckIisS+j2ADrQSAjtiBpB0w4QjhLRQz7zOWxqbdc3NvsSC+LGsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrjmYHO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrjmYHO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C81F000E9;
	Fri, 22 May 2026 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459948;
	bh=d6jRwPgAcI2XgMYdZFDYRMU6saR++/qTNMXG9LPOrb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lrjmYHO42yNXqPIcNsU4M4STijQv6zicY79HQV/w2VdrG1Xj0fmKqfvshxMcqDN2w
	 V62eofZPTFlnX7eMp65g0bVhWZnNJF4HQteNzRv3yFtKn9ZAv+zR4yHxyxSfIAzvH3
	 MdPNjJNTkv6cuGVw/5AB2pHOPvgMTiS3CPXfjxyqjP3Vc+oa6+fN8o00vvcfl0h0oE
	 OJ5hZKcU3LfDxFUGEmXVd4aLMn4iU2GNF4qT9EoB2yTzluDomMVoKsPMDV0PaYYhp0
	 zd5xSZ2jwg3OHsNoYFcFH890+ntRYyncCYVI97Q9qFgnqsthk7CIJShkDeWHjLZ604
	 lW2L9lCnaUanw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93957392E9B4;
	Fri, 22 May 2026 14:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260522070507.3385533-1-m.szyprowski@samsung.com>
References: <CGME20260522070625eucas1p26fa2143e0dfc4c3e630ee98f29e1d22c@eucas1p2.samsung.com> <20260522070507.3385533-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260522070507.3385533-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-05-22
X-PR-Tracked-Commit-Id: af0c3f05866237f7592219bfe05387bc3bfc99b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c04dcd891c011839f57d0501e9bc473cc0aae7d
Message-Id: <177945995722.1238704.9387913405920113273.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 14:25:57 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Jianpeng Chang <jianpeng.chang.cn@windriver.com>, Petr Tesarik <ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 22 May 2026 09:05:07 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c04dcd891c011839f57d0501e9bc473cc0aae7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
