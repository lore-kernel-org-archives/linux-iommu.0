Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F1283FE1
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437314; cv=none; b=B5pBwEvCBGBBIwAHKb8zE6XUvZA6ZNknNV/Dwbr3ETaaHznVBOmeKWFIyhPl1l38E7CfdVC84uFDU9yh29MhJegJPXjj2BQ6Rzj9Y4GEFPWhgxYmEGzEVO/9moYjRLIZ8wep80S+644x69W2tmgVoAswbu9cE+ZV+L2OHqVD/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437314; c=relaxed/simple;
	bh=NfmPX0yVFBBCDiBkKX9NhyYVI/32o1GQomiZQ8lwj04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqqew/IFfUbiaL/DUc472BF3F6tel7oWxaWj6YjMCXrvSJAMg1AzCu9lZ92AzTtcElwrl8ph/4/ckUWR1QiVvEIT5W/lk4JbameEEOhnjQwrFQr4spscGLS6GUv13cxwlpv4tU5oePIPgmOcBd9XrrkqIgaXeS8p2QEU5dz8JlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nowgvNM7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nowgvNM7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a442a3a2bfso30978851cf.1
        for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750437311; x=1751042111; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFurqnYI+L7RUrkwAcAgkoscsXJUHEF+OS7OBiZvdjs=;
        b=nowgvNM7XWwyc8LR4mTBRcX4AU7dRuRfK7TdP9Mt69yhXlaeZ5rX87kZ0Cmx34CT4+
         VwZm9LbV9BWfbFyZwWiQSpAcymhHLGuU5OmVIV+GBoR3UjwAZaSaKoqdFcDbXcaDYc5y
         0qvXliuHwiR9O5jN0F94xt//w89D4tXwTRbIBuOjx2uUztOokG5yrAUd7WlBp9P9Z/oq
         nb3gQkY58vhqnZx8SRXa0QWVrxFGPSkFJYV8gc0L/+DX5BTPBUhRiO8C2/EKLE38fA0P
         5pLgYSqmVm7P58KU1M2FgHP5nkD59KgdDnQpbbwcEhL6iAPxbdR+qUhgmkgNvGvb8e9E
         2cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750437311; x=1751042111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFurqnYI+L7RUrkwAcAgkoscsXJUHEF+OS7OBiZvdjs=;
        b=wVfhoRBH6ze2RmdhmY5EXZMXprTnxr8XGtKNRkRzXYNun5EkNMpSK44S3XRuYsdR+K
         K4HxcTssmR0c1GMtj2qvoegWOnZw9x7ab1PsxH4t+PpwEjLlubzv8z1PC6ZFeuUvBnyh
         CheQHOhPJvKYQaydxn0xG78BEDcKdmwxC5gsYjSc/KpUXGaZoX/Pqee8Fo1faPPCosHL
         4b4hDojnjOHRmbnpsVW7n5zdgvzxWJea8witjr5Intau2DzIbvpTDCmK9gBcnWnkIGKo
         dv525Wk81U5tgYDiGQ8TC6DsgmmGyhQ18hGEGq3PWmro3SBVaLCPmTMPOrbJ6Wq3aWS5
         qeOw==
X-Forwarded-Encrypted: i=1; AJvYcCXXG9IyZMhFaDVAaNm9NSultchpynwy9y5JQ8LINBllFC2JRBxTZtsFEFezeB1ePUFHpLhA1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYCR35hHSGR3nkkmIzyM8+TNvvCyZPjyeikXMWTwqn+Lt7Keth
	YqxxDzGnvhkl2KVDEkTHAupjG6y78TkC6S0UXhiT944Cz9DfRQ/IwrjZxKi1GZj+ep4=
