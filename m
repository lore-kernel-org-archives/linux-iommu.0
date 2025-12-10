Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA232FFDF5;
	Wed, 10 Dec 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410879; cv=none; b=jgf1yRBVPu1xcwTst8rjAqCTi9mqQoj2hYS0X/WAzprN9PllAZwRBINyR1p57tUWaHFumu4KcS/O7BI2MZc+/Z6lBCVaqszYQmzBHuXnCg9dhgPwZwWVKj/BDyJwTXF164KvxiKnBYPbA8GVHmAOAjtN5ShROVVRu0lF6FN8nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410879; c=relaxed/simple;
	bh=EAad6DIui5R30tB3pbWzWcKVcXY35W6aDYEY4Zm6Ne8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SgbAOpTZvIqUzJOgIEAg+Ax1f3MSVdR8rjslSbsJzVSbMD9nx3lbxmb8Te5hfiXiyJE4oaNM+eGh9nEBM9OGNd97uxtLqEgd4B1VNDjK64l8+9cCgOLSG2e78MNOyZTKrqOzAJlSuXD4bPgJwYNPOSJb3S0V8ATnWfsUpkdpDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqVqdA5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqVqdA5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F61C4CEF7;
	Wed, 10 Dec 2025 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765410878;
	bh=EAad6DIui5R30tB3pbWzWcKVcXY35W6aDYEY4Zm6Ne8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SqVqdA5oma+mKIa89Gj4FmYphloIjjd6hqQsq3wG5X7bpZYArN3yAeh9Xxg7nxs+2
	 854x+C4lJspzBUxBxJ4pIwf+tKBB1UlGSvC27kbf2ldvxzcFl8342kABWoXdVliu1s
	 OTyZ+h34fCgnkgIol9wU6R0cThamZ1oumW2AyQnxrUEDEcY8XsussoLZ/jzr52Te2t
	 2RDerYNMZNbc9K8KNNlYidHD86597e82lWPrA6ERKd8rREBIW4cRmV2HfDQgcdV0K0
	 xwX/qTl1/EuVTFPPVy5HIW3vfX2x8k43eG1ALRIfGSHk4Arf0NhQddIUJ3vkPTd46o
	 hFcipOorJv0MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29043809A23;
	Wed, 10 Dec 2025 23:51:33 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251210165854.2568046-1-m.szyprowski@samsung.com>
References: <CGME20251210165908eucas1p192490cfd679fc4ae5e7b99bea7b4e81c@eucas1p1.samsung.com> <20251210165854.2568046-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251210165854.2568046-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-10
X-PR-Tracked-Commit-Id: 31b931bebd11a0f00967114f62c8c38952f483e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 840b22edd5adf9dda46f4e701815eadce8f2f3eb
Message-Id: <176541069272.769338.9182894950095892130.pr-tracker-bot@kernel.org>
Date: Wed, 10 Dec 2025 23:51:32 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Hans de Goede <johannes.goede@oss.qualcomm.com>, Dave Kleikamp <dave.kleikamp@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 10 Dec 2025 17:58:54 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/840b22edd5adf9dda46f4e701815eadce8f2f3eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
