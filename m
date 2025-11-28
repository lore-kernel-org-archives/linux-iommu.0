Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8623F41A;
	Fri, 28 Nov 2025 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294104; cv=none; b=LKl3BbGZVOKx+JVRA5Qj60Q/OCIW17L85OiCMVrBpmAMQRF/zY+u6WzaOAXxbNnYfbZYoNoujYg68w5zsIqH/vim2+myhHy61TxBbehtn6+gLBL7FN6PznvO8KGeQpmb3qX8W8B98foLZUt2cBXC7ManUhMNcx9OQmGll6jofjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294104; c=relaxed/simple;
	bh=eCLArih4XNK6hraDMoLiKJxLjLRCauAIFc+1v7aKEU8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ki5zKou7LNjE2z5TRPAwnTsM0kc/SAxqmi9DqQwPawytb5VFbsa7rgv9aCZdc6054ySvVE/i8D6ld2cZhGGyP63U1NurSawtGtVl9jhH+RmyA7CJZS7yjsyO1OuVzjCHUdJ8ODvWT5c4KqY1EHcSSp4T/vG0LUzrguTq/ol54Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwzNZy0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwzNZy0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0E3C4CEF8;
	Fri, 28 Nov 2025 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764294103;
	bh=eCLArih4XNK6hraDMoLiKJxLjLRCauAIFc+1v7aKEU8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dwzNZy0q8mDX7WYOdEUVriqvQcob/fxabpGK4AbVlPAgIGHrp9nvqBtXMpRhSVBsR
	 WO8AO9eZAZvmDEbl8L1jDYZ13pBQ8BMGrYTiJkWtOwIQbhT31/ZU+VMnys62zxThEH
	 7FmgDiDFAiXL/exgN7+OtoWldJ1zIET+TYoiQZwtAMWcFEr2b+ojlc6CxTM9gnFiRc
	 NoFzWv3VwV8mvsR6ov7IWbwSVUwFp2JXoLngCQhKpgvVrEAYC1ZELb1J0RdenV13W5
	 sMWxjuooHX4wCTCD7Q7Jl626rAVI0Y05BPtndHQarcYWGMPl+zWi5VpoAhTiGoTPX2
	 UTS4TBcO0qBpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA4D3808204;
	Fri, 28 Nov 2025 01:38:47 +0000 (UTC)
Subject: Re: [GIT PULL] more dma-mapping fixes for Linux 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251127220431.1614800-1-m.szyprowski@samsung.com>
References: <CGME20251127220500eucas1p2434659b2b064b09a5fc250f4ea1cc402@eucas1p2.samsung.com> <20251127220431.1614800-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251127220431.1614800-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-27
X-PR-Tracked-Commit-Id: d0d08f4bd7f667dc7a65cd7133c0a94a6f02aca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa7243aaf1947a0cb54c44337795d6759493fe02
Message-Id: <176429392574.102139.11711106742991481336.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 01:38:45 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 27 Nov 2025 23:04:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.18-2025-11-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa7243aaf1947a0cb54c44337795d6759493fe02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
