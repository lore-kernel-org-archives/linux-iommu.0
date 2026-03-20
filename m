Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F23CF66D;
	Fri, 20 Mar 2026 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026838; cv=none; b=HbNoigc9I433Slj7ObuErxWPK/Wq7Oo+eIHPCzCJkK+/A7rZJWmKfnFk74c2bK1KieWTJqFhpVN66p9gxYIHsk8PtyscejgPKV21wXc1bRtQyE2GUbOP52HKY3RiYpExOwNqetaKOhH6waGiPAH8UYQrPNFbbj3dm9M4MSeykDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026838; c=relaxed/simple;
	bh=VOnNdn+AGO9/97A9PIURm57lixP6ZfKuVFSuuub4StU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H47I2+Crzm0ygT38ziUj5v835xIOEjYqlZaNZUQ2da75VWPPRHWLUmEXsmRmY2HfV/LBpkw9sNr6maNyf8358Si47w2oZ3XenhDq50n9LnjAtoKC8Mq5MkohAw82CoD5jg/YyyPNvLyeKd4S6/ZaKKjv0Uq9gxY+aT8cdyl8qec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxnJaShi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxnJaShi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E6AC4CEF7;
	Fri, 20 Mar 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026838;
	bh=VOnNdn+AGO9/97A9PIURm57lixP6ZfKuVFSuuub4StU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HxnJaShieRsnaXt0PWZD/zmcBDZI/G6ZOb1ZNmFlXt/4WIrNSQVd4vmuKmcM0d6k4
	 AvYLG1dhaZJir5CN0lPc1tAp1WlnaPk9A0K0w6AwqD2cIxf5ahURlTwCwTd+CvJtYH
	 631sZZGxSJlzxJG6VUv4rpq6ujugH6Y8Nk+g8eC0QBIZS9eURjx0EW1NxiVLT+N5rO
	 ri1GO3jowte49ifkY0vARDYeCxVV5Wl64b7k/70J7MZ5KyXcn4zhqXpo2Pb4A7vAgW
	 JKCTTzNfEq0VVMLe2BxZXYqQE66OQyNj7/ItS3fO3LtN2vffJOewPVJTib8iT0GLLz
	 pKHjPbTFWXwOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F20380820D;
	Fri, 20 Mar 2026 17:13:50 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <3slk6ukvf622iau2g6ukmmdyfjgw6rqrj2w4maph6ldkixtod7@wddilgwketrj>
References: <3slk6ukvf622iau2g6ukmmdyfjgw6rqrj2w4maph6ldkixtod7@wddilgwketrj>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <3slk6ukvf622iau2g6ukmmdyfjgw6rqrj2w4maph6ldkixtod7@wddilgwketrj>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc4
X-PR-Tracked-Commit-Id: ba17de98545d07285d15ce4fe2afe98283338fb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47e231cbd363669eef28dfa97496621e0fc6db88
Message-Id: <177402682869.2580860.8967822062729738633.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 17:13:48 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 20 Mar 2026 09:56:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47e231cbd363669eef28dfa97496621e0fc6db88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
