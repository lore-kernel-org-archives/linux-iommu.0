Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E92ECEA5;
	Fri, 12 Jun 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279737; cv=none; b=ANbLnsNgaFvR9jlNu7xd77i1mSUfs+aZeblVga8kyBi7g0teIGdEw7O+M8BIPJdbADusCQBtuArRFI3WFRI7FgA1n2/CENSGW+omfeRRN8B/E/AC7QNhVrg6nnM/rlYKMxIz+h2t2Q4l+h0ar9cb5aNkjUdMOu/v0PGlDINxvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279737; c=relaxed/simple;
	bh=pb6ew1hdYE3Bc25XzqBoe5D3z10OJ59yjoYLy/YOKjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SrlDKeZFjYKkH6/wZkjQ42LoyPDOF3F9jaUTCcwNlnqm5yurAbF67QLvA2ehfyA4TxsUic6pCZARg6G/AKHv7XavRyJEsU3PmoYsYYfQsVTWXZQ0OF5Yr+5eMpMoOCfKQDFFCzjmCWpc76RLJD9+qZfciW2deaGyccRoCI+xd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdipM/RG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdipM/RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115351F000E9;
	Fri, 12 Jun 2026 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279736;
	bh=hOFB9hIseyhg8wvevsdnVaHErr/EH1bVSNhdMmFWUcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UdipM/RGYelhAss4mXTxBd3RV6KI+8WEoQ71DT2C8pLlrXCx3bZWOCOlbcxFSXlZo
	 78jYqrmShszbgEYa285O2wr3IXyIvex9v6o59QEsfZ5bLOcSFkTw6UeXDT0xFoMg5t
	 mb+BMg4Xoy565ZtqIZlar+zaWxTZqye/UHQmxW9H5JVhtv35MYBCkbHGDaGlpGz17f
	 u5CNDG1WPpBXRMwelH7tinlYtqcGb5NS59msiQftvSQvJ2WKAaekIFw9vFD9q6DKCe
	 4ahjAd3v8VBemZ8x1mEKbPE+iSLp6sMj9fUxJQZi6iSoO6ewi7wUwcCkMWDJrqbx1o
	 wHmgPQm8DPsag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A3E3931092;
	Fri, 12 Jun 2026 15:55:34 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611205751.1255411-1-m.szyprowski@samsung.com>
References: <CGME20260611205755eucas1p2a4d68c135aab6b232fa3ce6ac7d8a369@eucas1p2.samsung.com> <20260611205751.1255411-1-m.szyprowski@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260611205751.1255411-1-m.szyprowski@samsung.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-06-11
X-PR-Tracked-Commit-Id: 6ec91df8aff77e2e8fe3179c1f3fc15b43a40ba3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f51cae6603c05b4b1fac65c773592e5bc8037251
Message-Id: <178127973260.723498.10313878544889388228.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jun 2026 15:55:32 +0000
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Li RongQing <lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 11 Jun 2026 22:57:51 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-7.1-2026-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f51cae6603c05b4b1fac65c773592e5bc8037251

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
