Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B21B502B0
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916175; cv=none; b=IxQnLRuRUGMh/9G/LiXdfY76MoN5GtG+EGh5glzpAxuDrKIRmkNQ+0mTCnbPj0Kjg1PnIqwml6JvFip0qQP+wJ+qyCxjKlOPEcSUctEqxnRIEN/6EjJu4xBj9XTtrR0WwvRm6ggR0t7gH+fnL8J65iRTGyp1hbhywRr9L4uf4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916175; c=relaxed/simple;
	bh=wGvL/neY55CYlh/+BYFblfew9EG3Y3VN8mIZQY0mojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqjeJim7FPNglPleksd8FDf1xpRah79jmCbMKKhiFOk34j1yp/lX/bDsIR+ysw+yNDzvDQsDFz0ViDEWeRcSDHAw2WgWYmohMdPIiLCDgsZ+FAsYoJxs4xC+ZjsGgNt1XS2/yV8za5bu2dVHjYHOKT5MOXyDREm5jA+C9BsVB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yrZfmyv9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yrZfmyv9"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4EDF8281A38;
	Fri, 12 Apr 2024 12:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916163;
	bh=wGvL/neY55CYlh/+BYFblfew9EG3Y3VN8mIZQY0mojQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yrZfmyv9ad5gnVE/ogyyhNMvJUuoqWq8FNPv8uYJ9lLqy7VLOqSCZDtqEAmzQ2jus
	 JEwDx5i30DZ2CD1HbT/XJVzfV4dPCP3bdcm+LFO9RrwoFiOlHVghnk0SNxjG+5BZzm
	 5lThHTF2sETNZFSP71Oy4eLdhFUCfZKkUFmQxaL+5XC5YfCVdgduC5QyYRcRSjaOQ7
	 67Qv+mHPOkv9OpR5QKQd7WiBeEr5Bu2eR1PudFFe9FISreg/RuR+6vhYDs1WbFriDQ
	 WTqHYaF7cUFrugRiCwgaYxxDq206Y7HOq5RPPzI9G3cgNy8iAXedo0Um3DCDpdHSxG
	 XDsd8ud5SJ9Rg==
Date: Fri, 12 Apr 2024 12:02:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH rc] iommu/amd: Fix possible irq lock inversion dependency
 issue
Message-ID: <ZhkGwloncC-WlmCY@8bytes.org>
References: <20240404102717.6705-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404102717.6705-1-vasant.hegde@amd.com>

On Thu, Apr 04, 2024 at 10:27:17AM +0000, Vasant Hegde wrote:
> Fixes: 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue")
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied, thanks.
