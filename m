Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F31DACB8;
	Thu, 21 Nov 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224032; cv=none; b=lljn/IAl7TT6J+73nmCi1c3RhExcF4Ql0mtLXlXC6a0PKHFhYTCtDvEfnPCaQavETW8QsiH5CGG6g4siKPps6Xqonx80jcrguA8ff0iC8K33q/HUjsIPe00nbb9i0wVWsWQ6zygve+J1AtqObwY2ERsJbjmSDFjUX7o231aRHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224032; c=relaxed/simple;
	bh=IxpblIWqpZu0HbLvgLE974vg5LATqEGl+Zie56CjbZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P2zjSQu/JzBY1B28FCX5o7+F4pduhefWuTtIJAHbCRGEVw8D6KuWTwS1YiXtWxveS5ol+rn5CydKfJqhqrdadQTzlwmHQXM4TaaKTEjq5CNrvyN2qdxSMxJGwUegudruSbzlEHw99b+GXW6oXCZ2MGpEiiuLGq4MvUJh2fIjK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/KlMoet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/KlMoet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7EFC4CECC;
	Thu, 21 Nov 2024 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732224032;
	bh=IxpblIWqpZu0HbLvgLE974vg5LATqEGl+Zie56CjbZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s/KlMoetYJnMJv75UPtPWSwZuDphRNn70VS5B/Tm9n0Fo4+/sx3iahCp8t51VI5rk
	 TZ6p02lSbOHgk+FeoD38oJEImmzLxNSN4ZLPoXC2DQIG6Z9FZm7nUFoLo51cqReTEL
	 bk9B8ZEuEjsmU4Y1xdbJpGxn93t5BjGKj8qJ5HTfFi3pUDgfMbSLAM7VxL1VCW22eM
	 0aS4F+IjOLgQX2OaqJlugaHxOzvRbc+IGT7wfOVMBe/xtdrJwwrtHC5e5i+srQv737
	 OUO0Mn/gWzcmvuOqXyMBN5NOXtgMW8vZedq16h3hER/B3Ql5Ej7ePDLhnTI7odLbWu
	 iimSCHesVbTYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F133809A01;
	Thu, 21 Nov 2024 21:20:45 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzzFkZHDxrgq2B9i@infradead.org>
References: <ZzzFkZHDxrgq2B9i@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzzFkZHDxrgq2B9i@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-19
X-PR-Tracked-Commit-Id: 22293c33738c14bb84b9d3e771bc37150e7cf8e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51ae62a12c242e49229db23b96d03ecc15efc0d1
Message-Id: <173222404418.2113520.13041009891626099755.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 21:20:44 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 19 Nov 2024 18:06:25 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51ae62a12c242e49229db23b96d03ecc15efc0d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
