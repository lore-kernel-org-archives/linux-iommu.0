Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629014372B
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041779; cv=none; b=PnvNSJTDcz1xqBrgxcJFCFUEe7zxBCYHlji5pwyp4Vps6YM+bJpfxoj9O94Z4BTeCBJNENa3y2gJ1ixMdid/rmvKOIWxk6sGW/rHAsL7ndYjs6rV01XbZDLfYH533kTuKY1jfCt0aSayscstLFVXDzrDFaw7p4GOgGSnvFNJGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041779; c=relaxed/simple;
	bh=iOCQA3gFhsaGFrQM1y+O+3mLLYJQ5KrPcSjHAx+iK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZxP/kBZAKxtZGgHuJYEP6yGH1HLc8tMlMMY/9WQrqIPakuYCgCZyNBgfYxWq0Og0qnT8YCWxQta11UDIA0gUOGSVzbGf6AedxbcLEFVEux6WP6AjYvPBKgj1TIiLYJc14zDAw1r29FcchqFS7loA+k3GM3qksTAdbWgLSooJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XMWlD3VK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XMWlD3VK"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627ea4e0becso50961877b3.0
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718041776; x=1718646576; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLnQ2l5LC4vBk1KAktpJMA8+PgPoixo2FswnJOlP1yg=;
        b=XMWlD3VKWhD+IZC1FQzSBxQ65ZWUOjxl76u3F6GP/BKepqboveSO0vVlgmh/4hsyHw
         lx4pwHJnSFTAaikl6JljWD4TZoxeH5zkvrJV5I6fFIM+m89UvGngLMKoJ0ecD+Kvn6p/
         ikviTAb/W12sj1jtx4J4gexR1SmKOYRX47B/nlF4cO9KxSubk/2sdz79jntTwPRBYn51
         rWr2rjLK81tFX205wp2j5295AQ4gU/uv8sWUOx8u6+lYDo7gz0Wf1slP7pL/F3bPfW/9
         POGZ+rkdbgKVXWkx3eznU50jLuuyK7PMqfAzW8vnAAy7RTeNP7lysdSuXoxUharQC2Ys
         +Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041776; x=1718646576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLnQ2l5LC4vBk1KAktpJMA8+PgPoixo2FswnJOlP1yg=;
        b=rB4+kH7tassGy/jD0GCwPuPdIiBVSxSdGgF/c8qvW05uPWI/483CiJFGyh4UaOl8PM
         hFaFrME0fNhZwPqzhAwdaVtX5OYphHFbQJGnVK8QBN+BP1eHpbybbPYIoPMb4Akx4y0y
         clzIXH/OeIjhr4WtBNF6xxwxOwoNN2eoH8mWWxss1boOoXuYA1YcSrA6M8X7uHJp8kVu
         xWlmsmLKYqOa4m6hBl/C5X3EpZ4F5vJLEgRVMiGzHFMEdalmT30Ve9fO1ALzTJChE7HP
         ScDuhXypLzoJ+7HiutaIUtA8aw3JJ7L9MestjZC9XOg6X3MWbxNXncaC34S9GaMexIbD
         BimQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxygKkBnqQyCTjNW5ni9un1o4rIieJmJ1RzNoafIbTPLgZfcC/FzoYQcYflriWTLQZ1c227t91virNEQ8xxrRkSSbaOO8=
X-Gm-Message-State: AOJu0YzmrMmWdJNV/+yuy+CbdefhppEZh1uU/zjmwTzNFJfOOH/s+H1s
	5fzaeixs/07AYs8LxwGRqgzxBHh3BSs2G7G7Nx4LTtL1ItqMKr5E0WYRboWVsw8=
X-Google-Smtp-Source: AGHT+IFe8OwLGzvnbALaK/BDvvOAZwFQVf4gWc79kKkP946QP6T5IhIBj387LfKTGJKnPwAn+7jYYg==
X-Received: by 2002:a05:690c:72f:b0:627:7ff0:fb4e with SMTP id 00721157ae682-62cd55f3aa3mr88716287b3.26.1718041776199;
        Mon, 10 Jun 2024 10:49:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04fa1a628sm48037996d6.136.2024.06.10.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:49:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGj9C-00Etv9-1y;
	Mon, 10 Jun 2024 14:49:34 -0300
Date: Mon, 10 Jun 2024 14:49:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
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
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
Message-ID: <20240610174934.GM791043@ziepe.ca>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>

On Fri, May 31, 2024 at 02:25:15PM +0800, Zong Li wrote:

> > +static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> > +                                    struct device *dev, u64 fsc, u64 ta)
> > +{
> > +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct riscv_iommu_dc *dc;
> > +       u64 tc;
> > +       int i;
> > +
> > +       /* Device context invalidation ignored for now. */
> > +
> > +       /*
> > +        * For device context with DC_TC_PDTV = 0, translation attributes valid bit
> > +        * is stored as DC_TC_V bit (both sharing the same location at BIT(0)).
> > +        */
> > +       for (i = 0; i < fwspec->num_ids; i++) {
> > +               dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > +               tc = READ_ONCE(dc->tc);
> > +               tc |= ta & RISCV_IOMMU_DC_TC_V;
> > +
> > +               WRITE_ONCE(dc->fsc, fsc);
> > +               WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> > +               /* Update device context, write TC.V as the last step. */
> > +               dma_wmb();
> > +               WRITE_ONCE(dc->tc, tc);
> > +       }
> 
> Does it make sense to invalidate the DDTE after we update the DDTE in
> memory? This behavior will affect the nested IOMMU mechanism. The VMM
> has to catch the event of a DDTE update from the guest and then
> eventually go into the host IOMMU driver to configure the IOMMU
> hardware. 

Right, this is why I asked about negative caching.

The VMMs are a prime example of negative caching, in something like
the SMMU implementation the VMM will cache the V=0 STE until they see
an invalidation.

Driving the VMM shadowing/caching entirely off of the standard
invalidation mechanism is so much better than any other option.

IMHO you should have the RISCV spec revised to allow negative caching
in any invalidated data structure to permit the typical VMM design
driven off of shadowing triggered by invalidation commands.

Once the spec permits negative caching then the software would have to
invalidate after going V=0 -> V=1.

Jason
