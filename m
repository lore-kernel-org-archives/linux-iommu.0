Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72B1D551;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362156; cv=none; b=qLkGMnvE2AfAI2M9FLhvxQfun1bkZ4XMZRyUXB7T0RCbcXJCWLSP/r67OL1eIbhDOHKBxE4ODJtERm9kjrpUxcr0/4kxDo6fHhwjhCwMd0AVqa5dS3QyRup0KbFvWmiWSCnWyXtQm/RxVlr7CZM6XfaDBsN9NBU9a3gXsB5+S90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362156; c=relaxed/simple;
	bh=QCNeesKti1aV24vXGmj1n2ApCzCJdiKXfIG9Yd9WS8Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qi+8Wq56tAJOpEfBw8jCf5Q5bxPDMC/HXRLlKCQS49kkH/e5jc6YMsYPVOZ/7qfuKjXwHG8k6Cdnnj4G7qbGXrXAMEKEHPnLur0R1YMSB3nNYYw/28sCRSKhwDB9iAZSo5Gx8Puj++oUhBfEpseNuI/qo87rjSmafSS4EDptbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhl3/5Va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhl3/5Va"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CD8AC113CC;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362156;
	bh=QCNeesKti1aV24vXGmj1n2ApCzCJdiKXfIG9Yd9WS8Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bhl3/5Va7L+N83FO8TmI73KSX1P4t4wiFhf3jprz/C+qFq51Qax12lDjI8arodBe1
	 xHO8pOOa7hQwSjbyrMhPWKHiWpBZTAha+gLsUauGDI94Lk7B1sREDBQzbrxsDKJdhd
	 w3kYAF/2uFYmLty25Vyiy1Ncm8uWidXELicjpWg2BULo1weqiOd0B3l8EfG1ybIqT3
	 qfMVloSOTYiAdMiB8BAEPEtNKF7vHSFiBhLDFLusumdajEYWIaajRjXF2X/Y4y+eZG
	 WU6Vi9IfZdO/ImQ/T0UiPGQjMb6zvcRYGBm4EuQUkC0VCVnB5yNB3rSiYBXxQBVxQW
	 80/OfqrzmnvtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0307EC04E27;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zj37-X8iMR81fNZa@8bytes.org>
References: <Zj37-X8iMR81fNZa@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zj37-X8iMR81fNZa@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc7
X-PR-Tracked-Commit-Id: 65ade5653f5ab5a21635e51d0c65e95f490f5b6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98957025cf146a0240bb9ffaf50727ac786078ee
Message-Id: <171536215600.32093.9118983519128595279.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 17:29:16 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 10 May 2024 12:50:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98957025cf146a0240bb9ffaf50727ac786078ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
