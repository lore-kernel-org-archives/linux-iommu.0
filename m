Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33157219A91;
	Fri, 11 Jul 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255839; cv=none; b=NMIEVg3zGVKQEaGGs4/1eM2pynAVs2F77yKt+llb72N1hdeO0hpVfYbUKoIO29+fWYI/VyA74zUHpErEn8jQNow3CCYqAEK5PnjkIyy33ila0JXuGqUXXne4GaoBecEDsLeYc91QrAcUiWx3xAZHhBXKKNpNfF7DCfDluI4fcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255839; c=relaxed/simple;
	bh=6cMw1EYAweCj433gLU7lID7q7ifiGcWotpm4W0Ln2j0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FVnaAu9lvAmZxBmTai0i5YlIVJs3kfgt5MB5ksrcLVuExBNB35B1/uXuJc7oxye/0+BiXlUUbtb6UQeEGVXsWJ0MkBwaC+NqCBtE5+MEF9M1TWVjCOwZGc7WjzM1CdngZ94/gB/eIG7NV1nzYEp7svtyHwm9ktTbGaV6u6dyjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbkCsfhx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbkCsfhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4107C4CEED;
	Fri, 11 Jul 2025 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255838;
	bh=6cMw1EYAweCj433gLU7lID7q7ifiGcWotpm4W0Ln2j0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gbkCsfhxQod1ONTD1+AkoIRbpO0Up6ipDvSBgjPERC221+kGpDDaadmd+bNRr8GUM
	 ULG/pmvnBd9x2vps+64psxJy7Zkp1AE8bziOw9nTrKIYnblFVodEeTPcWKZBAoleOL
	 mufDHXvSwEuVjvACeU7vvzyyyG4eqFX4CtF9rTUZstpr24OAQq8c+TKCtpg1Idj4fu
	 5rUIcK6Xs9HLdBLpx1OXOmVpwTCLjnCOInE+yzpp19UGRoGRn0XLIBHPYX0gH3Gvhp
	 tL5bZsgTBtWHFPQ0ZaNq7WOf4jYpkdcdgzm4BybDY6Lnujvtb497hAMop2qwBFrptw
	 DUiQPF9tgJdvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB74D383B275;
	Fri, 11 Jul 2025 17:44:21 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250711070102.4071882-1-m.szyprowski@samsung.com>
References: <CGME20250711070117eucas1p2788fee3599caf71ac5f0a5f811f6c6bb@eucas1p2.samsung.com> <20250711070102.4071882-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250711070102.4071882-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.16-2025-07-11
X-PR-Tracked-Commit-Id: aa807b9f22df2eee28593cbbabba0f93f4aa26c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0f8361c3ce4cf706608edb81c4334783cb093cf
Message-Id: <175225586053.2350666.7682054107347295245.pr-tracker-bot@kernel.org>
Date: Fri, 11 Jul 2025 17:44:20 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Feng Tang <feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 11 Jul 2025 09:01:02 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.16-2025-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0f8361c3ce4cf706608edb81c4334783cb093cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
