Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC15AA682
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898529; cv=none; b=j/XOPzpFuO+WB1o4OndzxftfGjQs8p/Y5Dtt0B4AYAFY50G0Gr5sqU9ouNqS/geJWsa4TJY03X2AflPkdo6KeMjkhTnJUPo8i0g1iL+nxKKXXLBWZDUzBUxRaO4TAL1uSPLrdD3vLqRSzf6ve9LfJUa0aXXMcQepw4a7jpMFmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898529; c=relaxed/simple;
	bh=lk0AVzn6SK5g3cLpL994sHHi2ORtltKoCFSEfplHs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq6R+K3CN9op3u2FKYAMWrfH62KN6tY/xZzACwut2K/wiTCwKvsOP3tO9pHzD/kPGHTZDwvWYy7G4bAKwe5Rj9n4sY8mQmDVGsoB7UZ2wp+3sjnrTzwnAfoHV1iYpnodHeTUgmchmUHuoUFvac6XdYIfVklF0gQ4nsrMxY15SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4QknrmH; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4QknrmH"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so2895ad.0
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898527; x=1789503327; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8nZbq7ojrvR0nhCFEzuDTGoUBYYORnGgdKFued90iew=;
        b=j4QknrmHaL7f5fnRjOw1/mVmAwHdkhWENYhBPD5V1P9VJfiOzfsTWwl2aCGOsxBy4d
         I6V2dNezMPTH2xm6BcyJK7UgdVWs9dIS5dPXRkbHjFbKw/uFUrsAgexycBuvS318/Xhc
         hXWwkHxM+YRV9TBG/KP4/lqntufU9xg5VXydeBm+SgGiaPEMjn1ymWKZUwXsXbqsZ4cg
         ZKPMpJsSZHN2aT27CEDDAJxv2ChnaomHoNjdVLsdB+TDxWrizTcJ6JR7GLA+X/24d6x8
         uZnAdQQIwzWZg1qGQM1GBDIWPMoTqv+4XGe2iQRoIwQYGP//waCwEH31srKiSCGp8Y41
         MaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898527; x=1789503327;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nZbq7ojrvR0nhCFEzuDTGoUBYYORnGgdKFued90iew=;
        b=MGjtLU7gl88E13mWOwSzuUdA6vp8EtcZ/ajVqWkeTA14w7F/fEyE/0d9sLLTuog84N
         CrhoNfE9u592dRpiaZih/kurOTenGjBtYMLvmnX1jgN1yxLWXQekEkESgwcE57LlCtzX
         hCREu/eMx2e10O727wxa6q7LqkeG9QgCuFtAiq8EHVg4IaKOjwkB+0vDXNdKgdI01CUi
         r71A/RXY4ZUACUhunQbCyLBheFzOygLdIN9njX5pJbuICXadEqgiJxQOU6jNIzDL+JBO
         QHis74xlvBeIyWDT/EFToy870phl7bnWS5HIHlNjYCAsehgqGYtp7uXP9DdKQj7Ht/ZJ
         w//w==
X-Gm-Message-State: AFuF++kwpqKWE5oFABn0xxZkpYhlCwBKrkt9gvFdNLBWZwqLFx9qjPqI
	Xq+EH1jhXjLzDgwTJ5TnRQlFSf96Kg36dopQw3VyPaG5kA9+k/MNtxQPxDBq3Kl8GQ==
X-Gm-Gg: AYBFou1h7JMY0pSGJ7mbKwVw2WI9++fbsssyi4kxs7CgrQalx7UFAyfUNPyvP+gprcs
	zpPedkmK7bdRwcX+xJfFQ2TQHOiiy/1zg8aJfIvE6tTzqVFrT4lYb9OTAB/5SlHnqju4HRHN3x3
	zSdxVhVqonan+owAFxg9ThG56MzPHxGVDxjzoTRqUzmvSbRPhGcrK21mMJxke0S87DApyM5WbRz
	2stVPas7+oXEy6eY9mffIayRWSXoBjSIpUsh/v1TfZd4onM6KsdaMpdgB+sYBiH2DqRUm4563FH
	X7pxUCak3E/8Rld1NYVns2+DJE2LU7m5oYuujMjo9GthZiAGDYAzb8ZHiMVztiZIcddtyD3TsHw
	iPVH28CIUI1MY2ALlEO8qZDnHTGB0vaNdEnw58p+gyjiKp461E66FBJHzX4EmLefNlvrt6+pxa7
	djt3UXyDm59rrX55jZ0lW2XneZblHfwGMlpN8E1UC4JAkqU62gngidt9WCA7YBCOezqAp8vpSjC
	HZfvJVf8X6dZ4MwBV3Cvjzh9Q==
X-Received: by 2002:a17:903:3df5:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2dbddb1f4e9mr1130545ad.6.1788898526478;
        Tue, 08 Sep 2026 13:15:26 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1c16sm339807eec.13.2026.09.08.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:15:24 -0700 (PDT)
Date: Tue, 8 Sep 2026 20:15:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v10 07/15] platform-msi: Introduce
 platform_device_msi_rewrite()
