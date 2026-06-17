Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB838B127;
	Wed, 17 Jun 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725209; cv=none; b=gm0N/SfYr5PIV2/UIYxY1fDuRkKQeVK0nimVlAaQEtNcpo1DDRLExayVBf7jWv8CP0cVj8AZyEWwsbfh4NugYdMj41i4EH7fmwe/hMQz2/TCaDw50fxbD/D62T5pjDkJsoHmSXI38nPKUWVJcGA3IP2+KLvc1SAzbhfMEU+gsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725209; c=relaxed/simple;
	bh=qJvjr/hiMD8oTqfx/fRyi/FryFDd+8Ho8cDyA0A+CjA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GQYUfOZUhShXvkg6rdjbWVregSJdvsk0gMV55pPZGTVuyhOZtkKw4tzVx10T4v7r9/sCZXL7vuiSTIVxwAvcH9+ID9/30LzI7C80KvGK2GqKYe72zyHJ7/iRSTxG4RGyGvX0U+vAc2m+FC5QsYcWN5uxWATl7SEMxkVyTdENvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOUpMIaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOUpMIaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0B21F00AC4;
	Wed, 17 Jun 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781725208;
	bh=cjrfcpvo4W2llnfq4TNkJvZChO2mKlwZ8mtJjSw9G4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HOUpMIaGJJwM0+SNmUke0pKfRA9CzWNklkw3q57+tk8rYRIjHLQP3PPEYkndvmt+o
	 mJwe19ragS54yWH+PWcX9ibvVsX5Me5A5Na+mVIO+8MHxaIkurBfrGzPrrntUChxIA
	 zirlW092kxVUCBxQXqaUOaHimHJBEi8jIhPhHI9NUd4MS3/hJza+Zc8OMGpg4NGoQx
	 qeN9nbs5diq4kUjwYG2ujnwLDvqcBke3KcCYW+IKfGrWUYCd+A6oaEcMquc2C045pX
	 /ZIzRDIaEubfV+NMxk3c6MS+dzlcm/N+VQUl0gTS+11dp+Nlm7kj7mkofIyej0dbYB
	 zFVizAf2M+qTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74C583931009;
	Wed, 17 Jun 2026 19:40:03 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260616091630.3261096-1-m.szyprowski@samsung.com>
References: <CGME20260616091643eucas1p2a8cbfd992db37b6863c2ce7e30a5b9f5@eucas1p2.samsung.com> <20260616091630.3261096-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260616091630.3261096-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.2-2026-06-16
X-PR-Tracked-Commit-Id: 7318301e060e3f1207a34f2fca6cd86770dd9160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cc14386e35030d016478b4ab9b10a6a95727003
Message-Id: <178172520223.1784504.4414977589423295692.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:40:02 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, Rosen Penev <rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 16 Jun 2026 11:16:30 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.2-2026-06-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cc14386e35030d016478b4ab9b10a6a95727003

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
