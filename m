Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8734403F;
	Mon, 23 Mar 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297104; cv=none; b=JTh0FdPLW/i6zo2wj8+h2NFxK1JlR+b0SgcxkiuA3A5B79xY10twv52LP1FcC70MU1nADDn2xP93OxTvLvMjTPZV/2OJ+OgbcnQypMmqTcTYRfv/oLjaqaTJcx0tmOef2vraoQjUeNT7suUhZ6mdnlChK6wDL9Nzsf1H0UIY6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297104; c=relaxed/simple;
	bh=e5DL7+JTtijBA3D8gL8fx8L+pljVuSTB6hi6yJ0pRlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kn3LJ7I6ldzMA33RUD4TZlOgQv6aaUUO2VNeWMTmM6x2ybCMZ/dj1utegSqOU2ziVyemal1C0AyVO2Lk3RgUPtHBFJ68W8kEyWDuG+2piAPgZ8K8fjnNEQQWuuFkjSi1NL+wTvLq1kX/QuY1/bWlX0ElXx63W1ZA8IATOkUbNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UczAWmPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UczAWmPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEECC4CEF7;
	Mon, 23 Mar 2026 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774297103;
	bh=e5DL7+JTtijBA3D8gL8fx8L+pljVuSTB6hi6yJ0pRlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UczAWmPbcKYGPFSHDjAt+hAUq4x3YO9+fNPL33w0RxnTuc0J0vOd8rt6CGfXXC6wt
	 B5ZGzBAYLq6k0hyN09Svizk7YPQeyr2iwwwFePMiLciOSGn5MpH0kZ/4YaRDIuPnSL
	 AO3AYRMewREbZS+KsfG9y8hzTN0TTz3/8XOOJ66c=
Date: Mon, 23 Mar 2026 13:18:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Oreoluwa Babatunde
 <oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
 <saravanak@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/7] Refactor reserved memory regions handling code
Message-Id: <20260323131822.abae01e95817011f24bb8237@linux-foundation.org>
In-Reply-To: <20260323100901.4079171-1-m.szyprowski@samsung.com>
References: <CGME20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6@eucas1p2.samsung.com>
	<20260323100901.4079171-1-m.szyprowski@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 11:08:54 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> The reserved memory regions handling code was reworked to handle
> unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> reserved_mem: Add code to dynamically allocate reserved_mem array").
> 
> The side effect of this rework was a set of bugs fixed later by commits
> 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> "cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
> call site for dma_contiguous_early_fixup()"). As a result, the code in
> drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> specific fixups.
> 
> In this patchset I try to untangle this spaghetti and perform some code
> cleanup. I hope nothing breaks this time.

AI review wasn't able to get all the patches to apply, but it asked a
few questions:

	https://sashiko.dev/#/patchset/20260323100901.4079171-1-m.szyprowski@samsung.com
