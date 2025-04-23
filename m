Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8526561E
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426824; cv=none; b=rU9BC/h+4GJPW9oiv2lM85v2a3GbXBGSCpqXiFkmiUL/maaVoRBsMBXrVdvrgYtXlnGOkRq8ftYjuqU4Cg8rKjIu7MayS9+e9jJAx4fNDpv5oSdYBhMjh6PZvF22gVGLeNpuoZ524XydrlPvTyK13mB7R3bhmjKqcBS4W1drHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426824; c=relaxed/simple;
	bh=m4WVOwAjcjgnM8goDGj/NfyDxwbR3w9B3VjTYwZ8Bzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHoPSCbYasySgQLIMImD5qalhLVMFntjKNQ26ILgQ3WpWg73CHFxSpnVIJxbFreBCqT5TxZVw9sEfBbNP/s0CA32Cwrn1GFV5cq0hFNed4XzHIEMT7SAa1wydCIJKFWn73w6jbbdm5PuShD4OFu4TnpG1X4VWyama2+f1oukBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RmVJgf6j; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RmVJgf6j"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c55500d08cso5109685a.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745426822; x=1746031622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+8rggCr0z1qPiuM8lIjq53Nx8yYtHzEKWUk97MIIIU=;
        b=RmVJgf6jrUKNLULttCwO/Xw3w2BUAJhcOPJoz3hwyTRy0ORf5TrWJJ5ZH9w/1eL+XH
         AOEtXZnY6Lp48zfIycud2OwfDY/7lrmngXUYWzxVhJgT9m83slLEeraMd2qgwuFk/ttf
         BzBvHODzdJrklkJ66SHQgEQmpIehPGnwq/N12f5/45Tv3BswgFIiMEi81KZ7cREXDpnw
         ok/3hTrJsE0gukrmDCfOeBweTmrbRSM7bcWfhE4QiY74V0AI8yd5ncIfBtiBPuJtQw5f
         X5+M8JkrGZJ5T5nViYR3DMfiCOAfx9zpyijwjQ157Xh/ZweEewnaVbBhz0bLvqQ7k6M4
         Ic6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426822; x=1746031622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+8rggCr0z1qPiuM8lIjq53Nx8yYtHzEKWUk97MIIIU=;
        b=lE355C3uYdd4Y5vIROpNV2sGEVpYcNCSC9BQ2FRlfDdQB+ir43+Mz5leMHZg7OfkMp
         I0yijjNngiS+z/svXRnn5pYYb/r6m5AlysHknwRcUkRowsI7oQ0qAK+d2FMyXx6038cx
         6u89opWZJ+pYEglwpdkg0cNx0FwdsLh753rajDF9c6RAkV/qmn3C88BEjG1SVUOQMQhn
         Xlma8Ypi5c58tjAZbWHx2/J0qjjvBL5FUARLNLKr6rMIckjiVrNCGMyjjhOm1t0KJ+Fl
         OsMpxxQ8ETne3wG2pzfTread0CuYw3Ix+uLXfxUTWHeeZ28xY1d5l/HWTIA9BLuP/gSf
         Bbqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbR6qzqfEHVcWRHeXqcAWU7nkYnRAkwCA9atFMQmCbfjBkLjSvL4O7DpSpDPXBsPNCD/SkEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz57Sdmt20eu4YM41oxGlNPBZYEZKA1KQmTsrvGwn/g8KBYztpE
	Mwfjh6k4DMtTAfSbeCI3RhYgi5rlhN2nlizIa4QS809BNK8YlP8CxXr+Wl+86tU=
X-Gm-Gg: ASbGncvC4GFQSepC9iPwwXGRXfAMSabYW4NukR8hRw38R8CG6MNFk5Tao74QhKu75M8
	POzD2JwjdnCc0OPDw9ZWxqzslP3av2m64on8hEbncdAhX9xw0Okv6MXubqPi1Di7iPPJPt2SFuZ
	YTz7zlEnmzppF0E6SpM0Jz+1hLRvCY0ySg7KTwmCxDjYxpKsPpkouELBC8qtQwIcGqMJO/Wg/+A
	A9H/1mwv7BKzN5HmWCmoB2N4tzmZIVgigk+38LWtbWBDLQbwWQy8RO0+4hWUitcWnu2NTLu/BS1
	RzY08fzPRts4kljomLJsDVoP6hYy0y6Na4Vm+RSaVGcBs3PLv1DuuRx1rP3JkvUo5aEF7iNQfrc
	DVx5Hx6Y8HjMQYsiH2Jw=
X-Google-Smtp-Source: AGHT+IHLwFuRAmk7gfG53u60+o1yuFvnpHCWeSmLNb9pe/u1DKOYa+3/GqvlkBEaYk0caxSiBgYSCA==
X-Received: by 2002:a05:620a:8017:b0:7c5:48af:7f99 with SMTP id af79cd13be357-7c955e6b6d6mr45515185a.35.1745426821711;
        Wed, 23 Apr 2025 09:47:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dbe7sm700352585a.87.2025.04.23.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:47:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dFU-00000007LB5-344v;
	Wed, 23 Apr 2025 13:47:00 -0300
Date: Wed, 23 Apr 2025 13:47:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Magnus Damm <damm+renesas@opensource.se>,
	Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: ipmmu-vmsa: avoid Wformat-security warning
Message-ID: <20250423164700.GF1213339@ziepe.ca>
References: <20250423164006.2661372-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423164006.2661372-1-arnd@kernel.org>

On Wed, Apr 23, 2025 at 06:40:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> iommu_device_sysfs_add() requires a constant format string, otherwise
> a W=1 build produces a warning:
> 
> drivers/iommu/ipmmu-vmsa.c:1093:62: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^~~~~~~~~~~~~~~~~~~~
> drivers/iommu/ipmmu-vmsa.c:1093:62: note: treat the string as an argument to avoid this
>  1093 |         ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
>       |                                                                     ^
>       |                                                                     "%s",
> 
> This was an old bug but I saw it now because the code was changed as part
> of commit d9d3cede4167 ("iommu/ipmmu-vmsa: Register in a sensible order").
> 
> Fixes: 7af9a5fdb9e0 ("iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
