Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB91D38C2A5;
	Wed, 17 Jun 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725212; cv=none; b=UiuIrV7gYfcBp+5sEYkhoTKNSWwDQdHiBCVICqghuVA7b/H7vXQZ2kh9h8fx4cFTP88yvtFrOJWZGDhMtW2Od6vgV/7MMNDC/VTAwEy1L+SquWmEEdLuqCpchtd9b5GBZEGoOsP8BsV+Tm6CO3neuSdw9kj7MXS3/m51CybFCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725212; c=relaxed/simple;
	bh=OSrXu715IlwvpJBSC1lPr0QRiGn9DO09V1qNl5oAlmQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MFBBQVZ7Wbb+PKc8vJXKoLqYZ6vUP8CB0r98jLf8wCdc/hidignmZwfKM5k+gSHqAdGx+T79yVroSDd9iubufbN4l/TPBYPzGuTRNuSzK17B3NP4YI02yteldJBrbWAIuGEj2tFPjIRWBFDJC0/EccW361SRTm7150kw8tqbPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiJCgowU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiJCgowU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA5D1F00A3E;
	Wed, 17 Jun 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781725211;
	bh=RX59wTaHdRD0TDN9XvtXwz291O8YAFkXbjACiqwJ1II=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DiJCgowUPKcGNNVikLPtDBokO6ZSRFUXXb9SCP4YliAHUMk0H+X53vIMwjW5nw7h5
	 UfVOHJgaRqRLQVZ9kLArgG+s2rvvwf13t9sdzyNLLJfcJflA0OwHEzUMOTfk5tQjsu
	 6R7hoII04p0BMR2XTqxxwC7nC7zNHDVYBtnS04+glaryZkw1nbTM/diyCg3k49bsWK
	 O90aUdU/gR+l0LN10i1AzH48jIU5skteOrs/5ORWvd/Qeo0OJR8Prc1744ZrQp5L0l
	 e9u7oXcYaVW+ew9XjwL285Zl3KuIK06g03zH8Phb9SjbZm4DsA+XAU11gQWo5MTp6e
	 swzCyF3ToYnZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD53931008;
	Wed, 17 Jun 2026 19:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617173054.GA235044@nvidia.com>
References: <20260617173054.GA235044@nvidia.com>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260617173054.GA235044@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd
X-PR-Tracked-Commit-Id: e28bee5b445178390d63f7a93a5a219063c6434e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
Message-Id: <178172520556.1784504.2155052522855356616.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:40:05 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 17 Jun 2026 14:30:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e771677c937da5808f7b6c1f0e4a97ec1a84f8a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
