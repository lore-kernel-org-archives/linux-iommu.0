Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75C1DEFE4;
	Thu, 20 Mar 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515152; cv=none; b=H94ocMezMgjzyQC5J/Y7hFdH6vn8N5xO0LpYgLRsOiYQMKEwh5+gy2GNhZjavak4lEoLtYNoQtGVcIWDxKe61AETs9gXjexGT8Rd+P2weKHQs+pMk/ldIucNyFDekHDlbjSdYlKHM7h+kzTj0ynn0efMBdBryGBjBATDyMlsy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515152; c=relaxed/simple;
	bh=ETmVZMyiueeUOukjC5G5xNwuzGq6r33lp68Aa8aXCAQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QuqfVhE4rMR542rf4vTWuIPUsfAeA6zhMFr1wdJzCXgquXPg2kvcvL2bg/Cf/LIFh7mTpYPj372K9ESOgFe4UyM70gPtL7ys7Z8l610nplL5T1R2J8W0lcPpr3tGKfqIvrLxo9awPNIFCGb5Pg2fKkOg3wufoIiXFkESRF0hxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPad98dK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPad98dK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A087C4CEDD;
	Thu, 20 Mar 2025 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742515151;
	bh=ETmVZMyiueeUOukjC5G5xNwuzGq6r33lp68Aa8aXCAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EPad98dKp7pD8edluDa0J084CUFabhoCpjqWpedQw1Z0Fy/dNpSfilZXry4eu7iZB
	 U97FOc8rR0czycOtK5z8VByJTl3vJzK4q8FJgEr/hx7RkF5YR0wGTzy9OjltY6YboY
	 PkCU0FP3ADXllIw/cDpnt9ogLb6qS4r8Btbdw0RVg49yqrYrGSCm7zRQbp3vsz+3LY
	 VRaFITiwh/jJ5UJ82974+QhLTXbHru5QImjQPMcz4qVbuMwD/IF4M2BO4b0UFezWRp
	 wkqjPauMyRRFSX1ePuqLONK06rt+S8VnubHSO60cGRwQWK1r966krpiH/ncpD/Hh0E
	 7wfWoSVVjDL2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE32E3806654;
	Thu, 20 Mar 2025 23:59:48 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320232115.3940-1-m.szyprowski@samsung.com>
References: <CGME20250320232137eucas1p2f877454de65336d638b200d920ccf2f3@eucas1p2.samsung.com> <20250320232115.3940-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250320232115.3940-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.14-2025-03-21
X-PR-Tracked-Commit-Id: 8324993f60305e50f27b98358b01b9837e10d159
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1cffe8cc8aef85f1b07c4464f0998b9785b795a
Message-Id: <174251518733.1956662.8849960651830486201.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 23:59:47 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 21 Mar 2025 00:21:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.14-2025-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1cffe8cc8aef85f1b07c4464f0998b9785b795a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
