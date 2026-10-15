Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F240B6EE;
	Thu, 15 Oct 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093856; cv=none; b=omdHs/y+N067xbMrVnsvfTqxgx3ASHdGngd3GUdxWxYjkOc2sO3j4F4whNiqsiNSpMAHVcvhItDwJWQdRNM0dzRDcnlhEyAMXfNRHXn9EtMrsmMAHw69y8CnVPYztUH42zpA22uI6B1d3o6kGsZNMoIlB5xh8f9ht+zw2J58z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093856; c=relaxed/simple;
	bh=Umi+NsLNUzp/vpNnOCLZaEXs7VGp5iUfWsKLkNYc+b4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oigvP4JUQxplmQXSscr2h7DJV2YZ/0hvvm2qSgPiRoRU6J3dJu8aTk8cwysylU0JPTCM+TcG8P2xCrXy89iSlo7i4vZfhY7HH96ntKuV40GNrvYXAsNgdOA8ONapta/0hnjtAXnO3o/la5avqhEn67JbKA2qc2CCN3sI5slrOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+A3ExQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+A3ExQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A61F000C4;
	Thu, 15 Oct 2026 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093854;
	bh=i7nK1bZ/rBVIQNumlQtA4en4cFXbVsJieGT1MzFVY5o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=l+A3ExQ2v7rV8RwdEctnd9G6KmBHUQQP3z5lj8gW2CWkuhW9lQw+/i0+8rmEwBfF0
	 Bxf7SN0/XWNQYIpNa4FQVkBlscy0OBWBV59jeaasGsWgexLDlxmPrIYAfOLsmaXxop
	 99xLmr5XQYrybT5MAE42BUAOFfFfLGb6BkKMHvh8AIyzsUbwo+yJeTsYvssMhgkUfn
	 RdbAjddJoh7QkirGqG+98nYb7NQmdqjAO4l8H1SDdRnQ1t+6KI+7z8Wxww0KkhbrwL
	 M7HpCc0XLJ4cb5WAVIuOJIHjMtNsxKaFr9QvzdsYrurFhZCJYeYuY+RCiTpfmqoqbH
	 LF6jbUgSyuENg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B457D3808209;
	Thu, 15 Oct 2026 19:50:54 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <atEdnsNTxq-gWf78@8bytes.org>
References: <atEdnsNTxq-gWf78@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <atEdnsNTxq-gWf78@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc7
X-PR-Tracked-Commit-Id: 4bcfe29021993cb167fd9bbdb849f7d7247a166f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62f482ff73bf3ae88b0c899115527752cf9cbf13
Message-Id: <179209385335.4077689.14927818931280453230.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 19:50:53 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 15 Oct 2026 20:38:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62f482ff73bf3ae88b0c899115527752cf9cbf13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
