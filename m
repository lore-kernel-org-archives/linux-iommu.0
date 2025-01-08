Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F31204F63
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354356; cv=none; b=XoQaecl4znoZxzkUV9khu7G7acf55F3IzCw14t6IxNi5mT3xFv25VCM6Hxbd0P4kmYp+p8RxdwO3GKPAs1tw7l6ebzmIYXTA92qAMPdrDtaq3Y1Ptf/PiAiHuU6ISV8/wPHAKUHFjuRydTywVnQB00QJd3Fq9vqefIHjX8OUh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354356; c=relaxed/simple;
	bh=2K/Q8IHblydjKKseZ6/LGROez+C2+IVEgIzHOus7At0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5CxdB2Deby+/zbgnCLI7tujtXvDmZOa4PHvQfZMd64lzsudVdN0xiME5Eq/ehXulsUliQGnch316S2Tg+VOj2hyv1RWoOpyPhS9XJRMQ8yY3BB+H/XEZ4pghN5vAoXkosGHLJ4jZEeX+SnLpkRfb+wWJhPGGrvHyz4SywhqFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI0FbyQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI0FbyQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0823CC4CEE2;
	Wed,  8 Jan 2025 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354355;
	bh=2K/Q8IHblydjKKseZ6/LGROez+C2+IVEgIzHOus7At0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PI0FbyQNfATQsyRP8q0TCwQC+vVr1mjCO/M8qotUQ7Yvcdjd1CjK3nVnjd8K2NFPh
	 +mrjOMaq81373lcNHMyRcy754xCNGaPcU5NHXfZGyBP+yyTuAuz+Zh0RcSnaxODdhW
	 g2Z1P83oTjuXNG5+II9Ne7pI/EnPEBHo7twIU5qpO/i90PaOt/R4pJ/ZAMdhlOwJNL
	 duyIo9ZL4FiZKOiO5zlspmmVBZ32LSS1a0y+Y8EZcnfJ7uuoAwNBm5fgSjQ6cWwZMN
	 60rlmnK7IvP3xYfIrnJmdZp3tnzGox27RL65zcznNcssrYhhIBx78mLSoQQmB4A1eC
	 ROj1VJ771T29Q==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Date: Wed,  8 Jan 2025 16:38:55 +0000
Message-Id: <173634483515.508041.15672153772127288265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250107165100.1093357-1-praan@google.com>
References: <20250107165100.1093357-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 07 Jan 2025 16:51:00 +0000, Pranjal Shrivastava wrote:
> Adopt the `str_read_write` helper in event logging as highlighted [1].
> 
> [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
      https://git.kernel.org/iommu/c/f2c77f6e41e6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
