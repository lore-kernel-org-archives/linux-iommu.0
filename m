Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E35CAE
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8060C4347C;
	Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665435397;
	bh=G7z+dCtaDjBzuWQSokVn3ODByWmdzT4WQo+I5GOC2DY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bAnEuqBjUb2GtYW2C8cdshfztacHlyXq78dhErAcS4acPx5SlUiIDqJq6UUf6RnP2
	 tEOEEJg6kcfMq0m3GQ9b4w499bL8xrVHukB/Hb+YP1FpjsJhW/e80aPI8AdxfUxs6I
	 SlXDN/est5S2CYA3MPhbRVeBs9iYAL+E3P2rK0csxlCI76sNAf88Cqpb1I5MgCfqwk
	 EAX1Lj0DbSM7/gzO72L7oS6QBk3NyGrIpA1lo7IdrlM5hMHi05wzo4ksUXpimiVT6D
	 nOKMQ+uJ3JMnacpginrjJqFFTp3j6909CkmsIZ2BzSty3L7okiHU/KN6QZV61sE+ep
	 ZomNr/+YgqzUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 982D2E2A05F;
	Mon, 10 Oct 2022 20:56:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y0QMOy7g2nADghrJ@8bytes.org>
References: <Y0QMOy7g2nADghrJ@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0QMOy7g2nADghrJ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.1
X-PR-Tracked-Commit-Id: 38713c6028a3172c4c256512c3fbcfc799fe2d43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f23cdfcd04f7c044ee47dac04484b8d289088776
Message-Id: <166543539761.11766.7130453309101940100.pr-tracker-bot@kernel.org>
Date: Mon, 10 Oct 2022 20:56:37 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 10 Oct 2022 14:12:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f23cdfcd04f7c044ee47dac04484b8d289088776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
