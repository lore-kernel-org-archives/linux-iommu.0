Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097729A1;
	Wed,  2 Apr 2025 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558565; cv=none; b=t/LGUR5eYjiQu44Jxg+mK8ZplxB4CPqEAf6mZoQhrav4fi7HZDwuMex44iG6++Oj8wkEMiTITPs2KwDpMvj6wFkdV5Y05/44zfbj8GXAwseSABz7eRHZdmmhiVd3As/OyP6EIlIui7eMPfyLU9+dTnzl2pF4Ob/Q13evaVc/iNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558565; c=relaxed/simple;
	bh=ASTG/6TAMqjte6zQWLygzQWQTZpHH9A84tSPcOmIp9E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HYXNxwKuslrmCL6ljUhYVwfgqoZQFtHWvvgYhq2RycvCsSMWt7po/p+V+uGj3erhFvaxTkeGDtNfaZ2sHnzno1EC2eu/A+F6a6jkSbcxFb1IlM8FzjdZAH8rXjMHO/w7v49qr9hFVve9fziOZdqb33oWDu3vS6+tcnqz6HE63Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8J89YxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8J89YxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619D8C4CEE4;
	Wed,  2 Apr 2025 01:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743558565;
	bh=ASTG/6TAMqjte6zQWLygzQWQTZpHH9A84tSPcOmIp9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i8J89YxXzqxyNrXoP1Ux7gXqRL7gwF6Z4U6vQcRmfUZTqtgNEeu8vxBve+EsHtG9V
	 I1wHlKS+kygmZSQ/qbk3N6J3H8yMg+nVBlH7bmTlQ845cPsFeWd0Bm2Sq4Udlvp+kG
	 ErrUMTHDe9IzxCngi3xcd50yvxKgBFxAQX2MYaFSEHb2widrnmMYUbKhDRX6Cn4nW/
	 RoOFXkq0XAAUmd5pUKKq+59bFd83EBaZTNzRRCqUhQxR4V7oJnnS8gm8LZ6mb6QCIH
	 ZVT1HxcidgYeB5oOfMn+a3auSyXajwfUeOYSVC4AqmaZH0ItoJN/e8aVxymBRT0xaA
	 gkbBAbHXvnk4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71325380AAE2;
	Wed,  2 Apr 2025 01:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250331161227.GA287780@nvidia.com>
References: <20250331161227.GA287780@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250331161227.GA287780@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 7be11d34f660bfa6583f3d6e2032d5dcbff56081
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48552153cf49e252071f28e45d770b3741040e4e
Message-Id: <174355860191.990172.16123016267632296363.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 01:50:01 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 31 Mar 2025 13:12:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48552153cf49e252071f28e45d770b3741040e4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
