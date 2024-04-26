Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FBC14264F
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126275; cv=none; b=qcRXfdclGM7Dprlg3y5c3L279mECSwBf0CZ9DX09G8b95gGDBUInxs3CONQIawye5khjhvPG06ohMCUhN6sMmtPfaj79ultWRCq54p8L4jGz6Ywy1fkXdLGYiZkoKCjHPMym+RsEW1OA717J+zoHeSHHZQz499Bwy68cz8oC/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126275; c=relaxed/simple;
	bh=SPYBYBsCjZpgkYoiZpYIexHqdhb9BNUHQamBC0fYULI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI7rZDzxWNHuXlLqVH76HbyXJ9Jaj2CohJ1+/LVqjb/q4xBhgMRHuvzIj+byCcPlvLGUEm3c0A49blz0zHGk4G5gup0i5J9kfWi+iuSB/ofios67weOBbc1AFHMtr8pRoxxNLJQA8Fc2ptsd3Hwt3QDH85GpmlmXwfBqG3D9y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4thZpdbJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4thZpdbJ"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D848C1C7E6A;
	Fri, 26 Apr 2024 12:11:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714126272;
	bh=SPYBYBsCjZpgkYoiZpYIexHqdhb9BNUHQamBC0fYULI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4thZpdbJdPNVK6TqRqW3QyL7vPw+9xnJrbnfsbwnvzHNMwaMek/C7SNqtEDPvMM+K
	 Zt9wr0QWBnCOL1NGyk6NR/1U+f+xV883h954aJ90wWTtb01nBaGPI324pt+V7ZHu0s
	 90kx3iXwEimBiPQMO3vRuyYcdP9TZcm2Oz+m196eO8Figx+KOshowoyGwtESJkhK6U
	 FKvWMiGFxalDNIq8vbUcbkAewx1vB1OnMvj8mW8oCG7K48jQpAqDiI7n3RtY8EeTdP
	 IEV8JHjR3XLWvu8C+8Z9yAFaG848SpkxhLBxgD2jmmGE8ZQGDw7i5koOEfOS6SWhJB
	 obJgqAvgtJq9w==
Date: Fri, 26 Apr 2024 12:11:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	alexander.deucher@amd.com, baolu.lu@linux.intel.com,
	Eric Wagner <ewagner12@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	stable@kernel.org
Subject: Re: [PATCH v2] iommu/amd: Enhance def_domain_type to handle
 untrusted device
Message-ID: <Zit9vs4othrgS2Hw@8bytes.org>
References: <20240423111725.5813-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423111725.5813-1-vasant.hegde@amd.com>

On Tue, Apr 23, 2024 at 11:17:25AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Since this fixes a regression I think it makes sense to apply as-is for
v6.9. Things can be done more properly later on-top of this fix.

So: Applied, thanks.
