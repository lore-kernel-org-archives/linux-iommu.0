Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7015A868
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900482; cv=none; b=hxc9pV1+aaHJRKZY2qXrevlYtMrDn2P/r5/babn7EEwWDuP7Qe3Hytrv1z6cKECKtoqVg9g6Ts9Tr3v/VJiEkcqe077MTQHuMVUStUBzXP/KPIuvatR3c5izEE/ExhsvKl/iPX0sh3QJYntb3JZCs3qTtyx0+CoZcUVlIRROZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900482; c=relaxed/simple;
	bh=OIjh00Q5M3izE+JeNh+4wVsx4UdS0lS3tDduRZ4tyUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksrRW2I/oUbRoRCvxnq4JWP6SWXHu+0l9r4VAYElak9azL81rVfhRgU+ljbWxjmRm/MNEKeS/BRBDLE9L0pGJevMonZdCzgR3KdX32CTfMLEbYp34E2A3IshjIH8WgX8Yz8pdk5dBZ/KZSbX4iMWzHevyO5XFDuX9ykDyU+zjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Fn/7eJRt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Fn/7eJRt"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1BDC248667;
	Thu, 17 Apr 2025 16:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744900479;
	bh=OIjh00Q5M3izE+JeNh+4wVsx4UdS0lS3tDduRZ4tyUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn/7eJRtsDZpOsqKkvQ0jGZgM4n/w8ehBx/2XEF65xYsooLXW4chP8HTzrwO5HTpv
	 cbyX+8cHOuA87BQ//0Ezc73p6FjItjqBK529cnhzDkYrWl1OFPQmtnqdSlQzCDrrFm
	 jASwu4AYAdnVIgK6YOrML5P+38tC2ukA4Lf4pzvqTL0G8frxU7rbakGD1XUTFO7TOj
	 OwuLVSVm4oAsUxWY3hns4Fp8wXRe47GkUnaMnutTYC9gYxdVIjVUjJIi3G8cFwj+LE
	 9s1HD/TRn3TegIH+d8nrLYvr0rWctKCGkgKbTLPW5a02V5In00GkOlr6Bs2hXes0X5
	 kIQgp/BwW9NmQ==
Date: Thu, 17 Apr 2025 16:34:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iommu: Split out and tidy up Arm Kconfig
Message-ID: <aAERfYNxHvezN5XC@8bytes.org>
References: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>

On Thu, Mar 20, 2025 at 02:21:28PM +0000, Robin Murphy wrote:
>  drivers/iommu/Kconfig     | 157 +-------------------------------------
>  drivers/iommu/arm/Kconfig | 144 ++++++++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+), 156 deletions(-)
>  create mode 100644 drivers/iommu/arm/Kconfig

Applied, thanks.