Message-ID: <aqBs1Rzz_i1N7756@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-8-praan@google.com>
 <87se3j1qgu.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se3j1qgu.ffs@fw13>

On Tue, Sep 08, 2026 at 09:40:49PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:
> 
> ...
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason. You really should know better by now :(
> 

Apologies for the confusion, Jason just directed me to avoid open coding
this in the iommu driver and have the irq core handle it instead. [1]
Jason had nothing to do with the specific implementation / design here,
that misintepretation / mess is mine :( 

I'm relatively less familiar with the MSI pieces, and gave it a go
(probably should've prefixed this patch with RFC). Sorry about that!

> > +/**
> > + * platform_device_msi_rewrite - Rewrite the MSI config for a platform device
> > + * @dev:		The device for which to rewrite interrupt
> > + * @irq:		The interrupt number to be rewritten.
> > + * @write_msi_msg:	Callback to write the interrupt message for @dev
> > + *
> > + * Rewrites the cached MSI message for a platform device.
> > + *
> > + * Note: Platform MSI does not automatically cache composed messages. The caller's
> > + * @write_msi_msg callback is expected to cache the message (e.g. into desc->msg)
> > + * during initial configuration so it can be rewritten on resume.
> > + */
> > +void platform_device_msi_rewrite(struct device *dev, unsigned int irq,
> > +				 irq_write_msi_msg_t write_msi_msg)
> 
> Why is this a platform device specific function and why does this need to
> hand in the write_msi_msg() callback, which is already known through the
> interrupt descriptor and the top level interrupt chip?
> 
> I spent an awful lot of time and effort to get rid of these platform MSI
> layering violations and now you start adding the same mess again.
> 
> Not going to happen.
> 

Ack. I'll address the layering violations

> > +{
> > +	struct msi_desc *desc;
> > +	struct msi_msg msg;
> > +
> > +	if (!irq || !write_msi_msg)
> > +		return;
> 
> Oh well.
> 
> > +	desc = irq_get_msi_desc(irq);
> > +	if (!desc) {
> > +		dev_err(dev, "Failed to get MSI descriptor for irq %u\n", irq);
> > +		return;
> > +	}
> 
> Doing this without having the underlying interrupt descriptor locked is
> a recipe for an undebuggable disaster waiting to happen. It might be
> "safe" in the context you are calling it but it's absolutely not safe in
> general.
> 

Ack. I was thinking about races but I assumed the descriptor shoudln't
change but that's a "happy" / unsafe assumption.

> > +	__get_cached_msi_msg(desc, &msg);
> > +	if (!msg.address_hi && !msg.address_lo) {
> > +		dev_warn(dev, "No cached MSI message found for irq %u\n", irq);
> 
> That's just wrong. A message with a zero address is valid, e.g. when an
> interrupt is shut down. So if there is random crap after resume in the
> message store and the interrupt is valid, but not requested, then the
> cached message still has to be written even if it is zero.
> 
> So this want's to be a function in the MSI core code. Also this is not a
> per interrupt problem it is obviously a per device domain problem.
> Simply because the device provides the message store for all MSI interrupts
> which originate from that same device and therefore _all_ MSI interrupts
> are affected by that, no?
> 
> So this all can be solved at the device domain level without sprinkling
> per interrupt invocations including conditionals all over the place.
> 

Ack. I was wondering if the irq core should also cache the message for
platform MSIs like it's done for PCI ? Would that be a bad idea? Or is
it this way by design? (I'm having to cache the msg in the iommu driver
atm).

> Something like the completely untested below should just work.
> 

Thanks for sharing this! I'll give it a go.

> Thanks,
> 
>         tglx
> ---
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -669,6 +669,8 @@ void msi_domain_free_irqs_all(struct dev
>  
>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>  
> +void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid);
> +
>  /* Per device platform MSI */
>  int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
>  					    irq_write_msi_msg_t write_msi_msg);
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1775,3 +1775,34 @@ bool msi_device_has_isolated_msi(struct
>  	return arch_is_isolated_msi();
>  }
>  EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
> +
> +void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid)
> +{
> +	if (!dev->msi.data)
> +		return;
> +
> +	guard(msi_descs_lock)(dev);
> +	struct irq_domain *domain = msi_get_device_domain(dev, domid);
> +
> +	if (!domain || !irq_domain_is_msi_device(domain))
> +		return;
> +
> +	struct xarray *xa = &dev->msi.data->__domains[domid].store;
> +	struct msi_domain_info *info = domain->host_data;
> +	struct msi_desc *msi_desc;
> +	unsigned long idx;
> +
> +	xa_for_each_range(xa, idx, msi_desc, 0, info->hwsize) {
> +		/* Only handle MSI entries which have an interrupt associated */
> +		if (!msi_desc_match(msi_desc, MSI_DESC_ASSOCIATED))
> +			continue;
> +
> +		scoped_irqdesc_get_and_lock(msi_desc->irq, 0) {
> +			struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
> +			struct msi_msg msg = msi_desc->msg;
> +
> +			if (data->chip)
> +				irq_chip_write_msi_msg(data, &msg);
> +		}
> +	}
> +}
> 
> 
> 
>

Thanks,
Praan
