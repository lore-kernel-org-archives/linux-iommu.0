Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67434250E;
	Sat, 12 Sep 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226253; cv=none; b=GlMw+yfYEidOcO7EbJ3vjLiHf3oilWBKdmhx4sWdEEmUEncckkVi+fVQgtxtDab/qoLwal6VM7b6Gu50QR4hfUAScGdKdMLuitl9Hey763s/ihkoyaJRIegiccXJazDEUEg1kDRT5uiQutsi6jMJD3U54+7q/4T1IBrrcAOsX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226253; c=relaxed/simple;
	bh=a0xYkeTL+v3E1AOxxnMuIPRnEd/Pr1NCq9s7Ze8oSlE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VCXZAP666xiqqH9LjtGmwEouTD1pk52oBpbv6fnFu2H0gvnwxgBVITmCQMQCsm6mVluMWHXxzbnk86O0EUsk4DKUjZhzAiPuD+xHaDhTno/2EHsemsk/UXGrB22bvgLBqYyE7koB4i2Q9j6eDnE4O7CjvvbKCwPyluBtCvKBems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGpRx4xO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGpRx4xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0871F00893;
	Sat, 12 Sep 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226251;
	bh=7ftTn8K5isOXoNK1P9yxvjxQlAgd3LiZaZ3HVe2I11A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MGpRx4xOnOfpVLTj+tn6Zhupg7YeffrR7Q4S90FEablgX0X5j/CkpuOLGsQWMi46x
	 wRUngBKIjx4i+9yWA4jdei4SxG2yTL28D9DEhWqqQpFKyY3hqy+wYSl07imEC9oyh8
	 RxIBWaONlXesFlvMUwGaf3Ux5alDepa8l5wLu8XM9IcT3/R1CrGd1EhVhUy3jfBPOg
	 rKZDo3o4rGpOZzfEMr+tr+j55cZUa+Gdq5KKHpytN5dR9U2mI5pL0nzNINmlDptW0Y
	 Kk8McZfORRaWR/FwhjzHWvFfTAQ13mEBrjISV3pJM1rp6wdpcdPNzVKjlyLrOkR/NO
	 JNMJDMH7JtzZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3C380820D;
	Sat, 12 Sep 2026 15:16:28 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aqUOFhjG7gjWfpAf@8bytes.org>
References: <aqUOFhjG7gjWfpAf@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aqUOFhjG7gjWfpAf@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc2
X-PR-Tracked-Commit-Id: b63c3c26726576e2a87baeee80bc202a5a43c9e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e213d5a2a94255b31926f0e9f7c1eb234bbf22
Message-Id: <178922618747.3511661.11208626013686595803.pr-tracker-bot@kernel.org>
Date: Sat, 12 Sep 2026 15:16:27 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 12 Sep 2026 10:32:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e213d5a2a94255b31926f0e9f7c1eb234bbf22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
