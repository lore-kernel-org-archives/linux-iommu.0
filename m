Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEA197A8B;
	Fri, 14 Feb 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561294; cv=none; b=B2hOxO6Y35h4pyyPNWnNIrlc2BQR+0vJRQplImr2LF/O6nCVuTkN3gDcv0UWyks0OUnAnyOw44AaxuTvE+Fu7owPKZXYm7AymUP1eCdSBujqMixgCepJyKclUm0vDKiG9tOpOaOZZl6hCTRJDwzEVTaE7bfg5LR3nP3iqeC3dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561294; c=relaxed/simple;
	bh=8BpJdYDvSCwGfqx06V5AXLKQJAEUmS45pU+s7Lwsm9k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O2fCqbD/wDMPkz0/MWBUD8otoQKDRr5/gqoPGY54m5Qnm2JY3blnFNom5zW5zhRbIS5SOZW4wDe7QsDlOFP5VNP4LlY23e+Wu/M5yxxHtnIP24Vtp7QN2kZncCwH1LUH/K/zdZZS650Omncis4YAzDI6TCl8o6JUdgLUhh0sisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byvfp2n7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byvfp2n7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE62AC4CED1;
	Fri, 14 Feb 2025 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739561294;
	bh=8BpJdYDvSCwGfqx06V5AXLKQJAEUmS45pU+s7Lwsm9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Byvfp2n7Rj8RNT19a6t37OsgviprA0YOGM65U2BuzgCv8w9n75bhxQlP73gnTwu+G
	 QJgWLwK81Gn15XfnDkgJY5Gyt3wBMRwPdlj8W2knM03dQb6NQ8UACRBPJDfmqBJrYP
	 suKWbExH+eoTcwI4waTPBdx5g/YXlymQcJQIY6o3jjh4PimBR4qqhJptUyaKBeIw0j
	 SHPe+gRJ3gIv4yK/Izyc/vG8j9VaLuh6/HR4p2eA268IO+as1zsGkjfk7GMhEUYuts
	 QPtDpgPUZ2g8jm2OA35pVVGenr8t+08xWczNULt4rQCTSTi2KtYKLa8hGplWA9s62m
	 1gq2Y/Da+svDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE488380CEE8;
	Fri, 14 Feb 2025 19:28:44 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z679gV-O0JsPQNOb@8bytes.org>
References: <Z679gV-O0JsPQNOb@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z679gV-O0JsPQNOb@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc2
X-PR-Tracked-Commit-Id: add43c4fbc92f8b48c1acd64e953af3b1be4cd9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93bd481b6076299256c96aa21362f09cea121c69
Message-Id: <173956132332.2081923.12164524596999391878.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 19:28:43 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 14 Feb 2025 09:23:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93bd481b6076299256c96aa21362f09cea121c69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
