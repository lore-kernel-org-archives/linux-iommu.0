Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA868F65
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 01:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF041C433D6;
	Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666402117;
	bh=2NH6m2nyWWNkCu6dKhRmmjC+7R05DApm9d7S2WAVw2Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FlPPlqAsrdsucR/fd2goMAvag8TJ4q8LwVldb/4cY94UUnfzRhdfHhWX5ADT0dy6m
	 l34kz4onFBUVpziORV/CYK+gI3PXxWj/P0VByCvvy0arw4eoXu0xs9G4brZMxcvbrP
	 X2WZYMRWahgJMl1NYJRNeuevXGrHFlJyV8fdrJZMTO+2FeRNzj5An+3+HbPLcYmARi
	 ic40E9hFVZikDbNBqpJ+mJxT4fFhdhtHNHWUc1pjHMp4IIGSPAImwGK6o2JE/OH6jF
	 EFV6TUcNorFHougYPtJ4ReNZX3vh2FeOaObAj9DEmiPn+PfLQBuKa3ug9QnXLWs++6
	 Q2WmzSVXBSn1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B7EE270E2;
	Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y1K56ThNRTpLRA2X@8bytes.org>
References: <Y1K56ThNRTpLRA2X@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1K56ThNRTpLRA2X@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc1
X-PR-Tracked-Commit-Id: 620bf9f981365c18cc2766c53d92bf8131c63f32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e97eace635a42da4644290179aea496178e64988
Message-Id: <166640211774.11783.8745653046282981940.pr-tracker-bot@kernel.org>
Date: Sat, 22 Oct 2022 01:28:37 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 21 Oct 2022 17:25:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e97eace635a42da4644290179aea496178e64988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
