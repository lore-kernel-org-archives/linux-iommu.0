Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC7161
	for <iommu@lists.linux.dev>; Sat,  3 Dec 2022 00:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28BFC433D6;
	Sat,  3 Dec 2022 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670026234;
	bh=xlK210QimcTHCPMJ+JQwKNu1yv5oHYwLgQI6Ic3rbeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OcMlFqW9b75749v1kuhYgQVOX00RA1aTDW7jvD85golgYVnaWs67LiQTDYe4Bq+KX
	 4QxWrBAOlLlW2veSs53Cc3jB+MNd0H7n0J7Sfmw/eQYNQQ2OzFrxjr5aBc+e8GuE8+
	 667GjgJSFlQpd3cEREkzlcqrbmiE2eZnSaIUnTIQb3x0fk/vCld3OtjsoO74f3G9D1
	 ARVYwsiAZOyotukrRoIaJbUtsjCy+42rLlIY8qrwXmAMlWZQ6DAny0UR1Y6kv4oKzX
	 f/SVf1UGOdRmcuZlp1l9rmb4hl0AVv6VjxI0x9dnkiiIOOnmYOgrGkNAmcj8FMaADi
	 n4s6avCspyKKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91481C395F5;
	Sat,  3 Dec 2022 00:10:34 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y4oF8e7quzjm2kzD@8bytes.org>
References: <Y4oF8e7quzjm2kzD@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y4oF8e7quzjm2kzD@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc7
X-PR-Tracked-Commit-Id: 4bedbbd782ebbe7287231fea862c158d4f08a9e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f66f62f83dba3ec4237c3dd7a95b776824ac91a0
Message-Id: <167002623458.23477.8740887648769453661.pr-tracker-bot@kernel.org>
Date: Sat, 03 Dec 2022 00:10:34 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 2 Dec 2022 15:04:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f66f62f83dba3ec4237c3dd7a95b776824ac91a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
