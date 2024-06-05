Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A014D28E;
	Wed,  5 Jun 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602355; cv=none; b=mLeURxF0Ym/sW2t8dNHUAalArkOYDNxh76HTXV3EWq5i6S1F7+4h0mL6ItQ0y4jpc5xMIvE7uk3+w23dDCDNBFNZK7gTElJ4tFTvpvSbgJhv53afcDMRQYc6XT+otWX56C1dolEmD4Cm5HslCJPrYRtdDYWFsiH/47a3xvqPEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602355; c=relaxed/simple;
	bh=9nlpvd/RBQ7zvM1voaUqyGDGzARyaDyKMG/NAiuPlD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUuHKfWJFyRVlbx/qMXeB4ug2ZzJIwSsTeFaLtKUQ8M+iX88PBD7dQfkwUwtGtDgTW0TJwjBVd34q02f2NUF6EoEcZoAQ+Ha/4Dfarcnk1bsZa7jZmJI5pamOLr2r65RHC4Jd5uud543KnKajzEEWaY1SXBKmclpHq3uWkHtLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNyhLnF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNyhLnF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48523C4AF0A;
	Wed,  5 Jun 2024 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602355;
	bh=9nlpvd/RBQ7zvM1voaUqyGDGzARyaDyKMG/NAiuPlD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNyhLnF51uW+h4fS9U62w7t+gT7nCS60WbiQUUbLjMXX06IjXpIqKn+fyMItaKjAv
	 Bmd3tmC6HZB7L7tQSBJz9n+SAqSWl3RXyEPX1qPled8+3LFnqn4HuVzveuDnoTANgD
	 UvWvlJQA5GQA3Qw2SZ4lhAFE+T6xeRjCdFUQmZj72VOGAz05DDpNJs+PmwNjvBjR+9
	 0su9upXOaR1KMjrhDqTrGZPus1wM66kdE6UIVY/VFeb4rA8ckwICmdIMLCqXpzcjg9
	 ag1sfMASVyB57aWi7npzmrv03x6lfiTzOBngncJTpA4Yu0YhhLD+84Ki4jxTGD2XPv
	 oI0AJn1gMWxgg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1 1/1] iommu/arm-smmu-v3: Use *-y instead of *-objs in Makefile
Date: Wed,  5 Jun 2024 16:45:45 +0100
Message-Id: <171759237956.1130890.17283676990623114334.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>
References: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 May 2024 18:15:55 +0300, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Use *-y instead of *-objs in Makefile
      https://git.kernel.org/will/c/16c0bad7ae04

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
