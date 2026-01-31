Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01253322C98;
	Sat, 31 Jan 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822458; cv=none; b=H3V+iHkt0d/DcsgCkClXxT/R6vwlxZozQe2ETyrfkZqtBY1lKkVEKLITqZah2xYjfDAHUqgM8SgSGMWFD//X2x4O1driOeBru1QK+tjEgrPaQ+V9ArFDHHIse5rsniM572LkixtWCSPvJmi6YyugFi0c57EuIFmEzqf7OpEDmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822458; c=relaxed/simple;
	bh=t8iEZsGEWhKp/4bVGBswpKo14OCp07OqGmPT61qaF4w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UZtGUdJTW7n4T0FSgxIhQrzMLG5Ckczvp7be1k/Noyel8EOPiwHZ/c2L3q1f0oBCcilT1MScdiPIpokgwWfnevvXXd3lbtSFsTzHw8OiNwrTQIk9IyzHyWywe7z13H4JKOosmkX2K1pn69SUHbvNbYxNfhIyjLpZXQ7atIzcytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecphtajf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecphtajf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5F2C116C6;
	Sat, 31 Jan 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822457;
	bh=t8iEZsGEWhKp/4bVGBswpKo14OCp07OqGmPT61qaF4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ecphtajf7bfg4VpPEImGqGQUnpJC93QFbPISzVxL4Q40dig/NQpmPx+PBJE/SBRn/
	 RIoFrgXE/LtcmWQpIMFKMBaPY4sd7pPZS9ORcprziRs9mpy/oTa9/CsgUFsFACVRg6
	 hVAsNuZqN3CGBGnr8mzfgKsM7kX2wno0i0V8xq98vaD5fauQ2W1ksYy2jDHhuJNmGk
	 cR2WuJN2Z7H0qIAL/kYp50MgJUNQpgilL6Tq7AaqdY2bepHqjlNEHjkl+fKMmLrgho
	 i0TCyfrnkY0IK6cXUKrx4WB/PeqXW+tP+WWfaImmOsETI6SOsexZgbgij6ouUQTABH
	 mc0vWYN70/W3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2ED10380CFFB;
	Sat, 31 Jan 2026 01:20:51 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260130234158.GA3424021@nvidia.com>
References: <20260130234158.GA3424021@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260130234158.GA3424021@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: 2724138b2f7f6299812b3404e23b124304834759
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad9a728a3388dc5f66eab6b7135e0154249e9403
Message-Id: <176982244995.3954333.3767377285623872996.pr-tracker-bot@kernel.org>
Date: Sat, 31 Jan 2026 01:20:49 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 30 Jan 2026 19:41:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad9a728a3388dc5f66eab6b7135e0154249e9403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
