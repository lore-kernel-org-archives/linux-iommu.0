Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082026FDBF;
	Fri, 23 Jan 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203502; cv=none; b=jX40CkEEQUna/MsGyRyZscwJmMbwqVaMJoOVWByCAv2htnrAnVXCXBKn3Wuk41DdFBKhPvhCrKVaASbTKvvIekN5MtHOCw2X/DGWb4Y6z4Rq+ipYoavHM+/upAU1nA4uOAsiBgAVt/BP+OnGUpyfn6ieVr/ewkuulxhs4BzNx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203502; c=relaxed/simple;
	bh=5bdYMnAH8Rlm+TPBzdF0Yg+Y3O23TX7JpVBjWF/PbEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U6CZUAQHoYvWyS5r7zaU9ObKFrERq/MxmU4m2a8EZR6dy1rtbu1P+GnR8Inye+RRF+rtIecy6eCXTifxOV1u9TT74uAUTcJbIvCdg6ZEKyTsM8gcQL2IKOY1qo520omzXnyNCagAG+jsDd4F9gY9K8YO6xFiHreHjYhThtFPd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaZbc5Va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaZbc5Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFFDC4CEF1;
	Fri, 23 Jan 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203502;
	bh=5bdYMnAH8Rlm+TPBzdF0Yg+Y3O23TX7JpVBjWF/PbEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RaZbc5VavDR1uyrDyvoZGA1VKU2M543KOmncCcO7TJjtcQKWKRTRMlV5KwNldyi1Y
	 XH2Pl6DSaC1YwnQ0I2s6nReikoYWE2xzJznOcN5ajgTOTItrTpE8lZtYgGfbSDdWDZ
	 OXqaiHwTL2f57RWIkOgWMSOPmvogMTGoVgUML/g4uUITKkvEyBXIQprN7UBYTLghfz
	 Z19rENKGNN9EYW+W7weZv/aRI0GM4cRVvuyQzOvpH0dzHGFssp5hrH3WK1tgUmOosT
	 IxFBOaNZoZ0T0eQ8Uj1VYm31IrW3JRHX6l/JP5tCTG3iWhX2Iy9pL5AeWphAERhy3s
	 fK3Z9SjMOq98A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B9FF3808200;
	Fri, 23 Jan 2026 21:24:59 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <6ikdjv5m3mq7m7fpvccuvnnqm2xwmho4ukpd5vxiwu5fk7klqs@2wtgllvskkxt>
References: <6ikdjv5m3mq7m7fpvccuvnnqm2xwmho4ukpd5vxiwu5fk7klqs@2wtgllvskkxt>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <6ikdjv5m3mq7m7fpvccuvnnqm2xwmho4ukpd5vxiwu5fk7klqs@2wtgllvskkxt>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc6
X-PR-Tracked-Commit-Id: 374e7af67d9d9d6103c2cfc8eb32abfecf3a2fd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b33d70625977126d59f59dfd8c0bf9a75b4591c0
Message-Id: <176920349821.2720183.4068828957657794894.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:24:58 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 23 Jan 2026 10:13:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b33d70625977126d59f59dfd8c0bf9a75b4591c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
