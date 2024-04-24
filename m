Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1D156878
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000039; cv=none; b=fe4e5r0OiUfmOCsCip3sdTRI3Zp35ktP+/Nob4TWGUg8ezoEAN4swhfWKG8kKyvr0V+xSGgMLMrwNDmXSecqJVuAZAh9cjysYdgjGWQ7uAmqdJPkJGOB1bcJuwUqo9RoCNXAh6MCDAFupKXIE3ibJo2NoxMV+TJovM+tXSwNAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000039; c=relaxed/simple;
	bh=YkqsC0nF/H/k4Oytm2ewDWntFmRtzUD1STC8KXiQ41g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCK4wtSoThRup0Eh5RwxYgHg8bUSAImoZnVkDA/nnGctU6ch7BVZE5bB3X1nJkRyFYSaf+ugnr0sa0YlFajui4meRpG0GHPllFahwI3YXq929eKMzC7roxqOFJcU6o/Rg2o9XThmp7w23TaSmuALXYgt5OjmP79HhJMkXwexIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D/uGPfCQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D/uGPfCQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ed3587b93bso273847a34.1
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714000037; x=1714604837; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EOPLUxSGdh2673E9UnVgdv/f9WeKREWyE41T1+ComY=;
        b=D/uGPfCQNxUEYVeSdE2j7yyPBZIp5ynqJYDsj0Lc4mVARQdOurlEbgqFI9AH5k+SZk
         vqxHGAaFV6nKYZZYeZdmgY9EFjF9LxQipIxXBeSaZz7PRhbrnprvtSyW78ZrvoMm4XTH
         EqwndeFKDAS2QJ+pPV4/T0zAhKtIMvnp7DrvgiApj3MoX4lG6yS4UgHbGvHp2xxBBM5s
         FyBx70asxmFbN+hiLWNG9hTClNTvX42P1xOStU2ZLJ9gD2sdUhCmI/Hj7JE5A+7Ssdyl
         /rZyGfn103KTnhdkHLPkl0/WYXaYPQkmEkqbk517shaw0XdWnb75tycFi0vP5DYi65Um
         rZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000037; x=1714604837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EOPLUxSGdh2673E9UnVgdv/f9WeKREWyE41T1+ComY=;
        b=xNeh0lZNIj7f6cehBW1B/UmvT3ydtnSEBJcS65O+eHDH6+y0E2Vds0XtyE7JnLjTUp
         msVV7llg05NtzyZUsaGERHTeN2mWyRxdpsq9tMEhlAfo/hbLiTR8OjluPs2hR30yKayF
         /pyF/kGRt1D2VyxCB6OFoK81bNA44q7kW7BavSDZmty5jw+UNmTHNw2M/sp0pZ3LpdjC
         MMNCnjOhnNm2p7VDBYXrqZ+rdE3coZlfxBo2f4bwEICwoQ3c4l+yq6+cVQNrteTtQyRM
         VBCgKei0I+Jy81trWgjeRXmrrdz7L1NJSUyipxbvgZcVWQlK2KyxvKsoSwMYVryYX5hw
         Xlvg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZnyaKRw8ZpZnRaO6d0d0kEPFU42OojbnvuQqWVtJzbrh9Fz1fyd2YiT+V4nJ1+Z/tBRgsBKjAMeiV5pPQeojPAn61qk=
X-Gm-Message-State: AOJu0Yzb1PjK2t0zfm8TAIAtotvbSuIe7Nj/MKA3/9Cgj853jaYVpAK+
	rbhTI+HUNkSUZmVun88bo8RxOj7C7TEB37KkjdGGnw1zWx4mbG5vHhGwt/uAQ6E=
X-Google-Smtp-Source: AGHT+IEK1yF/pF3Jt1MaMAE7gbVSzzN/c9vmeIlr7aFyXy4aHkiw6cz3OYQ6jtkyalR6CHilLOVggw==
X-Received: by 2002:a05:6870:c0c7:b0:235:3d0:3096 with SMTP id e7-20020a056870c0c700b0023503d03096mr4168277oad.24.1714000037198;
        Wed, 24 Apr 2024 16:07:17 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id oh23-20020a0568702c9700b00239379f06cdsm2596004oab.9.2024.04.24.16.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:07:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rzlhr-009uvX-JB;
	Wed, 24 Apr 2024 20:07:15 -0300
Date: Wed, 24 Apr 2024 20:07:15 -0300
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
Subject: Re: [PATCH v2 5/7] iommu/riscv: Device directory management.
Message-ID: <20240424230715.GI231144@ziepe.ca>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
 <20240419124017.GC223006@ziepe.ca>
 <CAH2o1u7_YBtS6m1-T56tmxud1mda2gb6tLGVpbBSs15FPcjaGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u7_YBtS6m1-T56tmxud1mda2gb6tLGVpbBSs15FPcjaGQ@mail.gmail.com>

On Wed, Apr 24, 2024 at 04:01:04PM -0700, Tomasz Jeznach wrote:
> > > +     /* Update existing or allocate new entries in device directory */
> > > +     for (i = 0; i < fwspec->num_ids; i++) {
> > > +             dc = riscv_iommu_get_dc(iommu, fwspec->ids[i], !iommu_domain);
> > > +             if (!dc && !iommu_domain)
> > > +                     continue;
> > > +             if (!dc)
> > > +                     return -ENODEV;
> >
> > But if this fails some of the fwspecs were left in a weird state ?
> >
> > Drivers should try hard to have attach functions that fail and make no
> > change at all or fully succeed.
> >
> > Meaning ideally preallocate any required memory before doing any
> > change to the HW visable structures.
> 
> Good point. Done.
> Looking at the fwspec->ids[] I'm assuming nobody will add/modify the
> IDs after iommu_probe_device() completes.

Yes

> > > +             /* Swap device context, update TC valid bit as the last operation */
> > > +             xchg64(&dc->fsc, fsc);
> > > +             xchg64(&dc->ta, ta);
> > > +             xchg64(&dc->tc, tc);
> >
> > This doesn't loook right? When you get to adding PAGING suport fsc has
> > the page table pfn and ta has the cache tag, so this will end up
> > tearing the data for sure, eg when asked to replace a PAGING domain
> > with another PAGING domain? That will create a functional/security
> > problem, right?
> >
> > I would encourage you to re-use the ARM sequencing code, ideally moved
> > to some generic helper library. Every iommu driver dealing with
> > multi-quanta descriptors seems to have this same fundamental
> > sequencing problem.
> >
> 
> Good point. Reworked.

I suppose by force clearing the v bit before starting the sequence?

That is OK but won't support some non-embedded focused features in the
long run. It is a good approach to get the driver landed though.
 
> > The release_domain has landed too now. Please don't invent weird NULL
> > domain types that have special meaning. I assume clearing the V bit is
> > a blocking behavior? So please implement a proper blocking domain and
> > set release_domain = &riscv_iommu_blocking and just omit this release
> > function.
> >
> 
> Updated to use release_domain, should be cleaner now.
> Clearing TC.V is a blocking (but noisy) behavior, should be fine for
> release domain where devices should be quiesced already.

blocking is fine to be noisy.

Jason
