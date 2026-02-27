Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A72BE7CD;
	Fri, 27 Feb 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157409; cv=none; b=I/8hKEHqbrj/uAPyUESYRz0KPyPbSy72oCP+yp1qurscwDf5FG9ZS9IHjYTQcOVFaaCoMYC59all0rbd86iZOs2rLr7Kv5J4U2XNdROyKDmj98dApjDz7Fxup0Hszp5Bl1OP/HluQlB8y40teCwyXUN/Et+Bh08vZUMQwHoP7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157409; c=relaxed/simple;
	bh=7gh9mn3aQhHYH5M/r9TCovnNwr6iC4wvBKCpbFHUBsk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KWYNnOekUAFj1wh3MLqoGPSzvD6yXi1+fPaDvubVLDizEWEik/0490ApexEuMMTj+3ta4mTDiXtITQ1pK3sJt7mSYer29a77Wshram9k245G3jAqugV2OPdifH+rTAo7PsrWyXUYjOhHzCgSpGl0bejTS5xF65PRvF2ge03d7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+9WEf5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+9WEf5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60103C116C6;
	Fri, 27 Feb 2026 01:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157409;
	bh=7gh9mn3aQhHYH5M/r9TCovnNwr6iC4wvBKCpbFHUBsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F+9WEf5I+JIF2FB+vVRlLlu+CMm7Oschf49WUh+NDjQoK5FiyCAaV5NCtc7CPGFjx
	 blT0OXpDTa895JTmFnJ2HbC5th1gc1nip2p+IdFrvCljHG5DiAfPD2WMmOdNC5Vulk
	 RSz0esSzhsWZhz2+8rNw801hA8uqUYnzuNwXPC9dquS1ie3mWLHoCHEUSpVX08ARnv
	 Ljn34o1yGeXVrDhShNGLpeSsCGylyjzL/3fXv1UcXCURj8BHQspOvSBKbtQ0PYgoVl
	 WeUEtSwK6tIaRdDD+3PqNZqgX3SSKPuLr62c+CfcyzjqIve1n2p3TripfSTi3BM2cV
	 qlVMS6rhp3fKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA017393109B;
	Fri, 27 Feb 2026 01:56:54 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260226223620.873540-1-m.szyprowski@samsung.com>
References: <CGME20260226223635eucas1p25ed99f07826bffde88f607c822ef350a@eucas1p2.samsung.com> <20260226223620.873540-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260226223620.873540-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-26
X-PR-Tracked-Commit-Id: d5b5e8149af0f5efed58653cbebf1cb3258ce49a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 944e15f200475d530096cba489833dc6dcd8d1e1
Message-Id: <177215741335.1937342.2027273910560365152.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 01:56:53 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Stian Halseth <stian@itx.no>, Jiri Pirko <jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 26 Feb 2026 23:36:20 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.0-2026-02-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/944e15f200475d530096cba489833dc6dcd8d1e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
