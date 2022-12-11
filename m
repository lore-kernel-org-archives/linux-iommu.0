Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E11399
	for <iommu@lists.linux.dev>; Sun, 11 Dec 2022 18:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78EA7C433EF;
	Sun, 11 Dec 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670783631;
	bh=ULrQ9kAJdlN8FOWy6OZJnfAR4nlgpU+Oegbq+ErLvlY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TsmB8CwS02zIYQWwP636yC1vxpjsGPeY+KPnZZJ5HsS9VukPXSFluzdljwrj+nh3P
	 iJKMjwU7YytQuH0+joBrRi1YO8sLwxa9jtQlwBpgb8yjMhgIKzYqYQBHf5G9ur0ZH5
	 n3zMnMbbys4MQRNz0XuZT3ryL77WTiP4HM+iGzlxzSZpl3sUmps9BT/uYnFufinWkX
	 72OFrgtNq1124Nqmo7otrSgCXbjiq/Qm3pHdNBYb0lU2/rcrgQFW3pNT6AexoAWyWm
	 GEsaZ+LmIeGTBHYAkhZUdr3nd9ydl81V3jFReGrP6wilYLsPIz1KCsDVKxWl8u/mhG
	 Vgl7Ly4rM6m6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65F14C433D7;
	Sun, 11 Dec 2022 18:33:51 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y5XgdLWLDDRac92s@8bytes.org>
References: <Y5XgdLWLDDRac92s@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5XgdLWLDDRac92s@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.1-rc8
X-PR-Tracked-Commit-Id: 81c95fbaebfa5990c3c786c8c3e87426a33106fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d92b86f672a42d9d74a24a63a1e59793c4116830
Message-Id: <167078363141.9533.17574340125800472883.pr-tracker-bot@kernel.org>
Date: Sun, 11 Dec 2022 18:33:51 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 11 Dec 2022 14:51:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d92b86f672a42d9d74a24a63a1e59793c4116830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
