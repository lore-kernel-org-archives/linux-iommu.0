Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6F19D8AB;
	Thu, 25 Jul 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930339; cv=none; b=Vn0USXx8LAg4E18tgtwyg1K9xOb+3I0WkZvrIMjPF8CaViPBC0yYKtp2iSaPvq3gvNOmGeplNbtVLseqji9PBLMDM0MOlVhSSj6/8YMggoAi69XLLfH0kHtNXvTJg7LZRvL+/Ze1BYqoER+8myui/1evGVMLuLSAqCysOL37oEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930339; c=relaxed/simple;
	bh=ksZxtGQ5DZ+6mstx85eEqx7V+pB1g9WvFQ0VaWSbzEI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CmxHb54pvAHlG4X5j7RJ+ebZcVMZSIAOPNCiaPBGvKSuDouBT3pubyXCn3HFCuKvU4AIJSJ+od7stmrSiUgqRRL3xAELiX6mgQYSPCJp/ljE++EsBwDd3VGGtpLQmIzYjkpTlO7OzfmdVEs01Y/UNghU41YbfTJlfE9L+O+oN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHg8duUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHg8duUI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFFB3C116B1;
	Thu, 25 Jul 2024 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721930339;
	bh=ksZxtGQ5DZ+6mstx85eEqx7V+pB1g9WvFQ0VaWSbzEI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lHg8duUID96qWhHIlwEFqokXczwnLdZHCittGugwzjYy/iAAo+a9QPxhdfqrz2efU
	 GnO9cus6hA+8XKgl9wYhGHmle3gSGl/eeoj+cr/WXUT3+6m8Iu7W8lQQmlKR1Q1Mgr
	 2FtGGkm2zMQ7KZnDvNAo4dphGKR5a36vQiEqk36KgOvfe0KWaOjkMpAreKx/GQLSFE
	 f6qZSwCDn+55KkGPUE8P+xhlvdnLjroDfcMTR5h7GRi2AQAbo3oDyTGpQFLVcFLjto
	 JD3UjfTJTvC5SBxMKeWZ24EsdBci4rKeCrjJBEnZ4Uza8ekC5aP9IHL8IL3OkNcUb2
	 LrtRHaIr1Li6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7230C43445;
	Thu, 25 Jul 2024 17:58:58 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqESJ3kPSvh3mG3G@infradead.org>
References: <ZqESJ3kPSvh3mG3G@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqESJ3kPSvh3mG3G@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-24
X-PR-Tracked-Commit-Id: 28e8b7406d3a1f5329a03aa25a43aa28e087cb20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cf601e865198c72e2a53118eaf37dcfd9a6cf1f
Message-Id: <172193033893.22070.2888636634378990521.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 17:58:58 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 24 Jul 2024 07:39:35 -0700:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cf601e865198c72e2a53118eaf37dcfd9a6cf1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
