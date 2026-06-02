Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D151EFF93
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371108; cv=none; b=of/pPxKLZaKrEPdIT9Uz8fdb64eC/h7BqEMDjNOGMWnwQWsCP7W2ftjfBTix53gvyKbF/G1eLWC6M5Bfx3ZQw55NHjK+V/Fd19Nt3mW+0NU2flW7UPo93P4k3jzc0Plgi0BMcbV6e71bYqYF+rJNCJFE6i3f2uug+WlVq1nFIiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371108; c=relaxed/simple;
	bh=XblSE/qFO5iv0k9CvmUX4AYma8Ne8fzLlAaeuIg+uBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/uoJUfiKYTJ2ar8JndoqKv12jYyWaUdxpo6NCrW2cRWwJGwxoiKMgGaSf5tptzToDRmWxKjavb6u9KpisQAM1liWmJpD/qpqjkhWvF7ahnP2Ozldww/rBIooOkcUw6iMljLgD3SYrfUbJk1a9cUhh43TYmERWv4oybSmscQNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYk5gAHi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYk5gAHi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2911f93cso455ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780371106; x=1780975906; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Diic5IFOcgXcVWmgqDsz4OF2UmpW2reWxY9MFp8cl5Q=;
        b=AYk5gAHiAYNL94MZ/F2aQF7KSaZLIfLIWfgWaI8thtjkuYbeSNTimGlV50iP1Hdzip
         t4dQsmtFWtV137QemqC+y1WXlUFRqo+6UCNlPyHM1WSB+rGBIC/+G8pirNtPUOcoGX4L
         K5EqLhQ9XbNI+gGgufiE9FwnOVVTL9tsYQ7BO5zsrjHw3fnawPSatReKqzlYoSrz2+8R
         QRQT5/klZ/gUmOXRoB/cBUeUyll/3g4Bf5ZU1fCF6ZMDXtwU8YeaOcy6SMOwfJcofeSY
         mdqFMk9pMhawx2nv8KPiQAKMVCmNz9IorC6sLTfyldVaYpwlllxnBJ21/Bsio0Fe+jVb
         Kgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371106; x=1780975906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Diic5IFOcgXcVWmgqDsz4OF2UmpW2reWxY9MFp8cl5Q=;
        b=b9AsLQ5oT4208AX6XD35p1avU4lau6ul7SeJ/GWNrRGMmgfCy6wvA73NeiBiq53cqx
         ArMvUygCGbC6IJ20qJage/8MGbHo9NUt08JdqhUtJxedfp9ZaSIY1yjYGbaMK1PwPiRi
         3sCtsXKs7u72v0p43gfCD0makYl67SrmUU+fmQQ+cRqJCb3U8wI4fLytKyzSXRhZoq0+
         gckAsg00wDNE/hLO5ehDBBUT7/2LFXa0iBt4fqNOoRpFCUTsGyaMLAoBYH56fvjLxOZq
         uOIIdjGnsaA9cn0vv6ZEM79eZKSmblE/Jukh9+o4cb4GhRoz68L4cdwoidekWEXiAUty
         2RJQ==
X-Gm-Message-State: AOJu0YwoZJzub2f9fJtypC7Ud8z4wBqk7ncOt4zIkYECUzxSU1OyEjjw
	fG3byLs7TvrFL0nwSYgP3tMp4CjjIzmPR851DOzFXXwf8jPDybIp3IB3RjwSNOP+iA==
X-Gm-Gg: Acq92OHIZkt9tMOsIizflkKjJWghUcZREXayuWZ/9LIZcKEhB57wHqpZjtva76ReCpq
	fJxpYhTfEw5ek7Ml8SlDYkS11ihsP9+yyLZUX5wcR1y/MFFBKROd1+/bsllPq3H+rKVLPCmjZvv
	kumW8yPPWxVp7Vz7uS71x+6JoQT6Y6cn+qvrZi5KKnr5c8gL1UvsHnNnRQC6yEOtfodRih642Ia
	HkaciLac82h3mG8aJ52DI1Kxn4BUGnygAc36kOr/ZOhufsKORZz6DlZJd6/bsF+1PSppeeuC6kn
	TDn8IkCLUfVdA3ygATWfAhAJlC8ylJyTLwkR8/tvFypeSija9j+gKO90soUXcmFCvD0Nx9cQ+eG
	fgypFuHuYXWAu3H9iHqmK3onAf9yumHw6w8PnVSeZJ6u6/qYgInGlgN7Y7VlEMWywN5/UP43ZEY
	qhHzaZs87vKtU6IgAUrCpmIhEOpVyuQk5KMA/QOVyitUy60rTM87LZ+rGLhH9OkGNf3qZGd7I=
X-Received: by 2002:a17:903:2c0f:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c10eb100femr2152345ad.16.1780371105574;
        Mon, 01 Jun 2026 20:31:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85770b9e2esm11379046a12.0.2026.06.01.20.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:31:44 -0700 (PDT)
Date: Tue, 2 Jun 2026 03:31:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/12] iommu/arm-smmu-v3: Handle gerror during suspend
Message-ID: <ah5OmlcgW-oP9WDc@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-7-praan@google.com>
 <ah4gq5NzuW90OyoS@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4gq5NzuW90OyoS@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 05:15:39PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:59:03PM +0000, Pranjal Shrivastava wrote:
> > @@ -2300,9 +2300,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> >  		arm_smmu_cmdq_skip_err(smmu);
> >  
> >  	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
> > +
> >  	return IRQ_HANDLED;
> >  }
> 
> This seems unnecessary.

Will remove,

Thanks,
Praan
