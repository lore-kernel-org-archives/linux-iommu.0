Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5220E30F;
	Fri, 18 Oct 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261016; cv=none; b=OHY/vdOkAnmZltwIsgVv2GmY1XgZXaEBX8gNM9R9bLfcI+dWchDSUmdqb9w5zqvTgCvfevLhqe7yRD/n5qe5sL4o6XoPB9gUX9X/6mUy6nIPZ+paHM863TRO2HqC4rFUeONvrHDMoteJuD965o9FW6cXRFh+p1UIplFXCBcNCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261016; c=relaxed/simple;
	bh=Qjv4LGBapouiLntCuhtpOuIErChW8N2emOUOuyq7ibw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t1rSGNhvfesw5GkfKLDHr7RMX+B4iF/ta7pFLjsXiQu6ltFiGgVSgNz9eIyIOMHcnv7y2cirJ6edbIMb9MqDVXBMG3Nnw8e9gBESoydb7AqBGRT/j7op020wy/KhYWw/oKZGxhZgocP5sVluG+LPg3ZZ/SJJ1dSrvjmSmh2XOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umCpfVwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umCpfVwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C4C4CEC6;
	Fri, 18 Oct 2024 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729261016;
	bh=Qjv4LGBapouiLntCuhtpOuIErChW8N2emOUOuyq7ibw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=umCpfVwUI+mbL5Zc+V+xUlpZt7qAQ3k/AWbgmJMi24dgZA1NRbSz4rcU53FV+cA5k
	 JHsdRkPH94OmoWAvSFSQk1DaiGlcp0xRgwRa9dSYXfT8oOW6sx3jcvl0OEuCa66oEB
	 s17aLajF4Uwk68VhlY2qEqd5XS6CFGfU8ugfmUQaRLZJxD060cDGD4vv18DgHqA8zd
	 TTlgrXNqsFGvI9FHzDHTRaoxCXGadO+QV0o2o1vU/f03zamXWUzbXb9LdOH6NpotSm
	 6e1PBQ4Yx7yzcvmvOIyM+dA+q4G/RJZEU04H5uCFITC9jNOsblf8//pty7ncP70iTd
	 WQItwYihThy4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED73805CC0;
	Fri, 18 Oct 2024 14:17:02 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxIi9rUNnv1HOPpr@8bytes.org>
References: <ZxIi9rUNnv1HOPpr@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxIi9rUNnv1HOPpr@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.12-rc3
X-PR-Tracked-Commit-Id: 6e02a277f1db24fa039e23783c8921c7b0e5b1b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75aa74d52f43e75d0beb20572f98529071b700e5
Message-Id: <172926102134.3129992.1622022412842618651.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 14:17:01 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 18 Oct 2024 10:57:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75aa74d52f43e75d0beb20572f98529071b700e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
