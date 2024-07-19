Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066F149018;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412570; cv=none; b=jsAGYiidgrA49CksPdS7bEl+5jTWMawKhrSYRLHiqkHBIKU/eFgwLvbYZZ+vyx4MqBWhTfUAYJaazTiXt+PkD38V/VxaOIit374YM+CfpCwf+ZMrwE3BI84e1zjguYiVrjZHOyaBoY6/odEhOt3ZFWfygwSYawxtHfVsEvPI2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412570; c=relaxed/simple;
	bh=3OfrNDfs4xXp/fGf/pTnSzqtl3Z9mO7O3TQgXSYpD6o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S5vd4hpTw+qbQEN1KH7IVMAZkXBsU+bxKlc1XEgKCmqxGVIm0E0PowZIH/rXI12euOC2w1p+bmUJCDxqMdp2Qn2xacx21PgLCSufMr3FDguHiV5WcfMxu8sWzsbkSA0QZKzER/yRlUqDLupVsWZrZb4bbCSBySFcmbICyvrTZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih6vLcBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih6vLcBj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA36C4AF10;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721412570;
	bh=3OfrNDfs4xXp/fGf/pTnSzqtl3Z9mO7O3TQgXSYpD6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ih6vLcBj0ub808pV3SL7bKFyE8rGWoslrYtWLmYPj4g78OA8AiWBbbKL9AS0UbZ7M
	 Os2Q07Qu8GMCYSTdj9yPk0sReaSw/rnivqUR1Z9AyBOs00/naS0LyTX5yOVahT7car
	 JHuedCohinegpD2Q4zRsYW5Vs8/Ix5J45qzcxNeciHG2BGs3UJXKeiYDD5+WQv6/CW
	 He4pCuj6ONgoCf9dV3aAXsfJvg4TgAotBp1p8Fb4nJ55fnFg73RA5FwAvhOF0GLqMW
	 Q/xDDi/HyERKG2KcgxwJiimz5ug40uNAre3Vx0LtnA2HdFU3tCv6ezv8ztFecEKI/n
	 4/2INJhsfLtBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05C51C43335;
	Fri, 19 Jul 2024 18:09:30 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zpn4hhOk6GAgXjLf@infradead.org>
References: <Zpn4hhOk6GAgXjLf@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Zpn4hhOk6GAgXjLf@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-19
X-PR-Tracked-Commit-Id: b69bdba5a37eb6224039e9572e0e98fc3a931fee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afd81d914f6fb3e74a46bf5d0dd0b028591ea22e
Message-Id: <172141257001.2862.391205994968692873.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 18:09:30 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 19 Jul 2024 07:24:22 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afd81d914f6fb3e74a46bf5d0dd0b028591ea22e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
