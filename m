Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9515532D
	for <iommu@lists.linux.dev>; Mon, 22 Apr 2024 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814264; cv=none; b=koJDtfibcdMtmLsrdYInymkB44QvHvAYBSIhSgAOf3v6rTTzLErb+mljdf0fpGTghr6ZBGmU0tEmPv0IbRj18IQd7OlgXC55ipmxN/ARbDIS9ny+OLqWSoEXWLEl9u7k2xKgc5vA8TXWc91VPV8pxYNGf7l5QEB6WPoxxzFn0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814264; c=relaxed/simple;
	bh=3uf88LX4hpj9MBbr+gHmp4PX3GIFmCWPggLOKfmTPMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYJ210l1NzWwIwkhv8w3QX2dl4+BDeDN8BYsVAlRMxycxmJejKK/VtFAsgCD0nO4dm90RO7cy4Jpbgm3ZtFdUtEcazCtPPeW3QhTyZfy404270Qxm2P4xPQ5FqaC8zPZM3RWtRHD255IzpgsKnwl42zrezDkQfAPKnK4djPXKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bdv+dBYK; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bdv+dBYK"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d9480d96bdso251955839f.1
        for <iommu@lists.linux.dev>; Mon, 22 Apr 2024 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713814261; x=1714419061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yh3rgiRcQXBNCIidxjhakiopwH4ays77o8Kd/hCbWDI=;
        b=bdv+dBYKr/nXri+wrrf5yxQaz5B6kJ3/jhj+aEMoR/D8K+frVy9ABsH6ra6IWjSH++
         Y9NLgY2gOHj2YMBTycNlzHPAlTjv4Y4FVb2G2EN+GfWLJ3sKIKDPjxKuEBEmxYp8hzCN
         WebIu7jHJMV/MXibSx8pAUyFSsjrVhNns/TIMWW0k33qlk7ofpcmNdieoUlB+uFrfGFt
         QDR+DAdj+4lkFVsGJMYYhLTH845IuY8CtpiCcF9+dCR1zLYnb6qyccaUuZ1l3g2EpIPA
         5bbvPxZjCK0xZ7lLymuAsKj0/JchEt64e/VAi58PfynrOosBJi7zA8ca+amtWgJsSH4F
         W5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814261; x=1714419061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh3rgiRcQXBNCIidxjhakiopwH4ays77o8Kd/hCbWDI=;
        b=Rj36hES3SjoNx3bZtvY4dlUGVkTymKgvBPcThfwyy5oqLFqs+jhWRDjQXsjM0D+mcI
         JdXOaPXilnq+E9crVa5xm7twKpTxUsgi6f8laJ5TnmDl2KzSjRl8+blPAmJkAmUd4ReG
         7DXnXjn5Zo/TIgJYNoJVv8gOp1NwFvW05WPJIbnZInMfUCDIMckMzDX2DqIOPM1iomCR
         QMFsDJoP4CP3LdVf/IoqvbalDnaRsnXNuzUzKdiMjAu1w6P4Jbb6oEhwwq3ith2gn8/1
         Ndg1/wE2VSIVR7J5tR7+0OGfY0MfxI2knd1BZFxo0M0x7LDM2xtcspcXFq7ow4qdre+9
         ZQMg==
X-Forwarded-Encrypted: i=1; AJvYcCWAFpHKXKhBPaRH7Mtxq8eem4cDQtzNjtIDzjeqmeDaA+wL0E1lE7Wh+huJFqdELLvTq6szzyNtlgCuwFMR/chXl3zO3bA=
X-Gm-Message-State: AOJu0YyTVsdUN6ij/hOoMKByeB9Ppf7ao1fC6I9fF+iI9THAcwHOA4md
	f+Fx90rqF4+o3/aTJ822oc4uzRvYLc4ni1JlOckWzsh7+RlaDF1jY2P5qLNSV8I=
X-Google-Smtp-Source: AGHT+IH895F9KLddG1s2eZCz4/bKHter3T6UNI8IsPcUq25R04uAGE5maPekZYiqnwm1PrKXKmatlA==
X-Received: by 2002:a05:6e02:b45:b0:36b:1868:fab7 with SMTP id f5-20020a056e020b4500b0036b1868fab7mr15663679ilu.15.1713814261611;
        Mon, 22 Apr 2024 12:31:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id u10-20020a0cdd0a000000b0069b60baec46sm4402412qvk.146.2024.04.22.12.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:31:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ryzNT-0015IM-Mf;
	Mon, 22 Apr 2024 16:30:59 -0300
Date: Mon, 22 Apr 2024 16:30:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
Message-ID: <20240422193059.GC231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <2f2750cd-a5bf-4486-8f50-c93d246f8b0c@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2750cd-a5bf-4486-8f50-c93d246f8b0c@linux.intel.com>

On Mon, Apr 22, 2024 at 01:21:05PM +0800, Baolu Lu wrote:
> > +	/* Track domain to devices mapping. */
> > +	if (bond)
> > +		list_add_rcu(&bond->list, &domain->bonds);
> > +
> > +	/* Remove tracking from previous domain, if needed. */
> > +	iommu_domain = iommu_get_domain_for_dev(dev);
> 
> Calling iommu_get_domain_for_dev() in the domain attaching path is very
> fragile because it heavily depends on the order of calling the attach
> callback and setting the domain pointer in the core.

We have a couple places doing this already, the core code accomodates
it well enough for deleting from a list.. So I think it is OK to keep
doing.

> Perhaps the driver can use dev_iommu_priv_set/get() to keep the active
> domain in the per-device private data?
> 
> > +	if (iommu_domain && !!(iommu_domain->type & __IOMMU_DOMAIN_PAGING)) {
> > +		domain = iommu_domain_to_riscv(iommu_domain);
> > +		bond = NULL;
> > +		rcu_read_lock();
> > +		list_for_each_entry_rcu(b, &domain->bonds, list) {
> > +			if (b->dev == dev) {
> > +				bond = b;
> > +				break;
> > +			}
> > +		}
> > +		rcu_read_unlock();

But now that I look again, this is not safe, you have to hold some
kind of per-domain lock to mutate the list. rcu_*read*_lock() cannot
be used for write.

Jason
