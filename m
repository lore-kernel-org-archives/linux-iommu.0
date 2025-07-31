Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8A253F38;
	Thu, 31 Jul 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992088; cv=none; b=e6UeFT7eInWDVz+QYl7j8kc1AGyhITpvLWQ9FaQ6THN8HFa94KACJy7v6xMwLo3LdTk4pAW1pHZ0rQRnTMAUEEgJtS0n93QahHAN2VjDp0D7BVSGKkxV+3wWXfPkHPwTbWKV24VMdcJ5f9B5jtN+/ZQ1iMZUm+Hk6SftYVj3ChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992088; c=relaxed/simple;
	bh=2uoUc9+lOOVvx9Gi64hH38p8FPZNOvKYWNppI7sGdy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rc9X8KAdfL7x+222oasAkj2qfADXHhvQRipeFtV0+yzNksACVGFYxPJR0ygSi0xUPMyQQrMUZ5WN0VY93v1+uQmOEYCiBLmKbByb/5A+61ZdMwJKn/znfyS5zebQccDXZZm7WtxMwSDMpNPm/NobYrgkifOkg9OG4Bt/30S23ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeBEDqCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeBEDqCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57802C4CEEF;
	Thu, 31 Jul 2025 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753992088;
	bh=2uoUc9+lOOVvx9Gi64hH38p8FPZNOvKYWNppI7sGdy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qeBEDqCE5q0CUlsx29veJantSVD2DTwk6I/XK8rTEVoaB6T3EJ34TZaf3Muo26BuL
	 2ReDHn5RSv/6ARLJOE0BNdnZ+oZpfAlW3lJwCxHESDP4lmiW+e+TF6okRZx4EZs2CM
	 190stpGvxouxNipZUcUinP19RA2fB3zQnLzeYicCap7KdfTI6FrDyIwaVLUhgPOBzh
	 +2Vh0Mf8Oqtlhz2V8ijIWYrmqJfmjFseRNFhnXqbwzi6ivSg8KxkhldQUjtu9ahbYL
	 ciCcKO00xw/c+e1/DT35sKocNaGG+vYKh4vUpk1/dL+IV1dZ3HHTwCQlHJYCcmf1d7
	 6b0fQtpM4yZeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3409F383BF51;
	Thu, 31 Jul 2025 20:01:45 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730184734.GA179487@nvidia.com>
References: <20250730184734.GA179487@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730184734.GA179487@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 2c78e74493d33b002312296fbab1d688bfd0f76f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c93529ad4fa8d8d8cb21649e70a46991a1dda0f8
Message-Id: <175399210391.3274898.3571852572592711065.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 20:01:43 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 30 Jul 2025 15:47:34 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c93529ad4fa8d8d8cb21649e70a46991a1dda0f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
