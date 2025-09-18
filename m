Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F63016E7
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195718; cv=none; b=Y0AqO4s3tlEiu2SGc+1x+boHtImB0Yg+BX2fQF49j/T1eKFrlsfsO1bSbPrXHyo/XW76ai/6QO3dDrqmKWEz2mEfF6NGu8pe68YReLGomILfmzHWmvNWfad7j+ZQmkvxKKQW/B4OdWid6lBse2DyQkfUBUYWlWjl6jwW0rrnJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195718; c=relaxed/simple;
	bh=7N0UmSdKOHAaSXIPk6et3/EoSHnVMaI/hTlcSmus18k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3YKzdvmo7VhdyTS61cc2Et+DN+wrNgX/O4peRB8U6+06AJLYFEaxTSqWlyRDx5eT2q0c7kk/o6XYgRcjA31YL1ZP89AUspoVz90w7H+YJbJ8uVn7wqwwTUFWScunYR80tqpkky1SL/yqGJF1Im68AdYJVWK5Cqrg9wKDEdHDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmbtjQBQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmbtjQBQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso54285e9.1
        for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758195715; x=1758800515; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8l84kyRuuCoNVc5N+ElWv18ENe/Xi0Yvo10Z8affNw=;
        b=OmbtjQBQhvMkCCshAAC2oB/Dz3i/fk1gHyc7tBsZkyQDaiNb7Ktr7SlVI1d97ePAx+
         ib2nIm/O40FPCJ08GXeZ5lfo6fiThYWyMwRl5JW9rDZGNfbd+oWd08UoYi9hkZy+omBC
         ST8PfXdEh23UPLOlKChvQqr0cttfCnp8exNaKX2WY09TzWI9Uur+Geejv4wxPlrNRkOW
         Obxyn3VhBUoxA7sFCB+9sZ+vBhS7xRZBQvXO0cTxep0Zya6PDJ9T0xrYpczvD4IMZg0E
         QhTF1fvLqCbibJ2wjuBnCbTQliTQmi/i8LvjapjjdfdjRYAlpY2oIB/MWcEEH4/U95xI
         MGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195715; x=1758800515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8l84kyRuuCoNVc5N+ElWv18ENe/Xi0Yvo10Z8affNw=;
        b=vuLYXXTa5HAqPF+iUMwCtZLeIhIjltDEfPrpudL+oC26woeNgWj8RSdRTYiA6YZNyp
         ox//pt4p8CBcsyvPb/tAPKpOivWrl6PN7Smqq8/erqm1QM27chJXZiiWAE7NYrpf2Y0y
         0IKSdntcrgqOkEWCZtGBZ4lvIRDZP9diGkL645y0f/VEZShKjUV4cPmRaiD0jraqY3dC
         maZgfNdTyBEzoS7U2PmJfdhzRz2imem+63RXPaJLbrIhlchQ2TlhCVEMxDDKH3bEgHQl
         nC638462ZJ67vWKeo10NsTcpgoZmwJEc5Aapt/OWQf7eOufreOueilTbL0+L5kyc/YR6
         Ni4g==
X-Gm-Message-State: AOJu0YzAFQM2trTC+6tUlUZgOcjcX0CphWFIh2/QpYEJksFmgcz9O+R4
	QIzJ8DdjPmyzuLKCNXZ7qf2XRkYE4teHGLYSygz3VbExzlsxlZKvfom10BvPNqd4og==
X-Gm-Gg: ASbGncuHU/0vaerVmsLWo5grA4aDKZwvBhjVmVmZzd9ghWDv/nYWRMk0X2dyV5BHT3+
	KAB7lhW9IPPAcFO0rqFFUcbPc7gWl4hXiLQcqbnUTGubWtI+YGl+/rvOjk7qHUl57tttr2P0cqP
	/ORTvO48zh3aGh9V8l0QH3dfvY35IdY4IJwFHNu1AIlHx2dVSZQbtquplpZbPhHIYCamRZofPzL
	4UkXd+senpELVbzjhAdMn++JdS+CCXnUOa2sCDkaTt14LPVJSCCTpXhFnbzQCnu9JEwBTR6I1gO
	qFNYDXvMBtkCo0D90VgpUNhI3MWph9D+x2Mionehx9tPXTS4ify+NagGrWZws7cG96kjQurdi3z
	zxamFlJRxdNr0OL3NVZtAkbbyJBtYzL7eSC0W1I7o9dSGIgchqDoeop/ZBrSSBX/50tarHS0dpv
	CPmQEG2i1GWnLHzyKfjFkXBS8=
X-Google-Smtp-Source: AGHT+IFo++kIW70zN9Z7jaqR2wmSrLihbXgI8ryzk1jKjLYdejG3WXIUw1J2WnvE7qB1mOgjXOYq2A==
X-Received: by 2002:a05:600c:c4a5:b0:45f:2949:7aa9 with SMTP id 5b1f17b1804b1-461548788a0mr3774745e9.6.1758195714750;
        Thu, 18 Sep 2025 04:41:54 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm42958055e9.5.2025.09.18.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 04:41:54 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:41:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aMvv_u8HXAV7tbYz@google.com>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
 <aMsX_HafW3rLs5dQ@google.com>
 <20250917214824.GN1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917214824.GN1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 06:48:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 08:20:12PM +0000, Mostafa Saleh wrote:
> > On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > > > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > > > +{
> > > > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > > > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > > 
> > > Can be:
> > > 
> > >        struct io_pgtable_cfg *cfg =
> > >                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;
> > 
> > There are a bunch of other formatting issues here also, but I wanted to
> > move the code as is, so with “--color-moved” you can see the exact
> > difference, otherwise, it’s harder to review.
> > 
> > I can add a patch before to fix those + the printing as you suggested
> > next.
> 
> Yeah, I brought it up because with the above you don't need
> arm_lpae_io_pgtable
> 
> > I don’t have a strong opinion about this, but I am more inclined to
> > keep the prints considering it’s a low-level test for the page table,
> > and such parameters would be useful to understand the failures.
> 
> My general view has been that there is alot of debug prints I've added
> to kunits to debug them but once they are debugged I tend to drop them
> off as they may not be useful to debug the next issue.
> 
> > I know this is not relevant to this series, but the KVM driver will
> > need to expose arm_lpae_io_pgtable anyway.
> 
> Really? That sounds like wrong layering, why does it need to break the
> iopgtable abstraction? :(

Oh, not any more actually, in my lastest version it's just exported
for the selftest, sorry for the confusion.

I will respin v3 with with this patch leaving the arm_lpae_dump_ops
behind, it's a bit ugly with the guards + the exports, if Robin and
Will are OK with removing it we can just drop it.

Thanks,
Mostafa

> 
> Jason
