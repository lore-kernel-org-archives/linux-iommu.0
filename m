Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37878F5D
	for <iommu@lists.linux.dev>; Tue,  1 Jul 2025 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751340849; cv=none; b=Yc+9+bWaDsb3FE5BrcCstV1CmPcKG4n1mR/tA68NSkSdhy2+wKXfNuNd5yyYY59VATtrnSwZuzumtct/HX5FXf+4iPe+KlQd9yiZ8fEX8mFCw4Ge+TsfD1KrlwLX0ZPZGty9QkXIXaCaZn5QscHS8EQpWv6kV64ImmKXixZY6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751340849; c=relaxed/simple;
	bh=0ILwCOvCew56oAyKwRacIstQKCp9aDHxuoc+AExHhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT82EsDIkwYA4hkHe0s3OLR9uWYoTDqv0Q/d3jkLpgF8+KHcl35pXEJa0T+KmjeesJqqoPhu16AaD3/oTAeOZl5vB3yMUZUCZXWF10CB+Lv8TguUpeINJ22IWPMPoGHLpR5U5m+5cYmvMd37Ggx6zDIgqc2J1l/UDeH+ZmTCGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dNU7U3Cm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dNU7U3Cm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235a3dd4f0dso31707475ad.0
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751340847; x=1751945647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31XS2nxYehKiliXMsYuVNFSQuv9hNJl6nMqw6J9ZvFA=;
        b=dNU7U3Cmnvs3RgoMWHM3qUTAb1PHxsJ3yj3yypuut3H2XiUSA5uY1Dwy+AvLG5rmpH
         oJfIW6Eyu3anXajQ68pyVRay2sxhThpYT6vFzZcxXzwEi1JN+MMCUKxFU0kefJ1gbS9t
         ialzgUAVWx/1tRHAbXoHJ2GgeaY6tmgV2Q24+x7MugemOpMa6gLMWGjCJ/3F2dExLGz9
         LSCZApg5RUJ1KKog8Q7jE993BZKC5NJJswgw7QInC0cV0CJfZKcAuhCzYBzhb2hR3Z7G
         DPGZz0uE4T+ZajBQjcv5b6WzjlU9HQdCQ5MXuL7eW3yiWBzLBSNTrF17KdjHhWWnHyOB
         TC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751340847; x=1751945647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31XS2nxYehKiliXMsYuVNFSQuv9hNJl6nMqw6J9ZvFA=;
        b=HzTFREjrkkqj0P3D6ZfnPMJsMF8Ij63yRKTLGpGK+drFuNHrRgAlrSmviehw/f0FAY
         VHLE2xUAMaO1p0IeDWJ2VJfGNBOWdkMD1crBxswNp+l4ETSLZG9ZYHqtNPBtd1yw2090
         w/nXQUSHJE4sSsdYS/BJokTnTBBTUwoV/9vTPRXbPCKKaV1VaZiHMzIBDcTH2Mknhc4Y
         E1w8BEuNeviQy5D5huvnFdRgJqQqwQc5uIcHZzJorB79UhdbgIDa2PIXQYbMo5mjmTd0
         svMItF/yym+EHYTEWaaJmB+CdIH51Xgt9rognts2RvAcigUecDS8q1hAFyVA7ddsRG17
         v9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmVq00/9CO8o5M4urCKIPDF9fm9MoHsoPq8Qa/JA/jLcE/RDCgr8CfaqWsGzW3zjQsX5YDJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrbtjM6Ld7u7tK4x2vhaI4DyDmHjBKG59soqdVc9sBtZS4eC7G
	VPiAkfruG0Titlv6cgsCxUv5NquJQqbTimU8UAH3e6SQriYBl/P/LdYnNwG1PwWPkLY=
X-Gm-Gg: ASbGncsuLaRr4yL7aVvSTKGeTkK091P3Ir0R6hsQX0RZVf7EO+SpgnI2W8rAJvKN7fI
	YwoIO2dI7Umfs6MoBNFpSEzJKiEJkFwuyOeo7EF8zYmqjy+hJta1x+ZSWWe23wegAxfVSv/x2o6
	b1pAI2K1xuAYFVqUi0oyAfzqGKTM3It9UKIm/LvlPxZTFHGSCY7v6DTim3KCBiBPSHLm8m7lzNl
	yXfoIKCiSr4ZDIWdsYRws+PogKz9UMFN3sr6qrgp/kcj0PbgHnl8asBqOfP4ECpIpZwjRJTocu5
	RxYLosBaZoBYfBYL32pUGNOcKQIOV9HAz2eSzOXQxihfFD1WPNHQu7GejVUBBq+CKnwItw==
X-Google-Smtp-Source: AGHT+IHBFOUU87e7HImdYW3OwpB6jU6VOhsQ+1GbwVU50fpWtSuIe6bavi41hI7Zk0rpNJpgH2mTrQ==
X-Received: by 2002:a17:903:1a70:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23ac40f4e43mr241646815ad.15.1751340847108;
        Mon, 30 Jun 2025 20:34:07 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c90d5sm95757375ad.247.2025.06.30.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:34:06 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:03:55 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in
 acpi_iommu_configure_id()
Message-ID: <aGNXIzi8vYL4AOj4@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-3-sunilvl@ventanamicro.com>
 <20250630-c479c6607cf8c1430f11336f@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-c479c6607cf8c1430f11336f@orel>

On Mon, Jun 30, 2025 at 10:02:53AM +0200, Andrew Jones wrote:
> On Mon, Jun 30, 2025 at 09:18:02AM +0530, Sunil V L wrote:
> > acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
> > Add support for RISC-V as well.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index fb1fe9f3b1a3..70f57d58fd61 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/acpi.h>
> >  #include <linux/acpi_iort.h>
> > +#include <linux/acpi_rimt.h>
> >  #include <linux/acpi_viot.h>
> >  #include <linux/iommu.h>
> >  #include <linux/signal.h>
> > @@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  	}
> >  
> >  	err = iort_iommu_configure_id(dev, id_in);
> > -	if (err && err != -EPROBE_DEFER)
> > -		err = viot_iommu_configure(dev);
> > +	if (err && err != -EPROBE_DEFER) {
> > +		err = rimt_iommu_configure_id(dev, id_in);
> > +		if (err && err != -EPROBE_DEFER)
> > +			err = viot_iommu_configure(dev);
> > +	}
> 
> This can just be
> 
>   err = iort_iommu_configure_id(dev, id_in);
>   if (err...
>      err = rimt_iommu_configure_id(dev, id_in);
>   if (err...
>      err = viot_iommu_configure(dev);
> 
> Thanks,
> drew
> 
Sure. Let me update in the next version.

Thanks!
Sunil
