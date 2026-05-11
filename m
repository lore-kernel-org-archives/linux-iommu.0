Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532543B8BB9
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486791; cv=none; b=bvZvUtmSl4tVPvoGzGDTGPHNni6VJUcpt4uQ5HA5X2s6xII8h27Cuowt5NEPfVKw8L0jVZlCNIYp6NUuez7AnNaAf6quoYcEC0YCVwQrNAoFUn1aLuuEKYIE2dp0VWi/S05tyPt+R0xjL65wQNZfW8zyaSYW3WnX6Ioiiw3cFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486791; c=relaxed/simple;
	bh=XrNIOApwdgCY6NJJSqjTKmwCaVD2zFKQEqPAT5q/IoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zws7NOM8h+Y/hwUR6KaPUg6y1QAL7NbgDCuUu2cOPEzUY/yNSJLix0G1fEb26Ef0vFA8CAcKjuF/4ZwMdPq+87CGUDrXWkr9xEbVPf7mkqv0S697VN0UdGGtjy4+4cXUtJ1MDx1TF0pTtoovb3Z4l0+3Zv2vIJwl6cMy2L2wQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mpHbKrKT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mpHbKrKT"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4D5D41C44A0;
	Mon, 11 May 2026 10:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486781;
	bh=XrNIOApwdgCY6NJJSqjTKmwCaVD2zFKQEqPAT5q/IoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpHbKrKTcwOVPc0N6UFsPf97xg/jKiZOG2xliOuK1gpZW1ekm/xnvXCpNUyUREj0v
	 xj9gI+UnYQYPos/JdX2s+rPJpqNeChisg1UPtzn+hklUmR/5Zj4/p6UKrGhIVF7sOD
	 IluTjxFw67KA3Z8ro0VDb1sUehdzdhxPmEAZRC4KNLmngofz78KVuwsKEKfCGchF2l
	 p2TIJ5jF4ox9x6ZZEkkoCX9DarWGl4ghMFPHYrpBNIm4jReRJmrRwJAZXZCgcUff/X
	 nszhnftIC8iRhG6MqHhuscgGNBcxJj1mO0rcVp/9z0K7skRx/AghhnxLXs5Ks0VqV9
	 WBQlGyCR5JgrA==
Date: Mon, 11 May 2026 10:06:20 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: suravee.suthikulpanit@amd.com, jgg@nvidia.com, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/amd: Remove unused IOMMU_IN/OUT_ADDR_BIT_SIZE
 macros
Message-ID: <6phx5gqczzz4krrk3xnenejlymkmhozf6rmkvxxccauidlxrkz@xwoe54gkcz2b>
References: <SI2PR01MB4393EF02E213EA4111DBEF74DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393EF02E213EA4111DBEF74DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>

On Tue, Apr 21, 2026 at 06:00:38PM +0800, Wei Wang wrote:
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.
