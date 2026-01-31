Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982C315760;
	Sat, 31 Jan 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821265; cv=none; b=iqa4VLwcWtzX7Gi3tsHJE+IckSC0BCbaqAuFM1hg7fWpbkxZZNg976PCAmVmf+u9k01lMHusWjhjZU0SMDyWMV/dNW4LuKyVvU4HTGqalVXYTOWPdSNE4sog3/sm++ZupRh5gSRqQoGPBrqzbTMw/zzqZY7g0AahYl744cxsbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821265; c=relaxed/simple;
	bh=fT9V0fh6LsDfrpzlNi6fOLuXw7GwWl/GqOa2CSP5mGg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s1H4V8rr/FbQLbvt0CKjNWS0shAKIHxkt6VNrjdnsYgk/b2pAf2prZqG0TlbQNWqXVhtuTu6DjYJ20mGUaoqAsUBSRgB57O31cokt65YVog1vqtwNcFAg/BxUKr/nbOIWzcRANfxWMzNN9nUU7Ho7TyfbMuC53iK5ph1R+ejHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXxHFdqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXxHFdqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBD1C2BC86;
	Sat, 31 Jan 2026 01:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769821264;
	bh=fT9V0fh6LsDfrpzlNi6fOLuXw7GwWl/GqOa2CSP5mGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LXxHFdqE4Uikg2lfUBvU8ZNFeyw7pRooXolJFfJm8UgMrDDVZyaw3BboEmMlDEQdn
	 K7qJtWNwGLOGjtqU+u6kylClJfQ8hp97l84zhHBzMVRFRIfuwPsODg+8YP+2ZxEup/
	 g1yGC5bOmTT6nA1WpC7juDJAK+ufnt7BdtA3DKoWEtCJ79yz9Ose5C3aoQBHxWN5R2
	 BOpEmaQBjKiBcX9ThdaqjyxwK1MhemMFHmkM6GRcotlGAjdmyMkavplhoqK2Cq5jBs
	 8uhDCorfGfVpQ2ioS968qxKw5tXwAhpnMWD8BaMjiVSa0Kt9L2ibjpQRsFpeGHsZ8+
	 zTAX2Z8zcr+AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC73380CFFB;
	Sat, 31 Jan 2026 01:00:57 +0000 (UTC)
Subject: Re: [GIT PULL] last minute dma-mapping fixes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260130133445.2069751-1-m.szyprowski@samsung.com>
References: <CGME20260130134440eucas1p1e639225c498d3f6668f2f198860a9900@eucas1p1.samsung.com> <20260130133445.2069751-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260130133445.2069751-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-30
X-PR-Tracked-Commit-Id: 56c430c7f06d838fe3b2077dbbc4cc0bf992312b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b54ac9e0cf8986e138736840f20d537db22ce79
Message-Id: <176982125635.3947395.8316555071441136316.pr-tracker-bot@kernel.org>
Date: Sat, 31 Jan 2026 01:00:56 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Sai Sree Kartheek Adivi <s-adivi@ti.com>, Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 30 Jan 2026 14:34:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b54ac9e0cf8986e138736840f20d537db22ce79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
