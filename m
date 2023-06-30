Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B017EC
	for <iommu@lists.linux.dev>; Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C008AC433C0;
	Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688098609;
	bh=znCQpmhTfXUE877jJ4hkyBv2ALfcZH3Ig1NWgRLP3T4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QolZP0SNKkAIUO9cJ+WQoD0VWdtX4mVQEn9qyovtJsAbTa9LDEgT0c3G234H2xiD8
	 S4KuVx5rVL4AARGXYnIToti1O7yN+B3Z+wAnCKtza/6p2HiKSMP0OX0LuBGYUpVwbM
	 VXcSNdIJEtpxAnxGbTrYgd7aw+aQ/oHcy/IKWoadWmnw2SXI1/c0K14gzPTN9DOQ2X
	 NWL8/nq/p/pXrwMNTdd+TXM5Py6Yam1dnV+Oqv0ZO3M4cvaysg/G9YXp4wD7wTubcM
	 9UCKK76HFwZR9Nn0xdBLmtG8D7ThUabKbcsHswgNilMVg3ldJLiZ0GB5kO4wsjDd09
	 GGpy6DNE47e5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF865C64458;
	Fri, 30 Jun 2023 04:16:49 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZJWfBNRk89N0jfgi@8bytes.org>
References: <ZJWfBNRk89N0jfgi@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZJWfBNRk89N0jfgi@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.5
X-PR-Tracked-Commit-Id: a7a334076dd725b8c3b5d64f68e3992ffcfd1d25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d35ac6ac0e80e55bcea79af18d935f19a3e8554c
Message-Id: <168809860971.23778.6044069114339914650.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jun 2023 04:16:49 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 23 Jun 2023 15:32:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d35ac6ac0e80e55bcea79af18d935f19a3e8554c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
