Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAA47F7F;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716055621; cv=none; b=t9FROibnTcucVfTjtU5Lpi0pMdk7i33WM3h0n9E12mtE8CRaRUucrzEqcTNTTapdOXTygfMaPSHwHo+0UE4zbR1NS+wPjaSYAC5QX3c1XplHNXpBU4ImdtZWXtEONxPVf+e3RbChImABjWG9RXP1L74N78rPZWjPJHVxM5E4bAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716055621; c=relaxed/simple;
	bh=+fYWbrwzH7fNf3RB50idGC+p8fSx3vdXVzTXv8qZLBY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DtFbyiST1DGcNSdJp/E3UkHghI2cV6XT1tXEQlQcH/aZO7/LPvBDF/eYNM+JdyMD8av50/ghGwPmI3IxO2i+FQjJhMK7AwbQaGoLUzKEtHXMiVwhcJ5iO8+RgIRPcXqBCBlQuRxDTV70zKRkkCJrvQV7EivqB4PH7laqfzdCINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIoyYv3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIoyYv3w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 727A5C2BD11;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716055621;
	bh=+fYWbrwzH7fNf3RB50idGC+p8fSx3vdXVzTXv8qZLBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QIoyYv3wxI98mT/SnpyhikVheI+V+8Akf8JujMYGJknW2XU/11s74tiwTivVBzmoH
	 IzeHN3iKqtTRofuddI2GB2xuE/BSOesf/mQ39YjZEs2oEnqxLUZ4xPmksaEfXqR9c7
	 lGmSWWyTqJ2lHXqmimxkWTwmMwUX89fIuIDzfA7mtiR5g1ekK5PSqUGJP4S0hrdiME
	 CoZK5b+3dJ18b23qvBGm/lvFb3w3oU4C0Vsk1z0G0yFJufaMdHAHao9ARcIIJnrFN8
	 I7QVbNyXBixZdyPrIJZ7yBLzXmB3DEWFPijlUWEMWovg5huYXCXbvB7qqw04aX8kBs
	 XehsckiAikrkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65A26C43339;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkcqDrFmd4ZHv7Qf@8bytes.org>
References: <ZkcqDrFmd4ZHv7Qf@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkcqDrFmd4ZHv7Qf@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.10
X-PR-Tracked-Commit-Id: 2bd5059c6cc04b02073d4d9f57137ab74e1d8e7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cc6f45cecb46cefe89c17ec816dc8cd58a2229a
Message-Id: <171605562141.7011.17834859902168748093.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 18:07:01 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 17 May 2024 11:57:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cc6f45cecb46cefe89c17ec816dc8cd58a2229a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
