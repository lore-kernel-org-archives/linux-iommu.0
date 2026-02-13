Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C13EBF2A;
	Fri, 13 Feb 2026 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026817; cv=none; b=e4q1yAga0A6QhzqIMk8F7VDXrqk1fQrX+ueHJtdBPjG2gXAJaHOwn7YeLFrxX2Sn2jcZ2DdEThT2ELCbQkH9hMIv9fST76vv7ofYte3CvXgvGTr2/EORmMTZR+D9soQSwi6wzD+FyJIUfKV3FQPODDZM2wesxqZwSyR17ArbFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026817; c=relaxed/simple;
	bh=/200HuJEVOe9Dd63n9cYwaK6WUDsoKxsdMGX9AeuC6s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hJgyIPOXFIWO5CDG9bsu3o3Eip7XYW9GQUFTFDJztkPFNVLBFdtSoE4xd8QR4wzUvca9EmZ1zPdkEfIpgJoHcwRm/2prXJRvMPNj1yHR8LOXDWQHlzD8/KrRAbxv7HG/lDhm+txanvXCu6IYfeB+CshoUHE1LPzk7dHq4xrTXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnM9k86m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnM9k86m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95070C116C6;
	Fri, 13 Feb 2026 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771026817;
	bh=/200HuJEVOe9Dd63n9cYwaK6WUDsoKxsdMGX9AeuC6s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PnM9k86mg2KVz0B/fAXHfyR4KnW1Q9QxwRRlr+lUsIVhy/75E9PKuvgOA5DO5h5y3
	 suZV6xdJRcv526y/x+u8Orp6/Gnn/3AWGF4EWJnZ8rFYW+SCA1doiAH50baf7yBsaH
	 sT/iBxfcne6XLkPZVVt9CQnNyrhKbI+j+7xC91x3IsjUkA/NnuH6bVyU3XMhu5oNb3
	 7Atpj5PsqgIO1p0Wbb1VfgNtb10vj2NPU/8NywkjAm1oKo+TsAIhJjHsNA0F75PlUq
	 DxDNoH+zV+yTR/b28/STRrT451xJp+/RRHtGclaiCt7LspdNb0FbEBfRno7Nv2xCIg
	 OREodw8if9sNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 853AA3811A44;
	Fri, 13 Feb 2026 23:53:32 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping update for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213143104.473529-1-m.szyprowski@samsung.com>
References: <CGME20260213143112eucas1p150d4777d55a1e013b0e21d5ea7bae16c@eucas1p1.samsung.com> <20260213143104.473529-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260213143104.473529-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-13
X-PR-Tracked-Commit-Id: 8a840ab0567ff2b7d382694ba24a58a893d2c7af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72f05009d804c7ec92459da94ccc9ccb77686950
Message-Id: <177102681108.2616894.5941818050956998355.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 23:53:31 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 13 Feb 2026 15:31:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72f05009d804c7ec92459da94ccc9ccb77686950

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
