Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7482E3392;
	Thu, 27 Mar 2025 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743048024; cv=none; b=APi+yn96aKPadfnma4D64fZpLsarqrx2vYcaxwXxTsnTjzsRvpEGk7IPpi7JBcXhY/QVHbwcj2RdLQtiqdNyVJVnj2GiWFlaJrz9LiDppdC8rj39cT5wXIF0cuJO7khCZrBo6YXXYhZCNmnZLfEptSx48B/58mlESLHuPlmy8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743048024; c=relaxed/simple;
	bh=ZXBJyVmzASxOtuIhiplKyIHxXyGJ8hxoIgZsZ/+DTKM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rQBMj01H4vThACoi0g45/P2MUL3CSf6dT5QS3qjsS65GBCW8RjJsax/Qrj0flXNTubNA3/AzHzn/fNeEZVj8LJ4vJl9V/AvbZTIqu5p5oZyo/Vo4nfn/yrFYGT4lfCX45mdLXL4QwnqEzJyFhJKYj1Pq+Vwb+3RmvyQSTU/cnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtN00LB7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtN00LB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9040C4CEDD;
	Thu, 27 Mar 2025 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743048023;
	bh=ZXBJyVmzASxOtuIhiplKyIHxXyGJ8hxoIgZsZ/+DTKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OtN00LB7Q1fFsjtEcz2i24mUo0Gwbd+ro2yMUETan1arA1ShpApknnhmOiZ1ZCfsC
	 YodMEQ76U7Q1FK5cyYNFzLIQ58I3FILdz0UMY8n84wU2dqHqIMRL20ohq+MT19VgYo
	 JmzZoqJ3+91TjSMNGsKuNksM1rcH9yJ/H5A3xFpF9/odOCvkEBYfzK1DRggNx+5FzZ
	 5BQvjQ8R+Pa6yD0H0RVJc3kz1+sgaqbjbaacE2rzNQaxRjoKpi8FsZoGlq7f/eBOIU
	 fA8/SAPugooJVdq/jHiu5ypO8FpeXHXhsZNq10jn5sGwgcwNYKz5QhL6yc9S6T3MNt
	 Z1XiZLxeztBOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719BC380AAFD;
	Thu, 27 Mar 2025 04:01:01 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-QVmVGmFhromIEy@8bytes.org>
References: <Z-QVmVGmFhromIEy@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z-QVmVGmFhromIEy@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.15
X-PR-Tracked-Commit-Id: 22df63a23a9e53d06ff2c67f863e9ce1640b73cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 336b4dae6dfecc9aa53a3a68c71b9c1c1d466388
Message-Id: <174304806006.1565894.9044048933781553360.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 04:01:00 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 26 Mar 2025 15:56:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/336b4dae6dfecc9aa53a3a68c71b9c1c1d466388

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
