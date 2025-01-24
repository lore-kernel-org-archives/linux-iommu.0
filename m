Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2792E574;
	Fri, 24 Jan 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733638; cv=none; b=i5cwfPDFy7n7+mHNYeOSaagocelgeSZQDsH/IT+IAjl1JQpCHL7vIaAkCYNwgD6cmcONy06brIXQoK4ItLCTT/MGc6gA21OuRY3C0Hd9btkJRrEeF6seMPhK7EgV/IidaLPBG3krwImGoKYXzVE+TTcZHxAXszqgsZMUBTrl6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733638; c=relaxed/simple;
	bh=cRHaqssYYaayYULQLWdzTSEwO4NfqwSDSAuyvMKEkI0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OjpkENuDWfJDt2YW5DHOKO+IxkO+4VmsqRqL9gKxUzvivqlYHz45NE0T29vpTRZGkEpfFbqkxT0V47wnVn0bsf0Kn/BIM25VuqtKBh6mZIj2CNLQRf7NMzRr/XBvWoWR/9BT9ZIxJAhiGihWVMVIXlhRSX6aL7bTGnCPOypvhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9bFRQDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9bFRQDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F4C4CED2;
	Fri, 24 Jan 2025 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733637;
	bh=cRHaqssYYaayYULQLWdzTSEwO4NfqwSDSAuyvMKEkI0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k9bFRQDECdHUvv2hELX368D73LhJZQWksHCre2Tr0OdDIID2ToHpcFPUG76VlZTBw
	 OquyrCmtvj9LGITPIS18FOq+idbtNT9uE37xIxQBA4F4j2as4d8fvnX0bDHVTT4Qat
	 tAjtns5oDqdQVR4adAnmz2Pyyc97YFCjxn02/13TBMX3X9YeZHdALZ8vJEe+uRCCtj
	 wfthdr13sauG6brq0NyJSKG0KsNuIFZCq7W29M3CHOSf72CqR6jHDr4NgcUtk9vd9G
	 PWq9jojFFc0iR099aDf3qNFGCz12josaxaGqQwPbrdpX4opwVgb41fFJpA68wZfRSP
	 fdY6euMTlTsaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB54E380AA79;
	Fri, 24 Jan 2025 15:47:43 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z5CzLFtBJZrnAMdk@8bytes.org>
References: <Z5CzLFtBJZrnAMdk@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z5CzLFtBJZrnAMdk@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.14
X-PR-Tracked-Commit-Id: 125f34e4c107b151029ccbeea92631481bf5a6a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1c243fc78ca94fd72e2e6e8f0f49b7360fef475
Message-Id: <173773366260.2077644.62531479999479828.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 15:47:42 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 22 Jan 2025 09:58:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1c243fc78ca94fd72e2e6e8f0f49b7360fef475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
