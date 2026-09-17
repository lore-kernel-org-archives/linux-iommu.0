Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E50279D;
	Thu, 17 Sep 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665220; cv=none; b=AHh3OqefOUA2fS0xChYVsvqxZhk33YvkghGeqWrhKx5m9s/XjUCtntyz+RjYEQg2cpVuarBSTW907TWw1N4A5lLCuDleaHku6RKxGpdVtuWoTH9CTmzpAncXRNBt7GeH6XxWTH3FXbUN6yD/PbcmzxlaVP9DLdiTCX5T1QZ9fgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665220; c=relaxed/simple;
	bh=sZD/DnlV7yU3MsXv7r+/KzRhOulnYxgwUkzzdcu7F3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Znr7oWDl7636AHvwJGjUy2ndVEeTXxQ2JWOIpREMtM2uPwOTIauI27z8MQxXTUDbIW/iuEOuY2ykCyDe5yhv2fv2/ftUTZs2x74y+c0VCs8O2lqky0DsUiM3AhYvQWzRztDyeuqwWAV5SVYSrbEH2tyXkUVPnNx6/cOgDjj8jY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQpRypiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQpRypiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BC71F00898;
	Thu, 17 Sep 2026 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665215;
	bh=HRU18s6JcAMuZnh4jIWXw0Z3VXt+PTZWLiSMD+jgSro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RQpRypiRLkEB8l24E0K6ej9fqztNfBqeM6/TCA6FNqix5f3l9DFkJXg0uRTceQc0O
	 jAlYFvDNdXsbC2XE56eZXWWrXF5alPnSCeXW43BTEM9YrPIKQ5HOyLB0iJuLfgqJzF
	 iEfm3cfCgfLlzTGUGLVbCRQMVPjC525jJtNCsWGF7PsSzTDHoNH82kBbEabgvd4E0X
	 R67X2wUI0L7oep8YXk4T3r8fUQzA9cbBThFLEzr5O5VOpCVe8GsEp1FOlsrff4aduA
	 fmcZhuou+8beIBrwn8ZTFVGCjGRKe5N4+AK6AAcqSTXejlsIkmV2caXL7JkXxoUmlj
	 Oan61W8Ho8Qdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0EF8381197E;
	Thu, 17 Sep 2026 17:12:29 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260917092443.342396-1-m.szyprowski@samsung.com>
References: <CGME20260917092456eucas1p138229ed33c56428e9c0f2247245bad18@eucas1p1.samsung.com> <20260917092443.342396-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260917092443.342396-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-09-17
X-PR-Tracked-Commit-Id: 55a8e1451869233db837a97e8f3cbf9983bc8678
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aec9ad1c668755b253bff4d95a9d82a17d2d434
Message-Id: <178966514833.3773542.10450757662913674151.pr-tracker-bot@kernel.org>
Date: Thu, 17 Sep 2026 17:12:28 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 17 Sep 2026 11:24:42 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aec9ad1c668755b253bff4d95a9d82a17d2d434

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
