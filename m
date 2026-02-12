Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221F224D6;
	Thu, 12 Feb 2026 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770868740; cv=none; b=OsYrILFPdukm8uZ3eClL1hpRuhZAGFAjcyXP53iau8kz6uXhbVMuAjY2Q1V52CH3C+aZkqw2Yna6uPk1a1GvvnRw9yE4qWP30LSgP6bC1pJguFMjzZSmtbeN+RQ977Wn6KdAfAVVUJ8ScH7wRZ+Y3/dEyl9SdWN7So43tvTFLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770868740; c=relaxed/simple;
	bh=5JvQ1Lveh0j7NqzrW6U0FXEHPMqUHt1T1L++TWhwhss=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c/+nE9jYlkpzDhWgpy5vErHW/IyMlKv/TTLkBvO3ydvI7M2X0qlxqQP74MLE9uza2LhThEuZWEOkqeufztAjAxVSqr1F/ODW8HXpdpyDdqjnsIEoqw7MhPertx7Cp5Q6EETVf4Dvq9GPsBBYBRimIPmX4uaKJzwkSaXd6CoOJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZwgfSJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZwgfSJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECC3C4CEF7;
	Thu, 12 Feb 2026 03:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770868740;
	bh=5JvQ1Lveh0j7NqzrW6U0FXEHPMqUHt1T1L++TWhwhss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tZwgfSJqJ/crZ3W3vClXVxaiqk96Dd2NvulUILgNuUpy42z1yheLXtBk/9Of5EGda
	 WMrsCJr5Wb4+20bbK/vmSHE2BWrGsKsU+ODCZEwyel9ZD3Lufn6dBQBERGPaMqnC7y
	 yez5EFRf6ZtoxRMiPVu6JxDS3C66BqVnOuLlusZu8L4EnxAtUxHrZo61aJAq/G3Gu5
	 x3os5VKTi+BXHd8jOb7K2NxhgoeqwwI8EP8FkYVjvTmHSprLNyOMw5Md8SJ/XtUM87
	 MDozfzKGo0Eynf+gu1YTXOtOmFT4NONQZPnLKskVQW2LhwQO8cnysw1alZ4TNyJOdc
	 9A0mT/aXMji6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B39E39EF966;
	Thu, 12 Feb 2026 03:58:56 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <hwokwarr475oc57disy6m44ojwpjktdwfsmfnwizi34ao75nz7@odsleyef263s>
References: <hwokwarr475oc57disy6m44ojwpjktdwfsmfnwizi34ao75nz7@odsleyef263s>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <hwokwarr475oc57disy6m44ojwpjktdwfsmfnwizi34ao75nz7@odsleyef263s>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.0
X-PR-Tracked-Commit-Id: ad095636604604b3574c1920260b1360c25ced6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e0ea4dff0f46a3575b6882941dc7331c232d72c
Message-Id: <177086873452.893578.11005481341684264036.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 03:58:54 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 10 Feb 2026 11:58:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e0ea4dff0f46a3575b6882941dc7331c232d72c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
