Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38053369D45;
	Mon, 24 Aug 2026 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599136; cv=none; b=rhAIUfipo3XKw7IbFvKTaEc2+QPwy5jVia/bIQN9CUf+iYWJ1MSsaGbtFtxixeHnKrpYlzHzrlOx/e9TAwKxC9pw3FNoWXrwjRY7dh/Xa90RQfL9VmfXvVMpQTeG648vz2RgdNYt6XBloIkIbkunyGwBN5RmlBJdK0kdS36qDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599136; c=relaxed/simple;
	bh=8qCA371VXMAoiSymWKnpTmcxwakLSAhybf8NklyzHKw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vGG8aVSKoob1164beIOW1s6AQWJASigOR6fQNcgFdwitVo3INs3N/nQ07kAygSFV53p107zbNaB5UAyLJ3VQsrHDuaF498S+HMwgceic340COOOoH2EfgF3AFd6rlwox4k+ODpRxyZA26KlSuu1d8LS3ihellWan6XKbEydLXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnkS8FVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnkS8FVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA751F000E9;
	Mon, 24 Aug 2026 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787599135;
	bh=9cFOKKT8rzs8LOolHgRHEztnKHt15HBZbs6IjncMz/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EnkS8FVXDn95x2jjuP+ZUY0W5O1RIGuRvJ4uxo27m2AFKfw5vSbjl+++9FRiYDrL5
	 xH2wcWZWt5QcETaPRnphDTSqgu+F4At5lJR862j7kihE7XZnAZ/toJZ6YiAvqjUUCc
	 P1kiBUPLlSw1oX0JfOTRzwpKvHYGMya8mXSiZjH9U6vuXEjAxdW6+mF+Jt12Rv7kqf
	 /ySRsxBcGSR/x3P3j3kbGD1+9ejy60cfBLOpqqXh32niAPYy9BWDi1aq4gSkGIQBPa
	 lMDIpCGdHfq3kXof1ToiS5R4r3KtSZn1HpZMM064g97cTfgZZu4bgqr9EfvOMcMWkc
	 N2MhKCjNJR2KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AE03924A4C;
	Mon, 24 Aug 2026 19:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260824141901.1739207-1-m.szyprowski@samsung.com>
References: <CGME20260824141906eucas1p205a270ef4435dbc65fca7b45937dad41@eucas1p2.samsung.com> <20260824141901.1739207-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260824141901.1739207-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24
X-PR-Tracked-Commit-Id: 121f9fd1c3083312055126205f3e40b8ee999fe6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f43193b88188b184a967c9427602e019f1b8708
Message-Id: <178759908241.3075085.16093524606920477200.pr-tracker-bot@kernel.org>
Date: Mon, 24 Aug 2026 19:18:02 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, chenhuguanshen <chenhgs@chinatelecom.cn>, Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>, Honglei Huang <honghuan@amd.com>, Vova Sharaienko <sharaienko@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 24 Aug 2026 16:18:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.3-2026-08-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f43193b88188b184a967c9427602e019f1b8708

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
