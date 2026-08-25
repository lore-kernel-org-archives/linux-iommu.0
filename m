Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A937F336
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653464; cv=none; b=aURrwZnVbCLep12RoX5/ocRBsKm8hPawRtkGmExVtLLWI1Z3e5WdSkiVcHrwQQGEc6FJFIWhv6/zaPheuLbQ+wix2t5y4E7Gdyog1t4xx3NsGKsKqNqS5uJkBoPENIpL+HtFJ4S36XqyHYo4nBZnQM/KBqHVDIjubiK56MEdqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653464; c=relaxed/simple;
	bh=lK2BFmWVVl023uFQVfWzK7Q0QzOCzFmm33ddjKEUoBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F02SoudnmWH/HtTqYWF4qKiwHGHH8w6mqfNWsaK66thbQ5O7l5wlLtbVo0MSvhsnUdtoRVr0jYi7nDZz9mes2CO48jGPn799aWHDnJOR6QROpBL+orrA+uvZJd+vrXUJ1Av1mF/9x9GSFpGkMN/ZqhJov54tuO5KsOsaQ/lqCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JC6Scfsz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JC6Scfsz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso100745ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653463; x=1788258263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3wkoXmohD3gha4H5ZeL5zxsjojGVMUQObrPCKo/HBgk=;
        b=JC6ScfszUKBUzXwa6TC/TK9SOYjWXlFPAoL/CBf3pcfK8aIJGb75EpXtJXL7lZjnQp
         5bx8eqZzlcgDBSWXYq1wlJPTGLWZgnS+V5wsMJ9M4Iack1lCZ8+lc0xToDfmjywooW3g
         JOD+3ViSwTLdik5Pr94q1MTQgOeaOEFzzXD/Y6LY5RKzjsXXD0aekEtFmNhFY4KTVnWj
         8PGXcnR4Epv79V8ZDSWKj8PTlmzjDbJeUKrMeTFZjHzEe0SYtrc93yMLk56ngfSBwYn1
         omYJ2QDCKK42nXT75W3YsuRnlZG66MDqruE8h0Wd93A574mf7v6EDsDiSHxKG4HZE80Z
         QXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653463; x=1788258263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wkoXmohD3gha4H5ZeL5zxsjojGVMUQObrPCKo/HBgk=;
        b=aKnlMFWxoavNwvLn7pZJ7nsSOlv8JqWBvTKbs/ivtMQNOwLUATS2wi3svoEoxqqcQ5
         vweykveaEyfdHg5X5ljLrlQy2NvJmNKwmAjfMLWbj8ItQCxUlkknOXH8nxYNYZ82+MIn
         ur1oDuXuZpcXfDzR47kIIzzV8Y3BZLNu1XwBukR9AFD/g5CBz/TF7BIaeFPJxGJqqVyH
         vgoN/3GFmNURScwGSbVYB1LKMcNHeXkL6Xf4K5ml2jmDNdeweP018dp6UuMoiFowVHV0
         zWSWRbPwkWho0+aG2cFANfv952TtX24hFR39Fh28z4dj8LeZiS2ak2DVxcClKPGAs1Vc
         qyZA==
X-Gm-Message-State: AFuF++lVZ8vj25TarEYi/MLl+ib7DsmNTgaNxvtp1DzJTKiNwL689sYP
	1oz5GlR4Tc6lc7MiBG4c/qPIu39esK3qSoTOuq+rvVDr2Nkm16I4+6dhvb8bSeodtw==
X-Gm-Gg: AR+sD13g1dnvv74jo5Am5GlHtYmcLllTv2/L+4Lk8weddfccIotj1RQrJjQ0iQZlZc5
	hbIX18vu6f5Ehd9OD+QIcMzFnWauchUmNEnkKqo9D1UoOA8vK5x3tE/UbBYSQKaaPogem/YSJ0S
	DI1aITWzTE2MLqLgADJQYh/BzC434TmU6zzx39BLVXpazf6hkANIENF80mB/DYtS5rKBx8Q67HD
	DeScqczzR5mrg3G8WqxQXPRPWCIcFIME6eKdXfrzqb92i1y92Q8e8DzXz/P/NEarj7lYzyh+482
	tPLDlRTEgZzn4fhBISZldFmqs6m6AT3omEH80nh0u4QhNmrIkHB3Xnyz6DAzcEviFXS5KORGA0R
	X2nr68LlSAMmMRY1kG3Jjt+EAqSF0/5++MLUjkYNHFd9KHxK1sGfz2hQfbTTYgzfIkaZcxYUhcF
	QG/Hx2h2jLiRJGMpUSXphZ8EShFrekoX3vYLNxPIF+0BAxc9rmV8bRgTzxT+8rAE+3wDJ+bKHwX
	iUq1VZOKOSNg3vu5NHl1/jzU6olrfgy+gMk
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2d6f2f25ba2mr2716195ad.15.1787653462056;
        Tue, 25 Aug 2026 03:24:22 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f16d77csm2916024b3a.59.2026.08.25.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:24:21 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:24:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <ao1tUKdiMZSoM82a@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
 <178759520116.3131778.9383172724893797706.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520116.3131778.9383172724893797706.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 14 lines skipped ... ]
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> >   * This function checks if the driver got a valid device from the caller to
> >   * avoid dereferencing invalid pointers.
> >   */
> > -static bool check_device(struct device *dev)
> > +static bool iommu_lookup_device(struct device *dev,
> > +				struct amd_iommu **iommu_out, u16 *devid_out)
> >  {
> 
> If we are touching the names driver functions should not be called
> iommu_*, it is confusing..
> 

Ack. So just lookup_device works?

> Otherwise looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Praan
