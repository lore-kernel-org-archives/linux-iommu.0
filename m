Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815122E7648;
	Sat, 14 Jun 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924628; cv=none; b=sP+t78tU95T6MZOATNjNEF8y77jurKeSvtMSewUby1ECpHij3ivzSQTSvI6kD1lHxOhviXRsPmqZUICHL70favs0OvREq6YGm8LE0yXCJ698EtPd3bX/uDZF43uAnn1dJe8ujntsW3Nc4lVKKn7Csq/xQ5sKF2i8n/7f2Ny7dOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924628; c=relaxed/simple;
	bh=/w64GzNNbniWgyDZAoW43PdVaV7WTPtV39oesDekIzM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TwukkP8dSukkH1PYm2uYCoOdYwgJgOygLhWfCSACIcwCQZdUAq8DP1yz+aUbGw23R+Vf/G5nJQcjhPTeLiZWyp3V8lV2HKCwdq9DS3RLPhNgJn5Zjl2AeVd0yc8pE9bpYFWU5BRV0/1n0CGKFTnxmoFST1RbUl6uQ+O+lflJQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idkaM58u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idkaM58u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED3FC4CEEB;
	Sat, 14 Jun 2025 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924628;
	bh=/w64GzNNbniWgyDZAoW43PdVaV7WTPtV39oesDekIzM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=idkaM58u0DHtjDZxaWwy0PHo2/UuCQmb9FATjvJZQkmH3Wqusr05iHVlSL4qH5t8k
	 K0dSmuYc1GTUBU7FIw0c2h3Wt0jhGvqR8hXz6nh3nH9xO+/DB6x/7aNjDzXZPidMFx
	 jIrCHmPH27tBOKm++rQnKopBP7G848Yr1/1Jvsb6JYlGPbiuIFTzHygDNDuhCMIyOm
	 QHr1GjAVRXCPfWW3OoIZobwhTHhGWtp5vOTfLEI7DYYGUw6tk9gWbh4TIFlPWsbRsI
	 T9tisWiXZagN0oM6tYyokTdIngGSwBvCPhtCDhQI4eR/Lp5J7hKqxGTs1flZHpSkD9
	 92m6kX387M2Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD09380AAD0;
	Sat, 14 Jun 2025 18:10:58 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fix for Linux v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aE2BNXtOVC2ss0us@8bytes.org>
References: <aE2BNXtOVC2ss0us@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aE2BNXtOVC2ss0us@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc1
X-PR-Tracked-Commit-Id: f9705d66fa7107fcd619083f7aae2afb0554a593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac91b4de4492bfdbbf46b265fb6c5c0ed4b66504
Message-Id: <174992465751.1140315.4705320958677347857.pr-tracker-bot@kernel.org>
Date: Sat, 14 Jun 2025 18:10:57 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 14 Jun 2025 16:03:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac91b4de4492bfdbbf46b265fb6c5c0ed4b66504

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
