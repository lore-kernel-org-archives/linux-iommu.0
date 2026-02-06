Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFD3115B1;
	Fri,  6 Feb 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419406; cv=none; b=UHvT2qeYqKFb8GUKk1yi7yjB4HzAf2eDgSSw4TTzsFYsxR/K62EIZkS3t01wepKVj8Qg6yqh5zDikYskv9gKKYAkdsmPVbF/UxBHMdqqJSG+azrmwIFN8f3bfyRWGAhqRg1V+QhnONLsGz9MVDOhv+X4QhBX4KPt4P6vjCTGFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419406; c=relaxed/simple;
	bh=np8IMM6o6puZ09ILkDbt0uPEl9Eb6b6qgfnv6gFErbg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uNMFMYtkesxgGYLEFdvt5xDfhtgXGYX7wgwob44pOOAIzddvWoMOSRl9H18kYZaguQEI2Nr0lcrV4Ufle616rwruYsoa2HseJek2ExSJ5/wShyMBji4t7HZRDo3ofLmoOKqTHDLcgJp93WgUvnLW//6CS1wtAHBUWlraHqUks1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+vlbnMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+vlbnMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2DAC19423;
	Fri,  6 Feb 2026 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770419406;
	bh=np8IMM6o6puZ09ILkDbt0uPEl9Eb6b6qgfnv6gFErbg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s+vlbnMVOxI8pZS8thp5jdPmySjMM7eWIKjfQSogER/njbUEDurC7YEr04UGaTsO6
	 kPWGKagfxfVxAX4MJyBco/SUPsovFlA68F1VjsINQJ5K1bv97GqWnZRCsK6wxvqxjr
	 hTipEIgFDs+3bRnatlO8EKsZQH0nU71qn9IhnT+/qJuJhuhXx8Kq24ifD5njoxfHz2
	 1vUHT4MPjh9KlYFtxWwUOab0Y2okWHIY6Fz6z3UFEqjkGUmbGkLyQZeJVWgLn1jcfg
	 J20B0scV1Pdbm4rCkCxKMNf1YHULartcOxl+AwKTl5kCFNzK5ANG1zD8LWPrXP3nCs
	 +cQhY7Tmfs1dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8528F3809A17;
	Fri,  6 Feb 2026 23:10:04 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <6yetluqpicwgoocksffij2mc22gjw7xqmlfsliq2eipmmnw2zk@5ihrvupht7yw>
References: <6yetluqpicwgoocksffij2mc22gjw7xqmlfsliq2eipmmnw2zk@5ihrvupht7yw>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6yetluqpicwgoocksffij2mc22gjw7xqmlfsliq2eipmmnw2zk@5ihrvupht7yw>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fix-v6.19-rc8
X-PR-Tracked-Commit-Id: 02f9d76a76adb5ea16b4e3b403496c42033f8fd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe70b3260e39ce4915a01cf3556a3ffe5b7f8817
Message-Id: <177041940314.1109628.6485530434654389930.pr-tracker-bot@kernel.org>
Date: Fri, 06 Feb 2026 23:10:03 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 6 Feb 2026 11:19:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fix-v6.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe70b3260e39ce4915a01cf3556a3ffe5b7f8817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
