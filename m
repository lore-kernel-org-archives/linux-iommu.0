Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1241618754F;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110843; cv=none; b=X+SUS5BzZ77PnARbXaVaMJ8Uwd26jurvoJlb6/7IzfOD8NE6/GUL42UwwKobPJjlsiFOJyCtnEzord+T2OallFX6Axpm2OmY2WHlEy+HIQMtX2tLia8W6paHQGD17p7YtoBxVwhfVklSneKPxGTTshwxUvlLeSGJYC2HTljoZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110843; c=relaxed/simple;
	bh=zJRMEl/eco5g8UgqMnfuzJ0N5RL/gYUQPHdeRZVIRLA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RExUHTim5TdGXL3npDqwX7khfb/JMaD+EDEF0vQdnFO0zYb4kdCCf7JXQ7sELGPcw+b/FFI8y/oFHhCzsjx8mZ8XrKUriCQGqA4phUsUrMpbtOEkN7mUDvqxYckKI0KVKH4EtZ35E3IkG8teS/Mn+eveSA28X1H7S6oYzPCWzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf0xb8OO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf0xb8OO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8930C4AF0A;
	Sat, 27 Jul 2024 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110842;
	bh=zJRMEl/eco5g8UgqMnfuzJ0N5RL/gYUQPHdeRZVIRLA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gf0xb8OOkGVND365e4ZrR+STz61XLy+XJPNW3d81hEt2hfZtcLTPNO9kzWJIqVo+e
	 fILRavDVnkQiaj4ESebh8VLUAegVPkyNus+eRsX0f83UfU5nnuSFy/CFQQL/srJZ3/
	 j6nSlmuOTzsMQDGa4EVUhdbKlR2KmGRfEX9Waox2y27IvOsScOsEg7sjI3/+jm/LJZ
	 DYiMCs2tgQ0yMXUoemMbt89dDLpFVcia/6/Ng45XipJNdEeJ7Y0Pb8bbDUTqwKg6QD
	 rybHPqsLPS633wkUHWDkFc3ByOzU4Uwt7vbxit6UM9k+QXwd20LuEayde9xqxiLzzF
	 bCqZDYUNfVOdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0E98C4333D;
	Sat, 27 Jul 2024 20:07:22 +0000 (UTC)
Subject: Re: [GIT PULL] IOMMU fixes for -rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726084532.GB29687@willie-the-truck>
References: <20240726084532.GB29687@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240726084532.GB29687@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc1
X-PR-Tracked-Commit-Id: 726d4f528dbc98a84d9ce3c749dfdada3dcdd5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b465ed28f7125fcc41f3e556db57c42c11892ff5
Message-Id: <172211084291.16614.15817953204225647929.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:22 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 26 Jul 2024 09:45:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b465ed28f7125fcc41f3e556db57c42c11892ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
