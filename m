Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7EE13C8FE
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502418; cv=none; b=nSHT7q8XVd9CAl5bBLDNyM9jxKtVAOT3BMv6QKJT76W4m75LUS8XA3TSW3TitYK3C3qkARrCgoOcYyTBUfVO0uIC1zV7Qg2G8UYEr82xdsuYaXwkDJJjD1EFi8dK3Ivf+u85AyYKRAszBeZRRZJFLzy2sDPal0N/M3T4WKPZD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502418; c=relaxed/simple;
	bh=6NRUggHH4BGxg0bf1P8Dte8C8g+Vbw8Z0TlqBsEq7/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL2nrtMHn80SgihCcNcVuPTkw+dQFrDDN5tH9QwqoJouS3jXcWdDKAaAddB62OsrjQGXg7TDUeCAuSz4pIZy/Wkvr+D/LIH4KVpni6+s9h0U++B9qFubHazL+qkJn140zWbyYYcBc+rKCyoX464I70YuH3ZFMonlUmOH1RJrwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=hJe/ZTwO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hJe/ZTwO"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5B1081C7AEB;
	Tue,  4 Jun 2024 14:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717502415;
	bh=6NRUggHH4BGxg0bf1P8Dte8C8g+Vbw8Z0TlqBsEq7/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJe/ZTwOOYUXMjDKcsdHHsP/xZjfC8A0xxCMCGy7khcw6nVoyBzuwfWJXoyVXr6i2
	 p5+BtuCPr9LNzH1LlveUE28s/2zIzw96XrW2aEz6KPKzWvQy6GF0X3NZs3snY1seg5
	 pUlChQF/CbJKnVoI7sw8vl0V1R4ONMgDVnDbbtGyJp4X960gyiACbnx/hvTdmWjEVV
	 AiuVuenFZwJlteF0fgRjW3xO++wuim50lImHZj1umf5f24jGLkGC+VXcvQOWEA53Pl
	 YrfODt42ZbghQ6HoJZm2BR3zCgVHjsQSGZFiJs2MCQtkNqIiM9Om9rHtpfymfYnDkY
	 7taYU3Uhoc3Xw==
Date: Tue, 4 Jun 2024 14:00:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Borislav Petkov <bp@alien8.de>,
	Jean-Christophe Guillain <jean-christophe@guillain.net>
Subject: Re: [PATCH rc] iommu/amd: Check EFR[EPHSup] bit before enabling PPR
Message-ID: <Zl8Bzj1NbLQb9bMi@8bytes.org>
References: <20240530071118.10297-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530071118.10297-1-vasant.hegde@amd.com>

On Thu, May 30, 2024 at 07:11:18AM +0000, Vasant Hegde wrote:
> Check for EFR[EPHSup] bit before enabling PPR. This bit must be set
> to enable PPR.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218900
> Tested-by: Borislav Petkov <bp@alien8.de>
> Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

