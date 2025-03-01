Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946341361;
	Sat,  1 Mar 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787702; cv=none; b=Kfkp4rcxD+8656JpAtzKLWd7VvV1MbHMbbxZRZ+X29MOp0QRO5CGheXWkEvhUbwFWkfN271XPomy0/OrzWUYlJbSa5jCTOWG3rNPJtEs8nUEoteS0gHoj87hlv8XoBSPvUzkdoZDJ6FI45n09M8AKHFYOR9qKR4kx9LxqsOExzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787702; c=relaxed/simple;
	bh=ZM4rukPfdzXy40EEBLIDN2kXpB2mA4+goejNKuzyTCc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PcxjMBS+EIpnfbSLhVAIwNPwa/2LgrXtW6ZA7l+F48vxSoqVXB8HCY2oICxbW0Fs2nn+x9jFW99NmB7/XqKQPDdTbN6sB6KqDqDn2EQ0pa6lNadlaW2gT8Ie3uI9kzfxjdM8dGF6CgmW4mmwdL79ZcT/9oS+/0zVr0Qu1nXL9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erqXsde0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erqXsde0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D3C4CED6;
	Sat,  1 Mar 2025 00:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787702;
	bh=ZM4rukPfdzXy40EEBLIDN2kXpB2mA4+goejNKuzyTCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=erqXsde0WqODb2Qu6bO5DkwSfeVBVHGGdBfY2ej7cQ8Qiu2dvxIzJeWih+/wXg751
	 1B8ZFZP2PejQrBRi2sh/jddOHsX3nz7VAfExTiJfjXeh0Gm29JbcQidMlUzf3RbHeQ
	 4Xogjv1fKHLV5NV5hbC1igh8sBU2fuzdMXLhfFzXKPNQp4lzj+xH7bY1NHzL5VJuEi
	 EjC4sLKn4X0+mq42uME+oITT75JRQdTEOIhe8rXMAwR+Wn/ojtZE9wf4oMd9mzAhe1
	 W9RVIs6l/Q70CNCDWLN0nP8V7+p3umW8D+agFOxMXXDuDIFLLIfnpzhF5tA/MkG/2V
	 +P0CD4esNxx6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4C7380CFF1;
	Sat,  1 Mar 2025 00:08:55 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8HdD3MdUViUc0eo@8bytes.org>
References: <Z8HdD3MdUViUc0eo@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z8HdD3MdUViUc0eo@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc4
X-PR-Tracked-Commit-Id: b150654f74bf0df8e6a7936d5ec51400d9ec06d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d7dc8658105f0408f53f5df13f5f2b4610bb4ca
Message-Id: <174078773442.2315171.18262882660224639308.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 00:08:54 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 28 Feb 2025 16:58:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d7dc8658105f0408f53f5df13f5f2b4610bb4ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
