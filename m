Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006B35CBBB;
	Thu, 13 Nov 2025 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001931; cv=none; b=GcXXMnBcuwbnV6xQDmV4RxgtWdaXcTe23xJqDeRX9CyvL3PgnS4dEBesyRWelArZC50QWZp7F5Mrrsz1RlTycsyO+RBbOjyAHHwL1qxPP6iS3rmGUWlZBS9E6qj25SkSCZ8T5Pv/MWtP/MFBJRw7bGNmWnmjqqIlPZtx4FpO590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001931; c=relaxed/simple;
	bh=r2Nn/gcJ/jTLFa81+j43qCZ/VADWztwTlZtWWGAMgSI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QI9Oy+G+9+xBFnsE068VAOn2I10GE2fGIqDuOwW9yiRN+pNO52ykj2E97vCUGBLko7O0VJW7C5gfGNMwdwBA+EMBweO0XfBK0uY9E9mugwvf9ON/y04bKPJznWDIloBVOe+ZLzkuwR7zXEHdO0MhHADDsvqer/mIrW5UbkDod8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnzZYi0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnzZYi0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B01BC4CEF1;
	Thu, 13 Nov 2025 02:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763001930;
	bh=r2Nn/gcJ/jTLFa81+j43qCZ/VADWztwTlZtWWGAMgSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TnzZYi0Whyen/ogsQ588GJjDG2UcT4+LOf2V2qKF0JoWeYxIxZ0PvMTWpx8YDRvWb
	 JQQn9YRs0B6mxXvlP4Xm+gOfYGvX8WKzmkqSm5ksrt2op9PKc+NV+3swl0EpzLs59l
	 C3PQxseL/00ULkcFuXVDb3wX1YPxo+7RrXUj+02OxNwgjIbHyKGWHMpGogixTKWd3M
	 IuN/Sz5jhBqtHcFymy1kH4KniTxxnV+f6LOLoPRvOihnsoCKk4bF0P342Gn/LfJlZN
	 SXPe00PdHWmjbgObF09BU+zvDDaaW1vYj2ojjGoZcqWDjhN8LtD1uaT0fzNBBBqJTh
	 OkYEXbra78rVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE03A40FD1;
	Thu, 13 Nov 2025 02:45:01 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251112095920.5802-1-m.szyprowski@samsung.com>
References: <CGME20251112095941eucas1p2e0efc01a697cac1a9d51f5a2ae92b5ae@eucas1p2.samsung.com> <20251112095920.5802-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251112095920.5802-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-12
X-PR-Tracked-Commit-Id: a50f7456f853ec3a6f07cbe1d16ad8a8b2501320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92385a075a01124100edc581e3b8285268d8591e
Message-Id: <176300189969.293034.11758883672291066804.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 02:44:59 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 12 Nov 2025 10:59:20 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92385a075a01124100edc581e3b8285268d8591e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
