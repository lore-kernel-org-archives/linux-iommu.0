Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813727;
	b=3Q5fIktlcB5sKmtI6Spudl3g+OloLYXGTqYDUZHuqAY9AaNrzaJ79hGckhdwUwXMjej8
	 TM20/kF9f9ZxBllI8ivHN4rJhMdW8ECYjg13pDg3ciLt1mhLYMXNU9/ep/hGV1T3XF2VN
	 ccwUnpVcQoKqROUMvXLD2/tpUBhQSw2SQ3vsTbLWmQigcE21aWq/AN383bwtb5j/ftgfP
	 FI+O2LI/j2jt3uVFHTRW0TRBtt16iNSjOLEJVaULHXosc0vtvvA0l3Dg3n/NS1BiQD3Yn
	 kVvQ4gCdWKDmX7Ozj+hS/Wdebi09VonFS4gfIZEclfVpuko4+6waMJbHTs6mKsqsI0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813727;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=hM2qNgS5XP77Q6VJ3q+L5S6t064r46tcKHRAWA/weR4=;
	b=yaGumBVx2lishsEyrCMoABecRhAJpY/yE5qKrjo1pcekDuy1LTXjSBlV2UUodtoUig0L
	 MvSu5moVTE+AX0/XMVT9CqBlijnXf9BkgZElEbfloW2ZsFt3E9o4kbLMnXTB+ga8WLElg
	 wpwFMBFZGZIwQkKzhj0jyh6GGBrX5AlunrEsbjRON9doObgp6tCSgu6B9nLskk41z63RK
	 yfefNHBC/nJmdcz3YFZyTqztzAgcx9/K4K7JYMUASXzyeyjplSuTaQ7hR0a8nnSKtLJQC
	 LSxwtF8WAo2qCn5SdiW8FP0fRa0OvEtlMXrFoe4+YEtRy7we31c+kKEwWX9uKPAVylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMLNY1oK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61606606A321;
	Fri, 27 Nov 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMLNY1oK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9DD1F0089B;
	Fri, 27 Nov 2026 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795813727;
	bh=hM2qNgS5XP77Q6VJ3q+L5S6t064r46tcKHRAWA/weR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HMLNY1oKU8V+COLSkIUQ68/TmVeYSxuEUQk4lwHrwbCtVWEvADh8QBkRfEp8mfqzP
	 OWp4NHiKWa/9+JD7DeIB24NinGgooGS4or0bhsXiJrdJtSaQN0jVG0BwR4zosHBsXR
	 +ca+U2a2jFAPaS4MPRC+0mTWYs9/f4RuX5Y5GAtU3ZL/NqoXRmh7w66qq/BfJEReXk
	 94e7u92wDjoLX3SiMd34CgK45NVifwPPHEZlRPLKY+IakzWvSatPYV+ZmATChV+Unu
	 W4uW0Pxaz/EmiSbeTBcwKYtJN9+Qlmhx0Y8T9e8zJWbKCdOYQj9UTWJuh691P2ECvI
	 Wtzi3KoE8BArw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3492C3927065;
	Fri, 27 Nov 2026 21:08:47 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <awml8VcCjRQKHVXi@8bytes.org>
References: <awml8VcCjRQKHVXi@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <awml8VcCjRQKHVXi@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc4
X-PR-Tracked-Commit-Id: 10bcc637f7a657725dd8bbcc2b30d027acee6f2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c8611425a367d250339cdb05aa898971d35abdb
Message-Id: <179581372594.1686500.11038876807079457331.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 21:08:45 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Fri, 27 Nov 2026 16:47:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c8611425a367d250339cdb05aa898971d35abdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
