Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025831D53C
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983357; cv=none; b=NyboO8sFCuOSmUiN9fwEevQ11Wd49dQLb7o2iyTvHFhqqFe9JLWGMyVrx19oK5FvJPwFdsWVMwCxxcgMFpi1VIUg7vknJWqcofAMWCjAktLr3e33Njygj2LQbyFSYTGJ6bVOxkCmRrfB4vy2ke2/t9XA5zDf8fKd9aLgmD8RNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983357; c=relaxed/simple;
	bh=riMYScqxhEe6kJYQtxRw3mS5OQZdn6TKMrWoZEvFwQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSumEw7a/DlBj1OFbhs4nnaBpdOSz5VKFyUqIgRk65satG62QruoEqdpWQcrP5RbhlYYsoXi3QcfAVStgziakiOXETFh9oADB1hjhvNJlxJq5McDeYrJ2Htj4W2bp6n4izSbvQSreezteOh7RlcXsFak2jqi0PNcI7Mi4eUfrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=tyiE7H0m; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tyiE7H0m"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 37E8A1C0B67;
	Mon,  6 May 2024 10:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714983348;
	bh=riMYScqxhEe6kJYQtxRw3mS5OQZdn6TKMrWoZEvFwQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyiE7H0m/nZV4FMt87XPFHLZwt2NXhVwdNLAp4Xo74IUxEJ6VX5Et978TyVKal9Tw
	 DTfotAX65rxioRYSFEtVqoD+p+0KRBb/y2LH3iPCutbPJsCrCoOGt3VZ5Ql5RkkDQq
	 iM1ZBwi0Pp+ZB8cHl3y4OnDcRx0kP7BZz83NAd8Fm6H9G9CwiZ6rXSZcUX10NdTFfS
	 lJ10DHGmqPw/eEdC8MNKvee1Mno0SBRhnjez/7jvJEKwPoOj7sjEJr5bG8pIZICtol
	 WgykjdMnYStrr5yxSJyocLgtsYF1j3syQGwgnuLCnDTygHnX5PefSZ8oZzsZFiiu5m
	 LkggyM7wi6x0w==
Date: Mon, 6 May 2024 10:15:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
	jsnitsel@redhat.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if
 domain is SVA capable
Message-ID: <ZjiRs2rTmgJ_hXwu@8bytes.org>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
 <3488f733-c920-4e2a-86f7-05dc1779685e@amd.com>
 <2a0d574d-6a3b-4344-9571-840eee569ae1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0d574d-6a3b-4344-9571-840eee569ae1@gmail.com>

On Mon, May 06, 2024 at 09:47:50AM +0200, Klara Modin wrote:
> This fixes the issue for me.
> 
> Thanks,
> Tested-by: Klara Modin <klarasmodin@gmail.com>

Thanks Klara.

Vasant, can you please send this as a proper patch later today,
including a Fixed tag? Thanks!

Regards,

	Joerg
