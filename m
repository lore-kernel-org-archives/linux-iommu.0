Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0ABA21
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006088; cv=none; b=iC5v9H5M07FDouDo9mw8Yf+WukVn7z6tisfwE81o++cQKctIhf8jshIiPPtIYXqmonIoPdDHY8FCRoccEs+EZvnNAmpLPgurh2r0zLtHf72ZLAxQCYMj3eKEQYGyEg6uAt36z/atzERHSgOErzhF78kL8AKO5o6I+skLq1Ga4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006088; c=relaxed/simple;
	bh=1FwFfqE9i616o1VTvMvnmB0Vi4XGdpO5ENmkg5Y9C+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spZdkvOlugpxSEZXTGoWCMBbYRMR8Ugl7bLlD9Tt6V7KGRs5Dsl0dAYTP0FY9FE0pySuGEXaDZ7pz4V6xG+crxK0qWqhNfeGzFg5PhRRU6MHhGRit+Km2AYxCFe+UK4ubart9BRp2wbFEm55qi7PysXwlrrUljfUSK7hv2TFsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=asIiecnP; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="asIiecnP"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c7510d1bacso322666b6e.1
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714006086; x=1714610886; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuFHLVEWRvr8nT3POIEE+NeoEX4x7+oc0ycZrONvMnY=;
        b=asIiecnPkCnbLXK1pQC7WVxnOztZH/s8qMpQkdOdXbqSmvgnpSZG/KtnENAFKvRBAU
         0Q7YxQnB8wCs+Oj9FAs7N73iRxSDIHKnPTVglCIF2aLusTcrfq7VtXdBoXvLIZqOBOjk
         ykDbPHDlF4oHJ0QUstTIp3wJJSEgQ789rz1hCWTXZKN75Noe6iuHAKEJL3KraSqMb9/x
         pa2Z15dzS50pNRXswR3b2xa0Q7Dr9NprP0TIDyYS9v3cGub2mtkbCM3ParN2UAD75Blo
         KlHCrHKllaCmvvupe1lUpDIcGNMgoRN+HTYt+cuiVbW3dZ/XMvO5JjhKkFJ/z0I560GE
         d7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714006086; x=1714610886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuFHLVEWRvr8nT3POIEE+NeoEX4x7+oc0ycZrONvMnY=;
        b=EMPxnlicIbXp1PW68ihH7uSQwHjE/zDRzPHfPyK+I1axUIoGnx0n337i/Rd6rt/yBu
         GQ4h/gQE6LxZc+b8f7k8qa3mPq7SwCoja0nhEs6ZBERkKIt0OvML/o12NB8PMBcqY32T
         rfURzk+u5zNzYtw5XqDb8JJ7hD7K3K8ZSvCCBzrn0qB9tVAMFZN3N3K09xVPRnIQZglN
         ziGhjC/8/cabSXsAD4b+njvztlDkV89nx7JfV+3rFgBLIvfeuT9xvR1geLhXfhuelISm
         dCumVM3M4tBnLkU1LBQle0WmhR9l77u93Ib3ZcFy3dZB2QkfhOBiNM90n065xt/RfOKi
         c8rA==
X-Forwarded-Encrypted: i=1; AJvYcCVjRLL7MMRNf6sbXZk+tu3TUT2ad72KPY5bxHnKd+sQL05jMUm95NbZuj/k8sX/pO2e0pLwCfRKQ1STeUJkEb6Dtkl1Uvk=
X-Gm-Message-State: AOJu0YyAYRW2Ag9nM7Aoyq5Z6sdOG1s/OFBodC7bWX5Y7Ck+JpvR+heg
	0RNSH4e64AiObvputMQ4HnWHi6XJqwReyf+PGoEbth9SIpUa6N2pXb2rn5v2ct8=
X-Google-Smtp-Source: AGHT+IEPuZwS/Tkiq24z8ESvoiDOcfXfHtKEsJScRX3bkfnzRD6SNCxN7/xPfUqfYppgfpYVzUwNDQ==
X-Received: by 2002:a05:6870:b527:b0:22e:9792:97ed with SMTP id v39-20020a056870b52700b0022e979297edmr5451364oap.38.1714006085784;
        Wed, 24 Apr 2024 17:48:05 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id xi9-20020a0568704f0900b002392041da7dsm2726725oab.48.2024.04.24.17.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 17:48:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rznHP-00AEjV-Rj;
	Wed, 24 Apr 2024 21:48:03 -0300
Date: Wed, 24 Apr 2024 21:48:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20240425004803.GK231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
 <CAH2o1u5+XD9YN=gdMVtfkyhKoKha0UpwKgOVbCAwOQa+saPfRw@mail.gmail.com>
 <20240424233950.GJ231144@ziepe.ca>
 <CAH2o1u4eZ-mRO7hiJzA-pwYDOo0+3vObpBZT3_MXW=zC9mXRbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u4eZ-mRO7hiJzA-pwYDOo0+3vObpBZT3_MXW=zC9mXRbA@mail.gmail.com>

On Wed, Apr 24, 2024 at 04:54:01PM -0700, Tomasz Jeznach wrote:
> On Wed, Apr 24, 2024 at 4:39 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Apr 24, 2024 at 04:30:45PM -0700, Tomasz Jeznach wrote:
> > > > > @@ -46,6 +46,10 @@ MODULE_LICENSE("GPL");
> > > > >  #define dev_to_iommu(dev) \
> > > > >       container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
> > > > >
> > > > > +/* IOMMU PSCID allocation namespace. */
> > > > > +static DEFINE_IDA(riscv_iommu_pscids);
> > > > > +#define RISCV_IOMMU_MAX_PSCID                BIT(20)
> > > > > +
> > > >
> > > > You may consider putting this IDA in the riscv_iommu_device() and move
> > > > the pscid from the domain to the bond?
> > > >
> > >
> > > I've been considering containing IDA inside riscv_iommu_device at some
> > > point,  but it made PCSID management more complicated.  In the follow
> > > up patches it is desired for PSCID to be unique across all IOMMUs in
> > > the system (within guest's GSCID), as the protection domains might
> > > (and will) be shared between more than single IOMMU device.
> >
> > The PCSID isn't scoped under the GSCID? That doesn't sound very good,
> > it means VM's can't direct issue invalidation with their local view of
> > the PCSID space?
> >
> 
> To clarify: PSCID namespace is per GSCID.
> However there might be more than one IOMMU in a single system sharing
> the same GSCID

I assume this is because GSCID ends up shared with kvm?

> and with e.g. SVA domains attached to more than one
> IOMMU. It was simpler to manage PCSID globally.

If the PSCID is moved into the invalidation list like Intel structured
it then it doesn't matter for SVA, or really anything.

AFAIK the only reason to do otherwise is if you have a reason to share
the ID with the CPU/MM and the IOMMU probably to coordinate
invalidations. But if you do this then you really just always want to
use the MM's global ID space in the first place...

So I'm not sure :)

Jason
