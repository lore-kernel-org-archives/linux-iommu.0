Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364813698E;
	Sat, 10 Aug 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723313183; cv=none; b=ciSYh4TjHcIIts3rWSM9fFW9HVu6CcJ+qIpDWZQ55u76XcSlmAymLk5avEAF821mYXvWiJIAn+o6VXBMCJeTHR3Q4MLpXeAXn50qXtrM/8J/tS9+TZzyNuqfFBHxvXb+q64ZlbZmcXP8FnrK4kuEzVIlt3yp0chpGJzqVUsk+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723313183; c=relaxed/simple;
	bh=ER72TH42xf8C1IxZDrl3jIfDCe1ApLaXESkCsBnaIYM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ryDE9/cUInFM/EX+2VnKdBMZgZEhTCKVk6CmeYKI3sDX2UT08BGTqkrqmdknfMk9tvm09SavTtFsZR/KXFbterH+Ei5JbCRZtxnDnHyJNBLUaIA+67pqfB54z1DWrrMfbBY6kYORfN6T/48Mj6NWO/L1r8AJtoSO1j7lYTWS280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Mf9QXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Mf9QXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69062C32781;
	Sat, 10 Aug 2024 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723313182;
	bh=ER72TH42xf8C1IxZDrl3jIfDCe1ApLaXESkCsBnaIYM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y8Mf9QXLbotFNrsTCohNVND8TURyfN3exz0wz5tyd6KiitwoQd7fWQBHpFoU491cH
	 p0M+5v5LJ4nXnugPBujtfF0Jf1/udhNngRP9RXTT6Yvs4I1LXz9W33qaDAWEv7QIdX
	 OXQi5zDtbB8x+Ze4Lf56kaST+1vtDWFgcJxXzyZjnjY9vUBi18+wt0aE/kQnPuVFQD
	 abzey+F5ifSiCM2SjHbYxQS7i+7hGb7XHoC0FJDHI44qgKTKtG1UR/JJdN/rqGWTEu
	 x2AgR/La09B2W8nZQf/Jt5zMeqxfQXFVEx7BRP5+fSKXFsVfT9A71cOithuGGh6mii
	 jjOZQfUP6ntwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789C9382333F;
	Sat, 10 Aug 2024 18:06:22 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZrcIusRi8Z1nlJTw@infradead.org>
References: <ZrcIusRi8Z1nlJTw@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZrcIusRi8Z1nlJTw@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-08-10
X-PR-Tracked-Commit-Id: bd44ca3de49cc1badcff7a96010fa2c64f04868c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0409cc53c42129cfeeaea610d0ebb91934491dca
Message-Id: <172331318021.44953.8754334118955613473.pr-tracker-bot@kernel.org>
Date: Sat, 10 Aug 2024 18:06:20 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 10 Aug 2024 08:29:14 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-08-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0409cc53c42129cfeeaea610d0ebb91934491dca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
