Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6E3BF68E;
	Sun, 26 Jul 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078085; cv=none; b=gIHtgQcSzQGdl0ZU7F2dTcSGBO3QxpytAeKInl9hBiAwhFKy0LHlw/hVW4KNtwZ6ubALFSvxtv5AAC4dUysxP7lirGsU586BRUHUNhoVZFssEXIErkGa1pylrPQ3IZUiZxsjeCbsD8qkGEyI0nBY8X7LHZ/z5rl97EevHsIH71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078085; c=relaxed/simple;
	bh=p+wthCRrmbVj+imV741v6PhO/4N39n+fp60LPdBj2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsBe4fmPkf8Ysbt3Tn79eMA+UdQyDaYLesMkJf/9swYWRRFM1hXvZ6RdQjncxhLsd4DqNWNxI7Hdbf3LPTef1Fr3Wd6e2DZ22Ntfty9WVqnx1dcRNYXZa+WJupNCoUbrTMpHvaKJQmnh2yUhoHsUQ7m+25qmR2MCmp44n1SxgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+icZZzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+icZZzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0351F00A3D;
	Sun, 26 Jul 2026 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078083;
	bh=JeeRZsoebfQ2LxiwKDM/TfxLahtf9YWY0xhqzs6a0rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+icZZzhRnqNEVXQx7tAkDFpNqQ0rCP6S0VMqLk5icQk3btu7VzjWcLrA6vH6+nYm
	 wCBGguf+2O4Q8qPWnIOACJGK1Dq1yYAm9jBwknxSa30Gtuv/xYzJesiIWXeCTt+STt
	 +saFrHPdqArTgCJqKzxb+5OLNgNH6hH7thr3egPI2xSCWDLTLQaYkTco23npmOav5F
	 8PYI4eufV7qTdH+oHgJAP6vJrFqJ+5WvAm5lj1u8eq9QvkNgcYji5IOHWr8lfw5vwH
	 9hJ6f2H4RHJHPMy5GFsN+kxHQOTJtargqFdvoU43zglewEj6yUhX59IGPPtqxTpXm8
	 iYeSlV/PbPjFg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	ZhaoJinming <zhaojinming@uniontech.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: Fix silent probe success when all MMU resources fail
Date: Sun, 26 Jul 2026 16:00:56 +0100
Message-ID: <178506936105.2042687.4098031706954883028.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723132643.2853525-1-zhaojinming@uniontech.com>
References: <20260723132643.2853525-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Jul 2026 21:26:43 +0800, ZhaoJinming wrote:
> When all MMU register mappings fail in rk_iommu_probe(), the error
> path returns PTR_ERR(iommu->bases[0]). However, bases[0] can be NULL
> if the first platform_get_resource() also returned NULL, causing
> PTR_ERR(NULL) to evaluate to 0 and the probe to succeed silently.
> 
> Return -ENODEV directly instead.
> 
> [...]

Applied to iommu (rockchip), thanks!

[1/1] iommu/rockchip: Fix silent probe success when all MMU resources fail
      https://git.kernel.org/iommu/c/ea0a9d453f60

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
