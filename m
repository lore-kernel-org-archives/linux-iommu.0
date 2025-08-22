Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954731354C;
	Fri, 22 Aug 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869800; cv=none; b=ScwNldz7z/7/vFAbRxng1tHv8M2COW4l7gg9z0cmiVCKWwchwgc59vQhD/KW+FQI9aC0KnIbjurqmenjAISOXziF2O1UEF1xuySV6mWYkFuMdYfXS6GDqRvy8tm6zDbk4VJzBiPu9MLejit76ILBkzAk0QNSJEALSLYNgRhlQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869800; c=relaxed/simple;
	bh=m84GiTKKjyrEi5A8pXmY9UqzbC9KSY8hGyNM0IRlq/Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qhtmnWuEXQDuEMQMSUEqVXR2bwVuKApH+aYVkM3XKOdBWSV3cDTXN7nAVrpyus809tlqWlyJ7OwCzA7JxjkX2ch+aRaZUinBX0hhJvdocO5mtgyMP8dzabMB+JVieuoSLnqVAAB/6p0wlw9BtVra3yh+U9RALiKabv5oJdS0CgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpysrmVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpysrmVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42041C4CEED;
	Fri, 22 Aug 2025 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869800;
	bh=m84GiTKKjyrEi5A8pXmY9UqzbC9KSY8hGyNM0IRlq/Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KpysrmVrUXFNzBCyX6z/EEWGYWWdTWJWd7AvweddwRR/UINCY5gQpuvZxNjltij5f
	 2tXDB+oVe5gmTM7TA4LQ4OJZz6Mh1O/Qpv69U0gFO94tAn/2nQLp/TRUCtfbNu5ur8
	 zyZBxtdfKNvMI/GK1T/XCl6QSIM1kKjT98WB3Rxn3IA+uQNw/hGrozEUQvZ59R1eq1
	 4PR5p99666zAHaOzAY4sxYsiCnnwATfcU3JUHtd35L75ge9c2uO8vT7WgSMmBYz/gN
	 IxWdINvB66I9xiHymURzAKdemxXIkjDPmrJ5VUjxDk8jEok4cmg/RTEBKIw/i2G+f1
	 rwmwuAlR5x80A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711C1383BF6A;
	Fri, 22 Aug 2025 13:36:50 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aKgzcK1EldsksrPH@8bytes.org>
References: <aKgzcK1EldsksrPH@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aKgzcK1EldsksrPH@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc2
X-PR-Tracked-Commit-Id: 99d4d1a070870aa08163af8ce0522992b7f35d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c37d2bc92b90ef4df898d1aa7a3ffed34e4043b8
Message-Id: <175586980910.1831455.15128189957749194915.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:49 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 22 Aug 2025 11:08:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c37d2bc92b90ef4df898d1aa7a3ffed34e4043b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
