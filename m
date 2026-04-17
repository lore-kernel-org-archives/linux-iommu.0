Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82322199D8;
	Fri, 17 Apr 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451749; cv=none; b=XxjTOXzCpdRJzsc9RuJPNb3vhoSp8U8lI4kJ8SG0hCylzKkHsoDoSZnYDNkOXh1icZvCBEuoKrWKMkFFmwv65+T4amiTEEA7a8ZcJYVV8iNv9+z7bDqz/NoFajtmJLs3Ef8/KSFLrtd106gLy2rM0MDa7NQ4B+raxfNYN7wqWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451749; c=relaxed/simple;
	bh=P/q7RpVFhxL3mySYtDJ7xGnAiSh5a0ui/JivSfHbeq4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r34xGf9mOEsQPCyHyNjDwK9j0kJJIhOse3nlPdD1sG5daFyeZDGAnkJec4UvYPv/z43Y5PsUhsflUDWGdhXNrvnOVJRFg5pxepXyq/nnuuzlOh3PAmxAuXSXcZKdfFCmMpOh7kQ/JnDtfK4Q7AjLgZVTVOPqmFM5Y4zU50bzss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/EtTj7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/EtTj7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9CBC19425;
	Fri, 17 Apr 2026 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776451749;
	bh=P/q7RpVFhxL3mySYtDJ7xGnAiSh5a0ui/JivSfHbeq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L/EtTj7SzviNo0iFF9ULAx5EwvLw7Ah+AmegDqZCfzGwwhaK0TVytVjCMJT6VxwFp
	 TUiGJBrJ2B7fam8kba+P2sFhGS/pJ2lr8aaJDa4JPIrxUVuSYUhJN0NflAzEYOli0q
	 VKXIO3pyoZrMU/9L0324mYfzkahIW9fmA6IYCsXXRUjQLxCvI8hjiZydfccDb4SzUn
	 mBa6ECrJcY+E4z8fE2vZJRJ1MvKA3spQ7GOS427qpc7rYupT50VIErgfga5wYc7EcR
	 fnZmM8d/ybIykxDkyzgBSJ6XzlifNksx4MB6qp8dZKxRkfQOuaxN7MsEsGYQ/awWxc
	 0vlRsOVYVQ5Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EA8380CEE7;
	Fri, 17 Apr 2026 18:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260416204359.3030425-1-m.szyprowski@samsung.com>
References: <CGME20260416204408eucas1p28659d11a64b12e1d26ee341afca0b897@eucas1p2.samsung.com> <20260416204359.3030425-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260416204359.3030425-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-04-16
X-PR-Tracked-Commit-Id: 15818b2cd42df3cc886f4cc46acfab4d072dcacc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87768582a440e7049a04e8af7383b86738d15b38
Message-Id: <177645171666.115481.5006657288076350920.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 18:48:36 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Barry Song <baohua@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Maxime Ripard <mripard@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 16 Apr 2026 22:43:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-04-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87768582a440e7049a04e8af7383b86738d15b38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
