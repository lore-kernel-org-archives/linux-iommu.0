Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E71E4EF5
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032559; cv=none; b=NibAmRyswXQJCLYNVzBpQoDAz/92FBzweCa/9pNkNlX56kQ/GCMDPFgmg3ed9PNfzwj90zuZrOcQQLDDmJbTJqMyaFOy3ghPZYdpjaKQ48T8cp/zmxlj+CBLKwAgLU6aP4P/ZdeSJzgttbdzIdWNbMsL3MaNrKQo2LEw7OsM49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032559; c=relaxed/simple;
	bh=+Y6GWnP1+MQe2MB/QuUAk+X+C6Y7NQwVJjcdav32LgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcx6h9ZHDpquTJNtfVe71kPi8OJIqO341Cku/SZfozGvXPKaHf2pZfHcSRub2qmj5exooRe6ens3jw4WuXbriOFSPIKxPGMK43V3kmy+m2bqm1wA1Pq44ulpoUWhuCZtn7GmkAA6Jr/sMDANEoKFr/9EwuI0c7fXD6hlFaodmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TH5TedBi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TH5TedBi"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe11dedb3so8074611cf.1
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723032555; x=1723637355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snW/PV7nq5nRVPwlSUYRJgZXzOG2u4xZdipMsckI06g=;
        b=TH5TedBiyWOJ1ceyCM2CoGepZoikxc9wMS5xhaOewo7s3ZFPGZtR9g17H9VyzpcBCI
         KaVb2z0tS0bg5685AVk1mo5InhERMhaYkCptz0Y23gFwfu3Tof0NUxSgcPoxx1tEG+V1
         1xfiiPXQ865rvExV20K7ufk6XBVlKf138LLTjC8LGiK9Fzn1gF3896ikcIpnYtdJ3ULv
         uCgNJwlF/yMbT0d7bvHbEjW91bD0n47veVm4LwpAhLw+qJY1vx9jUz9er5RHb2JC6785
         JUfzEFVo8+VuAPQfOm5JUJ7/FfYN8ujgq4CnBAYGnHGmONbhp/3TmkDDqTej5xo6l0I7
         hnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032555; x=1723637355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snW/PV7nq5nRVPwlSUYRJgZXzOG2u4xZdipMsckI06g=;
        b=ZGBg7s0fdLjmiNueJn0plGVlOaAmAL4tiXfxI6SXUQPKaZZaZZ1GiYIixsnIu3/rj7
         hWIlLLi0pWoTQwPkMtuSo0GW2eR1tUFrJIWAgJMEXnaJxU0fIdNXHtVDZ8ZnOg4K1fAx
         K1RsyVqOWObaPQT1aupR7J7LVQ7fcavFFY6Q1yeGOShvVAkAvfrrWgi3qFKsTELJPhUr
         chtIshY+34hMUxpCosLdCfN7bhunO5gLi9OqajCHs+ncpFkTV800uxP4ZoWmPHq9T50i
         npADhQ3PBZdBTBY0rsBH5DownxwKIq8Le8JNoB/2vOpOsfYS/blbrs6P8d96WmJKkLUG
         B/dg==
X-Forwarded-Encrypted: i=1; AJvYcCW1PbrKeCY2uyDe4nVZ2j5i4gfZaf3pvBuUz2unWluf2yF6JCo7wIiAT+h3sPeX/NZKigWdE7NTPKQs8n0PvA8bjgdbE00=
X-Gm-Message-State: AOJu0YxWIekzn1UV1f9iwEZgPi28UyjgVCLlasQldAVir6iQKJHEyLwT
	lRjzTEHo7ftXqaPw03czJNeMNyS+CxDWloImaQzQZQozkVOYA/o0tc2ulk0S9kc=
X-Google-Smtp-Source: AGHT+IH1iHA7GJrKiIQAdJfVn30gcsWwU242oRypvDRPgmnje4xxxq6RqcW9n9NLu0ZivAAsHLBieQ==
X-Received: by 2002:a05:622a:1788:b0:447:ea35:95ed with SMTP id d75a77b69052e-451892708cfmr219851361cf.6.1723032555501;
        Wed, 07 Aug 2024 05:09:15 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87314b3sm4325031cf.42.2024.08.07.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:09:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbfTd-001jVl-L5;
	Wed, 07 Aug 2024 09:09:13 -0300
Date: Wed, 7 Aug 2024 09:09:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <20240807120913.GC8473@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
 <20240806170653.GL676757@ziepe.ca>
 <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>

On Wed, Aug 07, 2024 at 02:19:57PM +0800, Baolu Lu wrote:
> On 2024/8/7 1:06, Jason Gunthorpe wrote:
> > On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
> > > We will use a global static identity domain. Reserve a static domain ID
> > > for it.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/intel/iommu.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 723ea9f3f501..c019fb3b3e78 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
> > >   	 * entry for first-level or pass-through translation modes should
> > >   	 * be programmed with a domain id different from those used for
> > >   	 * second-level or nested translation. We reserve a domain id for
> > > -	 * this purpose.
> > > +	 * this purpose. This domain id is also used for identity domain
> > > +	 * in legacy mode.
> > >   	 */
> > > -	if (sm_supported(iommu))
> > > -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> > > +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> > That should probablyturn into an IDA someday, it would likely be more
> > memory efficient than bitmap_zalloc()
> 
> I have tried to. But I failed to find a suitable ida interface to
> calculate the count of allocated domain IDs to replace bitmap_weight()
> in below code.

For something debugging like that just use 
  idr_for_each_entry()
     count++;

It is a weird thing to put in sysfs in the first place...

Jason
