Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292233793A8;
	Sat, 31 Jan 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893812; cv=none; b=V1tZKJOyuh4bLDEsrNYZDUwXrbLqmXL/DEHJMNidYvnKT0vNHspPFFdx/nFM8N9G2pUxAzDRJ6YhtuIQba3VCnkz8kipWXFF9uMC1/86PNiBkvWbJeAujNb1OfJ6c8lPT8ZYxdQpcx12DFwjMmYDpZiTNWbltO79JtKl77yf4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893812; c=relaxed/simple;
	bh=hCYxc0hq8guqzr2AkyxAkTXBwL6YFCHXuzLotELXTdg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qbDGqPHzkLfskBxzJqoMGgj26Rhs/Bubcta6anu2w900h1Rp+dglP0uRQjdALzUvqcmtREYdY1xV4qX2Vc9Qflh26F8IXaZxM0LuuD6+OrhriNGoasUphQYXE8lZatOdbPHSo2hd87qzS2Ia8Q/yPp2F7SST+xyVuhKEH/uXe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8Oq0SVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8Oq0SVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE8C4CEF1;
	Sat, 31 Jan 2026 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769893812;
	bh=hCYxc0hq8guqzr2AkyxAkTXBwL6YFCHXuzLotELXTdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b8Oq0SVcSB5k9bzxHteuBB6T9TFQpQpPDbvyA9T0bSqj3UgvnAgAy1MuI2o+0w5ik
	 EQ5vPM5X1sx08Q7uD0l3p8SLd0GnYMDvzgIIv2juemMvvoUvDKacM5ws1rUxi/8gZN
	 Qs6/S2MXDsmUsRtLNme73nxKK1EnlmFzMRLlr3H8Ce4mz95kIlKwPbfU1n3XSBmX5B
	 +eQ1lgWITLsk5unS8LFpgqGocaKW9OS8iYk7Mca7Jp3M4tzaW+/z3taXXLSnwJb+L1
	 nWzfsiWMajRZneAdbvLwvdzH7gG8KkHY8w2z787q8Ps8qJCs8YMk4abjSSs+UxOkD1
	 6Tbu1R+x9uubA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AB9380DBD4;
	Sat, 31 Jan 2026 21:10:05 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ue7jcc4xnwaif3yjubemtfyavmebqu7n6jmlhwlvkqhyah3r3j@pytdvipbgjqr>
References: <ue7jcc4xnwaif3yjubemtfyavmebqu7n6jmlhwlvkqhyah3r3j@pytdvipbgjqr>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ue7jcc4xnwaif3yjubemtfyavmebqu7n6jmlhwlvkqhyah3r3j@pytdvipbgjqr>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc7
X-PR-Tracked-Commit-Id: 80f1a2c2332fee0edccd006fe87fc8a6db94bab3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 162b42445b585cd89f45475848845db353539605
Message-Id: <176989380367.4190632.18320159725808793805.pr-tracker-bot@kernel.org>
Date: Sat, 31 Jan 2026 21:10:03 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 31 Jan 2026 17:31:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/162b42445b585cd89f45475848845db353539605

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
