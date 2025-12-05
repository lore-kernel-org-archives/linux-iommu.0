Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483352E1C57;
	Fri,  5 Dec 2025 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903870; cv=none; b=QfiWXqKPH0QxEBwMX9dLz5V1230Vpi07/t6yd7heFNifAHA4QyDusZdBRg0XXK9ylixFZ9oxZyWOmbJd+qrf4vKnD2sPErrkRdFMB/5kYiQMiXn02ZRlhGdVgABhewlwT7yYbVMu7FINFPozxOX9Djoun5IguvdXOI9xdoISnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903870; c=relaxed/simple;
	bh=PIiqe9/xcbzyBuImU0ViACMWSnMgQdcF498RUDF2tlU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d4qxBKA5MZewcOggLzS7UznxLhqxqnH/QAOwT7BjEQenaRmS4yUPAZuDks7Yd6jpWFxLNdrg9NCbL4Y97zIpKJXQkF+ZutF3uVvOyXcZ8WZRlm6rhkfFtsk+9ZSmSvii+uyl/tgLbaWqWwBUP1OZwBvavxnBhhiqhoG+F83a128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuFv2+Vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuFv2+Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50CCC4CEFB;
	Fri,  5 Dec 2025 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764903869;
	bh=PIiqe9/xcbzyBuImU0ViACMWSnMgQdcF498RUDF2tlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MuFv2+VbHlpcnOjM70eVSNMKH0vdQ/PxWcPQshAVzAFMxx17FVhFtDB3p5IluqMBm
	 dxdN8iJyMandd12Pk6oMIuAPOZERXmVQeVX1T3zEdJsCrX6L/XrPUbG4Ezpu0aCaDa
	 KkqAd19bl4nWEmwcww274fpfPlzzvD2WdzoWorFl/qgQdCy94eA6dwa8V2zckEx+wE
	 fD40pK5x9RjqFobLXtRfPNwQFmVCu1pH//MGbzljB+13NnH1SU7NqAPgunAwsxza8V
	 9PYqg8B7t/bajsz+vhKXj8b0MrpppeJSpvZOM3jAk3L7sHu+WeOYUQitKtm5OQ8L65
	 OGrhUukcMHneg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C0683AA9A89;
	Fri,  5 Dec 2025 03:01:29 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <2siidejxg252y5jsrevsx3pcfijzvtw5a76ct4ysajzllxxofl@surpwwn4naps>
References: <2siidejxg252y5jsrevsx3pcfijzvtw5a76ct4ysajzllxxofl@surpwwn4naps>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2siidejxg252y5jsrevsx3pcfijzvtw5a76ct4ysajzllxxofl@surpwwn4naps>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.19
X-PR-Tracked-Commit-Id: 0d081b16946ef449fcb35b6edc1ef6f9fea6f0a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce5cfb0fa20dc6454da039612e34325b7b4a8243
Message-Id: <176490368782.1073302.1845594123296714006.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:01:27 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 1 Dec 2025 14:15:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce5cfb0fa20dc6454da039612e34325b7b4a8243

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
