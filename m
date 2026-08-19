Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715344064E;
	Wed, 19 Aug 2026 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169304; cv=none; b=XOR9qrxDa9pUYskG7fX3FbW9yU5DgLv2G6aZnS/8v7/9eDanslY2zzHh9sarIwzDQ8Da+1CCw7k2yS91MmXpicif3kyjfGI5Se5rpkokqsDhcjsl+zsdRb8msvuK0NyKIznJwz6VtwTM9d4NFsZXB4gyRyd9zRruS27OG8OXJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169304; c=relaxed/simple;
	bh=dNcaI2PeyD4aDnJtk9eMrXn8Eajfyw8w40YCP3KBgI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PVZsKVM/ovOWIIm4/XCE6n9gdBgJ0+xcYUG3XV63s9JYB8x/5ZEkHRC8um0faZwZVsBmCwv3kvQg7nrjq9EGbh4YMY9ZWk5G8w59ZuUTNc31Ha7IKxTb21J8sapH7wWqZQb0bPnqnOPn9FeeVaaLo9kjKjcajGjW2DQxJMaqdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbuodYR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbuodYR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038471F000E9;
	Wed, 19 Aug 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169303;
	bh=CdduKpfLEieMjwAz7v8gkaW7mkfilKTd4J43EVChf28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RbuodYR3asIs5Qb8WoRXy5cshtEKDmiM8lMjyqRACJNItFxGhweT9uK1vFg0lpVFu
	 k8wITbK5lvluI5dgqekszqAYmptoTyJpWyNlKD2teDwnLZLC1t2crUVs3TwyCMAWn9
	 UnpHTXVt5OnqeHNdRw8tbovJvQGo7sHmbscQy1aqEamMLhxpCubg2H9bwldbpRdlnA
	 5afo5V395CAR4IgcaRjuf6RIyxSXHx54K0sFntF0SzKMUoaaCaXvngdYYexv7+ofsW
	 2ClyD+9XnDzHQKWcBkT++MkoZwfSK1Fq9NvbOwK0temsHHuU5nfkEloxIr68+Rx7G9
	 5Lj8gDYU6pYvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198243811A47;
	Wed, 19 Aug 2026 19:54:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260818203603.GA96412@nvidia.com>
References: <20260818203603.GA96412@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260818203603.GA96412@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 8c07df7cdfcf52f1ff276c588612aabc6c6b8399
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85e0d1de369cdf827dae8c759f40696de81b7ca7
Message-Id: <178716925367.3672948.7462034479550378677.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 19:54:13 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 18 Aug 2026 17:36:03 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85e0d1de369cdf827dae8c759f40696de81b7ca7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
