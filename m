Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CF2C181;
	Sat, 16 May 2026 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889969; cv=none; b=inyTjBQF0d3duEbMtl/+XK7dESrRgSXX8kQGhyz/Ri78FaJs9hd28qw7336Dn+UEKR1IGP9gHAofpqntdZYqeczdndKU4bLTV62vPfoLTUBHiMsfUaaJdSYlwK55QYLMAHiuQ6gS5VMvk3uTnHRxjDbB4b6Qfn2vHbFd0VTpjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889969; c=relaxed/simple;
	bh=auQmhg3dLV7WST++xIMy3N/BCMRO2IcKly2j/5btGCU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iiKqRC4GGLJcC9CQNl29Ln4UhdigrG/EQ3M+CPf+vv6E3KXmFDozXwIzCTI54zK2J+ki92KJrT6QW5mEPxqofFYSkzV5Mq1rjIfK8yrp4sFcXXInZJUVA0dqJLkF5hGxgstNPDHBJ2K07fEcOOsqLfQLf/NkvPgqUVsYSeGkn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqBwS2bK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqBwS2bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9086C2BCB7;
	Sat, 16 May 2026 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778889968;
	bh=auQmhg3dLV7WST++xIMy3N/BCMRO2IcKly2j/5btGCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VqBwS2bKIVnyHrorh9INWpogNpPo6LaC0sH1ADZJgtIkdZVMCNDJKoDlEECWWaQn+
	 ucIgR5C6eZmpPN0IUTGi0cYDkayx8hoaKdSKxpaJ7PoLP0H2Nc6+KIxIxfdw8J9omn
	 1vvREBbpjkMlpUR8YbWDGas6KXyjnj7CzUNdmJkloOBZR7N8cK1HaEcTtZuB3s0Nmm
	 jhZwvVG+uPnz5ndFsk6XO5z6kNGDPlC7f6DZKOLmJL2HyVbcawP0QsKt3CPcUoyQXT
	 7oVAQZDVG1qsGJLzO+1D1JihWFx91mI0PdZ/awEDGUVdHBkmmCM8EpKPFEyPtbbzOk
	 jXBvsDE6RWg+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5699A3930A23;
	Sat, 16 May 2026 00:06:23 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <og4pb7fwmfp5ogjssmsl6uk5ies4t7wba6l2l2gi7ek76tpfji@jhvxjh4rx5in>
References: <og4pb7fwmfp5ogjssmsl6uk5ies4t7wba6l2l2gi7ek76tpfji@jhvxjh4rx5in>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <og4pb7fwmfp5ogjssmsl6uk5ies4t7wba6l2l2gi7ek76tpfji@jhvxjh4rx5in>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc3
X-PR-Tracked-Commit-Id: 1bb54043ff309795c90ccadd8a6e6b13ac40ec4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30e0ff6d6a83586486674c343db5e9d933bd92e0
Message-Id: <177888998191.203181.4854015139177954207.pr-tracker-bot@kernel.org>
Date: Sat, 16 May 2026 00:06:21 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 15 May 2026 19:57:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30e0ff6d6a83586486674c343db5e9d933bd92e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
