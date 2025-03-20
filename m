Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392920C026
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457789; cv=none; b=l6L4D7t95MgpnOMiFa1vieTgz3F0mpVkV4lyytdj+h6R7fMZY+SFGNv2iuzEU7pE+inj5Zvve9fwDfAnSUYSqtRpwg/fJUW+3FHgOwKOc3vK1Yj3ipPm7AV4GCMRH0cZozD9FWI6vgT7zTMrc8+ZAsqPT6rYKJkXNf8a19jYxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457789; c=relaxed/simple;
	bh=MrWB02/K7zR5DQEk2qBWDeOUjrQ1PK40ju3WplPO0sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azd8+q81eB9rZUtgxP96rTmSjqOIYi6eDXp6hEt3HwY3kBUCRRqdu5JczCS/dv3kmloorghrzpcXTyOXrdeM/OJqwBnHS1nlmBUFmhuVbpPiR7WgfpOdCrqraoHJA/LB0Au9AqgyQnd3za6uMS5R08cqCATc89LnkbRfhj0ZmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Zwty9bYA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Zwty9bYA"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 585FC46438;
	Thu, 20 Mar 2025 09:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1742457786;
	bh=MrWB02/K7zR5DQEk2qBWDeOUjrQ1PK40ju3WplPO0sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zwty9bYAfSQKmJxx3E3DfdmXMhLC2KBtwJ8jHRmkxVCqC6yaviitQbYVHX1guwax2
	 32ym0rcTyVcI/S5EcWeC94UCDqPns87S1D7y5MYm6ZTR7UgNHXcKg6IRHH/4PpXV/+
	 1hG5CfKSvKm14Rc3jzv5yFmLwsGQQkXAiytqLHWT58Nh+hxiIWiA+bfNqZ58ONui9g
	 bBablonR77elqNjdsxL7xPo84L1zSke40/LdiuO+O+DCmRf2slwgkAfd3j9IPbV7bF
	 KyDkfdafHKR/n4TOmVHxYZTGHG5nq1nGNSEPzZeOz313KFu3EqBKkS0WSr17z2qtfK
	 hQW0DLL3HSeNQ==
Date: Thu, 20 Mar 2025 09:03:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/amd: Return a literal in init_gcr3_table()
Message-ID: <Z9vLuWvzVJOyuuWu@8bytes.org>
References: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>
 <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>

On Mon, Mar 17, 2025 at 09:43:32AM +0300, Dan Carpenter wrote:
> This code intentionally returns zero but it does it as "return ret;"
> Returning ret looks like an error path where return 0 is more
> clear and looks more intentional.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ce2626801ddf..7cbcc4933c8b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2150,7 +2150,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
>  
>  	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
>  	if (!pdom_is_v2_pgtbl_mode(pdom))
> -		return ret;
> +		return 0;

There is another case of this a couple lines above in the same function.
Mind changing that as well?

Regards,

	Joerg