X-Gm-Gg: ASbGncs7AdBMM+vCq+PgERM5seaLvU1160xhkx6mC6PBzQQk43C19yT1TlI1Jzeqjfo
	Ume1kaAtyOk2g792a5OEqXaGq36KNucMF+qujAqc1MV0b5O7MEcddr6gGTTsZNZQhnUqOWQbsup
	lJo1t1jg0GmdwujK1ZPzSisU3D0CsKqM3Iwptp8Gu0jEMeskXlhWccfL31DAw2p3dhW9KXXWY3c
	uDi8t3ywBnnIkHYgaK0B83KdGhJeSpiU0qESYh+bDusBfWLMRszaBQRkTejfllHuCed3JaNw4Mh
	In8ec21/eyjR7wbRPJmoExuPaTwwfJNnUvFl6Qf90R4+PauCEZ+3J6v17Xh1VeBS7X4pwh8diFU
	xPvQELrXbPe+XHRWXEhcdMnOhC8HriUQ72pUzhw==
X-Google-Smtp-Source: AGHT+IFA6k631lKxrYTYm+6L/JASXk2MoP+urHg89b8SmimDGgONLFl8B84S2EQnZ661ul3HBMs1NQ==
X-Received: by 2002:a05:622a:1307:b0:4a7:2357:dc81 with SMTP id d75a77b69052e-4a77a23abbfmr54566761cf.3.1750437311156;
        Fri, 20 Jun 2025 09:35:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d9dbfesm10698501cf.36.2025.06.20.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:35:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uSehp-00000000Es0-48hW;
	Fri, 20 Jun 2025 13:35:09 -0300
Date: Fri, 20 Jun 2025 13:35:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250620163509.GB39770@ziepe.ca>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <20250619134752.GB1643390@ziepe.ca>
 <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
 <20250619165928.GA10257@ziepe.ca>
 <e034a111-93eb-42e8-a533-46553b4f5588@collabora.com>
 <20250620120509.GA39770@ziepe.ca>
 <d9a1b9ab-b6ab-4364-a1b7-df4debc21bc1@collabora.com>
 <3337df6c-f800-4610-8689-fbd4b4a5d07a@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3337df6c-f800-4610-8689-fbd4b4a5d07a@collabora.com>

On Fri, Jun 20, 2025 at 04:42:02PM +0200, Benjamin Gaignard wrote:
> 
> Le 20/06/2025 à 15:52, Benjamin Gaignard a écrit :
> > 
> > Le 20/06/2025 à 14:05, Jason Gunthorpe a écrit :
> > > On Fri, Jun 20, 2025 at 10:57:49AM +0200, Benjamin Gaignard wrote:
> > > > Le 19/06/2025 à 18:59, Jason Gunthorpe a écrit :
> > > > > On Thu, Jun 19, 2025 at 06:27:52PM +0200, Benjamin Gaignard wrote:
> > > > > > Le 19/06/2025 à 15:47, Jason Gunthorpe a écrit :
> > > > > > > Ugh. This ignores the gfp flags that are passed into map because you
> > > > > > > have to force atomic due to the spinlock that shouldn't be there :(
> > > > > > > This means it does not set GFP_KERNEL_ACCOUNT when
> > > > > > > required. It would
> > > > > > > be better to continue to use the passed in GFP flags
> > > > > > > but override them
> > > > > > > to atomic mode.
> > > > > > I will add a gfp_t parameter and use it like that:
> > > > > > page_table = iommu_alloc_pages_sz(gfp | GFP_ATOMIC |
> > > > > > GFP_DMA32, SPAGE_SIZE);
> > > > > This will or together GFP_ATOMIC and GFP_KERNEL, I don't think that
> > > > > works..
> > > > I have test it, I don't see conflicts or errors. What worries you ?
> > > Just looking at the bitmaps I'm not sure? Did you run with lockdep?
> > 
> > Yes and it complains about that.
> > I see that sun50i driver have more less the same struct than my driver
> > but doesn't use lock. I will try see if I can remove the lock.
> 
> I have replace the two spinlock by a mutex in vsi_iommu structure.
> It seems it works well and lockdep doesn't complain anymore.

You cannot use a sleeping lock within the map/unmap
functions. Removing the lock is hard for your case because you have
the cache flushing problem.

Maybe mask GFP_KERNEL off and then or back in GFP_ATOMIC.

Jason
