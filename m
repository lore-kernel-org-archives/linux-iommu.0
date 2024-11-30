Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8283154429;
	Sat, 30 Nov 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010753; cv=none; b=C514qvhVmkwsy34VcVIgtnNG0dKZsr7RNRUsebvKlSQ+tO0abYaeiSzJDjh0GzvO3ozwySJTgVpntyetT9BtMrNfhmSeLnVnu5WSwXB0CTAge6jKNTeha7wkweTRoGXdynsOneRn1it2EYKfRaHHuRUlpPbtQ65ZpyoUFz6G2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010753; c=relaxed/simple;
	bh=iNGnEv/SIfwKB88RPRDT2qMbsV2eLZCAFlMWNH1XUMo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T4sEFVDL0/qIFB5fgul4pJTLDZPfBo/AtfjJgn7HsplkSjuy8umNCMJQ+06awM+MRCEsg6+rcsyKwSGg6jLmQYnlwFNB1VNr1Z/ApoqGt/ffmq6zQ0WLnZCvAN+IwTRA2UXXObXXdJJD1/g9i81Wq9KF8pheSj6VKLpOmnfQr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob4hmebz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob4hmebz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C74C4CECC;
	Sat, 30 Nov 2024 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733010753;
	bh=iNGnEv/SIfwKB88RPRDT2qMbsV2eLZCAFlMWNH1XUMo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ob4hmebzGuzOzee7J1FMyqfZwZLL5+lU/+ig4RaPzIKTnITX9yNawK3SP+epEiGDj
	 sc/V2V2uyc8B5cMoeIJYoeiNoiPbtxdyaawtiEVmsctNh3nBsH7NLyIFw5zHOPmD6T
	 +IyE+1R3xvpIo/DDtQ3gLbtSu9h4MBgQI7ZPDHEfpZs8FCwQ7nD0H25mxM1U+tIkdo
	 cw5L85etjGyObAiotIu8mFz9i1lQoOSlg+XOip2C307VC09SZ+qwgihh+5pzd9Tcce
	 S0NPYqJ06L9Wir8cBD5W/4Y05Nes/zq0xauJw77hxdKIWDAnRIzQtm+iPkxO0mHsjq
	 lE2/xKpE0EtPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC0380A944;
	Sat, 30 Nov 2024 23:52:48 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0q_dVrMZGDv9cvY@infradead.org>
References: <Z0q_dVrMZGDv9cvY@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z0q_dVrMZGDv9cvY@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-30
X-PR-Tracked-Commit-Id: aef7ee7649e02f7fc0d2e5e532f352496976dcb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 133577cad6bf48e5a7848c4338124081393bfe8a
Message-Id: <173301076731.2511415.18336472225121327742.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 23:52:47 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 30 Nov 2024 08:32:05 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/133577cad6bf48e5a7848c4338124081393bfe8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
