Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC37185937;
	Sun, 29 Sep 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629490; cv=none; b=df6WeYNeGd4BjMSMs+heP3wUcDo5OfUi+vULjUX0hiDsCthqOkvXobKyc9UBmqqSMZsJdwCdhC+pXS9aR/RH1+cczLp2seSjMljbG8JOnHDR/mRsgxjvoogSTQ+KMaXqf8+lWcvRHzS/qiDGyvATsCsWltFuCfOwd07J3dJFvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629490; c=relaxed/simple;
	bh=wVxS87Ek4pzVeuCFyciDlYf+/yxlQCXBfxkPcwJUAvA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NO+oBCCTWc75baOG5qutHaoNrOEu/yPcldyATbCIMdO6YgeUq30PpDf0j7kh+fwr0eZn66EZDvuMoP07ypdOt6FiHh8hJ7kEXgFOKnigsumU1XEevXIWvuz3a3DrEixpbYU2hkt2qPrbaPgBLUyrLAg1InuFxsxk9UzsHuwpA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baO7MiNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baO7MiNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9963AC4CEC5;
	Sun, 29 Sep 2024 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629489;
	bh=wVxS87Ek4pzVeuCFyciDlYf+/yxlQCXBfxkPcwJUAvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=baO7MiNzViYgXQyHLt7t7KjSXlBuO7m9Q3/Td6s1O25+b7kQVvtle7Q9OinEI7lbK
	 64OzSmNKkDInubCYQ7E6nwiRAW2yxtsNLDw+rtOOYRzl6Er/ECwkmVM+S/u6XNWy0/
	 E35OSZ40D36a4mgubh36APu3/gzVuNRmZFOxk3j4V1Us3HTB8Jj2aamY9VLEoptr/h
	 rXzJjCRGqExpUWBv7OovJqTw9v/6nT1Tz7sQB6cDewBJ1MF9pm4RTVW1TOQJwgK3lD
	 /mJYhPPqEgC92by6RuJWNql2UOhR5b31rZOdNU0BqeypDyiTPIja5CYkZW+svsAhRw
	 r2y1PTSyJA7/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AAB683809A80;
	Sun, 29 Sep 2024 17:04:53 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvjvjcC9VhDkb9Rf@infradead.org>
References: <ZvjvjcC9VhDkb9Rf@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZvjvjcC9VhDkb9Rf@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-29
X-PR-Tracked-Commit-Id: bfc4a245a794841cba5cf287034a0f60d3087402
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b81b78dacc44b30b32c8137b29f36712cc1ea980
Message-Id: <172762949219.2558104.15895730019425261080.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2024 17:04:52 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 29 Sep 2024 08:11:25 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b81b78dacc44b30b32c8137b29f36712cc1ea980

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
