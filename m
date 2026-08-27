Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF1376BC2;
	Thu, 27 Aug 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862343; cv=none; b=DxxsV363X5KRfO/DYL/vhZoHF3QwerBIWrNRcK0PyLruYiuNJcStJMFesEDeL7eMR9hW40wT8pkw2X3y8H2oxxUcH1kSJ4zDn6Q7uXw71QpEOYE5hKi6FP0zTg9t9cMvVdgGQCXH0NMrkGshV4iWQroWX8TQ37lzd10kMT0UoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862343; c=relaxed/simple;
	bh=luLC2ZXiKsBejSwnmFYZ1u+4SpxT4ZJ6yes4TmdBJ/o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D46fKZaZXBgHy+dr8Tedr5PpAGQqcHYwE5BlqNvlxq79+sguAqD9phSYNFevBsBFgY8sgC8ns/kqXYip/cF7YscUzuJ1Q5xuDKVTJiYHKsbtpHzZWlyYtttdd9S1j/H1IhYNWUDzDkMee6wJv/US5eSz8dWajA27GrtOnJ6jVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYwFGHxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYwFGHxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFF1F00A3A;
	Thu, 27 Aug 2026 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787862341;
	bh=LM4LoupxT1zkzzs0m5yR4DW6kWEASa7J5Uzzh4GSP5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fYwFGHxsojcC+hVNRbZlFag2FtUss38Qfnv5ELMnRF7KJ9Y5hRcOxOGsR777gdOKn
	 UkeHEx9f4oP+3PxXInuVZNlVxPs2BRJ+hRqDr66VfAKZOdjQwnipIkVEMSAywdsqXc
	 00r2S13Hv29Pq3VByAgAwZDZuUTl0wOxb8caDTpxTUiCe+WDzOTBsI42Ez6odChTeO
	 M26zL3U8Md79sIgdNdcT7b8qUMLJNdAD1mPsuQv8xk1qgcPRNwxx3a/pAw6K80mMCa
	 /KBVi2PXKo7zL/Pw7nTyL4WwDVLDhkP16+Bv3Wmr6vzBiAK2z/EkU+VjVSkvethcQd
	 AlQSzFzOX55uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5E3809A8D;
	Thu, 27 Aug 2026 20:24:48 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260827103127.4074178-1-m.szyprowski@samsung.com>
References: <CGME20260827103141eucas1p1a97fc08693ac663d8e8382e2ffb7f800@eucas1p1.samsung.com> <20260827103127.4074178-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260827103127.4074178-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-27
X-PR-Tracked-Commit-Id: 1476cca098f6d3a553fcec6fe9b7d86e15c00b59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cec13314dd8935afbfc0430d9d43fad75285b37
Message-Id: <178786228724.1831091.2047778443859484545.pr-tracker-bot@kernel.org>
Date: Thu, 27 Aug 2026 20:24:47 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 27 Aug 2026 12:31:26 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cec13314dd8935afbfc0430d9d43fad75285b37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
