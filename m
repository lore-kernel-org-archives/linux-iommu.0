Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574333DBD49;
	Thu, 30 Jul 2026 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449775; cv=none; b=i0OAiJvNZ/HOb5fyQHQUe5d1RVpo/da0fNF2TlumYj+FLGf1BXNXzc5/1TTS9Qwg4UEX6iZFpjcxzkNx9RAcybOB4Wf3/p8T6xAiFIUEN6BCo6lkZB8wueQDg8X/O4VBvLONkHChfaMN7ihjRccprx5KzzbabzS0sjQs2fl3zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449775; c=relaxed/simple;
	bh=DoKRbscpCDrR26fRtNn0eIP0Y+AVybjT/JN/gaqiTW0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GQRV/snUz5YBYtXNH4GDsgx2uJ0EIUpyDPVqWS882wMnNFlh4fTnLKrSE/ltX+avdv6SQhHg/xZfZpSnZQk9vim4C0NfRq3vAGZxCE9E6cSHffy0y33/pZj82SQjpFPbx/rDfpkzLRJEX2D4UM3JngiIJz2bbrRV6aZ4coe1o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJGzb7sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJGzb7sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1471F000E9;
	Thu, 30 Jul 2026 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785449772;
	bh=Dw31y5BhJX3zMgFYR8i5bO5ijSAkx5zAiIoBIbGcNuk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OJGzb7sTeKIQJTpvW3G/W/nk/FYI5ASFx9PtLtvYPMFl51y1jAF3884t4o1Ts9oxu
	 e0y2Cmi5jeqWT+Jhccd1Nofk7fUr7wSLpmZxTsefWBC6xT2baqV8htbc6LbjwScMAO
	 kcHXP/uzMTVXXLpjq6NAaoEUlX5fUdfR1Hx0PCOfXy2Xs4e3fqqEJTobfreJjkKxAc
	 fU61zbQhTcVzhd5VtvRZW1KiJ0LFM86lp9yJb9awB7q7oG4iG89Voik95Rvh2jftKf
	 Unurs3FvNfG1LZHgSrE6cfnDu2dZh0ArGZGKIp1loWET6WgYvwrK0t0OpXro8cJNAT
	 qclt4nWmniM/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A583924459;
	Thu, 30 Jul 2026 22:15:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <amvDg1M6+Wu3HwSr@nvidia.com>
References: <amvDg1M6+Wu3HwSr@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <amvDg1M6+Wu3HwSr@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 738e6f32e61d80b554e37015ecb7bc620b88001c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e05b559f9cda350d0ab33c44a8c1151ca62d2875
Message-Id: <178544973530.11712.8930571783434264316.pr-tracker-bot@kernel.org>
Date: Thu, 30 Jul 2026 22:15:35 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 30 Jul 2026 18:34:59 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e05b559f9cda350d0ab33c44a8c1151ca62d2875

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
