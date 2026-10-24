Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803246;
	b=IAuevDcDG7y0eU4sMu0qZIlACg43paqCZI2FwxVeuh5SVnagG2fNHyme6EqCoO6MslER
	 s/8Qp7I7u25xd57+dOir2wCaMGUWRPdeL8C2LgRt7Go9YOYXuMn8brVvOnST6UfoXWPdq
	 JHtBWpICIeaIjckCWFvJmEhxgMPVh2ttCPFhMz0bmcfiX+Qh4UTvNOVnN4MpPwGXSWsyP
	 Hsqtct5m7Pqe6gHPJr+BsSRUEz3nJofAgvjQ1mjaogt22l4dgKhiOTHQtd2rV7CbKiVBW
	 Mf/m3VXTCCRJOQFRoPVjNN5Yh+DW6XnvUP+VPFieszono8qn4uCculXZ+6vmwYbT7vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803246;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=xub8Ght8EaSj8kZeqWci3WmwT8YO1oakAqJeUp5WWVs=;
	b=lYohfn6g4z0N7Fhi3pUdt4chDnbwzkpcdvpQMOmHa09xVwZfKVNggvq0f5Gh0sJhc1U6
	 638v3D/FVsFdza0xfQRbeUTnE2sEtR2J4w23ooO2t8Zmqw96Z0s36pPEitk8BEfOeWTNN
	 mARsSTkelT6qTq2Uf90n8ZnnVbaVZCc3Y89zkA7cmRXQzdOUATzoylXOjPm5971TqSAIl
	 2Aga2kPJtuW7nJDP7ioHIqMgF+Jufz6WHO8n+gu2v5n4CSY+sy8AIROuHxgk36S0mReKq
	 H4jYXcQy3YpF5rGB8oT8zpMQmbxUC4BQpCzvkYjIQHEJ/q0CK/Q15LuDwoMvmamc9Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWlabzQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783B606A31A;
	Sat, 24 Oct 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWlabzQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C924E1F01825;
	Sat, 24 Oct 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792803245;
	bh=xub8Ght8EaSj8kZeqWci3WmwT8YO1oakAqJeUp5WWVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CWlabzQR2YSBtFYeUrWgJ0T9DqBnhWAbzDzcp6thLxfMtj1v46BNp78sXdWzI0wAl
	 zt/YKla689Ly4KfJ5hsQDjp0DHkhPQVmk9rilE92fZE2oATJZkpiLmtxVWkza969cK
	 4HGB+cq7hKG7IwxKQKTWfUO+cgnZWrlumLb3SaQQ8f3Uijh+jk5vft4zeVS3ZCiZMY
	 s87QM6ylMprhGY6I0p1Tt76mS/Wiev/DGwz3FI9hK7gtXeTboiOSu9811m5lbu/Ulv
	 hd0bCKTwSqVVf6z38Oq75FdStC+xW5T6+Xtuo2OThjlaQuUbPvZIUXxpEfO/jX6gf5
	 YXQdqGiAaKBIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE91F391B16E;
	Sat, 24 Oct 2026 00:54:05 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021092802.3294826-1-m.szyprowski@samsung.com>
References: <CGME20261021092826eucas1p167036f47ed4ccf542f3f7b33d253277c@eucas1p1.samsung.com> <20261021092802.3294826-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261021092802.3294826-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.4-2026-10-21
X-PR-Tracked-Commit-Id: 4733f2966433b7f926f70c9dc461c33cd5c10835
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 906b6e1d8c782a8442b30bdf8b8992f5031ffc59
Message-Id: <179280324434.1378757.17245242963624253935.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:54:04 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@linux.dev>, Qingfang Deng <qingfang.deng@linux.dev>, Francesco Valla <francesco@valla.it>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Sasha Levin <sashal@kernel.org>, Leon Romanovsky <leon@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 11:28:00 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.4-2026-10-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/906b6e1d8c782a8442b30bdf8b8992f5031ffc59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
