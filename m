Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DD423A76;
	Thu, 26 Mar 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546259; cv=none; b=RpgmKYUacA5KJ1x7RjIkNWWvefGy+KxohAatzuhvVTqhjBNHUPSBHFRo+o5LTJe1KUbBsjMtVZqTGsY1LEphiOpVUoubrsLAyBeK5hKyRzJj50nBfp1XYDNInm3YH30liK3+5ObOab3i7j/PK5z/erKLGzJAlxGbJ4GWIGh+L4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546259; c=relaxed/simple;
	bh=4EeuRosMZbwH6d8OipWeJaJ57dZ/HpX0mMvnqarsT2I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cEsCccRDQ+H9cnLfjSUfwjaMAZRoyk0wW35VZpQ9HLtuUtflF6VtEpxQu4Q0qvAI2lzF/kTyOl67DiQekwpdXNwvkAEp9jrWHtA7uh6JAux9hYqkKkZ86JntBiTouvtQt/kpI83K8Qp7m5RHvkt6sl0AGTGLrH5VHgvnu/NdJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEMhqzrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEMhqzrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B36C19423;
	Thu, 26 Mar 2026 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546258;
	bh=4EeuRosMZbwH6d8OipWeJaJ57dZ/HpX0mMvnqarsT2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dEMhqzrXfgR3GVgtHLB8QRIG4sxz6g07auvPxK/hD67sWqRgIb3sSSwzxomF1pPi7
	 1jIviaGE4wvpIUTQCqc27QwVHEVcS4YwfPWxuih8IivUFQAgP8z2EgiJjyUzfVxWww
	 GJzDFaO6LRZUE/vuMSsRKziE2WKUlTfeGNGI+K0K+qoVgvVKjvCjYl/dbErvRlMTPk
	 eI1vuPffVGESAKnwfCEIKgGuv3kAloRo9QsR2mLbDW6MU+8w2RNo3rmtgxlNj1moJJ
	 hUAqHt+0Q+kK3k9ZP3TNib5VU2txA+EHzD0JP3pqgK3gX/H205T358N+3OuT/FKPVO
	 bnTlA6kmC8nKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6D39F2037;
	Thu, 26 Mar 2026 17:30:46 +0000 (UTC)
Subject: Re: [GIT PULL] second set of dma-mapping fixes for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260326075200.1751363-1-m.szyprowski@samsung.com>
References: <CGME20260326075214eucas1p192a7e540eed96bae33f17cdbd3745d9d@eucas1p1.samsung.com> <20260326075200.1751363-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260326075200.1751363-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-03-25
X-PR-Tracked-Commit-Id: 2cdaff22ed26f1e619aa2b43f27bb84f2c6ef8f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dabb83ecf404c74a75469e7694a0b891e71f61b7
Message-Id: <177454624484.3098378.7934674180683409569.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 17:30:44 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Shigeru Yoshida <syoshida@redhat.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 26 Mar 2026 08:52:00 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-03-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dabb83ecf404c74a75469e7694a0b891e71f61b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
