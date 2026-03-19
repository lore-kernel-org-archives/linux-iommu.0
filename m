Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FF2DBF78
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931972; cv=none; b=qmEdN43TAKNiuzkumCWbjbZ/g0AvxbMSk4xJKUN29VjInsCPmIHUwhtFJXp2QC2d0thfM3M5ftMZo9geY9ljFfuYlboTxhscoftRWDRSNKmyosgtBimrisfNZJlMMr0vcnCDFrkcqPPVqRx4F1sLB2JcFMxPoLRiW7+AWQ+CD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931972; c=relaxed/simple;
	bh=QQwB89gb4izvIOCxDjl4eeppBwj3MyfA1wpkYnHwvlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHLkKZd6g08liHGw+kmHQVKhnPieEK60bjimoxy6hXZjO5zViQogDRG1Fyt14XBdgNmkmCtwQ6lxjg5QqTJ5PCDtPD1qyuy28wCy1mgN3ILGsgnCVnUpJpRNu3H6RB/Jnf5/TW8kgAMeNdY6VY+Zq3fLEi5RL489yUGRh+fvjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3mV/lwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3mV/lwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99655C19424;
	Thu, 19 Mar 2026 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931972;
	bh=QQwB89gb4izvIOCxDjl4eeppBwj3MyfA1wpkYnHwvlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3mV/lwcjOwNFWnJdS5D2jnG+CrPmyv8He02F44zXCJOhZnhi18d8PXACqHFPYpwY
	 GdtamTUPW6V/pBRgoGoWzoRS3rhXjeDBnTX5gOFXXJMkj3EHHYF8UZBsheBwT07r+0
	 rEHQvwckfiEUeS6f+O3qWhO7p+Rb+JNsylA6iU75Sro0ANsGlHkTTN94j4ZX5+ji/X
	 nh3tv+OGsLgOgdrklydD9cdSBaCheVKh00+M6bvQ4M0fQP9SuVNDvPEjMFI/WcbQiQ
	 TYNR7Qke6i2xI4zY/8dZwehBVWpjrKi3V3320z7pl4RAnOIRADgat4e10ocNW4ZVJx
	 Oc7v78s5l98Ag==
Date: Thu, 19 Mar 2026 14:52:47 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, daizhiyuan@phytium.com.cn
Subject: Re: [PATCH 3/3] arm64: errata: Sort Arm entries
Message-ID: <abwNv0Gx00fXnQ3x@willie-the-truck>
References: <cover.1772125743.git.robin.murphy@arm.com>
 <e2af5db2f1f41d052cce68bf4518f3cc1c4ea81e.1772125743.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2af5db2f1f41d052cce68bf4518f3cc1c4ea81e.1772125743.git.robin.murphy@arm.com>

On Thu, Feb 26, 2026 at 06:10:22PM +0000, Robin Murphy wrote:
> The Arm errata entries are in a messy sort-of-consistent-but-not order
> that's awkward for actual reading, rather than specifically searching.
> For the sake of sanity, order them consistently by Component (but
> keeping the distinction of CPU vs. system IP) and Erratum ID.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 64 ++++++++++-----------
>  1 file changed, 32 insertions(+), 32 deletions(-)

I don't think this is worth the hassle. It's just going to create
unnecessary friction when backporting errata workarounds.

Will
