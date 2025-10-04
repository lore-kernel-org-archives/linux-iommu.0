Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297C19DF5F;
	Sat,  4 Oct 2025 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542064; cv=none; b=At05WfDztLsdDPqlfv/o4XNxzieKjQQUWpIHUsWZf2iZ1G2KSVPBcQdzyLHqU27e1orJX6FOt/WVCU9XU1BCkWYJyvtGr86c6C7fiyzfCLcAORJGhqDpg0raA/cA8c/49QUGDHtyuaUBXfQjYXZUGe7gpKzNN3NSfXz0DMHbkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542064; c=relaxed/simple;
	bh=DHdsPQDZj5i9zekZaNOHZfLVVeopJTwNlNyCJcy4tN0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SxTnP5ZznAn/NV26/e7AUR6kCOOApCEdWWkfZH8e1Rth6HWttg/PvDsg7a1iVERAc59NCzKbaFOrNAn3WePET+NOMJh6Se5YNkIwhIrt6SiptRIq8T7NiOPUgxT/U9aSWGgeqGbAvW5SISEtm7CRB0zr1jWmKlhPsV/nIYIYRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEwTmH6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEwTmH6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD72DC4CEF5;
	Sat,  4 Oct 2025 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759542063;
	bh=DHdsPQDZj5i9zekZaNOHZfLVVeopJTwNlNyCJcy4tN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gEwTmH6u00TbBgNC0nZ30gjPdOwYDC4xiUsEjtdgcpKwlzy4JX2ppqJScVKAMBiJp
	 iUiD528OfihWmZiH0MeVpIi8pKJzez5UiAbPX89Ye4SDCdmPLqxAKR6br2W9853eyK
	 BHVYr4V7dnI953h9UGEvYG+HQPwvVjWNy8I+f6WAYNfskfCN98YoDORBe18XY1qF1i
	 zVemYICPui1uF0DAlqBVyIFzNozftU5mOvgsi104yRxiFVic3O5gFh3GrRhdADbfvN
	 Sdqn0pFxncMc5kyUuTsw3AjoWnz1PUiuN7pa9EVKm8CKqd4tROyJ254xAZqBgvc/6X
	 RnQdboV1KTr3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7A39D0C1A;
	Sat,  4 Oct 2025 01:40:56 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <wkxilefpezz4bnwm33rcffdvqiufeengtujjpkr65wrdtluj2u@co4fqyct6ot5>
References: <wkxilefpezz4bnwm33rcffdvqiufeengtujjpkr65wrdtluj2u@co4fqyct6ot5>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <wkxilefpezz4bnwm33rcffdvqiufeengtujjpkr65wrdtluj2u@co4fqyct6ot5>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.18
X-PR-Tracked-Commit-Id: 5f4b8c03f41782f37d278946296d9443a7194153
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed0653fe2aacb0ca8196075cffc9e7062e74927
Message-Id: <175954205492.144727.18235900130702578442.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 01:40:54 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 2 Oct 2025 11:32:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed0653fe2aacb0ca8196075cffc9e7062e74927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
