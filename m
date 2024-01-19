Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D75664;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626527; cv=none; b=GEdY9fmD1ZF2IP5puwDa47/pApLNrn92/PPgvh7DDuss66CYQ/Tv/X0h9vFxl1lrcHUMSB4LFxiRFhzhVeViTsSELpbOPczJJBb3DhzewWkl9x5m20LlJMY0FkUDRtDE+76OS7dF6bRw+A7k9aMf75nrBUQfJRM2Ux9FQCEmSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626527; c=relaxed/simple;
	bh=8kV433EpnX1489IMm2QY+ikqK/G0cWYEbDb2olixkRk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XzUrkQPn4Rir2dnboHsx6uAjgbTwJ/e78ILshSSa326jSD4W//WD1sAlpbiZy8x6BXtJCGekNzUh+YLzQWRn7wUSQ2pJkgd3Drzk2m4oBSlOvyxOTGhojDDgrcDTBMoxmurB9+OujvN5lVQsiDG9GZZ4CmCE2hEXon5yUl8omDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMjdnj4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMjdnj4B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438CFC43141;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705626527;
	bh=8kV433EpnX1489IMm2QY+ikqK/G0cWYEbDb2olixkRk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qMjdnj4Bgn9u8KXRgNpTqmnqVTqrzAqVwvYzAI9zO9hac6JSHseZhVkURwXi6CgCx
	 tPyI1ylA3KXFOycLUVOTbJQUPQMYE/G43ma9ZM5NiRMu0SDSQvbLvwLCHqQOCfq/au
	 9wjNZMFsqtSNilYCWRccTaa9L2D1WBRH1PkYq83+nqhNuoPxCEdu8Koelt4/oqG9m4
	 QtUKxII7sOeaBXp5IBS9gAAFPtOLti/5BWmnpM4mXOzWBn6G7zMjamF1RQQgkJetOy
	 r5wGiw/k+/2UYxydUPvXdOwMGGLtQA/US6XlF3HqjbWvykPeYxsqhWFSdZmltL5Ou5
	 LVmgQaAB+SWlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32EA4D8C970;
	Fri, 19 Jan 2024 01:08:47 +0000 (UTC)
Subject: Re: Re: [GIT PULL] dma-mapping fixes for Linux 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
References: <ZajTpGRSCJkhPEKk@infradead.org> <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping tags/dma-mapping-6.8-2024-01-18
X-PR-Tracked-Commit-Id: 7c65aa3cc072cee76f577262fbe381a111a98774
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17e232b6d2feddd0285e59dbe641c0efe67a5ee6
Message-Id: <170562652720.16604.2876131930196768961.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 01:08:47 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 18 Jan 2024 16:52:17 -0800:

> git://git.infradead.org/users/hch/dma-mapping tags/dma-mapping-6.8-2024-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17e232b6d2feddd0285e59dbe641c0efe67a5ee6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
