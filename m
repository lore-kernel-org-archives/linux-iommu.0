Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA79B64A;
	Sun, 20 Oct 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451528; cv=none; b=emrcG/qJlesYnp8NUqBc7oKiCZnt1uweSOqpY/ZmpO+cfDSG790f/60eDeVMA4+hnWLV6dIe32Ne1wF/vLMmqyziUG0xFKpDLUdGh7B26PBgbvMa+X3u5LUVQBs08pn0BXtVDkLkqKDTGOBhkrU/qtkSlA0Ecw30CiPVQ48XI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451528; c=relaxed/simple;
	bh=H++99qjo+jw4U4j0s89NkEiFdypMRoqfvAdp/rn05pE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WkIwAy/PSaf2nw8BqVmDsJj3jxIHTNIE/xf/A+DMjCvlzAUdp2iRpTkvopRyrw0knnTrmSYBjUd0SJQ/2Txk3dUEWbeJnrk9lo5c3mc0dx6BBdLI32Ii12ChURcQgo08DyKIcbSRZLS2YJEDAwhDr6h6s4Wc9iV49EV+QkEuWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8D4jrRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8D4jrRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC46C4CEC6;
	Sun, 20 Oct 2024 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729451528;
	bh=H++99qjo+jw4U4j0s89NkEiFdypMRoqfvAdp/rn05pE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L8D4jrRdJxwK+4YMurKsIc/aHeejL9fCm9ewRlsGMnBe8w5W+pw9YxHIybs3xNdQk
	 e/LfHkKR7lIbMU0j9+fn0WzBdxFNIINSNd6VbcCpDtkXy3k5tbLX/KoGbBFXKq+qI4
	 Cpev+ff8vQbIW0OsMrS59NH42KaCp646uhNtwH8WSPzS7MUAHckf4iphshQgv7JtYE
	 46g4iYwGCkhPBK8ndeT9ZlkLV105g7j4LL06sMAOmyItE7H3Ko4XgMf8fEZhT8nZxm
	 sc0UBfz5NaM80bO+my9p9sou0p9nJ1towhp2O1rzOF/o6BMhf+3nZV7sJsozOjCqFF
	 y7wbbT3ZQ05Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BD3805CC0;
	Sun, 20 Oct 2024 19:12:15 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxSGmK5gbvmANA9U@infradead.org>
References: <ZxSGmK5gbvmANA9U@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZxSGmK5gbvmANA9U@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-10-20
X-PR-Tracked-Commit-Id: 78b2770c935fc1434a95cc17613fe31165b02dfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10e93e1900286cdb2db2754d86910e229be635dc
Message-Id: <172945153437.3627590.1426507892114198181.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 19:12:14 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 20 Oct 2024 06:27:04 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-10-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10e93e1900286cdb2db2754d86910e229be635dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
