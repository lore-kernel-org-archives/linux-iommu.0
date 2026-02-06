Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C53126D7;
	Fri,  6 Feb 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419407; cv=none; b=qVqxM3Ugv4RjSnI9GsDaC7Ixxpb2szpDB/oNQqlr4OlFiPs9u5ltDIF0/o8uuFoBEUCQWgE+ZwcDBQVYL8OKZhl4MrwCRQSBuWrPC1Gg4LMabur9MEcBMZjEtGlirb/FAlqFs5jREK/sVvJB3Ibtf13yDchUIJB9dxlfay8JNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419407; c=relaxed/simple;
	bh=uA+xNkno9PAsydhmlsxIWa/TmD9jwG3N/hQ8m37gBJA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NtG4LF7pl8thLNVdUr24knxs/FTWHCRrRR0GeUXBeSnRuV6xBU56ctfoP3iGYUxqnDwLqB3OQTjWe4A0zAQU2FpGgHOC7Kow0r+H39Y4g4YAg/QmNA1clxQ3fSIJ02c3A5N+HBmcqjDzYSwiMpqEe+0GYafscUQIUxxTyWaCwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxIMhIJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxIMhIJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BDBC19423;
	Fri,  6 Feb 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770419407;
	bh=uA+xNkno9PAsydhmlsxIWa/TmD9jwG3N/hQ8m37gBJA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bxIMhIJ7euKHiqlVrnRZqGCqZRdW1l3I1xfeJA+2UUrYx+BPgrx8Trxki9ZvvNgyi
	 OXFw5Quzwbp7M4nIHr17MwhDLCg06pkORmFGXRBp3xIfgupuQ4B5v+SQlbHpJZcJdb
	 gwD87g2SqoxN6QAHskUr0g577UeoqMq9DI8gutQ6OuHv7gVGTHGSmC8FWmy9IOMoh6
	 LYpzmv9Gk9eXN/XqSowLD0avhwGTr9S/AoA3Ojm2nAVcyzc8VV+F6W1zNEdlByE3/X
	 +CTWN6peXQDI0jiplzPu+3awlZNbqPLFQ3O7kGVHJYTyA0ODmQYUxKQ9j5F1BHcEU4
	 od7rfQvreY9Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0D83809A17;
	Fri,  6 Feb 2026 23:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] more last minute dma-mapping fixes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206115313.3169749-1-m.szyprowski@samsung.com>
References: <CGME20260206115325eucas1p10b41056830dfac249ffc9e1603de43da@eucas1p1.samsung.com> <20260206115313.3169749-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206115313.3169749-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-02-06
X-PR-Tracked-Commit-Id: c33efdfcfa6f80e05ce1ee33694c1bad4994cd78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23b0d2f7c2864099fba140672017e3e69ddf88a0
Message-Id: <177041940464.1109628.6825295282178098251.pr-tracker-bot@kernel.org>
Date: Fri, 06 Feb 2026 23:10:04 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>, Deepanshu Kartikey <kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri,  6 Feb 2026 12:53:13 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2026-02-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23b0d2f7c2864099fba140672017e3e69ddf88a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
