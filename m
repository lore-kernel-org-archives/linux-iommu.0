Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803248;
	b=IOgAFRZHdnvHAzBg18d7nc3zQxIylUBInEMGceFy7vteqa+fO1WiYfDimIod2m2dhLRk
	 sD/1BJsS+q8AMUxzJs7Bj4zrwrKeQm1NhG9tLu9v8BSzCZCstHdgtIHEP5oH31oOjtcwB
	 c4LTKs9h3bWB4IV26B1Y54y80qwEBHxeHTOT4xJM1T7wwz2tUK+MFBfkL+pzbWq6SCqwu
	 G+Cujh/YNG7ZrMtETi6ZwvGRCLJwPDyM1+8w329XNzcVsbt52dd82wqVIZ1J8NGDcszC9
	 dLR6QTuBeBrP/vxPKEhVXNQaemXmARGYryElM4z6TcHBKtJMVoOeOErZ/XdymgUme7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803248;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=7ATdJPlrfzqvx02yJnMQZL0LOKOMjttqMuqLPlXHHv4=;
	b=AM6qU5EBr18sHAKiRFBBoJEYqGtZxORW+pviZsscFPXF2iR+6rl9uahH5NZLjpIX6Spd
	 w37HzGun0ydvrBzyMeMG64Hf+nT8NcsNzzaOAcA+1CxF99rSO7E758FvmBxGXUHa7Yhep
	 A1pHRszobgMF+TL6la7VKIFZ1HCpMIdabVrwU3Q3JamVkxXfnPRd0S18CelC5L7q/Xd86
	 YzUJ9AdopTlvhX6C+14q9SCfrO/0z4TptrwYiwk0fppcyEDDnI8D6JRGJSsjsC5hge631
	 K5QisRpyo2LIgpFbeqsiufTwQIT4ojLG3bEYyHiaRyONrUZTNoTehzcBWsSmpTn814w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1QTHOIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE13606A328;
	Sat, 24 Oct 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1QTHOIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C820C1F031E2;
	Sat, 24 Oct 2026 00:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792803247;
	bh=7ATdJPlrfzqvx02yJnMQZL0LOKOMjttqMuqLPlXHHv4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=U1QTHOIEbN6vQesrD8jeGEpPYixrqVnAOwYIE6Y77TozkbQtJjFaBouBJWbb84zFG
	 2QkZ4GJKDR8PBc84V14wlSjCo12dJgS4SjoCPlp1QNo/J4Rqw3j3hh0g3Ot/azhAvC
	 od8Evy1A1+T11olxRHscGoTJfHRFaVzd83kNQguTwCyx6h0C7y7j3wpZnHF9OZoAK0
	 /ZJYPGMDgzTpBypIgts/fl/kEDLf0WQIO/zemE6kHYZHtCXAPEUEXFVxaRxX+o6R2S
	 yZ1RFqzOiqvAGV2xD4LYEMTEzq8jMDsIVtQ1yItnXA/eay/I3qTXROmZ9bMl0OhYj4
	 5zPH7ObJ7CRRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5A2391B16E;
	Sat, 24 Oct 2026 00:54:07 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <atnAm_7wyGt6wsK7@8bytes.org>
References: <atnAm_7wyGt6wsK7@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <atnAm_7wyGt6wsK7@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.4
X-PR-Tracked-Commit-Id: 20bfd25757659ff8229eeed6f048c76f9a11a4a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da9dedf3fc59137fd86d664693776aa38cb97f5
Message-Id: <179280324628.1378757.11684610881798829298.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:54:06 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 09:58:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da9dedf3fc59137fd86d664693776aa38cb97f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
