Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9114D717;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795025; cv=none; b=MI6yM19YxljhFC+KM2WBn77h8GxP2ZzZLGEiY/qJbfhNv0Gvax4bHKYqH0Pqn0znZFf/QiVXnAw+4qKLALXx9iciUZGGEZV2NqcbF1K2HediDy+Yx2MffWBgUa7U0HwgsSuIJMeqOO/RDvY5gq0u0BBM930YaETf6LX9Tq2amMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795025; c=relaxed/simple;
	bh=jm+WpAJBytJpDPr3S/iqcKAk21S0z72tagc7YbQM8tg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ou6mwNvZdkIaqEF1/F0BodtrbUrp6prRlAfArn26h1cHAKh5yEDYr74ONHG0ekiEy55+30vOxHeziBuQkmsLPCYOMaBwxkq0ryhBr5c95dkwKZOwbhrixYtSq0ByLyf+AnTP4Uty4FMuFRb9OV0aTLPuB8c+YiDkNFtB4Gpl6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R19+Mfvt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R19+Mfvt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95118C2BBFC;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717795025;
	bh=jm+WpAJBytJpDPr3S/iqcKAk21S0z72tagc7YbQM8tg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R19+MfvtKwtCagdXS1aNkyFFeb0mc/VRAdPDR4jd8mAYc5bl/+NrG9QpstHU9JMPm
	 joXkHfd9u8V57C+1t6xDQQOd+VdSEr+pN7ADYUOHx6XU13s167/hVCY4ZGNTIskqDx
	 y5vQvtP/9gr8wXwIW2ZubUBt5QwKoI5frX4dWRVPrLAkEhiSFyc0jft4IYDY1BnNbT
	 3tM6pIstulbUrPUq5G50RTrYEKEBTqYuqoCQ9Z0w6qynM182Y0vEhc8tVfktBAjQGW
	 pxwaTi38o4a+zoYGbRWZRH5GMTpgoA/rleXGjFXVXjCPE84WaLCKit+WBJn2V8lTSD
	 JlGeSMggkM+VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE2CC43168;
	Fri,  7 Jun 2024 21:17:05 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmLKAr7RYbL_wP3F@8bytes.org>
References: <ZmLKAr7RYbL_wP3F@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmLKAr7RYbL_wP3F@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.10-rc2
X-PR-Tracked-Commit-Id: 526606b0a1998b0791b42c199d53550c3ba724b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f24b46ea10d7d2096ea1c9ce5746a0c85920ec62
Message-Id: <171779502551.6230.16654574952865952490.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 21:17:05 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 7 Jun 2024 10:51:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f24b46ea10d7d2096ea1c9ce5746a0c85920ec62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
