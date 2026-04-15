Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E40248166;
	Wed, 15 Apr 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292745; cv=none; b=JikPNJ6zUel5na82GPQJ+1qk1Gr3tgy9dW3+efScKvGMJihRdIFt6NdK9hYwhbTcRUtc0p29aGV10sSPuv7rBtmidtxJRmATzLnt3z0V1hUcPUpkLMOkoSieMEbYsGGNl8Lm/NfvCphfNrTxSST7aMMYyxDeklvKOjvyevQrWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292745; c=relaxed/simple;
	bh=hW5VgXIk0n+rfwNhjtDwlbzHA1WCo9J00v4/s+PeC0k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oApyfE1VwO4mit3t9KPHeucgdwhoRQUhE7dnrYX8YEDc1NOuPKJy+j4h3CFkiFLQHK3BUc2cDBslxAxBqW5Flvsvd5JZbwPj1+cCCWI2oqj7mJg224O9/iYaeQiVQ8jXwo5PbRLFLFzMYiv7UbdbRfBRZxTA7MnRdG+txzUi148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W19Xyr6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W19Xyr6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF36C19424;
	Wed, 15 Apr 2026 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776292745;
	bh=hW5VgXIk0n+rfwNhjtDwlbzHA1WCo9J00v4/s+PeC0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W19Xyr6z4edVVGVjdQs0srPhzhKk+Tnlvbd2JUX120dOmQDAS+3sv8n/WQ2ZblZ9c
	 v5ZYRZy74XC6yXMKpSsnbec3tFEOJqNy5mix2E3jcC8FeevuITOsfXoTAH+8I0nGS+
	 KfBXTkVuAKCT0+h+hXt96vzN5rXBw1mQ+6nMMvPtGpz6hkSEVonfOD9dzTA2Toools
	 kZPb8r32VnwEl22JQ+XDr/XaCkRDHk/8VGYEy6drmjNuWkFMKl1b11qYsTDcaKDaJm
	 Nw+YKDzGjTo6UNRll3dvT9MtkDnOHjfM38eh7IXG8EE2jWubmoJGDdGp8ongnH6vhL
	 HWDJPdxwxigkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40002380A963;
	Wed, 15 Apr 2026 22:38:36 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <256dnfavvrodzkhib4d2vy3irictbb62umjdw2uh2hwm3u7zua@7wwea7jpebxi>
References: <256dnfavvrodzkhib4d2vy3irictbb62umjdw2uh2hwm3u7zua@7wwea7jpebxi>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <256dnfavvrodzkhib4d2vy3irictbb62umjdw2uh2hwm3u7zua@7wwea7jpebxi>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.1
X-PR-Tracked-Commit-Id: f8d5e7066d846c92ecac245134baf8a207becb65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1d26d72f01556c787b1291729aa7a2ce37656a8
Message-Id: <177629271485.2482053.11740506744852865207.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:38:34 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 14 Apr 2026 13:38:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1d26d72f01556c787b1291729aa7a2ce37656a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
