Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E163F7E92;
	Thu,  2 Apr 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151529; cv=none; b=Lue+XINwQabGB7WQN0ScVhQPY8OGmQGtd5Nby5CbGXAg0o8kJU3H4m2CF7i3De8KB/QuoJodb1YQgHtxB3eaQGb+rFXc4/7cWlKDd8Z1973p73vruEbegNDBeOwfrHBvCZa8Hc4a3ZiBgABvXYdadoQWtRipby0CjWR/kVr8WhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151529; c=relaxed/simple;
	bh=e3ZtVG+on/Lm5CvtbwItFOqppCja+UJ6D/Y8x2QJcso=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F18pbZt4Dlnr0kpgc4pZwyqhfKnt2KEqvSq2Tluj6757M30mXiGSCBm5DIfl4hnob11Q6xtTAmShsNyT+pPaZRh3ufeihNG8UDi3RP3jauu9E01lQPNvGWuHLb0Si7oTxp98LbqXytFS5wSTSKChl+f/K3yT7XJKDJsYq6w02KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh8OPEcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh8OPEcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D624C116C6;
	Thu,  2 Apr 2026 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151528;
	bh=e3ZtVG+on/Lm5CvtbwItFOqppCja+UJ6D/Y8x2QJcso=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qh8OPEclx9dDaqY6CmC5nxo2b8KFoKkHUMWBhx1xG2Z72tzWfHiagdkk63Tdkxmbv
	 dyirUg9voyKXRgkwzrcB3CJpQmA+6tBDDe8xvB4p3nj1feXFes/OuU+3hcgm/MAa+E
	 lkYd++n5p0noi7GdITJv1CXMSOxOgecqNiU/mGkigEzFAuQuG1TcQ0cU5dx6OBweCG
	 jHwSd3Vu5PeDb8Rrbtw4wxDjhoIKH8JH5OwMwawgprIaHbcev1PCknfZ8dqqO22s8L
	 w1Hp13/1tDJ79IUY9Fyp7WE3s5R9HzXx40sMTiy/FkoitrGlzf1h8StQZiZZaLCok+
	 wAciqnqpN11cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030293809A08;
	Thu,  2 Apr 2026 17:38:32 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <5bfq4uev4ljcwc7ntw4zphscwmbazuh3jrebsbcohcmnriisa2@zonteyjx2cua>
References: <5bfq4uev4ljcwc7ntw4zphscwmbazuh3jrebsbcohcmnriisa2@zonteyjx2cua>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <5bfq4uev4ljcwc7ntw4zphscwmbazuh3jrebsbcohcmnriisa2@zonteyjx2cua>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc6
X-PR-Tracked-Commit-Id: 8b72aa5704c77380742346d4ac755b074b7f9eaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c2c526b5adfb580bd95316bf179327d5ee26da8
Message-Id: <177515151069.547608.2588675636010628800.pr-tracker-bot@kernel.org>
Date: Thu, 02 Apr 2026 17:38:30 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 2 Apr 2026 14:05:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c2c526b5adfb580bd95316bf179327d5ee26da8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
