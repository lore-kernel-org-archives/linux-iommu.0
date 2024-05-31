Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD280617;
	Fri, 31 May 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183205; cv=none; b=p4HKGy7QrnUPkPZNW+I8kle2yPhIaNQrpIjqli+rKwwGw+woC8AZ7chDmbyR4unDyvsJAGMa06ibKykJfjT04bHkRDTcjvSe/HvG4lAX+3VxdB2SA6K2xFfMoV29g+q+Jf42xUp+wB9S6RVa9D1+cteqvxf8h09PYMJninLbU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183205; c=relaxed/simple;
	bh=9pc+i7ZzrsHVQYbzSDjM449o7+0EKM7LwpFWicTSX9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f3Gm7eE+EP7W4HvWS0jb/6eWfCU40/FZkwAvM0e0gfJ0kEWyFglCWYMd+8AweAnpsyS6h1sxkeTzU8FveLukDMdsQ4JgyAK1ao/+adkk+diY4MBhlkKcG5FPWym+NkbBNJ8T1iOA0T/9lMCBYrlPQwSx99QeLN8a8pbxdwgKIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCivOa3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCivOa3y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA1CC32786;
	Fri, 31 May 2024 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183204;
	bh=9pc+i7ZzrsHVQYbzSDjM449o7+0EKM7LwpFWicTSX9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QCivOa3yQPmsJqp6STOf8nXUGQJBWT6nWkNv3MdynIFsmzvf0ypa8Qy8ndsGzE0iK
	 RCyoOHJKi+ztc43xwc/Bog1fISVrCxexaApoc7JmfLOHoxPcmAVejQ+hwW05kqH3jR
	 cMESggyrCiL73/887R7rEFYI11Mt4tYgu5HUQgwZL0U3UBWhPIymLJqmbNidZTRDOL
	 N8moplrS2QX51j7bx5kOQJUnBdN5HTa6yWTGFmgoa/xIr5jyD7D+AtQQbstEOGF+Rf
	 Z8tMOk05isaLwTmf/PsxTE4Tg90QRgmFSYk1q/jpPcDVcgpOkNYvTn5YheEnGCZwtM
	 G2JNF0lEc1iIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C797FC4361B;
	Fri, 31 May 2024 19:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlnDOBd2X3T4fiev@infradead.org>
References: <ZlnDOBd2X3T4fiev@infradead.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZlnDOBd2X3T4fiev@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-31
X-PR-Tracked-Commit-Id: 82d71b53d7e732ede6028591342bdc80fabfa29f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b050496579632f86ee1ef7e7501906db579f3457
Message-Id: <171718320481.20247.10364979761614234670.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 19:20:04 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 31 May 2024 14:31:52 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b050496579632f86ee1ef7e7501906db579f3457

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
