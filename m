Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49181302CBA;
	Sat,  6 Dec 2025 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048038; cv=none; b=rY0t6GPZEwIirXf2InWnV2pvaA1gPe3Mk8nVAStyVWgJdi5bhbgpfkdsUtY8h8dyQpZufxHBTs1X/5Tr+S3PsNNAPZeDLRh1IEE5JoD7cOmhnlVMAC3yREkQIsI5KiKoRkURF0F46boFeC07DyvVEmrn95Z9c36VsQ/iK1qwOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048038; c=relaxed/simple;
	bh=D9apDIe6xpDH9Yz5RiEYF7XYtz/iJbgE+LBirwpQGas=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WDATQmpAWY9m6k519y9v0G5PafrXM9TRbTX3NE7MqY3lGfcVxB0ZZ3oJt/TNYs/wjBHBJlPhk7qHbUNqpw9kLSgzWRU2iTjZVwRhjeEwaX9g5K7wQpmI+cyYXmM5sQAXrQUSAUXU+EXBZroYitfD5Qolw5OWG1mEME86UyC/qKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGnlD0PT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGnlD0PT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7388C116B1;
	Sat,  6 Dec 2025 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048037;
	bh=D9apDIe6xpDH9Yz5RiEYF7XYtz/iJbgE+LBirwpQGas=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tGnlD0PTINXSfYO5AlzTy7AoO9Z2QvJW/5s/qoUnHaur7jOPzlPTnadSV8OXSeBp1
	 fRiQggsrv5IcE1F1T2AKswXhu3US8VElmxO7WPVQBx0JD9jnq777EONldEj8PTxDxv
	 8qijyNNYm8KqR8AdumXLwe96Y5cqoToqcxMh6lCBvfmVCKVSlngI9oY6sRb1VInEjs
	 IsrFWWErXq/wFFhnt67zkBMS8EUfz5iWmPf1tJ80CLzYuOREsv2YLyytBLaRzVxk6i
	 GV5DQXB4yc6gZmq4HhOQEQJzHfMnn7Oca7nBVW6VBhyFMYY6umIBzmf7UTpFhXnYhu
	 jBosdolUXbx4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A163808200;
	Sat,  6 Dec 2025 19:04:15 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251205142211.1639096-1-m.szyprowski@samsung.com>
References: <CGME20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c@eucas1p1.samsung.com> <20251205142211.1639096-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251205142211.1639096-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-05
X-PR-Tracked-Commit-Id: 131971f67e258170c678fe572fda95f8cef88e66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7405aa92feec2598cedc1b6c651beb1848240fe
Message-Id: <176504785451.2170003.4986913218974050438.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 19:04:14 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Qinxin Xia <xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri,  5 Dec 2025 15:22:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7405aa92feec2598cedc1b6c651beb1848240fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
