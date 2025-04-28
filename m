Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CF264616;
	Mon, 28 Apr 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838709; cv=none; b=DE1PGxihwLyC4e4PlQ6zV98qcMrgaGL2XRfAT0aRRU/yQOIGbzzcOPL52vkGBGS+reyMZqpPkVA7+dV1a2x9kHta0o666GJ3v8eOEaDHK2C8zg4QSLQ2be6GB68x3FLmesLLraG4wBt7/pjf9OUUEOBjZ+gA75f4WU+GOzz/6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838709; c=relaxed/simple;
	bh=Veuk+Z/sR4H/xEb/EwiI6wtFnWURIfFvrkb6odssbcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiF98PEP6lhWUmELs1QS0BUSNy7cxj1YDlwr9LrLcCvsu26unNeOaT0qhbzCriUyA8ZEKQ3jCaiLiH71QSDfwPmGr6RFtQ3uxj15KHqEMqJJgNGEClWBr+tAJl0YpNxfuONzAfCXUnw+q196QUkHPrDa33JBC1MKe7U3q6ue7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=rfRFviFJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="rfRFviFJ"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BC9F8470B7;
	Mon, 28 Apr 2025 13:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745838705;
	bh=Veuk+Z/sR4H/xEb/EwiI6wtFnWURIfFvrkb6odssbcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfRFviFJT9ccUMEDhTzc9B++u4Pr5H0EL3t3VfgeVKGXQ8RrEh5S0KxD2Dhq9xug/
	 tHWt+hwHh0cnIdaIS0zwo/Kkc8uQeNCUQ2dz8XcNXVLlHnWQkzaUeHPHJR7ea93huV
	 BBLNPqoZUgqaRrWoc3bxmCNgkApYyuGeTG3bRPggD169NN4Z845VzaOXFILpmRXUWv
	 bFY4iuMo5NjMycRxlzypzkDfjVaBQ6Eg78ETnJTGi2KymeCCTqs1lvpNS54/V1a5od
	 3SR+jOTguk26n3yfFXMlaSLV/h1WAdfCvaJ00HVnwsdEB+zKQ6v85aaikKpRyRBv7E
	 45xCYAe9Y+XSw==
Date: Mon, 28 Apr 2025 13:11:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: sven@svenpeter.dev, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev,
	will@kernel.org, robin.murphy@arm.com, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: apple-dart: Remove unnecessary NULL check before
 free_io_pgtable_ops()
Message-ID: <aA9icDMayHKAocnc@8bytes.org>
References: <20250422072511.1334243-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422072511.1334243-1-nichen@iscas.ac.cn>

On Tue, Apr 22, 2025 at 03:25:11PM +0800, Chen Ni wrote:
> free_io_pgtable_ops() checks for NULL pointers internally.
> Remove unneeded NULL check here.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

