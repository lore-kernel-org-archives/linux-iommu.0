Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF523506A;
	Tue,  9 Sep 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441905; cv=none; b=LL6wOLrnU1OBUbBnx6rCBdL+kM24E/eTmStK+SKq+I6oJqm8BX8cIL7mnQpFVwWPU6b9xkz+/q61Z3H8CMgmazE6Tth18q6DvyeKCGWNB1hHuorkL04GvdLDRRax7unDfRzgYVK/k9Chja0EX2BkM1mRMrLKlmfB8wZTqSL13uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441905; c=relaxed/simple;
	bh=z730CuhYQuGlnvxbNzXbPf/AYKqry6kp6mu0eA9lX2c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pMuQskjmTWJk/NeFpWTlKdGqhJGksX283kBZmbGZY3CW56DmYK92r6kGkaRXqFVS32cmk8vp1SUqQplnw0o2FP4keMedU2XGdT1dcKI/4t5Q+EmOxMqt82Hb0/uKOl06ndfboZfl/KH0Zd+foEcjx79gS0UDv6QUudS9VHSUd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdIHY8+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdIHY8+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124FDC4CEF4;
	Tue,  9 Sep 2025 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757441905;
	bh=z730CuhYQuGlnvxbNzXbPf/AYKqry6kp6mu0eA9lX2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TdIHY8+8yK0583O3tH4Ct1GjUXfcxZvFvobO1q62AePxCx+y8uRuoN4YxdPXUtlH9
	 rxfkWvUl3nZFc8oSGRD6gB9wLlq3wSY/QgVFV89YhTRbZ8qTSh14XQW3pQR9RjvWwy
	 OFzd2+D52gXGshwf0MR9ihm9R/BClYHniiA1lUtn00uzp+dDaFS8esvmULLV9SfTzo
	 CTk5gXg3BOKpVlNjXcIaIQUzKH6sjerrKxDGMzdQ0+PZD9mKFLDjxX8iFgXOFTroIl
	 +7DEAD8MXwDFIYPjNj6X8FRf/yNwSWwlAwl7hXxndPu9MoAD6ffgbVg3vgwNqpvy8u
	 KowBIiZlw7jbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7298D383BF69;
	Tue,  9 Sep 2025 18:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250909110152.1143681-1-m.szyprowski@samsung.com>
References: <CGME20250909110159eucas1p260bd877535b4bc0d8fe6c3101f3dcbca@eucas1p2.samsung.com> <20250909110152.1143681-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250909110152.1143681-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-09-09
X-PR-Tracked-Commit-Id: 7e2368a21741e2db542330b32aa6fdd8908e7cff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dd1835ecda5b96ac88c166f4a87386f3e727bd9
Message-Id: <175744190798.777625.15342846763827379136.pr-tracker-bot@kernel.org>
Date: Tue, 09 Sep 2025 18:18:27 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue,  9 Sep 2025 13:01:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.17-2025-09-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dd1835ecda5b96ac88c166f4a87386f3e727bd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
