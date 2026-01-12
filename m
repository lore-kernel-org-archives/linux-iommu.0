Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9D632;
	Mon, 12 Jan 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246902; cv=none; b=IZ7ZerxL9SRwKiyORB6t+t6Y3CSdAaSlBjgHCo9m1FDLtix43twdh7V3PDn+1/tvlRNPKQzpLQG65Csj86sOQoAOicoON7BX5VkNwlcGdb1SFLYvAwy4cuNtQcIrNI2hkbuVLMZGYSKTpmGDiTIGCOyyL4DLBKvAbSNoBgJm8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246902; c=relaxed/simple;
	bh=K4qN7yUFcwubWcUubI8UvkFpdnFuSTuW7vE4AYw7cAY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SL0kWCd7EQ6KgBCxQOhnk/8+FdF5EKitcJk10T/Jdqa0ex6VRuagrRq5hkOffeTTS3/0VpB5hXz+b92sac+bD+uVcMaECMHjxvptdwNKDA9SlgN4dx4ENKIB5sXIGLVoHsud2dEB63K9CThbJMCyuCPVkW0OFJTuqoFN/xz/zAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFA1RCNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFA1RCNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38916C116D0;
	Mon, 12 Jan 2026 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768246902;
	bh=K4qN7yUFcwubWcUubI8UvkFpdnFuSTuW7vE4AYw7cAY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DFA1RCNEK102J+j+WzO8np3uZ+ov6rvfkA9xFbNNooIbsIkf2wutBj9Gzl5NVxOG3
	 LNttfQWNCCWuaVKxdNSr69w1CvbyCufBvm3PayQXarWfHuRoDPbK6AuCEpP8CjjDwr
	 RH3r0jF2VV7NXAkjbbo1KZ4xTOEOiNRRIRbg3DdXe3+yBdiy0vU2shslsNSgKESE6B
	 5qtlkY7hbUjb/nNr9/bzMD/YZMCRLzsaAIhG9R99zghlEAzveOpI8cV2AsDCFlIKeK
	 sDuZVNjkZAQ4oI/hsU5uYcvJcY3Rtht1CB/CIkCpsPMOkkFjvZ15SS9QBG6ZxwGIw7
	 Ym++kqGJ1rTTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4224C380CFC3;
	Mon, 12 Jan 2026 19:38:17 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <2zpyoiwaldo2tywqq6kiigojntryoe6hbh5pu7cjesedip7csf@e6utyv33jpmo>
References: <2zpyoiwaldo2tywqq6kiigojntryoe6hbh5pu7cjesedip7csf@e6utyv33jpmo>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2zpyoiwaldo2tywqq6kiigojntryoe6hbh5pu7cjesedip7csf@e6utyv33jpmo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc4
X-PR-Tracked-Commit-Id: 6a3d5fda2ce464a80a9af9e358dfbab6a989ab5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97313d6113ab4362ad15076f65560e65288fbcb8
Message-Id: <176824669596.1091852.9529854051489918436.pr-tracker-bot@kernel.org>
Date: Mon, 12 Jan 2026 19:38:15 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 10 Jan 2026 18:13:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97313d6113ab4362ad15076f65560e65288fbcb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
