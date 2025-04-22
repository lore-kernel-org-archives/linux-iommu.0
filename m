Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46F2135B9
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365390; cv=none; b=tAF4R3x0KEzf1y7XABvkcJRqJdAQzJt3l2cMyzvEnyo+CFB+JoArmyGqExZ40ghV+2jid3h8XP33SpnEAyBLapM9i6mXIV7222c4EL4cch03vQj9TYUvNF5rjApY4mpClLva6RutzIpf6aNJrzjO9Fg5QP/jHtFJ/KAE3EvI8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365390; c=relaxed/simple;
	bh=v0cCoG4hu0MAdn8PJxhcSn+lcyGfNDP9cmZ8UNW+RxE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc56kH3SUb2StykLWApOtHze4hDVADRIRLiDcQjHsiXZrBCAaJRJsfZS/SENir12amVolRAE9h9+Mn5OVl2+0WZ15Te7AhPcj+8y0nnt1UsC3AoHYQQb3aNYLGBrLywLf6kZZYrgYZQXtDSOkrgVjQNFSaMvLEceLj+mOPYkwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HsadfEqP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HsadfEqP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5a88b34a6so543326985a.3
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745365387; x=1745970187; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Zxh8t9YCpxlI0ZgT0ViWXKWEXuTyrLctSuix77HrU=;
        b=HsadfEqPLA6AkwGfdS4ZgF1lSZwy57XM/Tohet7dTDNfHDpKVcaOcYB85YMpJoIpcO
         GRr1Our710Sv2TKSQquHEi+nn5Fv9Et8x6EgOajix0CgzJTp8z89X14YS1b483YQbN+6
         opXV/gBXeP8tStXPystY3eqP6RkqzIpWo642pqRiEcMKDOwvaErBzHjWXgL4MTN9CXtV
         SIjuyQSVB3aMfcvCeSSLQ2JkyEvMemF8hgMjSadIvU3r2pzNtaFPkIrohuAK0Qcaq34b
         dUuOCOqcq64U9wCZ27eZ7H/+E5apTxjLCKq0v9d2SjHAiIZkfCrfkz2ax+KooYdjWvnq
         CGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365387; x=1745970187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8Zxh8t9YCpxlI0ZgT0ViWXKWEXuTyrLctSuix77HrU=;
        b=xExd9HJyLS6m3T0MQ0FERIvHC9a+B/djx6QJ5BP4XoGJQAhr30IYLA56mNiq99H7fD
         dr4j3WoRQysN+TTDJrd2mvEOui8gjjAmvvcvEOv1r6MdVHkSJzk4K2Cg4wcI9qKKvBDV
         o1b1jL5zcPLOE/xMa99+DufgzVuRzoG7GYx+HYt7Lmhs/5/iZ8CoM86Y8MMN95YFmQO1
         DGDFAaKLWrd0UzOLX6NSG7TdLEFkz7jREe7sLR3IqX44QEn8+2L3lpLecvZWXn47RHSR
         eo1roDkDl30i4SfoK1tyXKsJ4eMUkChLvIdcHRVHFTdHgxWSWz9+LENb9hyqiJ+oPsKR
         MB8A==
X-Gm-Message-State: AOJu0YzWywhKYZZBNEBnwsGa9N/qSEvqgAOjs4weBnts5lGspAI3Ybdb
	UitktXOC1egzVkgULMOS+Xu19qQF9qIWbh29RrR+65JWuRIB0oBDwyxi/pygwAx81N0Q1/kwVks
	H
X-Gm-Gg: ASbGncuM3w9A/zTAyv52D/KUxCbb8Retv2M/+zaqPiuWmIOT6WX4PBn5DVyOSrXdrKf
	e0a4R6+kDwptTCWZR3TOLVEejsaQrlYIsE0+A3ooKEmHxbsZm0vp1Sla000kAaYwL2SS/VdawCV
	B0ARw9IbQuDqVOn2EL/SA/1uATE/BX1RTSR1p5sFtw8gw4TahLlYX0zR7OForISFlj0azPVeUJ5
	52ztBiULzdGhl652ZNDPLr1r/xWjOiFlUsPWOb2T5wPF9viLLV1+ZM/aYpOmcZOtbawn0uF77e8
	W1PRMEIEn/q+ZeV3IVArkxJpdcLBWrbrGyQR3LoJTWpaAHSEBqTevmcFVL3it24Sw1jFs242dHy
	TTJciU50lgxKGDhWBUTM=
X-Google-Smtp-Source: AGHT+IF0d7xIg/JkBNfKB1dvFEqi+nm6q/lLlUP8QDJzin7elXIwVxFKdmisgA6rLVL2E6mqGZK00Q==
X-Received: by 2002:a05:620a:44d6:b0:7c7:a5cb:2b65 with SMTP id af79cd13be357-7c927fb2214mr2562644385a.26.1745365387014;
        Tue, 22 Apr 2025 16:43:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69579sm611812185a.91.2025.04.22.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:43:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7NGb-00000006xvD-2euk;
	Tue, 22 Apr 2025 20:43:05 -0300
Date: Tue, 22 Apr 2025 20:43:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
Message-ID: <20250422234305.GE1213339@ziepe.ca>
References: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>
 <20250422190921.GB1213339@ziepe.ca>
 <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>

On Tue, Apr 22, 2025 at 06:21:32PM -0400, Ben Collins wrote:
> On Tue, Apr 22, 2025 at 04:09:21PM -0500, Jason Gunthorpe wrote:
> > On Mon, Apr 21, 2025 at 10:46:19PM -0400, Ben Collins wrote:
> > > diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> > > index 30be786bff11e..a4bc6482a00f7 100644
> > > --- a/drivers/iommu/fsl_pamu_domain.c
> > > +++ b/drivers/iommu/fsl_pamu_domain.c
> > > @@ -214,9 +214,10 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
> > >  	INIT_LIST_HEAD(&dma_domain->devices);
> > >  	spin_lock_init(&dma_domain->domain_lock);
> > >  
> > > -	/* default geometry 64 GB i.e. maximum system address */
> > > +	/* Set default geometry based on physical address limit. */
> > >  	dma_domain->iommu_domain. geometry.aperture_start = 0;
> > > -	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
> > > +	dma_domain->iommu_domain.geometry.aperture_end =
> > > +		(1ULL << PAMU_MAX_PHYS_BITS) - 1;
> > >  	dma_domain->iommu_domain.geometry.force_aperture = true;
> > 
> > What on earth does this even do? There is no map_range() callback in
> > this driver, so nothing should be reading geometry..
> 
> I dunno, but your "FIXME this is broken" comments are all over it from a
> year and a half ago:

Yes, I know, but you are changing this - are you changing it because
something is broken without making this change, if so what, or are you
changing it because it looked like it needed changing?

> The logic hasn't really been touched in 10 years.

Yeah, so I'm surprised someone still cares about it :)

Jason
