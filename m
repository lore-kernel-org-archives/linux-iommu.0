Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8528F1;
	Sat, 14 Dec 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195970; cv=none; b=KMfif4olE8Mny0g+15uBcjy/bGM61VKJa7hmuhHLAZQvK7SfkkFsnAgAmAsGUAWl8f+cY8c1ArXGYLQipl/IQj++MHCdwH9WEvekHEmTJKrLhQ6Abe0V8qleE+s2ltRoTP07KdPl/kX5/4Ts61JIzeYlvhUnFqkkQ85xD80eGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195970; c=relaxed/simple;
	bh=H3jTgGE3cpg49GP8vbyozDEeTRj74vN4SpaDcMd4br0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ekgrMPSSQB/MK2+gQi4q7BxTBd1DC06LvXLElbnta97SQPoaYEZUW36fjZFqBP87FhRHicSsmZT2xq9SmsS8AVOOvo2Dmo/WNrXtefyWrp+nPMtnIbNokxioP3x6JE4nxxRb8OtNb6+WWgIhxrVtGuZ4jmOKnRxgl4YoTCatKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKSIr1X5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKSIr1X5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A00EC4CED1;
	Sat, 14 Dec 2024 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734195970;
	bh=H3jTgGE3cpg49GP8vbyozDEeTRj74vN4SpaDcMd4br0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FKSIr1X5xtljf8fWza8dBIIQ42ZL4yDKTrmItZKkNgY62m46veYQEaYv6spQWBbcR
	 qRz1Grj/3ucZtxgnDRXPuC2Q7NXPREypeKatTZE2NpF+C4gPHXSfTUz67pTqPbIX7z
	 MqkEX+IJm/ugYS4nlzBovm1aAmRKNCwSzYlVIvKegsSfMs1kb1rsPiIMfV092xccB8
	 py7fCGtnADKQODYrNh5UiXWj5yNCj8IfOXrwOXh3s12/siH/JMDyf/oD+LR+k5ard/
	 dR478N6PIvRdAUnNqxnnRP2F9YVZiBF4tnV80MX66tc6zJnVLgfkWDZVOd6mZpHhmn
	 phw4Q9rI3Eiiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB07D380A959;
	Sat, 14 Dec 2024 17:06:27 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z11PVKcR4-rJhQZD@8bytes.org>
References: <Z11PVKcR4-rJhQZD@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z11PVKcR4-rJhQZD@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.13-rc2
X-PR-Tracked-Commit-Id: dda2b8c3c6ccc50deae65cc75f246577348e2ec5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115c0cc25130c59025cab8f8a5f1a3a97b1e16e1
Message-Id: <173419598646.3359607.11029142147584167075.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 17:06:26 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 14 Dec 2024 10:26:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115c0cc25130c59025cab8f8a5f1a3a97b1e16e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
