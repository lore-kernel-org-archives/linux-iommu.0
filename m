Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8F37DADB
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693964; cv=none; b=H8rW3GKu1vakn0Be/nzzefWc8PW0pxanpFzEi4VVIqYAa4ZVrBJZFXueIC8oJY20KYp5NoUGKZpHRIwZgiBHNU8pX0RHLV31V7H6OaPhbM+LzcbcTYbLUddZX3YfIasAVNrIMT6HcpY1IBL9vmRgE8suXBQFy3uYcYngOUdDzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693964; c=relaxed/simple;
	bh=BG8I6hWOhVmVwAETJ4Mpnqkk7ce1JkzQX78g+XE7054=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E94MJZO+HKZBYpprCIvSgGduSgKZWe0gJXW4srN8IkLjHQrLJoFpoPvZEa/5YWkxFChGsgOdyajYFVYy9vHoV7C7IYGco03BQPPQw/sdjYI4/95WiLohK5nx0mE1H2l6FRBjlHI6Ahbq1Jecrqw9a6Xz9YEWciljeAza76lEFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5Pnfbki; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5Pnfbki"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6d3851e0aso5235ad.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781693963; x=1782298763; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/VrBPPU0BxnUkyl2VIWVxkiohO/pXSg9OgJaB65iUM=;
        b=O5PnfbkiEVH4r25Xaoq1sb04XqgYB47MgXZjHAxBX5TJ4uN9NB27FSKMBqJiWMeivk
         8TDIt2X22N18ae+QlRmvLbt1fIUwNUCvuySPHxsJqbCQl2S8JhV0yQrAayLQNxNS0JuR
         76lvyklucmjdaRoOd6wDV1LgNx0A8qibA6p03v4a+lBG8LUreCrK6M8feZ8K4h8q09cP
         TDxY5/8EGBkNmbghygn5I6m2j/BjPSFcYzctMCnmfSbl6EwzYHVae7d3UrBEbjgMoG4c
         l7fJ8uNjfHqAqzpuy9UysdeSi1CmOVq06c8tVj0T08+vbItcRaQj0G2QuBwurVIZHxlH
         Rdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693963; x=1782298763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/VrBPPU0BxnUkyl2VIWVxkiohO/pXSg9OgJaB65iUM=;
        b=XZpcn6w661N+GUCsrC5v2jwK3H2y9Z3smqH21CLacNtxJuiAvsOHNGFB3lxJQCJlnf
         AG4z39bfjQXjvECQQ5WYu7tvoTxC0lpJZZ8+2V4CrlZQhMc7hwoy6YU6Y0WLgvZLq9rL
         FBIaOLbWTFv/JXEET8fgMI3ZDpoz4oQHO5KH2/a8zz8+R2nCmwWVan9A3FkA3TvQWAiJ
         W5fExilVHQkgPr/zPSLJhMPD3WrC6Zj24otcUQLZP3FsiVDxSmEPyH3rCekIyjPXxpVO
         tphtZXUGbl/262EBHd1qN/U2ucaSvPfqwLtylozPu/x9k1bn0SpCuwzCjahaPtscvaUP
         M5cg==
X-Forwarded-Encrypted: i=1; AFNElJ884Dmrl9Y6o670N9aNp+up6Ezd5Po+iCjkH3r7IcdkgJ23WbSbCQ8V2KYwJ92nApjB4qokPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2XZEx1jKWL9hoc1MS0uJhmv6LrXO/QuRvzanskp1rUL+kNFxW
	eVh1AYqxkW6PbXg0i9cN+KB+w5HVhR72+j5PF/nDqjxgTcaxJYUE85R6XC/+BVPkrQ==
X-Gm-Gg: AfdE7cmQlJx604tIKy/1TFu0HxwDgSVijJkyaP7JAxYJq0h0/59Lvdf3pTY7iDjKMwo
	9vMV9/Gu5MMMze/qUjmKJLusH57TUiWYI9msagFCDVIP1DMTR9xy9J3/UfhN2FlAI5ixJhdhFv/
	YfMXrVBHlcKl8AXzXKE41uH0rEJmzxYUCRS8wm9rPOTcAzVjjeHuf9O3AitrDTPcMEbNbaMVnBb
	+plXAdjEAutQPYJPX4Z0RUz9llOfUbfCGhXZcDbMURzJPO9A3Q5W1oQbjgoCa8pNTNWFq41tNiD
	EsFWXsScdZRve1R/RfSh3iIm9Z+T136AH9nA0qQlTEcRi6GTMpcQzTdZa9SMbVsjV6DxHPSLRe/
	ce/9Zm4vg3s3el/1hPCNPg6M2J8/7eliWHkIlVt7z5rQYRKA2WAyoK2N/0AOEWpnsaI34H7glLF
	uYweV1Wgzy/l/Cy21vUAANeBW6SYXLNJXMMROnUXMB7CyJ65/YYg==
X-Received: by 2002:a17:903:1a8f:b0:2c1:4228:3321 with SMTP id d9443c01a7336-2c6bb8b16ddmr1874595ad.12.1781693962331;
        Wed, 17 Jun 2026 03:59:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm5696164a91.5.2026.06.17.03.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:59:21 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:59:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 1/6] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <ajJ-Ai1ruFINPMah@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-2-jacob.pan@linux.microsoft.com>
 <ajGvfqjkZ3I1E-hA@google.com>
 <20260617000948.GA3577711@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617000948.GA3577711@nvidia.com>

On Tue, Jun 16, 2026 at 09:09:48PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2026 at 08:18:06PM +0000, Pranjal Shrivastava wrote:
> > > diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> > > index 455bac0351f2..6c3bea83631b 100644
> > > --- a/drivers/iommu/iommufd/Kconfig
> > > +++ b/drivers/iommu/iommufd/Kconfig
> > > @@ -16,6 +16,18 @@ config IOMMUFD
> > >  	  If you don't know what to do here, say N.
> > >  
> > >  if IOMMUFD
> > > +config IOMMUFD_NOIOMMU
> > > +	bool
> > > +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
> > 
> > Nit: Should we explicitly depend on 64BIT here?
> > I see further in the patch we assume 64-bit addresses:
> > 
> > +	cfg.common.hw_max_vasz_lg2 = 64;
> > +	cfg.common.hw_max_oasz_lg2 = 52;
> 
> That will work fine on 32 bit, it is how all the drivers are being setup.

Ah my bad, I misundersood the GENERIC_ATOMIC64 config. I agree. 

Thanks,
Praan
