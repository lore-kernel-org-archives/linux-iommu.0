Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05003AFD11;
	Fri, 29 May 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085623; cv=none; b=nVA0bW41OSkwmENaVrV0YRNUNp310jZJT8x/TsZSxNRm8LoAhEKoJw1sRkcyTNDtLgo1AT7pluiDNL8f50kIpY4j99ArFhknY9dLqoCC4txrdlv8+h4YktVQP6HvoJvyzna8mLD6RtbGcJSDOuddio0ZV4ARYNuLjErgy1TGxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085623; c=relaxed/simple;
	bh=Wb260QWPJzQNZArjI8YRH60kNgzSfr4+cx5a0Y59VBM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fis9GeBptfv106gSgZOZ5pEvFVCFZ8aWYcBlBePqHYpLNOpaU6mEL7yL0yY5brBIL6VY5qawgShb/W6OGBvmZ4hQZ6q3DmaBSSdCcWcruatqPmK8g+JmArBNRAXc1wFeNurNQu77/ivG5tQGva/dDIRhufBz1DIWvh3w22DgFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKpPQJh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKpPQJh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A688F1F00893;
	Fri, 29 May 2026 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780085622;
	bh=dSJVMMYC9bS8h0auEvsTr12PK6NVaJL6X1pk8lCDtqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jKpPQJh6YjHTIi22SXyq+jraEf1AQgVjenMOyXuHcdRCKmgRWJdqObgZY0wvEq5kw
	 +Lgd3uHuZiGNWUe+rg85fI1Y+mFMPZkKai/wl5sRjx5AktJ7lHQf/sD8ryZBU9bWbt
	 6QZ746lcoHpn06DMEpUgQeUc599/xHSiPPY10aO6ZBCo3rhFW4hiN/WpoELf5IpOmy
	 iwChrAkJjge5BmeNMO8R4xDGvXQJsVbipEgMjj8sOFQ4wh7W+oy3MoKYUsT9l+eftl
	 e9c2WmFRhmGKJdnH4tzpcTUOwrKztVtpxjAqZyVwn+N1o6s0Ngjwov19l7J5fc6ELM
	 yRU06kI7z3rBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CC239301A0;
	Fri, 29 May 2026 20:13:47 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahl0UR5Z-mkv5wFB@8bytes.org>
References: <ahl0UR5Z-mkv5wFB@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahl0UR5Z-mkv5wFB@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc5
X-PR-Tracked-Commit-Id: 00c257948900fae69dae2a055b378edf09aacf6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0ab604210059c3626c9c77142b51f39e9842504
Message-Id: <178008562621.1949175.16545557023543670375.pr-tracker-bot@kernel.org>
Date: Fri, 29 May 2026 20:13:46 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 29 May 2026 13:12:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0ab604210059c3626c9c77142b51f39e9842504

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
