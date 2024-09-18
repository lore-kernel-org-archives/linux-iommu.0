Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2618893B;
	Wed, 18 Sep 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657807; cv=none; b=PWA/xBkmegW1GLkXlPSelmQB3qe9mDmO4Mf7NoQrAQ7nP0pkGdrrE+6YxHL6bQ0A/sED/TsemjKo8WLh/W+DmOPKH+f5hBAvMUaRblQ5CXAtWFd+6aDU942DoqxhpwQfxlNDJtPJMf52ZUsRZWJlbBO2h8TT8nsyd6AvGVcFSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657807; c=relaxed/simple;
	bh=2MXc1kDaGAjtMzUX6LuE7F2HGp/ycUIBbBcqt7X/xYA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MnzZNeekEruUXblAdz8SZM8Trk0dLDcf2QfDYi1m6tD4LBKOqc4aC0JCWklfuy5BGsZlwafk+T1Kn8YYkbPDLnEhfbJn3d3G/IE5mBxTYyeSUiHfZoqacGW4pUnEfqt9GYA3uI21AZiS7j1lYktEKKN42FS91BX6BbiAT+gcpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2hFNluE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2hFNluE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEBBC4CEC3;
	Wed, 18 Sep 2024 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726657807;
	bh=2MXc1kDaGAjtMzUX6LuE7F2HGp/ycUIBbBcqt7X/xYA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R2hFNluEDGNwvjQDQX2elhY5fyezm7UtKCLpfU5vMoNFEYHf6dn04D9I55wCv40YW
	 eZ5/qV9WMzh0fiTI1j8kDP81sxMnTrm/Uc88MVYT89CdaCCpiCMgZaQhUUmz/gxifU
	 cNO3wL1pXF8/7MkC3MvHyrrHGKwWaacP1BJovob89S9POnxLOkxqy0EURnv5XOND3J
	 wzGjAfM3kZfpGc6t2SfyNQ8MMLs2gk/5v4UlJkCzrswlNYu9wBUBJFaP9uCCzx/iKr
	 Ut0wS6GgMkIlF2RQ6XGgSMjHISxcAIpfDqx030Y3Tf368ZcdKgI5udw0mNUvZb5YMS
	 sRaDvRqO/ZnTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6D42C3806656;
	Wed, 18 Sep 2024 11:10:10 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZugDc8ryLmadGXyp@8bytes.org>
References: <ZugDc8ryLmadGXyp@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZugDc8ryLmadGXyp@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.12
X-PR-Tracked-Commit-Id: 97162f6093d263aa1c2c7e883912f922ea633512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eec91e22fe9f05846a7410beab671f26bef7ba7b
Message-Id: <172665780917.783948.3772868917407014927.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 11:10:09 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 16 Sep 2024 12:07:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eec91e22fe9f05846a7410beab671f26bef7ba7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
