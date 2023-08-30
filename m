Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE215A0
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 03:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AA1C433C8;
	Wed, 30 Aug 2023 03:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693367906;
	bh=hb4oPX0hdidBwhA+lBxaqsDzN0wS0uaurd/16gGnqXA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aoR7xLBJhzyznFHSvZ87kgcWvEh8MShTn85HvLf1jrgfR/2UGR1Ojq1c5q/gLnFUa
	 Y1kfdUALdHDX2Noxd2msD/y73OCevEKiquxIhGAKyhShqvDvXExeKsHgh6DhVeJWZR
	 NPVo+yyC74V83k1Mv+QY3eXSIfVdQK7mfFUr19vhEC4kSxNYFrmGva4k/DzyISnxgm
	 vhgel5ja+RIsuhg21Jm+RHXnDEFVlfWQ42b2MIx6+G2F4YIw2cXEs7IilgghrGTH7x
	 940EowdbvHF6hOMl8AZBnOQh7uHGX0iIMo5PcB7iKGb64OlO17EyRj5p/cqq6hfEvO
	 kWqczVqrtQDwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6394CE29F34;
	Wed, 30 Aug 2023 03:58:26 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZO4NUZ+k4Q4zPu6X@infradead.org>
References: <ZO4NUZ+k4Q4zPu6X@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO4NUZ+k4Q4zPu6X@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-08-29
X-PR-Tracked-Commit-Id: d069ed288ac74c24e2b1c294aa9445c80ed6c518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c1b980a7e79e55e951b4b2c47eefebc75071209
Message-Id: <169336790640.6268.18249090273820297966.pr-tracker-bot@kernel.org>
Date: Wed, 30 Aug 2023 03:58:26 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Petr Tesarik <petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 29 Aug 2023 17:22:57 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-08-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c1b980a7e79e55e951b4b2c47eefebc75071209

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
