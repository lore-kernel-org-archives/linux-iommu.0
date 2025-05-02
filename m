Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51425DD16;
	Fri,  2 May 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204042; cv=none; b=aCnXsr4TxOCDWDva0bpbl5741BTTQM6IHCzeKZDyvq/28LIu1NX+9gMDqPL3JS7G8HvJTeqWadPjVYWjozUNeZbHQz1O1omS0IJGsHWd7wSoXzOqd2DcJfXH/xhGNDEQwCFRK8YrQvuzrZLgiY3j5B+HRo9YKrxzdJU3/g4yIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204042; c=relaxed/simple;
	bh=pnKbokfHDEy+/0/sMAN4JKeK3BX48tDI2vzUDgtyHyI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u42U0RPYJrhb1pFAnQU44qVUvDK21mIMTLpXH4CVEuzmxP3IT11WoQnkCpONgmmJGQD5EaZVbiLRySyaU5y0C3ZbR6DBFWufL2+BOvVmObpeNTI0NFIg2zag0Zjvn9G7cN+sU3vY/uXPaXTn19mkLnOfmV7MBb/vGbOF2mQUn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGNJCdha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGNJCdha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6945C4CEEF;
	Fri,  2 May 2025 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746204039;
	bh=pnKbokfHDEy+/0/sMAN4JKeK3BX48tDI2vzUDgtyHyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FGNJCdhaE3FtjryMCQqyJosjGmT287ejUgvftkF4SwntIXYye9Sv+HCwXZt5bO/FE
	 Bl4eyyuS55UoU2BnVQP5Bpj2tiCX0UfNbqp/oD6CIZmCu4bT1R07godiCMIgj5dwBb
	 T6AON7L1NP6Wuo2AEQVHhXRq0+2DI/CVTY93ECqqc/5842SIeXQ5pVJf3+yV/nJsB3
	 1rjDCkkKgtZpRRaOAoCltkFFCr3csc+dZBkPd7cgA51WAdy5CFPodzLotStWnegww/
	 pjB1k2LnLahVpaYYWiJpC8TWO3EdQcu2ZOQvL9y/Uh1YbZkeWSXOsZ4TI7SB2zfhvU
	 BGdTH0umrVMYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2A380DBE9;
	Fri,  2 May 2025 16:41:20 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aBRvWCTS7c_j6CCa@8bytes.org>
References: <aBRvWCTS7c_j6CCa@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aBRvWCTS7c_j6CCa@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc4
X-PR-Tracked-Commit-Id: 2c8a7c66c90832432496616a9a3c07293f1364f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8164851725c867f74fc0e157f13a7f257da4a7db
Message-Id: <174620407879.3671706.4319814310766626858.pr-tracker-bot@kernel.org>
Date: Fri, 02 May 2025 16:41:18 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 2 May 2025 09:08:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8164851725c867f74fc0e157f13a7f257da4a7db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
