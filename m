Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEA17335E
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981595; cv=none; b=A6A6OLJkoJcr3Y4F8bV5vpBR5wJpn+HFIosYahy4v4JSJ1Gckb7DLMC3HwAD8qkgjBTScHQs+uVVG5A+CyyoJ6LU0pa+qmOFqge6vRzCz0vbnRXUNDdfO3/trtfMjf4jQJYJWx3bQUD3Y5c5B1wAusEukBPKevP/q6zffbouETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981595; c=relaxed/simple;
	bh=2ZK2ZVlbejpVIhZMyaIu0ssJnXCrsvDJcQkBZcrU3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyeMRQ7RUzQZaxUn/XNt3+bx1fo3q+otnncLQBkXRNhCNGbuPb5QcKh4Gs1J+0iF7RvEydy7e6EbXQjzp6hxvuuUjgi5o4J2lbqnBOlWMlortQ39DGAn4yBZl9GqcoEUXb7whryDjcY3UjnXbGWLhcRbZKfODwIm/SqRp5CF+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wl5bwN2H; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wl5bwN2H"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DBC872A6C15;
	Tue, 15 Oct 2024 10:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981592;
	bh=2ZK2ZVlbejpVIhZMyaIu0ssJnXCrsvDJcQkBZcrU3/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wl5bwN2HH+ILPCGmBJhsLv8hYyqJrC3uM58m6zSbKKE0wDuc9J8moUdWhA/CN7XxN
	 pcwpW14gyIhBipYg0xm5mRX5SOCzVZeNs7ElzJVREjV++vfNzC2S+EPJlD4lPeOvl3
	 1UIqbgiYmwAYM9RGo9ApY4zHpUyDkIFl9SwzW71euQjRps/h7pGtiupxWR6bxrqT7C
	 qXA3UDhuL7s6oLJe3Rh7on5KRD+lBHVp4unT4jj777LOBtN46UgtPeJ80lDw6j7KMR
	 AIfS9zHCy/EhV1+w4pwY2K8TR1Ot8b7x83Pcp8wqLf2KbnAVAlxDFlhvXYflgjJ/dr
	 F6TLhvddIM8ow==
Date: Tue, 15 Oct 2024 10:39:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 04/10] iommu/amd: Remove unused amd_iommus variable
Message-ID: <Zw4qVz-F7-kmAXGl@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-5-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:06AM +0000, Vasant Hegde wrote:
> protection_domain structure is updated to use xarray to track the IOMMUs
> attached to the domain. Now domain flush code is not using amd_iommus.
> Hence remove this unused variable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 ------
>  drivers/iommu/amd/init.c            | 6 ------
>  2 files changed, 12 deletions(-)
 
Reviewed-by: Joerg Roedel <jroedel@suse.de>
