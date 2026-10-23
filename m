Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714155;
	b=GJZfW+NIstKhnyiEYpACQ8lOG8v8uZ5Jgbiw+Jl2+UroiQ4CTWZJPfbzsKf7P8RA8GPn
	 jOTA6LEhiVZNhaBT/ejnY9Tnpsx709Z9Db6xr50BcpMCrHaJg4hrGr1KG7w7I65D/Nuhl
	 CPmco2LRl94lQKOvlrGS1rF4iRQBC0Rm8fJiP7jZTeNiHSXbhdpoRs1M41EsgTJDkkr3y
	 8gf25I1Up/IKCaHMPDM5xH+HtDrTfvV3gQMRLr8qupR7mp7JlF2J9+5CKlwcajNqyx4gQ
	 2NiogGYlIGc0KfIwuAcwRCE4M2CkOSgODpcrg8dWRSSR4FLtD2s5A/9KW/E6HzViT+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714155;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=QnoKK2jzD8Hwonqf2WpRFs+Sz+/+mD0PXb3boPhR/7I=;
	b=5sBxR9Cw02G6KKnyuhme04VK8cSR3PT2j6YDFLtSOh4qSr/N83m12JDiSraPzVGw3RHP
	 0xUqfdeRg4PaE1KpJsbk0OpZWYvUyYUo8008djGPwTsczHgQFseQvijZXKtT1ZlabPNWy
	 2y1cwn++dQWd9w5emPpNYlp6BUGRO7XZkly9PmcpmCkZeliQacA7+nSDRWFgUAYysYt8v
	 muWRKrq4JvA7PcLgkvWcGjWsZwsRr7AMhguE3zlLXlEX40DkG6QIQGjTG+vSZj855WbYJ
	 KHQJ+EsXt4+ATpTUgvcwpCgQ1tsxz6LA1Aayzzc9BpWW+gwgGLLLJRUMYMXOYWdS4NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSjl3TXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89196606A319;
	Fri, 23 Oct 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSjl3TXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122021F01825;
	Fri, 23 Oct 2026 00:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792714155;
	bh=QnoKK2jzD8Hwonqf2WpRFs+Sz+/+mD0PXb3boPhR/7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KSjl3TXxpemEg+lPzV8iOzg2dVVYOFiTGSpTUJwxiExPlDgRx0D4XnnE1qVVcAJ9R
	 GtJ92hVC7XZh0X23J5iMoG4ddpcsEWMUkJ0XlFnpPqjQSE0cjvFb/Zfz5FOaUn2Mvy
	 KUwfzumRQ6hrVp6gbmXHID8O5+j2/FdYyZX+oWow6Hgo7i341VfYNUN2++yy5fsMU8
	 6z/aN0sekQ+Cbf7Hz1LJng/m4NLpEr58LHxhLz46kT3ipZOvLtc0TZJwRMav9QniUR
	 +vXE3ahLmL/xAgrJjTrdey8hIBIGVbYMsipbMAmSbpof9ruRVn/D7xPX5kZyvDEvju
	 fnlGhRYCfGMDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 075F7380822E;
	Fri, 23 Oct 2026 00:09:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261022165151.GA3692244@nvidia.com>
References: <20261022165151.GA3692244@nvidia.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261022165151.GA3692244@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 04bcf84613346b973a8cc0c59238b6b5bc902688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1021679bed5acc46e1b2dac78bdd006bd50970f4
Message-Id: <179271415357.261177.7511031788658662320.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 00:09:13 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 13:51:51 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1021679bed5acc46e1b2dac78bdd006bd50970f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
