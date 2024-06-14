Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2A1A0AF5;
	Fri, 14 Jun 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391141; cv=none; b=Hikb3kjnCti3CQg1kXJw2NhaMH9FdSrZkY7mgOXQmWIJH2GJFQGjoHrKv3cPSkWyTo26a7nOnZi8mkXbl6920aK3AKHYH0cgp6o1cMsGGoqdvHaKgRD3tlWHLaLNPXacrrrfIDV6m9hvlkGYA2R0YCBH/EhZTOBI12P8hZXBMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391141; c=relaxed/simple;
	bh=9Kkr/pbB+nY/Hsb3QiUB7zMIcCe+UpOwOdCKI42w5M8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c+qiKgEZ7o9DL+KvlnsBBgGxJfJ/IXpuSI2AjPQjh3LAYEqgmUuFMLeWHEPN0TvkIh5M16nT1CV3Gw/i8hivXzEKJDSH4MTYPi/EItWZjssKFEKgLA+wAVEXRSKyUJ0gtVpdANRRgujn5ImLDyJBhhyNkSxCsSxBai9qqMzDgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeTbOCi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeTbOCi6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC5C3C4AF1C;
	Fri, 14 Jun 2024 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718391140;
	bh=9Kkr/pbB+nY/Hsb3QiUB7zMIcCe+UpOwOdCKI42w5M8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UeTbOCi62pIH0M0iX/i+Nj649RevslYRs+6w+yAsSnN7pt4XugPy5xTZ18JXZ+iPq
	 urZeAsL9ZSAak0K4mWHhztZy9Q0+gOVkchTZsgcD/p6rm0pPa2Xkl/ORKenWzqsuAP
	 THB0FAS8RXx82yRMwV6u8PaPVkTG5AYlSZiTJkLcuYNuxhDrZOaL6Ru+HJ7cr9hguZ
	 9RkUbanGCyL+j4geyVncnY9bEAyd95yPLht+jA6xMuYBmcAyyJdPYnasNZYF60MAGp
	 NCMIe8IpGZktmEwF3QKaolSXr4aGRS908m6YedGKliKsx0JGibG438eouftgYvxSR3
	 vc1bGonPwSEvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A72CEC43616;
	Fri, 14 Jun 2024 18:52:20 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmxZxT-j1B71PHQp@8bytes.org>
References: <ZmxZxT-j1B71PHQp@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmxZxT-j1B71PHQp@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.10-rc3
X-PR-Tracked-Commit-Id: 12243a8115f8583a6bcada7717c01fb164e23c89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11100273f25e326dd12c4534b1aaadb4df59d680
Message-Id: <171839114068.28657.10840558314640422451.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2024 18:52:20 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 14 Jun 2024 16:55:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11100273f25e326dd12c4534b1aaadb4df59d680

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
