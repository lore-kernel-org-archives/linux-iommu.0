Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2C1C8774
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980575; cv=none; b=diQoSAf9+Rzma8y0Ekw/6xIS9MhoyPhfWRwY5QpcStTVc1VBvh5Mj9F6p/xTb8yb7eTw0MLWe5Lr/787JgmfjDSmDvApg4Stotcyl/c9I3T11CNMHXXcTC7MUcAYb18qSJbQ/z266EX4Ts/FMKi8z2qBuzTx5e8oTITii7JeSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980575; c=relaxed/simple;
	bh=/Q3LAqsce/AlKuyLwH8xHtJGomiNsyhiJwbrArPR3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN6ScHL2VqVnAwBJMMgsocRwIutAuwXapPFPCL8rHuCcg2vaF7B9jSfe9lCE/tcFtcFpXF9YI60chZqceWgfpQWgmDiGT3il85RklZc+yShG0d+pBXGCR/HSuROIRNQQ72pDlColBYn8OxtQzt6CnQiAA+/LdTczO+UM0ztdYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UZ4NTIHi; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UZ4NTIHi"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D56192A7853;
	Tue, 15 Oct 2024 10:22:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980572;
	bh=/Q3LAqsce/AlKuyLwH8xHtJGomiNsyhiJwbrArPR3Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZ4NTIHi6AQ/ds0uBBjk8p+NizTdgsBsSEopyOwi+20eA9k4h+t/IblEeLgBDDCYh
	 cpMs6398Txfa24o2U2bOGbxbv2isvMc7IYFDtrLyXq4aanAHjnjtF3HMVM2/DaaRAj
	 YF/0wa71p1bue4fizSyktrSPzb9kTwlh/Bboz6bfAS7chkzolBb4D+DgO7agYMPUSL
	 K2JCqT/4iAK0YCZUu8aE63xeWg45y82hlZ/Zunc2Ls7UdfdCbDGNxz7XmI4fGMLFXz
	 5cG/GbdU+thQ+RNG9v5/KIzCY4WvARSiplmfPs/40C+M1ex0QUaaUsYbFbPHqXLDN3
	 r0no4WRtdpMqg==
Date: Tue, 15 Oct 2024 10:22:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/amd: Use atomic64_inc_return() in iommu.c
Message-ID: <Zw4mW6i_3QH5JaJH@8bytes.org>
References: <20241007084356.47799-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007084356.47799-1-ubizjak@gmail.com>

On Mon, Oct 07, 2024 at 10:43:31AM +0200, Uros Bizjak wrote:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
