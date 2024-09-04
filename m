Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B94A2C
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455720; cv=none; b=iMAjCmLLsC9p2QUqdQWDGHDrGIvm083iNdFHx3BhlAC8vzii/30pMJ5/+4ShPa4ZFcr/VJnO2PlWeh9tUS0YgjSzx5Rwp4bF3ginVJBS/qLtKFGyRgUmzYpc1+TVGLmWdA9BggUY/Vn1siwz/6YUTKXDrn+n+dZ55se9QYX37gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455720; c=relaxed/simple;
	bh=pTgZWhjZ/86Doose5uhGdxVqjDzd34gHHV0kELUYcrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcqcAjDsixs9xUHRhSYLAm5lwul2fCPX9N5NQh5IzGEOjkUsqfF3jK7/HZ35JAQtpLXReEyBNqEJCEk4cmWVFqp6PFWpNfNgLuuRAOTxP4PFHP23LhFaLgxxxZlbl4rI2BDxY4i2BYfGUt1L9jHp8NrIi0x67TEq7DvmMGB46JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=gZOf8lSC; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="gZOf8lSC"
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D6AA02886F9;
	Wed,  4 Sep 2024 15:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725455717;
	bh=pTgZWhjZ/86Doose5uhGdxVqjDzd34gHHV0kELUYcrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZOf8lSCP0zA++WRL2wLlfgrkHicAcoM3dtjjAMF4qlU/QZ5t8KSt9z5qlORyrl9I
	 3X+ajhN+lSrC9s0lW7qoYkX2oknB+l88Ta+gfboex5i/3GeUi0lUlo/gnBRU0C/6/X
	 LK/JDdCIB/OhFJRCuiHqpVeWrPgPqMQZ84pH+qPkGPhLoeesyAmQ7ut9TJ1euVtzKv
	 AJiOQKeG3J+YIb0te5KaN/PIT3SD5qqOfF1T5i0P6T5bDQ/Zn1KS6WhUx03sjSYazm
	 lRAR4YhYlnbkZBe9moPKttdH2On3JATltTguHY+VXCHwYN3/vpJZ5KxRrIwPlJQWXf
	 RAOdTMHXRRBbA==
Date: Wed, 4 Sep 2024 15:15:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add parameter to limit V1 page-sizes to 4 KiB
Message-ID: <ZthdZElA6KEMtYxt@8bytes.org>
References: <20240904125946.4677-1-joro@8bytes.org>
 <20240904130329.GC3915968@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904130329.GC3915968@nvidia.com>

On Wed, Sep 04, 2024 at 10:03:29AM -0300, Jason Gunthorpe wrote:
> Why is this a kernel command line? Surely it should be negotiated
> automaticaly with capability registers or ACPI like everone else does
> if there is something functionally wrong with the vIOMMU??

In the affected setups there is no vIOMMU. This is not about secure-IO,
the assigned devices will not be part of the trusted base.

> If we are doing this we also have a problem on mlx5 devices where
> there are too many page sizes in the v1 table and it blows up the ATS
> caching. It would be nice to widen this option to limit the page sizes
> to other combinations (4k/2M/1G or something).

Okay, I will update the patch to allow more settings.

Regards,

	Joerg
