Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F916A94F
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837336; cv=none; b=do268i/KXDCLqJYwLh8qEj+EHsBZW/ItsKG3E/tkgaQxjhlDWaCckQwGgGORFAUsr1Z0HyJf3+3jkwK2bi3xGQtqDEWCV700cu0ehiUogBjVrR0TNX/Yoa+0/lbIxhh1znToIKDVYIR+/rVg61ByVk1H95XT3tayOsoHZnkfVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837336; c=relaxed/simple;
	bh=za7IO0sCYx7CmPO+U3FK7Unvfx1Pdz9+mD87eVxyH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afjB1j4graBPo2veE1yB9He78TDSrVDGuS7+uxT4Jf7lXZT8lD5AzOXz0GaZVeTbtuun8O309VKK9wqwQsKOpFexsdsjptH9s4PoYyl9pFjYLssmHcpAqzLENddh6Fu8cXL552VYHjewywF4DcUwDLpLcFGMNQbJGNPuMI8gKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A0NuZhf6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A0NuZhf6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c50ea4419dso234937a12.0
        for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726837333; x=1727442133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJchD+fQIychs0NcvDtSiTW88y7BwZBhypW5JVKg9Ao=;
        b=A0NuZhf6zUSMe4u68Axq9jj1MMAen+MQsvhaGKjnFK2xlHSwoXixt5kbk7IAHUMSAE
         GhyOipQ+ESSjQCkxuAJXeNF9sJB8IOPtsHgq8PqUv1OvlrubC2cHU1fcApnygckM4vAd
         VFUZAGCPBVExGb/aHpSBtKcgND6TTmMO5VaXmkiBoCz9vrY+KcJxFdZxR5Ge+71COG/Y
         29yD7qIc9JvVeaqnVfl02Ks64IE+N9d9Nq0id7TPLAVSp2mACCm78BmuZGrQbEOg1Jx6
         gnZ0XtXuoHDg16np1MwGOcY05ZMGwTcXS93bzcUaXahdrIVlq6r7TDS5Inzs8DlCas4w
         9Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837333; x=1727442133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJchD+fQIychs0NcvDtSiTW88y7BwZBhypW5JVKg9Ao=;
        b=pI09lnVaFdPfLk3MfL1of7DQFKEZ4ppyPgjhnECs6/c54i0SLmQgh77HtJ0qonEYDq
         tt6Gp4nFk4c6T3OkOYNYq/+lSLbyVKz4FiFyEp1F4inAfdu9XuJi2hv8Ru+bGft0xiqQ
         tBpKCduDuesKoL5IEzJyBa6ZYjQLHEgR5TmdBlz9Dykx+03I9YXmC1OvpqM/FaapBfsS
         X2q02Qk4CMIwpTSBN+i2v0k2WHiuTO0h3/7eg2YrmamKV/anw7XV84Mn80Ao8zWesu1e
         VBtI2QHp9fQmxOpw+JK5FKf1N7NRfiOBn4Uf+/+uxeNWTHK3G05cGWRecskLJzS2VM3S
         HHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgiuLNtl15lKZZP6ICB4du+vmBKhlqGhiRpbyaxlKOi3im6tfSNIVAXMQU6+FTYPwfVmuY1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZymEq7s7+PFsN/2ORWtJxokw1FARkKIo5flJFaXgKPdmATRNl
	IF4He9ik2lNxie5d1dREzlP8dfJlu6eiauL0hOLsgFHiPv8V0flzo+nDyLEmnH8=
X-Google-Smtp-Source: AGHT+IFPAJtW0gSmTDvckrhsc6sALfW4bnckH7GSwkNDav+k1QZrV0bl2f/MfI2rRfdmyud+Ewn3YQ==
X-Received: by 2002:a50:c88d:0:b0:5c2:5c36:f838 with SMTP id 4fb4d7f45d1cf-5c464dbab02mr1546587a12.16.1726837332809;
        Fri, 20 Sep 2024 06:02:12 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a0csm7173028a12.79.2024.09.20.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:02:11 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srdH1-0001Ci-50;
	Fri, 20 Sep 2024 10:02:11 -0300
Date: Fri, 20 Sep 2024 10:02:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH v2 5/8] iommu/amd: Pass page table type as param to
 pdom_setup_pgtable()
Message-ID: <Zu1yUz6hPFuM49wx@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-6-vasant.hegde@amd.com>
 <66e4b125.170a0220.2fa213.1e2cSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e4b125.170a0220.2fa213.1e2cSMTPIN_ADDED_BROKEN@mx.google.com>

On Fri, Sep 13, 2024 at 02:39:45PM -0700, Jacob Pan wrote:
> Hi Vasant,
> 
> On Wed, 11 Sep 2024 10:19:08 +0000
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2285,28 +2285,13 @@ struct protection_domain
> > *protection_domain_alloc(unsigned int type, int nid) }
> >  
> >  static int pdom_setup_pgtable(struct protection_domain *domain,
> > -			      unsigned int type)
> > +			      unsigned int type, int pgtable)
> >  {
> >  	struct io_pgtable_ops *pgtbl_ops;
> > -	int pgtable;
> >  
> > -	switch (type) {
> >  	/* No need to allocate io pgtable ops in passthrough mode */
> > -	case IOMMU_DOMAIN_IDENTITY:
> > +	if (!(type & __IOMMU_DOMAIN_PAGING))
> >  		return 0;
> Now that you pass in the pgtable format explicitly, I think you can
> delete 'type' parameter and move this check to do_iommu_domain_alloc().
> As you mentioned in [4/8], pdom_setup_pgtable() is factored out for
> setting up page table only.

It would be nice but I think the type is stil encoding the DMA API
flag at this point. Adjusting that could be moved to where the cookie
code ended up

Jason
