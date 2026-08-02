Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AF3B0AE9
	for <iommu@lists.linux.dev>; Sun,  2 Aug 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672794; cv=none; b=Z3WeuDKGF3ni2gZ4BTF7JFi12EC4hGnVknoN/rRI+ms9X5v+xf9GmGeEz7UiF7Up4f8z/jJ4Uyg66HLWA8CTadEKVDJX1SY/4PIWQ6EWWINbWxxMLrk4G2S/sWMPBAzZqLKF7oKuEGJdAzyrxTi0Li21pmNF9VQo6LT0MQEkT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672794; c=relaxed/simple;
	bh=LdANEe96e3EivyckhrONj/PijE8JzThRRJJJ4fHQZu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StT1aJUZqtDB/HB/WQysDYW6zWyFSGHMKMPvGCd8GxKkSouxshGOTKp1Fwdo+WiRqWKarKzkssWT1JFiSRbOrlWYF1TB16F5i6k98yyN6NXJ9jtLiavmURfrRjsQ3IhjQv4Jp/9kfG5crkUfVybGuS/8KEKmLcKzT7RdvZ8tJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkOhPPKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkOhPPKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EBC1F00A3A;
	Sun,  2 Aug 2026 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672792;
	bh=ume27hYtZmliUEfOmZSy3B7vRgSoVATVO1vURK6pOyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkOhPPKB6u2i4p+F7nWexnh0pAH8cc3xFSfFKa0bL3ggBCmgtLH6BYUaleMvYo73W
	 6q+zi3Il5hGrolNigznNDZ1FF36hxcS5Gzh5nEaWb8TGE+BxcLmETS2bmeRkEOGzRd
	 9CGsySwhHaJ01ffaiWgGjl8CfZeMv3seJp+iSyz6UcCug9yXvZb3KR+MHpKKpDykr/
	 sFdLhYDEefUjtiSkFGbNZGdb5L2NTrq9RCCQq+s8wLHaPqh/yqcJRzi47Z3pmrCA7b
	 WyR65TEuv1xpNBQBVfKXS7/QUGXtMrpw7GEtCR2soF5j9RKpcJEbtVyBw6x6OsW9Pw
	 UuCq7Ql45ZC0A==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jpb@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 0/2] iommu/arm-smmu-v3: Fix SVA vs. HAFT issues
Date: Sun,  2 Aug 2026 13:12:30 +0100
Message-ID: <178566509348.938932.16551878749567703264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785153415.git.robin.murphy@arm.com>
References: <cover.1785153415.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 13:03:27 +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/all/878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com/
> v2: https://lore.kernel.org/all/cover.1784814923.git.robin.murphy@arm.com/
> 
> Further to v2, work around the contentious CD update.
> 
> Thanks,
> Robin.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/2] arm64: Add override for MMFR1.HAFDBS
      https://git.kernel.org/iommu/c/91038c83a250
[2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
      https://git.kernel.org/iommu/c/f99d3b4bb095

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
