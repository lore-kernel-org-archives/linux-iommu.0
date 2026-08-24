Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723D369D45;
	Mon, 24 Aug 2026 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599140; cv=none; b=aIQqp459RknX/gpDuUYSxS9ieE5tLHJ8a785ReXIvvKuf7xHvVEO0I5iMHIWnV6Ur9sNV6CIwShTMhgtRCC1rX7jKPb6vmDsV8ZfN2p+J6aUuXC2Dd2Dp+WUwveJFFOgWZmVJM/fXCmvtf7yHW5a4xHL/QWzSp/evT8dw3Xjo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599140; c=relaxed/simple;
	bh=XCvNLW1g/gdkHWVaXKbTdN5cyvbphmVVkEkzIobf9/A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PKPn4MUc5/8hy5WN1dRvOXycffFk2O46oZLgL5jqgjiQkbfyHXovfyQrEKykF6+ZOslBE5fSGs38jb67bkgn7hfqlmXFALuYfCa8EqBn6p2lBtcKrz8QYz7gUoCsCCCngmfmNOsoYFvW5IEssl64FR7kVUacxkyHvpKXuKRdL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na94BTRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na94BTRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA491F00A3A;
	Mon, 24 Aug 2026 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787599139;
	bh=Nd0lEx9hD6ylLpwOU9yD0wtJ3+jV/rg5UBsT4/paZVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Na94BTRF2RKxdkL+GaueRXmE0Ircw2EfbvvwCsLbwOsTjgK3B9rTx/kvlVO0PgzAe
	 WIiH5041aIY06VghRYSALGmPs7okvNfsZd04XRbTZrfTJPxfa9hUg06HyovG8fQ3lK
	 6Zi8xpWfQVs7pjFqm3rfO57bFpl38WG8mzRhm30G3eD9yh5AR4l6hOisw8J4Vpf4hc
	 txiY8o5eIx/AOCVMV7kh6rAf5oY7LhfNuaWnWBZcffF88lwQtpq+4YW0Lwht4HeQ/k
	 Lfb0GdLZdl4Wlvhux20orhrZVxbL2Ld8QqJhMYEZ2p88S6t9hCkDxz4LoWb0ACv1Qp
	 NpPOWDCkBXGfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D903924A4C;
	Mon, 24 Aug 2026 19:18:07 +0000 (UTC)
Subject: Re: [GIT PULL] second dma-mapping update for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260824145253.1740671-1-m.szyprowski@samsung.com>
References: <CGME20260824145300eucas1p10b9c95dddfc11e7847607f9c473b6f38@eucas1p1.samsung.com> <20260824145253.1740671-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260824145253.1740671-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24-2
X-PR-Tracked-Commit-Id: 04a19b35dc05354445f0096befad63af885bb77e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f43193b88188b184a967c9427602e019f1b8708
Message-Id: <178759908641.3075085.6062286800482339777.pr-tracker-bot@kernel.org>
Date: Mon, 24 Aug 2026 19:18:06 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 24 Aug 2026 16:52:51 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f43193b88188b184a967c9427602e019f1b8708

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
