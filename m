Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104805;
	b=emTiqT+Ev7hlEgAJZVjwZUcqIVXV3GR/Ht3Xq9ElFdRjnTEnsh27uXHjttOG6lYJqaNF
	 7nzlgl76MoRo389mQIjTdv9VYZBQHwz/WzpCo8ZfBohAtH8bSm+vt8MUgBbF/dbu+ipOJ
	 sX1SRjtOu1xAAe5DDJgX+rCB86ZMOldPdeY11P2i7N1puoRaLi1DJXu7kGarme/5YVfnT
	 LcySt2ykVoUjeZdkliwUGpDgF37nW/zKMovRRHZg7ahMvNTOEeGCCRzGwkluvoAb/G7Cy
	 qaYjiX7rVs+pnmKB1i9XnowKgi3ot/aAduxepvTUHGGpzHZ2UrIKZVqRpPSoYgx5nqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104805;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=xnc1skEhBLb0ilbwFRop9z7vHWej4iLmYmskGcoUfxI=;
	b=NaJS0mblpUhtEeZIZTRYlSq8ohQ+2bAwWnxmDf+vId3XRfzM7PFAGlCdsrnjsVbBWfkU
	 z0aGKv1WIyph6NCS28d54AZH+TuAHPME83KGklDiXtIjvc+n68tCNJSJ3J1limItQlqw2
	 1u7MD5+pDt7FK7yjYNutntRbe7/u+gxQsjHGeso1W3HhA5E+4ZeMXn4n5vRRS0tPp68Rn
	 TyM3Yi/4KLkxhZVnRW7RzUAN1hYY4mwGuwVgxkXcAOofoHKHyLzkgGXLXUxCAZ9mslPLB
	 Phmk8+3i8RzGp7GEHZEldeNtO8KjcnWDcTavbkh2CDbpegMk9pt4dUSIOQ7aJd0zWKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ne/ANsjl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793A606A324;
	Thu, 19 Nov 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ne/ANsjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441841F000C5;
	Thu, 19 Nov 2026 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104805;
	bh=xnc1skEhBLb0ilbwFRop9z7vHWej4iLmYmskGcoUfxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ne/ANsjld5bmDryViuvrcTtYL/mTBX9Z97qfKdXsKqHqfPTGzpYaa+T6jPkEIFurJ
	 X2qu3euFt2URXMohXiWgQFrwUCwJBUmRW8OR0aNodD2/pQmJ+fL+3kBqJP7Ypi8jxV
	 u4vAdSQKqWaFf9F9Pjr5RZVP2jHQAG3wHKoSioQeh4F2OhDNFL0Vx1SfRV4deF5cAM
	 0a082Tbon7zEhS44TGt1POY8B1GKDK+uXevYO975YRdfbsY9gH8NpsVrZpGObc/ewj
	 C/idPSGGdUO4YbAwCxFCiEKcP3r7+WlohOKQ3t7EiFVirCwmBuoPnVxOaGUWv4HOkl
	 IddBh9J2aK8Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3773808210;
	Thu, 19 Nov 2026 16:13:25 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261118140101.249506-1-m.szyprowski@samsung.com>
References: <CGME20261118140112eucas1p1f60a3d28537856e94a285334dc1e2f58@eucas1p1.samsung.com> <20261118140101.249506-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261118140101.249506-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.4-2026-11-18
X-PR-Tracked-Commit-Id: 14866e632fa48a0b4c385ab0121526575eb8f88c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c45d9aaa0b6eac6ebf74a3818a3667b9ec45078e
Message-Id: <179510480379.3187685.6713507421063330121.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 16:13:23 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Wed, 18 Nov 2026 15:00:59 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.4-2026-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c45d9aaa0b6eac6ebf74a3818a3667b9ec45078e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
