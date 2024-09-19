Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD419D09D;
	Thu, 19 Sep 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738801; cv=none; b=mr9E77RoDOcBwpsM8tUw9BVeJkI2WIdxml+dHm9xYD9s8AYc93g/MumEhpDpLZNDPLaDhkxD4jRFYzlQyWKuUI9KJnoO+LVRXk8OJXtpoI4MLiy3VK5QqmlbIEiGnApFrUu2NT486Jb6Ax3zO2EGiPpnBONXOHcg+ff40hUKY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738801; c=relaxed/simple;
	bh=pXFh0HRlI+qnpwBSbTyFva7eUNJi6tvx27w8helXoO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ixdGPdvnUBlfTMj8C+CKoUrCvVED4CeXgi+rk2igrQj3bKFjjBe5eCyEi5QUoqp6EG9YMi94Oj82sRacJ2iPPXnKyS8qcWXUExf5EC+FFL3mk28PWPqRO155HcJLlc4/VxSVz8YHXKKd8jgQ2aW8NFD6zFT0GCmHVu37PsBDyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6cYRWK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6cYRWK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396B9C4CEC6;
	Thu, 19 Sep 2024 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726738801;
	bh=pXFh0HRlI+qnpwBSbTyFva7eUNJi6tvx27w8helXoO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P6cYRWK5WcfAS/HvfPeRDxh9NRI0bb1+iUkhdItOPkHCtnrtzYjWBx5GIh2apcADW
	 E2C49hi1PLJNJPT/N/FdacoERJzQRKv1AABm1fVQkH0jgEv4XzEN72AAArYpqP9Qdy
	 DDNATEbD+8y72TDlrK7rVYa797CzLGOhCZHeIgm6qaD3oMkPzGSQvIfrO2S8osTS/A
	 cAbye/aTtcVkz7r3V/U3oMzw38BFC2iQj+bYFaCpihWboQ7NHyfetKkn6485Cm2KmR
	 /CummS01Ka58aPoAd9MakcRGdtMxljqE6sdERoQq5n/vlgA02ogbMdG2Ata4JFHI/R
	 61926UhiUWulw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5163E3809A81;
	Thu, 19 Sep 2024 09:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuvYnXzbM2qfXQPT@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZuvYnXzbM2qfXQPT@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-19
X-PR-Tracked-Commit-Id: a5fb217f13f74b2af2ab366ffad522bae717f93c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 726e2d0cf2bbc14e3bf38491cddda1a56fe18663
Message-Id: <172673880309.1462306.5201479198069833055.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 09:40:03 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 19 Sep 2024 09:54:05 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/726e2d0cf2bbc14e3bf38491cddda1a56fe18663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
