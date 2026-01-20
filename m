Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0179450904;
	Tue, 20 Jan 2026 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934251; cv=none; b=mEaRsyeE2UMcYkC774YY4daEJt86PQ7rZtmTTM6c3kOeFaqLfztP9ImxXs0h/EyeOkiu2n0ANpqSRfn3fatGd+sPhGc55GQ0rJE7z9XJTRdBJdCayC325+VvbrcS+j8Nn0aqOlYT6g8be3cIlgknDFk0vxbeOQVvIa9g+6BPq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934251; c=relaxed/simple;
	bh=lzyqulrMfk4ds7dWWZjSUEwhWKaqP6Jya10OAkj7aII=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Leb4bh8rqerAJRntz6S/3tFXurxfhwuUC3tGM6M0F75MNcjEd9tWs9xV0A8GREcVxVc3HqpXRDuLOGlsV0UE7YyKZyRsTiUN+leInf9HfqN0GMP+EJJz9o90ak3QtH9BLmZO8aOLD0+ajje61rdaqw7X4c0pqsHiJMRIGFmYkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGKslq/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGKslq/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4734BC16AAE;
	Tue, 20 Jan 2026 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934251;
	bh=lzyqulrMfk4ds7dWWZjSUEwhWKaqP6Jya10OAkj7aII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cGKslq/hfQ+dT077sl/MFbps2aucs6eGNBL4KwphkdbvR5iLRriaFxUjeLEJemXdU
	 VWAqkYZnuj8TKlRh7QGpOcGCpJoGa95jez6gqRduiuT9ARZ+X/m1JuBAlJy9NpKtwF
	 oHGuQEDMosWQNk2UeT7AiSYTrXbad4ItniqumF43UDOGowcFJWeHcemzVMeOvKjPwO
	 mwjSJFP9dg5JG7wrv8QHoEobP62Q5elSXjFbGdQM6yid0Z13npdJqP9tHePnSBWbo9
	 FIA4uSljZuD3NZCMNpAXLHGI6n/MW9W75Z7vn3XQTejT8pL3l0RpgDCDB7fbDyc7ON
	 lujEwfEGoI8bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B3C3810935;
	Tue, 20 Jan 2026 18:37:30 +0000 (UTC)
Subject: Re: [GIT PULL] more dma-mapping fixes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260120141942.3674759-1-m.szyprowski@samsung.com>
References: <CGME20260120141958eucas1p152c74f446ca0a743d0c97201bab52ac7@eucas1p1.samsung.com> <20260120141942.3674759-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260120141942.3674759-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-20
X-PR-Tracked-Commit-Id: c6ccd098807483762ccd726e1498bac5a71d0005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c03e9c42ae8f9be76a0cf55ef3f88663f0f6a63a
Message-Id: <176893424864.562471.15745725137796680736.pr-tracker-bot@kernel.org>
Date: Tue, 20 Jan 2026 18:37:28 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 20 Jan 2026 15:19:42 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-01-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c03e9c42ae8f9be76a0cf55ef3f88663f0f6a63a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
