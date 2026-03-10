Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A1355F36;
	Tue, 10 Mar 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160853; cv=none; b=NsrQajtyYyiOgEuetmCacoxM9GJNodrrGyjMTzeeDfQAz9RNe7cZ9H2nE77pj7kFipHyQF7hkw7CLC3MtkKn7ggDhZz0vPJtTujIMemLRpANlGy3K5J0ynbvb5oOzNsK0IoYIGgJ7MnB28gwRlknFIkQQxjC/htBHrcDrJ7Q2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160853; c=relaxed/simple;
	bh=2g+n9NhpHFHVcMxppYljVrkFGw5KHcpXiYAufvjJSgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0JJeoHonHJBYydYFMlTVjNVlOU/6gDUsATDfB6mAVxYx+G30PWnpNHXcdbh2YOm0n8EjQ8mJzxvXC0NXpgBoI0tJL8C7ZIf9tAH3kWWJ6W7xmS7IquLFhXOla5VHJCPccVQpi50DhbWmXzoa5SWbh4KmCSfOVIu8esO6THLciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmCWBRx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmCWBRx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E57C19425;
	Tue, 10 Mar 2026 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160852;
	bh=2g+n9NhpHFHVcMxppYljVrkFGw5KHcpXiYAufvjJSgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmCWBRx8OIcJMMNv1edDx2mvbehcHUDBqElh2Z/hwNLqffQsGJKrN7YN3AsA5hmWP
	 oLejdyKYx8/Kdfb/Bh52xfuIKPgisrY91+1p/UMPGzRBnyirSeeueKriPnOb0AtQc+
	 wdxhXJZRd7v2ZfMDNJiP/ErhnZ23vPnqU7zJ+NHO8CwdKpyvJV9P7BhHJ7s94bllh7
	 WIKWX3X1m4YWB7N62B5sxL0uvYXHWV1NQi7JxihS/hyIQL6aBfgWUJwNu5k9eISFGC
	 D7fWQD6Taw3JSkHR/BBhqOpt291nzWOSbJQf5cGook0Sh6Hsa1v/HVj7Mts+rhBfZp
	 HNeaxxfbFHlfg==
Date: Tue, 10 Mar 2026 16:40:47 +0000
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] [RFC] iommu: io-pgtable-arm-v7s: avoid gcc-16.0.1
 section mismatch
Message-ID: <abBJj72kLQb0LRJB@willie-the-truck>
References: <20260203162406.2215716-1-arnd@kernel.org>
 <20260203162406.2215716-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203162406.2215716-2-arnd@kernel.org>

On Tue, Feb 03, 2026 at 05:24:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-16 has gained some more advanced inlining techniques that enable
> it to inline the dummy_tlb_add_page() and dummy_tlb_flush() function
> pointers into a specialized version of __arm_v7s_unmap:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)
> 
> From what I can tell, the transformation is correct, as this
> is only called when __arm_v7s_unmap() is called from
> arm_v7s_do_selftests(), which is also __init.
> 
> I have not come up with a good workaround, so this simply marks
> dummy_tlb_add_page() as not __init. Since there are currently only two
> files where this happens, that may be an easy way out.
> 
> If anyone has a better idea for how to deal with that, let me know!

Can we mark the dummy_* functions as 'noinline' instead? We shouldn't
have to keep the selftest code kicking around in memory after boot.

Will
