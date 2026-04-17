Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDA35CB7F;
	Fri, 17 Apr 2026 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400087; cv=none; b=KUjZKKLdKaNFKLPZJ+OjflGHPnF7c69cqo0TOATP8YjwYwyid7E17IhQ7Uoa4Fsy91BUrKRQ9j8On83jxIgr+adoH0UInHLW7DXc/1rPXVNfJgdFwgHjfA5tm2/7oGT9PCE1+cBSTj6J7P2jy8iGELb4zXLNldyV252DQjHY7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400087; c=relaxed/simple;
	bh=nNb+WguxsOJPUuWzUS5QN6kre8vCM9zkGqeOxhqd0aE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YktIWNDgUYh1JTj3vXfFAXA9xHB7Mh46JP0ywzXqXKlam4nf295zgi0nugi4eFIK1gk5IecgZVJXdbq5aKPwKbsAIiicJLu1104lmT8Py2JP/ZC17z/LxdhC4cWuD3DRZ+7n1TA8W1aHjP9xRGvY01Ro4TSZO6+JNs7l4xwsqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQMggwzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQMggwzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84169C19425;
	Fri, 17 Apr 2026 04:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400086;
	bh=nNb+WguxsOJPUuWzUS5QN6kre8vCM9zkGqeOxhqd0aE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LQMggwzirkz6Jooiq8hyViSomJrAwgSJqHqW/JYyAz4LfJ6ETYlJDQGbNAZZbu7yE
	 pvSUZLBAWjCijvcBg499V6UwrjMX/S90u570/kmP39GQXz7RrCb4ioFt35Ii4spGFH
	 /u7BmtkYlB2LVShzPkN4fxv1CzYcNG2Ydq0rATf0kjgtIOtXMZcTwfTzH1GvQz9Acn
	 rG/IUxBNcNWwzh34W9qc2MC4sB3u3plbQhDHtVoaB/YmJOU1ZdYls0YjpiPj2zMn+d
	 QsD01eS1xype2QyEqHLZHVY7JyMl8NrwQDAnmm7D/Zc9FWr3KjYAnyshDgNsvxY88M
	 +YVsEKHQ02ybQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09A380AA78;
	Fri, 17 Apr 2026 04:27:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260416173317.GA1886788@nvidia.com>
References: <20260416173317.GA1886788@nvidia.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260416173317.GA1886788@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 8602018b1f17fbdaa5e5d79f4c8603ad20640c12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
Message-Id: <177640005445.3538458.8942534581938076468.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 04:27:34 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 16 Apr 2026 14:33:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
