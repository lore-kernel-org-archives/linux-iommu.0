Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4B63B
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La5RrBfn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28C2C433C8;
	Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475550;
	bh=bt0BN6stBYKeRTCmHTszNnfuLjPp/UVFO/XjnT3OMZE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=La5RrBfnIkmido+iMK5A0eKpSQiUw146pMX5WJJjuAe+v9zbESYLN8KZNcjg8Qobk
	 Cpe0y+Nxf+WdL0O3hI+qTmRbrRRiJno5hrMfGm7P4ma782UzF+iaUL4n4UgqcwopcD
	 pHra76Zh02tT3X+D3rb2wlr0CxXBwXmztdwKelcC1iPiWIsHUt9gEOGzYWJgjlmfjH
	 S6PC4wTetyUxaBWDEyJTcpAjQFb0NxI+kq8Bqpn1v/tkRdFnjDtGUrZ9zTgp6fqlyO
	 N01mqsx1lbfEZ4/ml2c2yQwEXdQxPdtURu/G1nIQhyHV/vyYCWXgUKJTRlcmcwLYib
	 Y5L8+s9/w/wjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF13DFAA94;
	Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
References: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.7-rc3
X-PR-Tracked-Commit-Id: c2183b3dcc9dd41b768569ea88bededa58cceebb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a2b4185669b6318cf75ec18d13fa5f8779ac073
Message-Id: <170147555058.9445.7883700317061628146.pr-tracker-bot@kernel.org>
Date: Sat, 02 Dec 2023 00:05:50 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 1 Dec 2023 10:48:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a2b4185669b6318cf75ec18d13fa5f8779ac073

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
