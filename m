Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14523394E
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985952; cv=none; b=dTo/0YISvC3IrzP8yDWJC9YVCUU8UIeq9UuUSu+ExzPBAvIEeAjJoMkGzQdT461WgkVDfY3RMTxXWHW583X5Z8rNXcGMPZcuAUggb3w4NEJZ2u8Qww1IXkw8Ozz5pCvhQxOAFgor3L7Mfe+YHAMMCXFokLnoiDouOqD0rpSRlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985952; c=relaxed/simple;
	bh=JifQjjeGTYkQYQF9OEClDLZwk6+0Cv5AfpxwRFxUgAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzoiJ0ZsD2ckpMeuuW/HkHLDglLeB76pEuHuvmM8X5KuDULODU5RmYb/cAzytcgKZPmbbA2OzrjN0xTwtVJcVNwdeiW3WDjzxVt1SrU+JXLvXj29bzRvL1teOGLG8icAcL21OFaMCoiSXr9ZyxWCinNYHFeQ/RzQScS5XescHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta9tIQV+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta9tIQV+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso1665ad.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985951; x=1780590751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=Ta9tIQV+xaRuHPvTz4yVh55BtlwgyfL2wUkhINuXKnL1LPMshzZUagctncQ3ELuZxd
         q3Tn4UJjBosGL6rggu0q0T5++SInTWxdSwrf3kHNM3RE9jUWJ6ZV/KhBF/Ae3smm1Ytn
         izrLRNZMolFrs4GeEraQUzPfifYpHKhuWrj7w0vBlheX6tOenMd8rofi3sPzSdFLd1/p
         y81aCTJjSnFSyLYwQ9Bp66kJp9PVkbGrQ9nwC/6c80PF32UaliX4v1ETWIldivLUb+B6
         MmaBpa/P7T/q79LUqdIND9THVxOiEY7E6c/kyU7ECIc5Uk3Pa3SqIUylemuuhbsOxPjx
         xnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985951; x=1780590751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=InhbSTB7oT4SwoqAOwvI/FWVW/ab4Ey4YUkctgEHT3VEZZyJdK5dGn82pm+2SMMXh8
         9CgZdRSlat5Qft4Mb7rjIxZqKBFKh311RMc/r2YiNBBW05QV0XD0x4qzZoqbBJLYurXb
         bUYErcoQfABVI5yDlnQ4kJCbN7zvcTkPsvIQsf5jdfeZFuH1VEEJyxNu1ubq8xBTXohO
         WxJTmndIg9J3BBgdSc02D/8eBiG9b6cqwweG+RbbocZy3yYM4Jhe87h/S3P7JdDu/lyK
         Cs9QeT5aciJMPFnZ7nUAE07fSgkspzlDSFjVs84NjBNXUkSbAqVc8lh0bri4myzkKSnt
         zR3g==
X-Forwarded-Encrypted: i=1; AFNElJ/E4RDYaZi5a9t6hN8DGNgmnAIl/HeJizyq5ai2aV1zXFh6iBCXAZmELnwwGnFvPM1cIvYeng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBDafBUa8IRKZSvVsHpb6eWPhaqmwdOeSRFW0ohCNrH2WLwwnt
	6a7CEFuWCG3FWNRBpVrAwDYYb11oowOdyfsU+OLPhDXSLtysRzmyHXpHrdIMJ43mPg==
X-Gm-Gg: Acq92OG8q5IYkMhb1c/z1IVrXa9T5dVyH7i7eoi7rhlJoMf85hPIe6O9neFXe43nIqe
	k2mZVRgZXSRBWr3FEvJtJeZASfDHaclamP7QeEzKoy8v0AL/X7vi/1t9EH0+MtPhC2zVR+w8bNv
	4FHOOqZl94QnsoAZGwN9px8NSndbQh9eZigkQthYtSQfy9QqmrQGP+zeqLcz3qudxQtJa3Z4PSZ
	53AlrHfCH+O2koGHPngxoJgcgTnvOTu9OxFZJVK9PM90ZLbRWXoHEMQ+LW727oTDLhyJF7YpQ44
	db/cgwzXvgl3GmA9WxI5RouT23lVbzrSboXCKuemcp8cxRHYziBNtxaaTuo97KgnH/9Z0hbAAbm
	Dbs+ibNBzPX2STVGJX0WwrAT53ZDKUDagwfC/D8EFuyL35710tHikMlLhyzWr/3a9Nl5dWyEt5G
	2+toDFV+frpmFuu031UR7XWbRBYGOad/Q/oxvTbEDCeM0uNVI088/AT4Ro0aImpJVLX5NAwbm3q
	uIK0zc=
X-Received: by 2002:a17:902:d50f:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bf0bb6f798mr1542415ad.0.1779985950617;
        Thu, 28 May 2026 09:32:30 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90c032fasm2002365a91.15.2026.05.28.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:32:29 -0700 (PDT)
Date: Thu, 28 May 2026 16:32:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahhuFw3ZJpy48xkH@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528152930.GA3195266@nvidia.com>

On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> 
> > > +	master->ats_always_on = true;
> > > +
> > > +	return arm_smmu_alloc_cd_tables(master);
> > 
> > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > requires Config=Translate with S1DSS in bypass?
> 
> Yeah, basically.
> 
> Effectively the ARM rules for enabling ATS and Bypass together require
> a valid CD table pointer.

Ack. But do we expect transactions before attach_dev? What'd happen if
we don't allocate CDs here? Am I missing the fact that CXL hardware
could be already active and using ATS after the device_probe succeeds?

Thanks,
Praan
