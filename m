Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74633342517;
	Thu,  9 Apr 2026 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768269; cv=none; b=GvovfOwQHFN/1N/HZa2lNROYfdH6Q2t7/NXTfmmys6pQFaQuD4RaB+tFoyrLi5DFAC2Ab6IJCIQrTWaM4PrCxPs88Agtb3QOH0VHH0eBfxyrDy5Vbj7b/Q2wGnHxZ0vjjwP1ivDPoMe0YWhq5omTzYaYSW0Hfblk5cYjJ/V9mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768269; c=relaxed/simple;
	bh=D8iGuQJgegK2KacHD+mx4NS7/9X86cRQNuV5QQ5LmaU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WfEhyYjq9r9183BAmy3R1PVhJoJhacD97YpYcHo6CnueS23Sh1jS3vhPJdKRORpc1bYzkMRoOC6O0Ipf73WQv1mS6oP+itgT7Wjl3zRWa+zPhLqM9kew8EoUOY/n5otkXTyCAclLrxv0tK+u1ea9T+juOx1qQGN33lOiAguxhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKgIWcRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKgIWcRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF6EC19424;
	Thu,  9 Apr 2026 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775768269;
	bh=D8iGuQJgegK2KacHD+mx4NS7/9X86cRQNuV5QQ5LmaU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GKgIWcRNF/WXBScjjTbZrM4lq+tjFYLJVJp05FQ/RscrUneLRvXQ/HrXYcS07PY+E
	 1U+3yJEEVtNvzxr8lpxVCKDUVmtSwF4pR19HorZMOuO0/f/gp4kYVrR3apRo7SqHer
	 dZvMpGolvXC1yyfu+WhbtCHUeTvoXq6wAqyZ6UXYNaHnuJ3nfk0SObhi+ZLdrRA9TL
	 Ojr2kQcjT8f/lt4a/ULG5DVkGYGgxbbESj8DkELXsr6Jxa5cKJstr0B83Sl+y+qLyn
	 9FSFCBoDEIwE3a4xF1ijlMbrHZfzcH0oLMjT7ajUfiNiviW8WrwkYOYMoBNJECz6FF
	 Nf6EYdkWoLMPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1F39308B7;
	Thu,  9 Apr 2026 20:57:25 +0000 (UTC)
Subject: Re: [GIT PULL] last dma-mapping fix for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409162701.3657907-1-m.szyprowski@samsung.com>
References: <CGME20260409162706eucas1p1823b4c676d51c8c9875fbba53e3a4db5@eucas1p1.samsung.com> <20260409162701.3657907-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260409162701.3657907-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-04-09
X-PR-Tracked-Commit-Id: 3d48c9fd78dd0b1809669ec49c4d0997b8127512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ffcd57823c4feb829efe46dd5135cd5fbf28e36
Message-Id: <177576824421.1737704.11634779464978619429.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 20:57:24 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu,  9 Apr 2026 18:27:01 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ffcd57823c4feb829efe46dd5135cd5fbf28e36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
