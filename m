Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687F1BD9D0;
	Sat, 20 Dec 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260110; cv=none; b=Jf7wSBd2VzUOTIjJt8Nq697Vz6pys2oZyX66PhDENzNYBm9gCFwZAod66e3oAcUISgyMPfuDTv6ajZmJQF8ovNALQXe2l3jWm4HNgfKKRhUxLtJ8/YjNdMLCxpGW0QjXFYDJofvwUgld3TT1HZmp3I0KXdfmL0uZvRnq/nMd2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260110; c=relaxed/simple;
	bh=P5aY9qysziEjDbbCOhWzExpXwmq6WMTAh+HRK9cllBI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OwKD4NmNK4ti5ApDBZHSfYEXNoqF9nduKbcWtgXhhwizpVsoHIruC619d1W1hx5zy58DrmouTdZazhMvIoPtbjptnUD3jeNFOOHSU6Ry4pNv6A7Fj4BiK1+jLakdZy8HBz5FrUONJNu98ST/JHFXQ+NA1zedB9i4cj9/u0qI6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXxCgGgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXxCgGgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32700C4CEF5;
	Sat, 20 Dec 2025 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766260110;
	bh=P5aY9qysziEjDbbCOhWzExpXwmq6WMTAh+HRK9cllBI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UXxCgGgV4AvSDz1bZV4Cj326csNi7C+cF40rVMF/JWxAskkUIbPbNj3w6Whz0fM8P
	 AvWtppmHLqL7L3nzxL1W2VPcqLiGmA9g4AG1z/piwL2t6Jr08WfcsZKCCMCFpvrti/
	 HRd6OFEQcYGHJ7hLmM9WSJ53zSc4/VcPiF/O9ap9JzdG2qoHuBMJgrOa2S67LN86GS
	 oGlxsGpXTMhsmi56BsHuq5DA908jHqMtSjeO4hZ5GwsfQNz+Yi+YAv9a4LUu0WbW5D
	 xPQIYDVt6ySlkhej2GOQtusz3WEMLnDIa8uPKyGIZHvcXv/Gvul2k7Ig5XGUKmeW2c
	 YjqXT2tS7rWFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789C43809A05;
	Sat, 20 Dec 2025 19:45:19 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <grcmmaikbzo6dn2b6j43l2beyuci7naqdtukc3lots5dtffo3q@ecsf76as7mm2>
References: <grcmmaikbzo6dn2b6j43l2beyuci7naqdtukc3lots5dtffo3q@ecsf76as7mm2>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <grcmmaikbzo6dn2b6j43l2beyuci7naqdtukc3lots5dtffo3q@ecsf76as7mm2>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc1
X-PR-Tracked-Commit-Id: c7fe9384c85d31e35bb61574d7a742ba59fb27c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4a3d52ab97169bba66dd718acf43e559ed5646a
Message-Id: <176625991803.123080.355996404069953477.pr-tracker-bot@kernel.org>
Date: Sat, 20 Dec 2025 19:45:18 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 19 Dec 2025 14:24:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4a3d52ab97169bba66dd718acf43e559ed5646a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
