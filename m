Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234018BBA2
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981562; cv=none; b=mBDufmbh3Y4iOHFX+Qm652l8VnRizurIrFBQvImLNQy6glUNEvZ6mKcIAs7BZGd0/qWWeJsXfDB6DObHcVS8kcIRlChA6HiaWYS9n2A3xgge0EZRz6vCXSbXYqYoSrYNH8Pirf+NwgmBM17pQPZPIf2STfI7OEBkB5w3decIxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981562; c=relaxed/simple;
	bh=6MeeYMCx7IGVlA5tDhutIlFwfDSDpZVFBDMGj+nFIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3QMV2WK7XnB7paYePTV5Wds7fKQBnPKj3WnUoegCHuv1vXKLLqdXcx/qw+b8jVc2PcHNEdU3Gw53OYw67CSDvPEko21xdpQPtjaspOO1Qya638xSBzwRz6r0FVCSTEHTwzFTZWVjD7/QIN9Rhgklt2JKilhhqu9L7UIQxA2orE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=l2WhzKHL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="l2WhzKHL"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5BD5A2A6C15;
	Tue, 15 Oct 2024 10:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981559;
	bh=6MeeYMCx7IGVlA5tDhutIlFwfDSDpZVFBDMGj+nFIs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2WhzKHL5yF17xbhKEclhhGScuomkdko396s4/jNK+OFRM/UChaogKfdSKklXtqdH
	 rMhyHR+ZZuvN5mzeGtwMZLhKLBHbKktD4X/vNuwyaJxrIy5gsc531N3avWwoKjxDtQ
	 5TqFFaAn2gHF9ITbMl3am5vPkPjcn1nCXXwOFGXM5bctRkpEfs9DwEvTHme3l9Mqsz
	 e+Mw3hHX3j8IzESr2iCtcz6z+lvwSxwQ4FCAT6wuLNPVRTxD/dRvBBMVSZJN2iskHF
	 gAd4x2bl/U8DBhgQZnt2XhlDPuzSZPQp5MtZH+VT6AimL9fh/o25Znu0pzP2vaBocl
	 hX65lsQYq08Ug==
Date: Tue, 15 Oct 2024 10:39:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 02/10] iommu/amd: Remove protection_domain.dev_cnt
 variable
Message-ID: <Zw4qNuihQKW1lbBD@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-3-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:04AM +0000, Vasant Hegde wrote:
> protection_domain->dev_list tracks list of attached devices to
> domain. We can use list_* functions on dev_list to get device count.
> Hence remove 'dev_cnt' variable.
> 
> No functional change intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 1 -
>  drivers/iommu/amd/iommu.c           | 7 +------
>  2 files changed, 1 insertion(+), 7 deletions(-)
 
Reviewed-by: Joerg Roedel <jroedel@suse.de>
