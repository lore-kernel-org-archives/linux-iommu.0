Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C411717
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478097; cv=none; b=Gobubs/LQYmmKyveUDYIpYhtTJhQ3L+6Twl7wnGwXb8KAfPUCRrYsP2OLVo5lXj8lLd5x2B74Kk4dCP9CEhKb5DY/YeSE4GdaIiTQXsuSOKuuXA372F9g+3Q+TsOiUCnRbb6jbV998bhECB73vwLXic/WbkkEPIiYLbWGsMUQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478097; c=relaxed/simple;
	bh=lHxOGmWdlihXCTgHVfb+T5jI7AtAtZWCWZ88p7h5se0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tns0YyyedSbQ7eBhPpPtSGhxcUSqMn/m6CbbHuiCUcwGpkgoCqxmSXqsg6KZwE97FUZgJd4D1qybHg8YBj+MvkixeoGL8VasqUECpYIasIb9FZn7mT6h84YUQ7QNCYjzsFL91Ebuu9HPZB8iFMitQ6Qw1UkMNY1Ny6P6KJMc6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fHIPd8vM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fHIPd8vM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792b8cd0825so184339885a.0
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716478094; x=1717082894; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmfyLYVCfyswQ3c7xb61Hr7O417fd5EFVF7yNKTH3w8=;
        b=fHIPd8vMLWQOhBmyk1QoSh9bBIdSsQj4woVVYRr0h9PnVPUQomRnGsj6ummXs4ucvY
         mwzMMhBlLhflJSrm6qkFnFsMSu9PFtIlFO/GPmcI1PLGR6WkcA4s0O9GaR3cA92+KN5q
         DT0yYq7LV1VwHraEuiefepNi8r5SZpkhj2loY/woEoHzytM4p6evmM41quR9stDm6aoO
         TbuESHF0WXOJ2u4Om0er2WMReTgVLURs0v8vUrvhUBA0ibb3gj3wDnsLcgE+Vv2xZY1T
         QMRq2g3MzDrb4ID1S0JLCD7tMo0qfV+fjbcAGLKM2cT88bFOz2AtSBXL/nii2Xv+5x2M
         kezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478094; x=1717082894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmfyLYVCfyswQ3c7xb61Hr7O417fd5EFVF7yNKTH3w8=;
        b=BmXlQB6Fn2DDKe7efEEnzAWz52AxjmVYFPiUTiozG+yT4asj5HzlFQsUYYL1p+z8fV
         QFgjNCf16saDe6UC4dlXWsHO4Kw5VOjdmzCrOyBVB+PaP6o36E8U2XTm6XzvP8w1b54N
         sDk4HgPUbC7tzroDWzB7x5/xp5gMSsqwbYyP+zLz6oiCJrUiCN6LBTyOxpRsM+KidciW
         1DghFGaA7mbgJ9SnCmL70/ljAmWJFUPkwG5MWAs2Bp8fRcbvIIlVJesOtn0C5+4TASKk
         BqrhdNI2jfDtsMGY/Hwf/sIWEZiGuJg8UVCoyuVPyL4+hGEOCSdGayPv7EmxiqHeBkXI
         /MqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiIGoL866FZYQJBxRlxL88wDO/Wh4pANjb29OBf/EOVP1WJyQlrqS8befey92uMBxYlv66p0NV/Qj3koGdHUz0fRdD3vA=
X-Gm-Message-State: AOJu0Yykt443RP3bOS91QsjR7OFlfi/i70wzdvHJUQZ0ixMiMqaMjsS4
	SVLcftKQcSoBUND92MakPl5vvlpsQlD6NFo+bjngoNq0ku+exoEwC7Sbp8vMYC4=
X-Google-Smtp-Source: AGHT+IHTBzzwi4PjhcyoMTsLG+C6xPlPNq6v4XQ9szwtINNcWYZzWlV7kEZtWT8wPy12nifAJzgm5Q==
X-Received: by 2002:a0c:f593:0:b0:6ab:8cbb:79f4 with SMTP id 6a1803df08f44-6ab8cbb7b85mr30572656d6.56.1716478094519;
        Thu, 23 May 2024 08:28:14 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab84cd6d93sm15777036d6.127.2024.05.23.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:28:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAAMU-00Frqn-OL;
	Thu, 23 May 2024 12:28:10 -0300
Date: Thu, 23 May 2024 12:28:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 7/7] iommu/riscv: Paging domain support
Message-ID: <20240523152810.GL69273@ziepe.ca>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
 <20240522-b25680db03b547123f1cd59a@orel>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-b25680db03b547123f1cd59a@orel>

On Wed, May 22, 2024 at 10:07:14AM +0200, Andrew Jones wrote:
> On Tue, May 14, 2024 at 11:16:19AM GMT, Tomasz Jeznach wrote:
> ...
> > +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> > +	struct riscv_iommu_bond *bond;
> > +	struct list_head *bonds;
> > +
> > +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> > +	if (!bond)
> > +		return -ENOMEM;
> > +	bond->dev = dev;
> > +
> > +	/*
> > +	 * List of devices attached to the domain is arranged based on
> > +	 * managed IOMMU device.
> > +	 */
> > +
> > +	spin_lock(&domain->lock);
> > +	list_for_each_rcu(bonds, &domain->bonds)
> > +		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
> > +			break;
> 
> We should wrap this list_for_each_rcu() in rcu_read_lock() and
> rcu_read_unlock().

Not quite this is the write side, it is holding the spinlock so it
doesn't need RCU. It should just call the normal list_for_each_entry()

Jason
